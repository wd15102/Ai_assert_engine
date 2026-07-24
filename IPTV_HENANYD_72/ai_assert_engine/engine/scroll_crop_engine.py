#!/usr/bin/env python3
#-*- coding: utf-8 -*-
"""
方案B：边截图边裁剪 → 焦点移动（DPAD_DOWN）逐模板推进

核心流程：
  1. 首屏截图 + dump XML
  2. 解析XML中所有clickable元素 → 按Y聚类为模板块
  3. 从首屏截图裁剪第一块可见的板块
  4. 按模板类型计算 DPAD_DOWN 次数，焦点下移到下一块
  5. 重复 (1)-(4) 直到所有预期模板都被覆盖
  6. 去重：同一Y区域的板块只保留第一次裁剪

特点：
  - 动态坐标，不依赖固定Y值
  - 用 DPAD_DOWN 焦点移动代替粗暴 swipe（不会跳过头）
  - 直播居中模板按7次，其他模板1-2次即可下移
"""
import os
import re
import time
from PIL import Image

from lib.element_checker import wait_page_stable

# ── 模板 → 焦点移动次数映射 ──
# 与 stub_parser.TEMPLATE_SCROLL_MAP 同步
TEMPLATE_SCROLL_MAP = {
    'common_live_mid2_template': 7,   # 直播居中模版新（11个卡片，需要7次下键才能出块）
}


def _get_scroll_presses(template_info, captured_count):
    """
    根据刚捕获的模板类型，决定需要按几次 DPAD_DOWN 才能将焦点移出该模板区域。
    template_info: 测试桩模板列表
    captured_count: 已捕获的模板数量（用于索引上一个模板）
    返回: 按键次数
    """
    # 默认：大部分模板按1次足够
    # 用户按模板逐个补充特殊值
    default_presses = 1
    if not template_info or captured_count <= 0:
        return default_presses
    # 上一个被捕获的模板（焦点目前所在的区域）
    prev_idx = captured_count - 1
    if prev_idx >= len(template_info):
        return default_presses
    prev_template = template_info[prev_idx]
    tid = prev_template.get('templateId', '')
    for keyword, presses in TEMPLATE_SCROLL_MAP.items():
        if keyword in tid:
            return presses
    return default_presses


# ── 从 Appium page_source XML 解析模板块 ──
# 使用模板标题标记（content-desc 含模板名）作为块分隔符
# 每块 = 标题区 + 下方所属的卡片

def _find_template_markers(xml):
    """
    解析 XML 中的模板标题标记节点。
    特征：clickable=false，content-desc 含'模板/通栏/列表/底部'等。
    返回排序后的列表 [{y_start, y_end, name, x_start, x_end}]。
    """
    markers = []
    for m in re.finditer(
        r'(?:content-desc|text)="([^"]*(?:模板|通栏|列表|底部|推荐)[^"]*)"[^>]*?'
        r'bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"',
        xml
    ):
        name = m.group(1).strip()
        x1, y1, x2, y2 = int(m.group(2)), int(m.group(3)), int(m.group(4)), int(m.group(5))
        if 'clickable="true"' in m.group(0):
            continue  # 跳过可点击的卡片，只取标题标记
        markers.append({
            'name': name,
            'y_start': y1,
            'y_end': y2,
            'x_start': x1,
            'x_end': x2,
        })
    markers.sort(key=lambda m: m['y_start'])
    return markers


def _parse_detail_cards_from_xml(xml, y_start, y_end, content_y_start=127):
    """
    在指定 Y 区域内解析所有 clickable 卡片。
    坐标直接从 XML bounds 读取。
    使用兼容正则（clickable 可出现在 bounds 前或后）。
    """
    cards = []
    seen_bounds = set()
    min_h = 30

    for m in re.finditer(
        r'<[a-zA-Z.]+[^>]*?clickable="true"[^>]*?bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"',
        xml
    ):
        x1, y1, x2, y2 = int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4))
        w, h = x2 - x1, y2 - y1

        if h < min_h:
            continue
        if y1 < y_start or y2 > y_end:
            continue
        if w >= 1920 * 0.9:
            continue

        bounds_key = (x1 // 10, y1 // 10, x2 // 10, y2 // 10)
        if bounds_key in seen_bounds:
            continue
        seen_bounds.add(bounds_key)

        cards.append({'x': x1, 'y': y1, 'x2': x2, 'y2': y2, 'w': w, 'h': h})

    # bounds在clickable前的情况
    if not cards:
        for m in re.finditer(
            r'bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"[^>]*?clickable="true"',
            xml
        ):
            x1, y1, x2, y2 = int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4))
            w, h = x2 - x1, y2 - y1
            if h < min_h or y1 < y_start or y2 > y_end or w >= 1920 * 0.9:
                continue
            bk = (x1 // 10, y1 // 10, x2 // 10, y2 // 10)
            if bk in seen_bounds:
                continue
            seen_bounds.add(bk)
            cards.append({'x': x1, 'y': y1, 'x2': x2, 'y2': y2, 'w': w, 'h': h})

    return cards


def parse_blocks_from_xml(xml):
    """
    从 Appium page_source XML 解析模板块（Appium XML 使用屏幕绝对坐标）。
    用模板标题标记分割区块，每块包含标题区域 + 下方卡片。
    返回 (blocks, content_y_start)
    blocks: [{sort, y_start, y_end, x_start, x_end, height, card_count, rows, marker_name}]
    """
    # 找内容区起始Y
    content_y = 127
    m = re.search(r'resource-id="com\.huawei\.tvbox:id/tabs_container"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', xml)
    if m:
        content_y = int(m.group(4))
    m = re.search(r'resource-id="com\.huawei\.tvbox:id/channel_tabs"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', xml)
    if m:
        content_y = min(content_y, int(m.group(4)))

    # 找所有模板标题标记
    markers = _find_template_markers(xml)

    if not markers:
        # 没有标题标记，回退到卡片聚类
        cards = _parse_detail_cards_from_xml(xml, 0, 99999, content_y)
        if not cards:
            return [], content_y
        return _cluster_cards_by_y(cards, content_y), content_y

    # 用标题标记分割：每个标题标记作为一个板块的上边界
    blocks = []
    for idx, marker in enumerate(markers):
        block_y_start = marker['y_start']
        if idx + 1 < len(markers):
            block_y_end = markers[idx + 1]['y_start']
        else:
            block_y_end = 99999

        # 在这个范围内找卡片
        cards = _parse_detail_cards_from_xml(xml, block_y_start, block_y_end)

        if not cards:
            # 标记下方扩展搜索
            min_search = marker['y_end'] + 50
            cards = _parse_detail_cards_from_xml(xml, min_search, block_y_end)

        y_end = max((c['y2'] for c in cards), default=marker['y_end'])
        x_start = min((c['x'] for c in cards), default=marker['x_start'])
        x_end = max((c['x2'] for c in cards), default=marker['x_end'])

        # 行分析
        row_details = []
        if cards:
            sorted_cards = sorted(cards, key=lambda c: c['y'])
            current_row = [sorted_cards[0]]
            for card in sorted_cards[1:]:
                if abs(card['y'] - current_row[0]['y']) < 30:
                    current_row.append(card)
                else:
                    row_details.append({'y': current_row[0]['y'], 'card_count': len(current_row)})
                    current_row = [card]
            row_details.append({'y': current_row[0]['y'], 'card_count': len(current_row)})

        blocks.append({
            'sort': idx + 1,
            'y_start': block_y_start,
            'y_end': y_end,
            'x_start': x_start,
            'x_end': x_end,
            'height': y_end - block_y_start,
            'card_count': len(cards),
            'rows': row_details,
            'marker_name': marker['name'],
        })

    return blocks, content_y


def _cluster_cards_by_y(cards, content_y_start, y_tolerance=30):
    """兜底：卡片按Y聚类为模板块（无标题标记时使用）"""
    if not cards:
        return []
    sorted_cards = sorted(cards, key=lambda c: c['y'])
    rows = []
    current_row = [sorted_cards[0]]
    for card in sorted_cards[1:]:
        if abs(card['y'] - current_row[0]['y']) < y_tolerance:
            current_row.append(card)
        else:
            rows.append(current_row)
            current_row = [card]
    rows.append(current_row)

    blocks = []
    current_block_rows = [rows[0]]
    for row in rows[1:]:
        prev_bottom = max(c['y2'] for c in current_block_rows[-1])
        this_top = min(c['y'] for c in row)
        if this_top - prev_bottom < y_tolerance * 3:
            current_block_rows.append(row)
        else:
            blocks.append(current_block_rows)
            current_block_rows = [row]
    blocks.append(current_block_rows)

    result = []
    for idx, block_rows in enumerate(blocks):
        all_cards = [c for row in block_rows for c in row]
        y_start = min(c['y'] for c in all_cards)
        y_end = max(c['y2'] for c in all_cards)
        x_start = min(c['x'] for c in all_cards)
        x_end = max(c['x2'] for c in all_cards)

        row_details = []
        for rc in block_rows:
            row_details.append({'y': rc[0]['y'], 'card_count': len(rc)})

        result.append({
            'sort': idx + 1,
            'y_start': y_start,
            'y_end': y_end,
            'x_start': x_start, 'x_end': x_end,
            'height': y_end - y_start,
            'card_count': len(all_cards),
            'rows': row_details,
            'marker_name': '',
        })
    return result


def make_block_fingerprint(b):
    """模板块指纹：用于去重，Y区域取整50px"""
    return round(b['y_start'] / 50) * 50


def dedup_blocks(seen_y_list, new_blocks):
    """过滤已见过Y区域的板块"""
    result = []
    for b in new_blocks:
        fp = make_block_fingerprint(b)
        if fp not in seen_y_list:
            result.append(b)
    return result


def crop_block_from_screenshot(img_path, block, margin=3, bottom_margin=10):
    """从截图裁剪指定模板块区域，返回 PIL Image"""
    img = Image.open(img_path)
    w, h = img.size
    left = max(0, block['x_start'] - margin)
    top = max(0, block['y_start'] - margin)
    right = min(w, block['x_end'] + margin)
    bottom = min(h, block['y_end'] + bottom_margin)
    return img.crop((left, top, right, bottom))


# ══════════════════════════════════════════════════════════════
# 旧版兼容：parse_blocks_from_xml（Appium page_source 版本）
# run.py 的预检查仍用这个，裁剪流程已改用 uiautomator
# ══════════════════════════════════════════════════════════════

def _legacy_find_content_y(xml, default_y=214):
    """从Appium XML找内容区起始Y"""
    m = re.search(r'resource-id="com\.huawei\.tvbox:id/tabs_container"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', xml)
    if m:
        return int(m.group(4))
    m = re.search(r'resource-id="com\.huawei\.tvbox:id/channel_tabs"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', xml)
    if m:
        return int(m.group(4))
    return default_y


def _legacy_parse_cards(xml, content_y_start=214, min_card_h=30):
    """旧版：从 Appium page_source XML 解析 clickable 元素"""
    sw = 1920
    mw = re.search(r'hierarchy[^>]*width="(\d+)"', xml)
    if mw:
        sw = int(mw.group(1))
    cards = []
    seen = set()
    for m in re.finditer(
        r'<([a-zA-Z.]+)([^>]*?)clickable="true"([^>]*?)bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"',
        xml
    ):
        fa = m.group(2) + m.group(3)
        x1, y1, x2, y2 = int(m.group(4)), int(m.group(5)), int(m.group(6)), int(m.group(7))
        w, h = x2 - x1, y2 - y1
        if h < min_card_h or y1 < content_y_start or w >= sw * 0.9:
            continue
        parent_region = xml[max(0, m.start()-800):m.start()]
        if re.search(r'resource-id="[^"]*(?:tab|channel_tab)[^"]*"', parent_region):
            continue
        rid_match = re.search(r'resource-id="([^"]+)"', fa)
        if rid_match:
            rid = rid_match.group(1)
            if any(k in rid for k in ['post_view', 'bg_', 'background', 'function_btn', 'function_new_']):
                continue
        bk = (x1 // 10, y1 // 10, x2 // 10, y2 // 10)
        if bk in seen:
            continue
        seen.add(bk)
        cards.append({'x': x1, 'y': y1, 'x2': x2, 'y2': y2, 'w': w, 'h': h})
    return cards


def _legacy_cluster(cards, content_y_start=214, y_tolerance=30):
    """旧版：卡片按Y聚类"""
    if not cards:
        return []
    sc = sorted(cards, key=lambda c: c['y'])
    rows = [[sc[0]]]
    for card in sc[1:]:
        if abs(card['y'] - rows[-1][0]['y']) < y_tolerance:
            rows[-1].append(card)
        else:
            rows.append([card])
    blocks = [rows[0]]
    for row in rows[1:]:
        prev_bot = max(c['y2'] for c in blocks[-1][-1])
        this_top = min(c['y'] for c in row)
        if this_top - prev_bot < y_tolerance * 3:
            blocks[-1].append(row)
        else:
            blocks.append([row])
    result = []
    for idx, block_rows in enumerate(blocks):
        ac = [c for r in block_rows for c in r]
        y1 = min(c['y'] for c in ac)
        y2 = max(c['y2'] for c in ac)
        result.append({
            'sort': idx + 1, 'y_start': y1, 'y_end': y2,
            'x_start': min(c['x'] for c in ac), 'x_end': max(c['x2'] for c in ac),
            'height': y2 - y1, 'card_count': len(ac),
            'rows': [{'y': r[0]['y'], 'card_count': len(r)} for r in block_rows],
        })
    return result

def scroll_and_crop_all(driver, adb_module, channel_title, template_info, screenshots_dir, lazy_scroll=7):
    """
    模板列表驱动裁剪：按测试桩模板顺序，逐模板移动焦点 → 定位 → 裁剪。

    流程：
      1. 首屏截图 + XML → 焦点在模板#0（直播居中模板） → 裁剪
      2. 查 TEMPLATE_SCROLL_MAP 获取按键次数 → DPAD_DOWN x N
      3. 截图 + XML → 焦点在模板#1 → 按标题标记定位并裁剪
      4. 重复直到覆盖全部模板

    参数：
      driver — Appium WebDriver
      adb_module — adb_utils 模块
      channel_title — 频道名
      template_info — 测试桩模板列表 [{templateId, templateName, ...}]
      screenshots_dir — 截图存放目录
      lazy_scroll — 每轮兜底按键次数

    返回：{
      'blocks': [{sort, y_start, y_end, crop_path, template_name, marker_name, ...}],
      'all_screenshots': [shot_info],
    }
    """
    from lib.logger import log
    safe_name = channel_title.replace('/', '_').replace('\\', '_').replace(' ', '_')
    clips_dir = os.path.join(screenshots_dir, f'{safe_name}_clips')
    os.makedirs(clips_dir, exist_ok=True)
    for f in os.listdir(clips_dir):
        os.remove(os.path.join(clips_dir, f))

    all_screenshots = []
    captured_blocks = []
    total_templates = len(template_info) if template_info else 0
    log(f'预期模板数: {total_templates}', 'INFO')
    for i, t in enumerate(template_info):
        tname = t.get('templateName', t.get('templateId', ''))
        tid = t.get('templateId', '')
        log(f'  [{i+1}/{total_templates}] {tname} ({tid})', 'INFO')

    for tmpl_idx in range(total_templates):
        if tmpl_idx >= total_templates:
            break
        cur_tmpl = template_info[tmpl_idx]
        cur_tname = cur_tmpl.get('templateName', cur_tmpl.get('templateId', ''))
        cur_tid = cur_tmpl.get('templateId', '')
        safe_tname = re.sub(r'[\\/:*?"<>| ]', '_', cur_tname).strip('_')

        log(f'── 模板 [{tmpl_idx+1}/{total_templates}] {cur_tname} ──', 'INFO')

        # ── 截图 ──
        suffix = f'_tmpl{tmpl_idx+1}_{safe_tname[:20]}'
        shot = adb_module.scroll_and_screenshot_once(channel_title, suffix=suffix)
        if not shot:
            log(f'  截屏失败，跳过模板 {cur_tname}', 'ERROR')
            continue
        all_screenshots.append(shot)
        log(f'  截图: {shot["filename"]} ({os.path.getsize(shot["file"])//1024}KB)', 'SCREEN')

        # ── dump XML ──
        xml = driver.page_source
        if not xml or len(xml) < 100:
            log(f'  page_source 获取失败', 'WARN')
            continue

        # ── 定位当前模板区域 ──
        block = _locate_current_template(xml, cur_tid, cur_tname, tmpl_idx)
        if not block:
            log(f'  无法定位模板区域，跳过', 'WARN')
            continue

        log(f'  定位: Y={block["y_start"]}-{block["y_end"]} ({block["card_count"]}卡片) {block.get("marker_name","")}', 'INFO')

        # ── 裁剪 ──
        try:
            cropped = crop_block_from_screenshot(shot['file'], block, margin=3)
            crop_name = f'{safe_name}_{safe_tname}.png'
            crop_path = os.path.join(clips_dir, crop_name)
            if os.path.exists(crop_path):
                crop_name = f'{safe_name}_{safe_tname}_{tmpl_idx+1}.png'
                crop_path = os.path.join(clips_dir, crop_name)
            cropped.save(crop_path)
            sz = os.path.getsize(crop_path) // 1024
            mn = block.get('marker_name', '') or ''
            log(f'  ✅ 裁剪: {crop_name} ({cropped.width}x{cropped.height}, {sz}KB) {mn}', 'SCREEN')
            log(f'  绝对路径: {os.path.abspath(crop_path)}', 'INFO')
            captured_blocks.append({
                'sort': tmpl_idx + 1,
                'y_start': block['y_start'],
                'y_end': block['y_end'],
                'card_count': block.get('card_count', 0),
                'crop_path': crop_path,
                'crop_name': crop_name,
                'step': tmpl_idx,
                'template_name': safe_tname,
                'marker_name': mn,
            })
        except Exception as e:
            log(f'  ✗ 裁剪失败: {e}', 'ERROR')
            continue

        # ── 移到下一个模板（最后一个不用移） ──
        if tmpl_idx < total_templates - 1:
            presses = _get_scroll_presses(template_info, tmpl_idx + 1)
            if tmpl_idx == 0:
                presses = _get_scroll_presses(template_info, 1)
            else:
                presses = _get_scroll_presses(template_info, tmpl_idx + 1)
                if presses <= 1:
                    presses = 1
            log(f'  ↓ DPAD_DOWN x{presses}', 'KEY')
            adb_module.dpad_down(presses)
            wait_page_stable(timeout=3)

    # ── 兜底 ──
    if len(captured_blocks) < total_templates and all_screenshots:
        missing = total_templates - len(captured_blocks)
        log(f'捕获{len(captured_blocks)}/{total_templates}，兜底补齐{missing}块', 'WARN')
        last_shot = all_screenshots[-1]
        img = Image.open(last_shot['file'])
        ih = img.height
        seg_h = ih // missing if missing > 0 else ih
        for i in range(missing):
            gi = len(captured_blocks) + i + 1
            top = i * seg_h
            bottom = ih if i == missing - 1 else (i + 1) * seg_h
            try:
                cropped = img.crop((0, top, img.width, bottom))
                t_ref = template_info[gi-1] if gi <= len(template_info) else {}
                tname = re.sub(r'[\\/:*?"<>| ]', '_', t_ref.get('templateName', f'fallback_{gi}')).strip('_')
                crop_name = f'{safe_name}_{tname}.png'
                crop_path = os.path.join(clips_dir, crop_name)
                cropped.save(crop_path)
                log(f'  兜底: [{gi}] {tname} Y={top}-{bottom}', 'WARN')
                captured_blocks.append({
                    'sort': gi, 'y_start': top, 'y_end': bottom,
                    'card_count': t_ref.get('card_count', 0),
                    'crop_path': crop_path, 'crop_name': crop_name, 'step': -1,
                    'template_name': tname,
                })
            except Exception as e:
                log(f'  兜底失败: {e}', 'ERROR')

    return {'blocks': captured_blocks, 'all_screenshots': all_screenshots}


def _locate_current_template(xml, template_id, template_name, tmpl_index):
    """
    在 XML 中定位当前焦点所在模板的屏幕区域。

    策略：
    - 模板#0（index=0）：首个出现的 clickable 卡片区域（直播居中模板无标题标记）
    - 后续模板：按标记索引优先（markers 按 Y 排序 = 模板显示顺序）
    - 交叉验证：去版本号的模板名应能部分匹配标记名

    返回 dict 或 None
    """
    markers = _find_template_markers(xml)

    if tmpl_index == 0:
        return _locate_first_template(xml)

    # 策略：标记索引优先（markers 顺序 = 模板在屏幕上的显示顺序）
    marker_idx = tmpl_index - 1  # 第0个是直播居中（无标记），后续模板从标记0开始
    if marker_idx < len(markers):
        marker = markers[marker_idx]
        # 交叉验证：去版本号前缀后的模板名应能部分匹配标记名
        clean_name = re.sub(r'^[\d.\s,、-]+', '', template_name)
        if clean_name in marker['name'] or marker['name'] in clean_name or marker['name'] in template_name:
            return _build_block_from_marker(xml, marker)
        # 验证不通过仍信任索引（标记顺序通常对齐模板顺序）
        return _build_block_from_marker(xml, marker)

    # 兜底：关键词匹配
    keywords = _extract_template_keywords(template_name)
    for marker in markers:
        mname = marker['name']
        for kw in keywords:
            if kw in mname:
                return _build_block_from_marker(xml, marker)

    return None


def _extract_template_keywords(template_name):
    """从模板名中提取关键词用于匹配XML标题标记"""
    # 直接返回模板名中的显著部分
    parts = re.split(r'[\s_\-.]+', template_name)
    # 过滤掉纯数字、短词
    keywords = [p for p in parts if len(p) >= 2 and not p.isdigit()]
    if not keywords:
        keywords = [template_name]
    return keywords


def _locate_first_template(xml):
    """定位首屏第一个模板（直播居中模板）：内容区下方第一个clickable卡片群"""
    content_y = 127
    m = re.search(r'resource-id="com\.huawei\.tvbox:id/tabs_container"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', xml)
    if m:
        content_y = int(m.group(4))

    # 收集所有clickable卡片
    all_cards = []
    seen = set()
    for m in re.finditer(
        r'<[a-zA-Z.]+[^>]*?clickable="true"[^>]*?bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"',
        xml
    ):
        x1, y1, x2, y2 = int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4))
        w, h = x2 - x1, y2 - y1
        if h < 30 or w >= 1920 * 0.9:
            continue
        bk = (x1 // 10, y1 // 10, x2 // 10, y2 // 10)
        if bk in seen:
            continue
        seen.add(bk)
        all_cards.append({'x': x1, 'y': y1, 'x2': x2, 'y2': y2, 'w': w, 'h': h})

    if not all_cards:
        return None

    all_cards.sort(key=lambda c: c['y'])

    # 跳过标题标记区域：找到第一个模板标题标记的Y（如果有），直播区只取标记上方
    # 没有标题标记 → 第一个gap前的卡片群就是直播区
    # 直播区特点：y < 500 且连续卡片
    live_cards = [c for c in all_cards if c['y'] < 500 and c['y'] > content_y]
    if not live_cards:
        # 如果第一批卡片Y就超过500，取前N个
        live_cards = all_cards[:15]

    # 聚类：gap > 80 表示新区域
    clusters = [[live_cards[0]]]
    for c in live_cards[1:]:
        if c['y'] - clusters[-1][-1]['y'] < 80:
            clusters[-1].append(c)
        else:
            clusters.append([c])

    # 第一个cluster就是直播区
    cluster = clusters[0]
    y_start = min(c['y'] for c in cluster)
    y_end = max(c['y2'] for c in cluster)
    x_start = min(c['x'] for c in cluster)
    x_end = max(c['x2'] for c in cluster)

    # 向上扩展到内容区起始
    y_start = max(content_y, y_start - 10)

    # 行分析
    sorted_c = sorted(cluster, key=lambda c: c['y'])
    rows = []
    if sorted_c:
        cr = [sorted_c[0]]
        for c in sorted_c[1:]:
            if abs(c['y'] - cr[0]['y']) < 30:
                cr.append(c)
            else:
                rows.append({'y': cr[0]['y'], 'card_count': len(cr)})
                cr = [c]
        rows.append({'y': cr[0]['y'], 'card_count': len(cr)})

    return {
        'sort': 1,
        'y_start': y_start,
        'y_end': y_end,
        'x_start': x_start,
        'x_end': x_end,
        'height': y_end - y_start,
        'card_count': len(cluster),
        'rows': rows,
        'marker_name': '(live)',
    }


def _build_block_from_marker(xml, marker):
    """从一个标题标记构建完整的模板块（含下方卡片）"""
    # 搜索范围：从标题Y到下一个标记或屏幕底部
    markers = _find_template_markers(xml)
    this_marker_top = marker['y_start']
    # 找下一个标记的Y作为上界
    y_end_limit = 99999
    for m in markers:
        if m['y_start'] > this_marker_top:
            y_end_limit = m['y_start']
            break

    cards = _parse_detail_cards_from_xml(xml, this_marker_top, y_end_limit)

    if not cards:
        # 尝试从标题标记底部开始搜索
        cards = _parse_detail_cards_from_xml(xml, marker['y_end'] + 30, y_end_limit)

    y_end = max((c['y2'] for c in cards), default=marker['y_end'] + 200)
    x_start = min((c['x'] for c in cards), default=marker['x_start'])
    x_end = max((c['x2'] for c in cards), default=marker['x_end'])

    # 行分析
    row_details = []
    if cards:
        sc = sorted(cards, key=lambda c: c['y'])
        cr = [sc[0]]
        for c in sc[1:]:
            if abs(c['y'] - cr[0]['y']) < 30:
                cr.append(c)
            else:
                row_details.append({'y': cr[0]['y'], 'card_count': len(cr)})
                cr = [c]
        row_details.append({'y': cr[0]['y'], 'card_count': len(cr)})

    return {
        'sort': 0,
        'y_start': this_marker_top,
        'y_end': y_end,
        'x_start': x_start,
        'x_end': x_end,
        'height': y_end - this_marker_top,
        'card_count': len(cards),
        'rows': row_details,
        'marker_name': marker['name'],
    }
