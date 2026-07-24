#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
焦点检测增强模块 — P1：焦点状态检测 + AI 视觉验证
══════════════════════════════════════════════════════════════════

在 focus_detector（XML + 帧差法）之上封装一层高层 API，
新增 AI VQA 交叉验证能力。

核心用途：
  - 导航完成后确认焦点落在期望元素上
  - 双通道：XML 读坐标 + AI 看画面 → 交叉验证
  - 生成焦点标记标签（可直接发给 AI 作为参考图）
"""

import os
import subprocess
import time
import xml.etree.ElementTree as ET
from typing import Optional

from lib.adb_utils import adb_shell, screenshot, current_device, DUMP_LOCK, kill_stale_uiautomator
from engine_config.config import SCREENSHOT_DIR
from lib.focus_detector import find_focus_from_xml, draw_focus_mark


def _log(msg, level='INFO'):
    from lib.logger import log
    log(msg, level)


def _dump_xml_target(out_dir: str = None, retries: int = 2, time_budget: float = 0) -> Optional[str]:
    """
    委托给 adb_utils.dump_uiautomator（已含 Appium 首选举 + A->C 降级链）
    统一 dump 入口。
    time_budget: >0 时 shell dump 超预算后立即放弃。
    """
    from lib.adb_utils import dump_uiautomator
    return dump_uiautomator(out_dir=out_dir, retries=retries, time_budget=time_budget)


# ══════════════════════════════════════════════════════════════
# 焦点信息获取
# ══════════════════════════════════════════════════════════════

def get_focus_info(out_dir: str = None) -> dict:
    """
    从 XML 中找 focused="true" 的节点，返回详细信息。

    返回：
      {
        'has_focus': bool,
        'bounds': str or '',      # e.g. '[100,200][300,400]'
        'content_desc': str,
        'text': str,
        'class': str,
        'package': str,
      }
    """
    result = {
        'has_focus': False,
        'bounds': '',
        'content_desc': '',
        'text': '',
        'class': '',
        'package': '',
    }

    xml_path = _dump_xml_target(out_dir)
    if not xml_path:
        _log('get_focus_info: XML dump 失败', 'WARN')
        return result

    try:
        tree = ET.parse(xml_path)
        root = tree.getroot()
        # 取所有 focused="true" 节点，选面积最大的外层容器
        # 有的卡片只有海报（无标题），有的有标题+海报
        # 面积最大的自然包含全部可见内容，自动适配两种场景
        focus_nodes = root.findall('.//*[@focused="true"]')
        if not focus_nodes:
            focus_nodes = root.findall('.//*[@focused]')
            focus_nodes = [n for n in focus_nodes
                           if n.get('focused', '').strip() in ('true', 'True')]
        if focus_nodes:
            def _bounds_area(n):
                b = n.attrib.get('bounds', '')
                if '][' not in b:
                    return 0
                try:
                    parts = b.replace('[', '').split(']')
                    x1, y1 = parts[0].split(',')
                    x2, y2 = parts[1].split(',')
                    return (int(x2) - int(x1)) * (int(y2) - int(y1))
                except (ValueError, IndexError):
                    return 0
            focus_nodes.sort(key=_bounds_area, reverse=True)
            focus_node = focus_nodes[0]
            result['has_focus'] = True
            result['bounds'] = focus_node.attrib.get('bounds', '')
            result['content_desc'] = focus_node.attrib.get('content-desc', '')
            result['text'] = focus_node.attrib.get('text', '')
            result['class'] = focus_node.attrib.get('class', '')
            result['package'] = focus_node.attrib.get('package', '')
            _log(f'焦点(取最大面积): class={result["class"]} bounds={result["bounds"]} '
                 f'desc="{result["content_desc"][:30]}"', 'INFO')
            if len(focus_nodes) > 1:
                _log(f'共{len(focus_nodes)}个focused节点, 最大面积=[{focus_node.attrib.get("bounds","")}]', 'DEBUG')
        else:
            _log('XML 中未找到 focused=true 的节点', 'WARN')
    except Exception as e:
        _log(f'解析 XML 找焦点失败: {e}', 'WARN')

    # 清理临时文件
    try:
        os.remove(xml_path)
    except OSError:
        pass

    return result


# ══════════════════════════════════════════════════════════════
# 确认焦点是否在目标元素上
# ══════════════════════════════════════════════════════════════

def is_element_focused(text: str = None, desc: str = None) -> bool:
    """
    判断当前焦点是否落在指定元素上。

    text: 按 text 属性匹配
    desc: 按 content-desc 属性匹配

    返回 True/False
    """
    info = get_focus_info()
    if not info['has_focus']:
        return False

    if text and text in info['text']:
        return True
    if desc and desc in info['content_desc']:
        return True
    return False


def wait_for_focus_on(desc: str = None, text: str = None,
                      timeout: float = 10, interval: float = 0.5) -> bool:
    """
    等待焦点落在指定元素上。

    适用于：
      导航到目标频道后，等待焦点正确落位再截图。
    """
    deadline = time.time() + timeout
    while time.time() < deadline:
        if is_element_focused(text=text, desc=desc):
            target = desc or text or ''
            _log(f'焦点已在 "{target}" 上', 'OK')
            return True
        time.sleep(interval)

    target = desc or text or ''
    _log(f'等待焦点到 "{target}" 超时 {timeout}s', 'WARN')
    return False


# ══════════════════════════════════════════════════════════════
# 焦点标记图生成（带焦点框的截图）
# ══════════════════════════════════════════════════════════════

def capture_focus_marked(out_dir: str = None) -> Optional[str]:
    """
    截图 → XML 找焦点 bounds → 在原图上画绿框 → 返回标记图路径。

    标记图可直接发给 AI 做 VQA（参考上下文），比纯文字描述更直观。
    """
    save_dir = out_dir or SCREENSHOT_DIR
    os.makedirs(save_dir, exist_ok=True)

    # 1. 截图
    ts = time.strftime('%Y%m%d_%H%M%S')
    screen_name = f'focus_{ts}.png'
    screen_path = screenshot(screen_name)
    if not screen_path:
        _log('截图失败', 'ERROR')
        return None

    # 2. 找焦点
    focus_info = get_focus_info(save_dir)
    if not focus_info['has_focus'] or not focus_info['bounds']:
        _log('未找到焦点，不生成标记图', 'WARN')
        return screen_path  # 返回原图兜底

    # 3. 把 bounds 转成 [x, y, w, h]
    bounds_str = focus_info['bounds']
    parts = bounds_str.split('][')
    if len(parts) != 2:
        return screen_path
    left_top = parts[0].lstrip('[')
    right_bottom = parts[1].rstrip(']')
    x1, y1 = map(int, left_top.split(','))
    x2, y2 = map(int, right_bottom.split(','))
    focus_rect = [x1, y1, x2 - x1, y2 - y1]
    card_pos = focus_info.get('content_desc', '') or focus_info.get('text', '')

    # 4. 画框
    marked_path = draw_focus_mark(screen_path, focus_rect,
                                  template_name='focus',
                                  card_pos=card_pos,
                                  out_dir=save_dir)
    if marked_path:
        _log(f'焦点标记图: {marked_path}', 'FILE')
        return marked_path
    return screen_path


# ══════════════════════════════════════════════════════════════
# AI VQA 焦点验证
# ══════════════════════════════════════════════════════════════

def verify_focus_with_ai(expected_desc: str,
                          marked_img: str = None) -> bool:
    """
    用 AI 视觉确认焦点位置。

    流程：
      1. 用 capture_focus_marked 生成带焦点框的标记图
      2. 发 AI VQA："当前焦点框在什么位置？focus标记(绿框)在最顶部还
         是中间位置还是底部模板？"
      3. 根据 AI 回答判断是否到达预期区域

    expected_desc: AI 判断的期望描述，如"直播频道的第一个卡片"
    marked_img:   可选，不传则自动截

    返回 True/False
    """
    if not marked_img:
        marked_img = capture_focus_marked()

    if not marked_img or not os.path.exists(marked_img):
        _log('无标记图，跳过 AI 验证', 'WARN')
        return False

    try:
        from lib.ai_service import ai

        prompt = (
            '这张图上有一个绿色矩形框标记了当前的焦点位置。\n'
            f'请判断：绿色焦点框是否位于"{expected_desc}"的位置？\n'
            '只用回答"是"或"否"'
        )
        result = ai.vqa(marked_img, prompt)
        ok = '是' in result and '否' not in result
        _log(f'AI 验证焦点: {result.strip()} → {"通过" if ok else "失败"}', 'AI')
        return ok
    except Exception as e:
        _log(f'AI 焦点验证异常: {e}', 'ERROR')
        return False


def assert_focus_on(desc: str = None, text: str = None,
                    use_ai: bool = False,
                    timeout: float = 10) -> bool:
    """
    综合断言：等待焦点到达目标，并可选择用 AI 视觉验证。

    use_ai=False：只依赖 XML 找焦（推荐，精确可靠）
    use_ai=True： XML 找焦 + AI 视觉验证（双保险）
    """
    # 第一步：XML 等待焦点
    xml_ok = wait_for_focus_on(desc=desc, text=text, timeout=timeout)
    if not xml_ok:
        _log(f'焦点断言失败: XML 模式未检测到焦点在目标上', 'WARN')
        return False

    if not use_ai:
        return True

    # 第二步：AI 视觉确认
    expected = desc or text or ''
    ai_ok = verify_focus_with_ai(expected)
    if not ai_ok:
        _log(f'焦点断言失败: AI 视觉验证未通过', 'WARN')
    return ai_ok
