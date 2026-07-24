# -*- coding: utf-8 -*-
"""
模板区域提取器 V2 — 基于模板标题 Y 坐标做区域分割
══════════════════════════════════════════════════════════════════════

V2 核心思路（对比 V1 的 _flatten_children 展平方案）：
  - 直接遍历 RecyclerView 直系子节点，找到 content-desc 匹配模板名的标题节点
  - 模板区域 = 标题_Y → 下一个标题_Y（或 RecyclerView 底部）
  - 如果 RecyclerView 顶部到第一个标题有空白 → 合成"直播居中模版新"区域
  - 不再依赖卡片 clickable/desc 检测来算区域，避免 CM311 desc 乱码丢失卡片

用法：
  regions = extract_template_regions(xml_root_or_path)
  for r in regions:
      crop_box = (r['x1'], r['y1'], r['x2'], r['y2'])
"""

import re
import xml.etree.ElementTree as ET

# 模板标题硬编码已移除 — 现在从测试桩 datas[*].title 动态加载
# 参见 stub_parser.extract_template_info()
_DEFAULT_TEMPLATE_TITLES: list[str] = []


def parse_bounds(s):
    """bounds="[x1,y1][x2,y2]" → (x1, y1, x2, y2)"""
    if not s:
        return None
    m = re.match(r'\[(\d+),(\d+)\]\[(\d+),(\d+)\]', s)
    if m:
        return tuple(int(g) for g in m.groups())
    return None


def _is_title_node(attrib, titles: list[str] = None):
    """
    判断 content-desc 是否为模板标题。
    
    如果传入了 titles 列表，只匹配列表中存在的标题（精确匹配 content-desc）。
    如果未传入 titles，接受任意非空 content-desc。
    
    Returns:
        (is_title, full_content_desc)
    """
    desc = attrib.get('content-desc', '').strip()
    if not desc:
        return False, None
    
    # 太长或太短的 desc 一般不是模板标题
    if len(desc) > 100:
        return False, None
    
    if titles is not None:
        # 精确匹配：content-desc 完全等于标题列表中的一个
        if desc in titles:
            return True, desc
        return False, None
    
    # 无标题列表时：任意非空 content-desc 都接受
    # 注意：可能产生误报（非标题节点的 content-desc）
    if len(desc) >= 2:
        return True, desc
    return False, None


def _find_recycler(root):
    """在 XML 树中找到 RecyclerView(id=content)，不依赖 XPath contains()"""
    target_id = "com.huawei.tvbox:id/content"
    content_root = None
    for elem in root.iter():
        if elem.attrib.get('resource-id') == target_id:
            klass = elem.attrib.get('class', '')
            if 'RecyclerView' in klass:
                return elem
            if content_root is None:
                content_root = elem

    if content_root is not None:
        for child in list(content_root):
            if 'RecyclerView' in child.attrib.get('class', ''):
                return child

    return None


def _count_cards_in_range(recycler, y1, y2):
    """递归统计 Y 区间 [y1, y2) 内的可点击卡片数"""
    count = 0

    def _recurse(elem):
        nonlocal count
        a = elem.attrib
        b = parse_bounds(a.get('bounds', ''))
        if not b:
            return
        cy1, cy3 = b[1], b[3]
        if cy1 < y1 or cy3 > y2:
            return
        if a.get('clickable', 'false') == 'true':
            count += 1
        for child in list(elem):
            _recurse(child)

    for child in list(recycler):
        _recurse(child)

    return count


def extract_template_regions(xml_source, template_titles: list[str] = None):
    """
    主入口 V2：基于 RecyclerView 内模板标题的 Y 坐标做区域分割。

    Args:
        xml_source: XML 文件路径 (str) 或 ElementTree.Element 根节点
        template_titles: 可选，测试桩 datas[*].title 列表。
            传入后只会识别这些精确匹配的标题；
            不传则接受所有非空 content-desc。

    Returns:
        list[dict]: 按页面从上到下排列的模板区域
            name, x1, y1, x2, y2, width, height, card_count, cards
    """
    # ── 加载 XML ──
    if isinstance(xml_source, str):
        with open(xml_source, 'r', encoding='utf-8') as f:
            raw = f.read()
        raw = re.sub(r'<\s+(\w)', r'<\1', raw)
        raw = re.sub(r'<\s*/(\w)', r'</\1', raw)
        raw = re.sub(r'(\w)\s*-\s*(\w)', r'\1-\2', raw)
        raw = re.sub(r'<\?xml[^>]*\?>', '<?xml version="1.0" encoding="utf-8"?>', raw)
        root = ET.fromstring(raw)
    else:
        root = xml_source

    recycler = _find_recycler(root)
    if recycler is None:
        raise ValueError("未找到 RecyclerView(id=content)，请确认页面")

    rv_b = parse_bounds(recycler.attrib.get('bounds', ''))
    rv_x1 = rv_b[0] if rv_b else 0
    rv_x2 = rv_b[2] if rv_b else 1920
    rv_y1 = rv_b[1] if rv_b else 0
    rv_y2 = rv_b[3] if rv_b else 1080

    # ── 扫描 RecyclerView 直系子节点，找模板标题 ──
    titles = []
    for child in list(recycler):
        a = child.attrib
        is_title, name = _is_title_node(a, template_titles)
        if is_title:
            b = parse_bounds(a.get('bounds', ''))
            if b:
                titles.append({'name': name, 'y1': b[1], 'y3': b[3], 'bounds': b})

    if not titles:
        # 无模板标题 → 回退到启发式分割
        return _heuristic_from_recycler(recycler)

    regions = []

    # ── 合成"直播居中模版新"区域 ──
    first_y = titles[0]['y1']
    if '直播居中模版新' not in [t['name'] for t in titles] and first_y - rv_y1 > 20:
        # 用 RecyclerView 自身上沿作为顶部起点；扫描所有子节点找 rv_y1~first_y 间的最小 Y
        content_top = first_y  # 默认退到第一个标题上沿
        for child in list(recycler):
            cb = parse_bounds(child.attrib.get('bounds', ''))
            if cb and rv_y1 < cb[1] < first_y and cb[1] < content_top:
                content_top = cb[1]
        y2 = first_y - 2
        height = y2 - content_top
        if height > 0:
            regions.append({
                'name': '直播居中模版新',
                'x1': rv_x1, 'y1': content_top,
                'x2': rv_x2, 'y2': y2,
                'width': rv_x2 - rv_x1,
                'height': height,
                'card_count': _count_cards_in_range(recycler, content_top, first_y),
                'title_bounds': None,
                'cards': [],
            })

    # ── 连续去重：同名标题只保留第一个（避免标题条被切成零高度区域） ──
    deduped = [titles[0]]
    for t in titles[1:]:
        if t['name'] == deduped[-1]['name']:
            continue  # 跳过连续同名
        deduped.append(t)
    titles = deduped

    # ── 每个标题 → 一个区域（标题_Y → 下一个标题_Y） ──
    for i, t in enumerate(titles):
        next_y = titles[i + 1]['y1'] - 2 if i + 1 < len(titles) else rv_y2
        height = next_y - t['y1']
        if height > 0:
            regions.append({
                'name': t['name'],
                'x1': rv_x1, 'y1': t['y1'],
                'x2': rv_x2, 'y2': next_y,
                'width': rv_x2 - rv_x1,
                'height': height,
                'card_count': _count_cards_in_range(recycler, t['y1'], next_y),
                'title_bounds': t['bounds'],
                'cards': [],
            })

    return regions


def _heuristic_from_recycler(recycler):
    """
    回退：基于 Y 坐标间隙的启发式分割。
    当 RecyclerView 中没有模板标题时使用。
    """
    # 收集所有有 bounds 的子节点
    items = []
    for child in list(recycler):
        a = child.attrib
        b = parse_bounds(a.get('bounds', ''))
        if b:
            items.append({'bounds': b, 'desc': a.get('content-desc', '')})

    if not items:
        return []

    # 按 Y 分组
    items.sort(key=lambda x: (x['bounds'][1], x['bounds'][0]))
    heights = [it['bounds'][3] - it['bounds'][1] for it in items]
    avg_h = sum(heights) / len(heights) if heights else 100

    groups = []
    current = [items[0]]
    for i in range(1, len(items)):
        prev_bottom = items[i - 1]['bounds'][3]
        curr_top = items[i]['bounds'][1]
        if curr_top - prev_bottom > avg_h * 0.5:
            groups.append(current)
            current = [items[i]]
        else:
            current.append(items[i])
    if current:
        groups.append(current)

    regions = []
    rv_x1 = min(it['bounds'][0] for it in items)
    rv_x2 = max(it['bounds'][2] for it in items)
    for i, g in enumerate(groups):
        xs = [it['bounds'][0] for it in g] + [it['bounds'][2] for it in g]
        ys = [it['bounds'][1] for it in g] + [it['bounds'][3] for it in g]
        regions.append({
            'name': f'auto_group_{i + 1}',
            'x1': rv_x1, 'y1': min(ys),
            'x2': rv_x2, 'y2': max(ys),
            'width': rv_x2 - rv_x1,
            'height': max(ys) - min(ys),
            'card_count': len(g),
            'title_bounds': None,
            'cards': [],
        })

    return regions


# ── 测试入口 ──
if __name__ == '__main__':
    import sys, json
    xml_path = sys.argv[1] if len(sys.argv) > 1 else None
    if not xml_path:
        print("用法: py -3.9 template_region_extractor.py <window_dump.xml>")
        sys.exit(1)

    with open(xml_path, 'r', encoding='utf-8') as f:
        raw = f.read()
    raw = re.sub(r'<\s+(\w)', r'<\1', raw)
    raw = re.sub(r'<\s*/(\w)', r'</\1', raw)
    raw = re.sub(r'(\w)\s*-\s*(\w)', r'\1-\2', raw)
    raw = re.sub(r'<\?xml[^>]*\?>', '<?xml version="1.0" encoding="utf-8"?>', raw)
    root = ET.fromstring(raw)

    recycler = _find_recycler(root)
    if recycler is not None:
        print(f"RecyclerView bounds: {recycler.attrib.get('bounds','')}")
        regions = extract_template_regions(root)
        print(f"\n提取到 {len(regions)} 个区域:")
        for r in regions:
            print(f"  {r['name']:30s} [{r['x1']},{r['y1']}][{r['x2']},{r['y2']}]  "
                  f"{r['width']}x{r['height']}  cards={r['card_count']}")
    else:
        print("未找到 RecyclerView(id=content)")
