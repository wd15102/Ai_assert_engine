#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
元素检测模块 — P0：存在性检测 + 智能等待
══════════════════════════════════════════════════════════════════

通过 uiautomator dump XML 实现元素检测，不依赖 Appium session。

核心用途（替代现有的 sleep 盲等）：
  - PAGE_LOAD_DELAY 硬等        →  wait_page_stable()
  - 盲按 DPAD 不知道到位没      →  wait_for_element_by_desc()
  - 不确定元素在不在就截图       →  element_exists() 先确认
  - AI 断言前不知道页面稳定没    →  wait_page_stable() 后再截图

用法：
  from lib.element_checker import (
      wait_page_stable,
      wait_for_text_on_screen,
      wait_for_element_by_desc,
      element_exists,
      get_visible_texts,
  )
"""

import os
import re
import subprocess
import time
import xml.etree.ElementTree as ET
from typing import Optional, List

from lib.adb_utils import (adb_shell, current_device, DUMP_LOCK, warmup_uiautomator, kill_stale_uiautomator)
from engine_config.config import SCREENSHOT_DIR


_warmed = False


def _ensure_warmup():
    global _warmed
    if not _warmed:
        _warmed = True
        try:
            warmup_uiautomator()
        except Exception:
            pass


def _log(msg, level='INFO'):
    from lib.logger import log
    log(msg, level)


# ══════════════════════════════════════════════════════════════
# XML 获取 & 解析
# ══════════════════════════════════════════════════════════════

def _dump_xml(out_dir: str = None, retries: int = 2, time_budget: float = 0) -> Optional[str]:
    """
    委托给 adb_utils.dump_uiautomator（已含 Appium 首选举 + A->C 降级链）
    统一 dump 入口，避免各模块各自实现独立降级逻辑。
    time_budget: >0 时，shell dump 超预算后立即放弃，不等 15s timeout。
    """
    from lib.adb_utils import dump_uiautomator
    return dump_uiautomator(out_dir=out_dir, retries=retries, time_budget=time_budget)


def _read_xml_text(xml_path: str) -> Optional[str]:
    """读取 XML 文件内容，失败返回 None"""
    try:
        with open(xml_path, 'r', encoding='utf-8') as f:
            return f.read()
    except Exception as e:
        _log(f'读取 XML 失败: {e}', 'WARN')
        return None


def _parse_xml(xml_text: str) -> Optional[ET.Element]:
    """解析 XML 字符串为 ElementTree，失败返回 None"""
    try:
        return ET.fromstring(xml_text)
    except Exception as e:
        _log(f'XML 解析失败: {e}', 'WARN')
        return None


# ══════════════════════════════════════════════════════════════
# 存在性检测（单次）
# ══════════════════════════════════════════════════════════════

def _collect_nodes(root: ET.Element) -> List[dict]:
    """递归收集所有节点，扁平化返回"""
    nodes = []
    queue = [root]
    while queue:
        node = queue.pop(0)
        attrs = {}
        for k, v in node.attrib.items():
            attrs[k] = v
        nodes.append(attrs)
        for child in node:
            queue.append(child)
    return nodes


def element_exists(text: str = None, desc: str = None,
                   class_name: str = None) -> bool:
    """
    单次检测当前屏幕上是否存在指定元素。

    参数互斥（至少传一个）：
      text:       匹配 text 属性（模糊包含）
      desc:       匹配 content-desc 属性（模糊包含）
      class_name: 匹配 class 属性（如 android.widget.TextView）

    返回 True/False
    """
    if text is None and desc is None and class_name is None:
        _log('element_exists: 至少传一个参数', 'WARN')
        return False

    xml_path = _dump_xml()
    if not xml_path:
        return False

    xml_text = _read_xml_text(xml_path)
    if not xml_text:
        return False

    root = _parse_xml(xml_text)
    if root is None:
        return False

    nodes = _collect_nodes(root)

    for node in nodes:
        if text and text in node.get('text', ''):
            return True
        if desc and desc in node.get('content-desc', ''):
            return True
        if class_name and class_name in node.get('class', ''):
            return True

    return False


def element_count(class_name: str) -> int:
    """统计当前屏幕上指定 class 的元素数量"""
    if not class_name:
        return 0

    xml_path = _dump_xml()
    if not xml_path:
        return 0

    xml_text = _read_xml_text(xml_path)
    if not xml_text:
        return 0

    root = _parse_xml(xml_text)
    if root is None:
        return 0

    nodes = _collect_nodes(root)
    return sum(1 for n in nodes if class_name in n.get('class', ''))


# ══════════════════════════════════════════════════════════════
# 智能等待
# ══════════════════════════════════════════════════════════════

def wait_for_text_on_screen(text: str, timeout: float = 10,
                            interval: float = 0.5) -> bool:
    """
    轮询屏幕，等待指定文本出现在界面上。
    替代 sleep(PAGE_LOAD_DELAY) 的精确等待。

    text:    要查找的文本（模糊匹配）
    timeout: 超时秒数
    """
    deadline = time.time() + timeout
    while time.time() < deadline:
        if element_exists(text=text):
            _log(f'文本 "{text}" 已出现', 'OK')
            return True
        time.sleep(interval)

    _log(f'等待文本 "{text}" 超时 {timeout}s', 'WARN')
    return False


def wait_for_element_by_desc(desc: str, timeout: float = 10,
                              interval: float = 0.5) -> bool:
    """
    轮询屏幕，等待指定 content-desc 的元素出现。

    适用于频道导航：到达目标频道后，等待该频道的 content-desc 出现。
    """
    deadline = time.time() + timeout
    while time.time() < deadline:
        if element_exists(desc=desc):
            _log(f'元素 "{desc}" 已出现', 'OK')
            return True
        time.sleep(interval)

    _log(f'等待元素 "{desc}" 超时 {timeout}s', 'WARN')
    return False


def wait_for_element_gone(text: str, timeout: float = 10,
                          interval: float = 0.5) -> bool:
    """等待指定文本从屏幕上消失（如弹窗关闭）"""
    deadline = time.time() + timeout
    while time.time() < deadline:
        if not element_exists(text=text):
            _log(f'文本 "{text}" 已消失', 'OK')
            return True
        _log(f'文本 "{text}" 仍在，等待...', 'WAIT')
        time.sleep(interval)

    _log(f'等待文本 "{text}" 消失超时 {timeout}s', 'WARN')
    return False


def wait_page_stable(timeout: float = 5, interval: float = 0.5) -> Optional[str]:
    """
    等待页面渲染稳定（XML 连续两次内容不再变化）。
    替代 sleep(PAGE_LOAD_DELAY)。

    返回稳定的 XML 文本，持续超时时返回 None。
    注意：有些模板有动画（轮播海报自动换），可能会有微小变化，
    所以只比对节点数量 + bounds，不比完整字符串。
    """
    _log(f'等待页面稳定（timeout={timeout}s）...', 'WAIT')

    prev_counts = {}
    last_xml_text = None
    deadline = time.time() + timeout

    while time.time() < deadline:
        remaining = deadline - time.time()
        xml_path = _dump_xml(time_budget=max(remaining, 0.5))
        if not xml_path:
            time.sleep(interval)
            continue

        xml_text = _read_xml_text(xml_path)
        if not xml_text:
            time.sleep(interval)
            continue

        last_xml_text = xml_text

        root = _parse_xml(xml_text)
        if root is None:
            time.sleep(interval)
            continue

        # 按 class 统计节点数量 + bounds 范围（作为页面指纹）
        nodes = _collect_nodes(root)
        current_counts = {}
        for n in nodes:
            cls = n.get('class', 'unknown')
            bounds = n.get('bounds', '')
            key = f'{cls}|{bounds}'
            current_counts[key] = current_counts.get(key, 0) + 1

        if prev_counts and current_counts == prev_counts:
            _log(f'页面已稳定（{time.time() - deadline + timeout:.1f}s）', 'OK')
            return xml_text

        prev_counts = current_counts
        time.sleep(interval)

    if last_xml_text:
        _log(f'等待页面稳定超时 {timeout}s，使用最后一次 XML', 'WARN')
        return last_xml_text

    _log(f'等待页面稳定超时 {timeout}s，且无可用 XML', 'WARN')
    return None


# ══════════════════════════════════════════════════════════════
# 文字提取
# ══════════════════════════════════════════════════════════════

def get_visible_texts() -> List[str]:
    """
    获取当前屏幕上所有可见的文本（从 XML 的 text + content-desc 提取）
    去重后返回列表。
    """
    xml_path = _dump_xml()
    if not xml_path:
        return []

    xml_text = _read_xml_text(xml_path)
    if not xml_text:
        return []

    root = _parse_xml(xml_text)
    if root is None:
        return []

    nodes = _collect_nodes(root)
    texts = set()

    for n in nodes:
        t = n.get('text', '').strip()
        if t and len(t) > 1:        # 过滤空和单个字符
            texts.add(t)
        d = n.get('content-desc', '').strip()
        if d and len(d) > 1:
            texts.add(d)

    return sorted(texts)
