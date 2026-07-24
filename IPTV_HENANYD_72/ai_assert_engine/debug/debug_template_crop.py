# -*- coding: utf-8 -*-
"""
debug_template_crop.py — 调试模板区域裁剪
══════════════════════════════════════════════════════════════
用法：
  py -3.9 debug\debug_template_crop.py

步骤：
  1. 从设备 dump XML（压缩模式，只取 bounds/desc 不取 text）
  2. 截图
  3. 解析 RecyclerView 子节点结构
  4. 调用 extract_template_regions V2 提取区域
  5. 在截图上画出所有区域的边界 + 标签
  6. 裁剪并保存每个区域
  7. 保存调试数据到 debug/
"""
import sys, os, time, re, json

_PROJECT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(_PROJECT)
sys.path.insert(0, _PROJECT)

_OUT = os.path.join(_PROJECT, 'debug')
os.makedirs(_OUT, exist_ok=True)

from lib.adb_utils import adb_shell, screenshot, kill_stale_uiautomator
from lib.template_region_extractor import extract_template_regions, _find_recycler
import xml.etree.ElementTree as ET
from PIL import Image, ImageDraw


def _ts():
    return time.strftime('%Y%m%d_%H%M%S')


def dump_xml():
    """从设备 dump XML（压缩），kill stale + pull 到 debug/"""
    remote = '/sdcard/debug_dump.xml'
    local = os.path.join(_OUT, f'dump_{_ts()}.xml')

    kill_stale_uiautomator()
    time.sleep(0.5)

    adb_shell(['shell', 'rm', '-f', remote])
    out = adb_shell(['shell', 'uiautomator', 'dump', '--compressed', remote], timeout=20) or ''
    print(f'[dump] out={out.strip()[:120]}')

    if 'dumped' not in out:
        print('[FAIL] dump 失败')
        return None, None, None

    adb_shell(['pull', remote, local])
    adb_shell(['shell', 'rm', '-f', remote])

    if not os.path.exists(local) or os.path.getsize(local) < 100:
        print(f'[FAIL] 拉取失败或太小: {os.path.getsize(local) if os.path.exists(local) else "N/A"}')
        return None, None, None

    with open(local, 'r', encoding='utf-8') as f:
        raw = f.read()
    raw = _fix(raw)
    print(f'[OK] XML: {len(raw)}B → {local}')

    root = ET.fromstring(raw)
    return root, raw, local


def _fix(raw):
    s = raw
    s = re.sub(r'<\s+(\w)', r'<\1', s)
    s = re.sub(r'<\s*/(\w)', r'</\1', s)
    s = re.sub(r'(\w)\s*-\s*(\w)', r'\1-\2', s)
    s = re.sub(r'<\?xml[^>]*\?>', '<?xml version="1.0" encoding="utf-8"?>', s)
    return s


def parse_bounds(s):
    if not s:
        return None
    m = re.match(r'\[(\d+),(\d+)\]\[(\d+),(\d+)\]', s)
    return tuple(int(g) for g in m.groups()) if m else None


def print_children(recycler):
    """打印 RecyclerView 直系子节点"""
    children = list(recycler)
    rv_b = parse_bounds(recycler.attrib.get('bounds', ''))
    print(f'\nRecyclerView bounds: {recycler.attrib.get("bounds","")} ')
    print(f'直系子节点数: {len(children)}')
    print(f'{"─"*90}')

    for i, child in enumerate(children):
        a = child.attrib
        b = a.get('bounds', '')
        desc = a.get('content-desc', '')[:50]
        cls = a.get('class', '')[-30:]
        clickable = a.get('clickable', 'false')
        focused = '⭐' if a.get('focused', 'false') == 'true' else '  '
        print(f'  [{i:3d}] {focused} {cls:32s} {b:22s}  "{desc}"  clickable={clickable}')

    print(f'{"─"*90}')
    return children


def draw_regions(img_path, regions, rv_bounds):
    """在截图上画区域框 + 保存标注图"""
    img = Image.open(img_path)
    draw = ImageDraw.Draw(img)
    colors = ['red', 'lime', 'cyan', 'magenta', 'yellow', 'orange']

    for i, r in enumerate(regions):
        color = colors[i % len(colors)]
        x1, y1, x2, y2 = r['x1'], r['y1'], r['x2'], r['y2']
        draw.rectangle([x1, y1, x2, y2], outline=color, width=4)
        # 标签放框内顶部（避免 y1 太小导致负坐标）
        label = f"[{i+1}] {r['width']}x{r['height']} cards={r['card_count']}"
        label_y = max(y1 + 2, 2)
        draw.rectangle([x1 + 2, label_y, x1 + 2 + len(label) * 8 + 4, label_y + 22], fill=color)
        draw.text((x1 + 4, label_y + 2), label, fill='black')

    if rv_bounds:
        draw.rectangle(rv_bounds, outline='white', width=2)

    out_path = os.path.join(_OUT, f'debug_regions_{_ts()}.png')
    img.save(out_path)
    print(f'\n[SAVE] 标注图: {out_path}')
    return out_path


def crop_and_save(img_path, regions):
    """逐区域裁剪并保存"""
    img = Image.open(img_path)
    crops = []
    for i, r in enumerate(regions):
        safe = re.sub(r'[\\/:*?"<>|]', '_', r['name'])[:30]
        crop_path = os.path.join(_OUT, f'crop_{i + 1}_{safe}_{_ts()}.png')
        box = (r['x1'], r['y1'], r['x2'], r['y2'])
        try:
            cropped = img.crop(box)
            cropped.save(crop_path)
            crops.append(crop_path)
            print(f'[CROP] [{i + 1}] {r["name"]} → {crop_path}  ({r["width"]}x{r["height"]})')
        except Exception as e:
            print(f'[FAIL] [{i + 1}] {r["name"]} crop error: {e}')
    return crops


def main():
    print('=' * 60)
    print('[debug_template_crop] V2')
    print('=' * 60)

    # ── 1. dump XML ──
    print('\n── 步骤 1: dump XML')
    root, raw, xml_path = dump_xml()
    if root is None:
        return

    # ── 2. RecyclerView 结构 ──
    print('\n── 步骤 2: RecyclerView 子节点')
    recycler = _find_recycler(root)
    if recycler is None:
        print('[ABORT] 未找到 RecyclerView(id=content)')
        return
    children = print_children(recycler)
    rv_b = parse_bounds(recycler.attrib.get('bounds', ''))

    # ── 3. 截图 ──
    print('\n── 步骤 3: 截图')
    shot = screenshot(f'debug_{_ts()}.png')
    print(f'  截图: {shot}')
    if not shot:
        print('[ABORT] 截图失败')
        return

    # ── 4. extract_template_regions V2 ──
    print('\n── 步骤 4: extract_template_regions V2')
    try:
        regions = extract_template_regions(root)
    except Exception as e:
        print(f'[FAIL] exception: {e}')
        import traceback
        traceback.print_exc()
        regions = []

    print(f'  提取到 {len(regions)} 个区域:')
    for r in regions:
        print(f'    → {r["name"]:30s} [{r["x1"]},{r["y1"]}][{r["x2"]},{r["y2"]}] '
              f'{r["width"]}x{r["height"]}  cards={r["card_count"]}')

    # ── 5. 画框 ──
    print('\n── 步骤 5: 标注图')
    draw_regions(shot, regions, rv_b)

    # ── 6. 裁剪 ──
    print('\n── 步骤 6: 裁剪')
    crops = crop_and_save(shot, regions)

    # ── 7. 保存子节点 JSON ──
    dump_summary = []
    for i, child in enumerate(children):
        a = child.attrib
        dump_summary.append({
            'index': i,
            'class': a.get('class', ''),
            'bounds': a.get('bounds', ''),
            'content-desc': a.get('content-desc', ''),
            'clickable': a.get('clickable', 'false'),
            'focused': a.get('focused', 'false'),
            'resource-id': a.get('resource-id', ''),
        })
    summary_path = os.path.join(_OUT, f'children_{_ts()}.json')
    with open(summary_path, 'w', encoding='utf-8') as f:
        json.dump(dump_summary, f, ensure_ascii=False, indent=2)
    print(f'\n[SAVE] 子节点: {summary_path}')

    print('\n' + '=' * 60)
    print('[OK] Debug done')
    print('=' * 60)
    print(f'  标注图: debug_regions_*.png')
    print(f'  子节点: children_*.json')
    print(f'  裁剪图: crop_*.png')


if __name__ == '__main__':
    main()
