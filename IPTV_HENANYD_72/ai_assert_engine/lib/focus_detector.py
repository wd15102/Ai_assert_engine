#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
焦点检测模块 — XML vs 图像双通道 + 坐标映射 + 标记图生成

优先级：XML > 图像处理

--- XML 模式（推荐，uiautomator dump）---
  直接解析 XML 中 focused="true" 的 bounds 属性，像素级精确
    find_focus_from_xml('uiautomator_dump.xml', 'screen.png', blocks)
    → 返回焦点坐标 → 映射到模板/卡片 → 生成绿框标记图

--- 单图模式（兜底，图像处理）---
  无 XML 时在截图直接找白色细框
    find_focus_from_image('screen.png', blocks)

--- 双图模式（调试用）---
  帧差法找变化区域
    detect_focus('之前.png', '之后.png', blocks)

--- 输出 ---
  结果 dict + 绿框标记图（focus_marked.png），直接发给AI分析
"""

import os, cv2, numpy as np, time, re, xml.etree.ElementTree as ET
from typing import Optional

try:
    from lib.logger import log
except ImportError:
    def log(msg, level='INFO'):
        print(f"[{level}] {msg}")


try:
    from lib.adb_utils import dump_uiautomator
except ImportError:
    def dump_uiautomator(out_dir=None):
        log('[FOCUS] dump_uiautomator 不可用', 'WARN')
        return None


try:
    from engine_config.config import FOCUS_BOX_COLOR
except ImportError:
    FOCUS_BOX_COLOR = (0, 255, 0)  # 兜底绿色


SCREEN_W = 1920  # 屏幕宽度，裁剪块也是全屏宽
_FOCUS_RGB_LOWER = (200, 200, 200)  # 焦点框颜色下限（允许轻微色偏）
_FOCUS_RGB_UPPER = (255, 255, 255)


def _cv2_imread(path):
    """cv2.imread 的 Unicode 路径兼容版（解决 Windows 中文路径 fopen 失败）"""
    try:
        return cv2.imdecode(np.fromfile(path, dtype=np.uint8), cv2.IMREAD_COLOR)
    except Exception:
        return None


# ══════════════════════════════════════════════════════════════
# XML 找焦 — 解析 uiautomator dump 获取精确焦点框
# ══════════════════════════════════════════════════════════════

def _parse_bounds(bounds_str: str) -> Optional[list]:
    """
    解析 bounds="[x1,y1][x2,y2]" 为 [x, y, w, h]
    示例: "[77,415][511,711]" → [77, 415, 434, 296]
    """
    if not bounds_str or '][' not in bounds_str:
        return None
    try:
        parts = bounds_str.replace('[', '').split(']')
        x1, y1 = parts[0].split(',')
        x2, y2 = parts[1].split(',')
        return [int(x1), int(y1), int(x2) - int(x1), int(y2) - int(y1)]
    except (ValueError, IndexError):
        return None


def find_focus_from_xml(img_path: str, blocks: list,
                        xml_path: str = None,
                        out_dir: str = '') -> dict:
    """
    从 uiautomator dump XML 解析 focused="true" 元素获取精确焦点框。

    流程：
      1. dump XML（或使用已存在的 xml_path）
      2. 遍历所有 node，找 focused="true" 的元素
      3. 取其 bounds 属性 → focus_rect
      4. 坐标映射 + 画绿框

    参数：
      img_path: 对应截图路径（用于画标记图）
      blocks: 裁剪块列表 [{y_start, y_end, card_count, template_name}, ...]
      xml_path: 已有 XML 路径（None 则自动 dump）
      out_dir: 标记图输出目录

    返回：同 find_focus_from_image 格式
    """
    t0 = time.time()
    log('[FOCUS] XML 找焦模式', 'INFO')

    # 1. 获取 XML
    local_xml = xml_path or dump_uiautomator(out_dir or os.path.dirname(img_path))
    if not local_xml or not os.path.exists(local_xml):
        log('[FOCUS] XML dump 失败，降级到图像处理', 'WARN')
        return find_focus_from_image(img_path, blocks, out_dir)

    # 2. 解析 XML 找 focused="true"
    try:
        tree = ET.parse(local_xml)
        root = tree.getroot()
        # 取所有 focused="true" 节点，选面积最大的外层容器
        # 有的卡片只有海报（无标题），有的有标题+海报
        # 面积最大的自然包含全部可见内容，自动适配两种场景
        focused_nodes = root.findall('.//*[@focused="true"]')
        if not focused_nodes:
            focused_nodes = root.findall('.//*[@focused]')
            focused_nodes = [n for n in focused_nodes
                             if n.get('focused', '').strip() in ('true', 'True')]
        if focused_nodes and len(focused_nodes) > 1:
            # 按面积降序排列，取最大
            def _area(n):
                b = n.get('bounds', '')
                if '][' not in b:
                    return 0
                try:
                    parts = b.replace('[', '').split(']')
                    x1, y1 = parts[0].split(',')
                    x2, y2 = parts[1].split(',')
                    return (int(x2) - int(x1)) * (int(y2) - int(y1))
                except (ValueError, IndexError):
                    return 0
            focused_nodes.sort(key=_area, reverse=True)
            log(f'[FOCUS] 共{len(focused_nodes)}个focused节点, 取面积最大', 'INFO')
    except ET.ParseError as e:
        log(f'[FOCUS] XML 解析失败: {e}', 'ERROR')
        return find_focus_from_image(img_path, blocks, out_dir)

    if not focused_nodes:
        log('[FOCUS] XML 中未找到 focused="true" 元素', 'WARN')
        return find_focus_from_image(img_path, blocks, out_dir)

    # 3. 取 bounds
    node = focused_nodes[0]
    bounds_str = node.get('bounds', '')
    class_name = node.get('class', '')
    log(f'[FOCUS] focused 元素: class={class_name}, bounds="{bounds_str}"', 'INFO')

    focus_rect = _parse_bounds(bounds_str)
    if not focus_rect:
        log(f'[FOCUS] bounds 解析失败: "{bounds_str}"', 'WARN')
        return find_focus_from_image(img_path, blocks, out_dir)

    fx, fy, fw, fh = focus_rect
    log(f'[FOCUS] XML 焦点框: [{fx},{fy},{fw},{fh}]', 'INFO')

    # 4. 坐标映射
    mapping = map_focus_to_card(focus_rect, blocks)
    template_name = mapping.get('template_name', '') if 'error' not in mapping else ''
    card_pos = mapping.get('card_pos', '') if 'error' not in mapping else ''

    # 5. 画绿标记图
    marked = draw_focus_mark(img_path, focus_rect,
                             template_name, card_pos,
                             out_dir or os.path.dirname(img_path))

    elapsed = time.time() - t0
    log(f'[FOCUS] XML 找焦耗时: {elapsed:.2f}s', 'INFO')
    if 'error' in mapping:
        log(f'[FOCUS] 坐标映射: {mapping["error"]}', 'WARN')
    else:
        log(f'[FOCUS] → {template_name} / {card_pos}', 'AI')

    return {
        'has_focus': True,
        'focus_rect': focus_rect,
        'template_name': template_name,
        'card_index': mapping.get('card_index', -1),
        'card_pos': card_pos,
        'marked_img': marked or '',
        'mapping': mapping,
        'method': 'xml',
        'xml_node_class': class_name,
        'xml_bounds': bounds_str,
    }


# ══════════════════════════════════════════════════════════════
# 单图找焦 — 在当前截图上直接找白色焦点框
# ══════════════════════════════════════════════════════════════

def find_focus_from_image(img_path: str, blocks: list,
                          out_dir: str = '', debug: bool = False) -> dict:
    """
    单图模式：在当前截图上直接找白色焦点框（2-3px 细矩形边框）。

    流程：
      1. 灰度图 + 高阈值 → 只保留亮白色像素（即焦点框边缘）
      2. 形态学膨胀连接断裂边缘
      3. 找轮廓，按矩形度/面积筛选
      4. 找到的焦点框 → 画绿框 → 坐标映射 → 返回

    参数：
      img_path: 当前截图路径（焦点已移动到位）
      blocks: 裁剪块列表 [{y_start, y_end, card_count, template_name}, ...]
      out_dir: 标记图输出目录（默认 img_path 所在目录）
      debug: 是否保存中间调试图

    返回：
      {
        'has_focus': bool,         # 是否找到白色焦点框
        'focus_rect': [x,y,w,h],   # 焦点框矩形，None 表示未找到
        'template_name': str,       # 命中的模板名
        'card_index': int,          # 第几张卡片
        'card_pos': str,            # 中文描述
        'marked_img': str,          # 绿框标记图路径
        'mapping': dict,            # 坐标映射详情
        'method': 'single_image',   # 标记使用单图法
      }
    """
    t0 = time.time()

    img = _cv2_imread(img_path)
    if img is None:
        return {'has_focus': False, 'focus_rect': None,
                'template_name': '', 'card_index': -1, 'card_pos': '',
                'marked_img': '', 'mapping': {'error': '无法读取图片'},
                'method': 'single_image'}

    h, w = img.shape[:2]
    log(f'[FOCUS] 单图找焦: {img_path} ({w}x{h})', 'INFO')

    # ── 1. Canny 边缘检测 ──
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(gray, 50, 150)

    # ── 2. 膨胀连接断裂边缘 ──
    dilated = cv2.dilate(edges, np.ones((3, 3), np.uint8), iterations=2)

    if debug:
        debug_path = os.path.join(out_dir or os.path.dirname(img_path),
                                  'focus_debug_edges.png')
        cv2.imwrite(debug_path, dilated)
        log(f'[FOCUS] 边缘调试图: {debug_path}', 'FILE')

    # ── 3. 找轮廓 → 筛选 4 顶点矩形 ──
    contours, _ = cv2.findContours(dilated, cv2.RETR_EXTERNAL,
                                   cv2.CHAIN_APPROX_SIMPLE)
    log(f'[FOCUS] 找到 {len(contours)} 个轮廓', 'INFO')

    if not contours:
        return {'has_focus': False, 'focus_rect': None,
                'template_name': '', 'card_index': -1, 'card_pos': '',
                'marked_img': '', 'mapping': {'error': '未找到任何轮廓'},
                'method': 'single_image'}

    # ── 4. 筛选接近 4 顶点的矩形轮廓 ──
    screen_area = w * h
    candidates = []
    for cnt in contours:
        area = cv2.contourArea(cnt)
        if area < 5000 or area > screen_area * 0.6:
            continue

        x, y, cw, ch = cv2.boundingRect(cnt)
        if ch < 50 or cw < 50:
            continue
        aspect = cw / ch if ch > 0 else 0
        if not (0.6 < aspect < 4):
            continue

        peri = cv2.arcLength(cnt, True)
        approx = cv2.approxPolyDP(cnt, 0.02 * peri, True)
        if len(approx) != 4:
            continue  # 必须是 4 顶点的矩形

        rect_area = cw * ch
        rectness = area / rect_area if rect_area > 0 else 0
        # 选靠近屏幕上方的矩形（焦点在顶部卡片区）
        top_score = 1.0 / (y + 1)
        score = area * rectness * top_score
        candidates.append({
            'rect': [x, y, cw, ch],
            'score': score,
            'area': area,
            'aspect': aspect,
            'rectness': rectness,
        })

    if not candidates:
        return {'has_focus': False, 'focus_rect': None,
                'template_name': '', 'card_index': -1, 'card_pos': '',
                'marked_img': '', 'mapping': {'error': '无符合焦点框形状的区域'},
                'method': 'single_image'}

    candidates.sort(key=lambda c: c['score'], reverse=True)
    best = candidates[0]
    focus_rect = best['rect']

    log(f'[FOCUS] 最佳候选: rect={focus_rect}, score={best["score"]:.0f}, '
        f'area={best["area"]}, aspect={best["aspect"]:.2f}', 'INFO')

    # ── 5. 坐标映射 ──
    mapping = map_focus_to_card(focus_rect, blocks)
    template_name = mapping.get('template_name', '') if 'error' not in mapping else ''
    card_pos = mapping.get('card_pos', '') if 'error' not in mapping else ''

    # ── 6. 画绿标记图 ──
    marked = draw_focus_mark(img_path, focus_rect,
                             template_name, card_pos,
                             out_dir or os.path.dirname(img_path))

    elapsed = time.time() - t0
    log(f'[FOCUS] 单图找焦耗时: {elapsed:.2f}s', 'INFO')
    if 'error' in mapping:
        log(f'[FOCUS] 坐标映射: {mapping["error"]}', 'WARN')
    else:
        log(f'[FOCUS] → {template_name} / {card_pos}', 'AI')

    return {
        'has_focus': True,
        'focus_rect': focus_rect,
        'template_name': template_name,
        'card_index': mapping.get('card_index', -1),
        'card_pos': card_pos,
        'marked_img': marked or '',
        'mapping': mapping,
        'method': 'single_image',
        'candidates_count': len(candidates),
    }


# ══════════════════════════════════════════════════════════════
# XML 模板标题查找 — 根据焦点 Y 坐标找所在模板名
# ══════════════════════════════════════════════════════════════

def _find_template_title_for_focus(xml_path: str, focus_rect: list) -> str:
    """
    解析 XML 中模板标记节点（标题），根据焦点 Y 坐标找到对应模板名。

    参数:
      xml_path: uiautomator dump XML 路径
      focus_rect: [x, y, w, h] 焦点框

    返回:
      str — 模板标题（如 "首屏4横图通栏模板"），未找到返回 ""
    """
    if not xml_path or not os.path.exists(xml_path):
        return ''
    try:
        tree = ET.parse(xml_path)
        root = tree.getroot()
    except ET.ParseError:
        return ''

    fx, fy, fw, fh = focus_rect
    focus_top = fy
    focus_center_y = fy + fh // 2

    # 收集所有可能的模板标题节点
    # 策略：找 content-desc 非空、class 为 TextView 或 ViewGroup 的节点
    # 且在焦点上方（或包含焦点的区域）
    candidates = []

    # XML 标签是完整类名（如 android.view.View），不是 'node'
    for node in root.iter():
        cd = node.get('content-desc', '').strip()
        bounds_str = node.get('bounds', '')
        cls = node.get('class', '')

        # content-desc 为空的跳过
        if not cd:
            continue

        bounds = _parse_bounds(bounds_str)
        if not bounds:
            continue

        nx, ny, nw, nh = bounds
        node_center_y = ny + nh // 2

        # 找在焦点头部附近的标题节点（标题在模板区域的顶部）
        # 允许标题和焦点在同一模板段内（焦点 Y 在标题下方 0~500px 范围内）
        if ny <= focus_top and focus_top - ny <= 500:
            # 越接近焦点头部的标题越可能是当前模板
            distance = abs(focus_top - (ny + nh))
            candidates.append({
                'name': cd,
                'distance': distance,
                'bounds': bounds,
            })

    if not candidates:
        return ''

    # 按距离排序，取最近的
    candidates.sort(key=lambda c: c['distance'])
    title = candidates[0]['name']
    log(f'[FOCUS] XML 模板标题: "{title}" (距离{candidates[0]["distance"]}px)', 'INFO')
    return title


# ══════════════════════════════════════════════════════════════
# 帧差法 — 找两张图的最大变化区域
# ══════════════════════════════════════════════════════════════

def frame_diff(img_a_path: str, img_b_path: str,
               threshold: int = 30, min_area: int = 5000) -> dict:
    """
    帧差法检测两张截图之间的变化区域。

    参数：
      img_a_path: 焦点移动前的截图路径
      img_b_path: 焦点移动后的截图路径
      threshold: 二值化阈值（默认 30）
      min_area: 最小变化面积，低于此值视为无变化（默认 5000px²）

    返回：
      {
        'has_focus': bool,        # 是否检测到变化
        'focus_rect': [x,y,w,h],  # 最大变化矩形，无变化则为 None
        'diff_area': int,         # 差异像素总数
        'img_h': int, img_w: int, # 图片尺寸
      }
    """
    img_a = _cv2_imread(img_a_path)
    img_b = _cv2_imread(img_b_path)
    if img_a is None or img_b is None:
        log(f'[FOCUS] 帧差法无法读取图片', 'ERROR')
        return {'has_focus': False, 'focus_rect': None, 'diff_area': 0}

    h, w = img_a.shape[:2]

    gray_a = cv2.cvtColor(img_a, cv2.COLOR_BGR2GRAY)
    gray_b = cv2.cvtColor(img_b, cv2.COLOR_BGR2GRAY)
    gray_a = cv2.GaussianBlur(gray_a, (5, 5), 0)
    gray_b = cv2.GaussianBlur(gray_b, (5, 5), 0)

    diff = cv2.absdiff(gray_a, gray_b)
    _, thresh = cv2.threshold(diff, threshold, 255, cv2.THRESH_BINARY)

    kernel = np.ones((5, 5), np.uint8)
    thresh = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)

    total_diff = cv2.countNonZero(thresh)
    contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    if not contours or total_diff < min_area:
        log(f'[FOCUS] 帧差法: 变化像素={total_diff}, 低于阈值{min_area}, 视为无焦点移动', 'WARN')
        return {'has_focus': False, 'focus_rect': None, 'diff_area': total_diff,
                'img_h': h, 'img_w': w}

    max_contour = max(contours, key=cv2.contourArea)
    x, y, cw, ch = cv2.boundingRect(max_contour)

    log(f'[FOCUS] 帧差法: 变化区域 ({x},{y},{cw},{ch}), 差异像素={total_diff}', 'INFO')
    return {
        'has_focus': True,
        'focus_rect': [x, y, cw, ch],
        'diff_area': total_diff,
        'img_h': h,
        'img_w': w,
    }


# ══════════════════════════════════════════════════════════════
# 坐标映射 — 焦点坐标 → 模板 + 卡片
# ══════════════════════════════════════════════════════════════

def map_focus_to_card(focus_rect: list, blocks: list) -> dict:
    """
    将帧差检测到的焦点矩形映射到具体模板的坑位。

    参数：
      focus_rect: [x, y, w, h] — 帧差变化矩形
      blocks: [{sort, y_start, y_end, card_count, template_name, ...}]
              裁剪块列表（来自 scroll_and_crop_all 的 captured_blocks）

    返回：
      {
        'block': dict,             # 命中的裁剪块
        'template_name': str,      # 模板名
        'card_index': int,         # 第几张卡片(0起)
        'card_pos': str,           # 中文描述："左起第X张"
        'focus_center_x': int,
        'focus_center_y': int,
      } or {'error': str}
    """
    if not focus_rect or len(focus_rect) < 4:
        return {'error': '无效焦点矩形'}

    fx, fy, fw, fh = focus_rect
    cx, cy = fx + fw // 2, fy + fh // 2

    if not blocks:
        return {'error': '裁剪块列表为空'}

    # 按 Y 匹配裁剪块
    matched = None
    for b in blocks:
        ys = b.get('y_start', 0)
        ye = b.get('y_end', SCREEN_W)
        if ys <= cy <= ye:
            matched = b
            break

    if not matched:
        closest = min(blocks, key=lambda b: min(
            abs(cy - b.get('y_start', 0)), abs(cy - b.get('y_end', SCREEN_W))))
        return {'error': f'焦点Y={cy}未命中任何模板, 最近: {closest.get("template_name","?")}'}

    card_count = matched.get('card_count', 1)
    col_w = SCREEN_W / card_count
    col_idx = max(0, min(int(cx // col_w), card_count - 1))

    cn_col = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十']
    col_str = cn_col[col_idx] if col_idx < len(cn_col) else str(col_idx + 1)

    return {
        'block': matched,
        'template_name': matched.get('template_name', matched.get('marker_name', '')),
        'card_index': col_idx,
        'card_pos': f'左起第{col_str}张',
        'focus_center_x': cx,
        'focus_center_y': cy,
    }


# ══════════════════════════════════════════════════════════════
# 标记图 — 在原图上画绿框
# ══════════════════════════════════════════════════════════════

def draw_focus_mark(img_path: str, focus_rect: list,
                    template_name: str = '', card_pos: str = '',
                    out_dir: str = '',
                    box_color: tuple = None) -> Optional[str]:
    """
    在 img_path 上画焦点框，保存到 out_dir/focus_marked.png。

    Args:
        img_path: 原图路径
        focus_rect: [x, y, w, h]
        template_name: 模板名称（显示在框左上）
        card_pos: 卡片位置（显示在框左上）
        out_dir: 输出目录（默认 img 同目录）
        box_color: 框颜色 (B,G,R)，默认从 config.FOCUS_BOX_COLOR 读取

    返回标记图路径，失败返回 None。
    """
    if box_color is None:
        box_color = FOCUS_BOX_COLOR  # 从配置文件读取

    img = _cv2_imread(img_path)
    if img is None:
        return None

    x, y, w, h = focus_rect
    cv2.rectangle(img, (x, y), (x + w, y + h), box_color, 3)

    # 左上角信息文字（去掉 CM311 固件产生的 ???? 乱码）
    label = template_name or ''
    if card_pos:
        label += f' | {card_pos}'
    if label:
        label = re.sub(r'[?？]+', '', label).strip()
        cv2.putText(img, label, (x, max(y - 15, 25)),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.7, box_color, 2)

    if not out_dir:
        out_dir = os.path.dirname(img_path)
    os.makedirs(out_dir, exist_ok=True)

    out_path = os.path.join(out_dir, 'focus_marked.png')
    cv2.imwrite(out_path, img)
    log(f'[FOCUS] 标记图: {out_path}', 'FILE')
    return out_path


# ══════════════════════════════════════════════════════════════
# 一键调用：两张图 → 帧差法 + 坐标映射 + 标记图
# ══════════════════════════════════════════════════════════════

def detect_focus(img_path_before: str, img_path_after: str,
                 blocks: list, out_dir: str = '') -> dict:
    """
    焦点检测一站式入口。

    参数：
      img_path_before: 焦点移动前截图
      img_path_after:  焦点移动后截图
      blocks: 裁剪块列表 [{y_start, y_end, card_count, template_name}, ...]
      out_dir: 标记图输出目录（默认 img_path_after 所在目录）

    返回：
      {
        'has_focus': bool,
        'focus_rect': [x,y,w,h] or None,
        'template_name': str,
        'card_index': int or -1,
        'card_pos': str or '',
        'marked_img': str or '',
        'mapping': dict or {'error': str},
      }
    """
    t0 = time.time()

    # 1. 帧差法
    diff = frame_diff(img_path_before, img_path_after)
    if not diff['has_focus']:
        return {
            'has_focus': False,
            'focus_rect': None,
            'template_name': '',
            'card_index': -1,
            'card_pos': '',
            'marked_img': '',
            'mapping': {'error': '帧差法未检测到变化'},
        }

    # 2. 坐标映射
    mapping = map_focus_to_card(diff['focus_rect'], blocks)

    template_name = mapping.get('template_name', '') if 'error' not in mapping else ''
    card_pos = mapping.get('card_pos', '') if 'error' not in mapping else ''

    # 3. 标记图
    marked = draw_focus_mark(img_path_after, diff['focus_rect'],
                             template_name, card_pos,
                             out_dir or os.path.dirname(img_path_after))

    elapsed = time.time() - t0
    log(f'[FOCUS] detect_focus 总耗时: {elapsed:.2f}s', 'INFO')
    if 'error' in mapping:
        log(f'[FOCUS] 坐标映射: {mapping["error"]}', 'WARN')
    else:
        log(f'[FOCUS] → {template_name} / {card_pos}', 'AI')

    return {
        'has_focus': True,
        'focus_rect': diff['focus_rect'],
        'template_name': template_name,
        'card_index': mapping.get('card_index', -1),
        'card_pos': card_pos,
        'marked_img': marked or '',
        'mapping': mapping,
    }
