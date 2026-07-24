#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
lib 包 — AI 断言引擎核心库

模块索引：
  adb_utils         — ADB 硬件交互（按键/截图/录像/弱网/APK管理/高频等待）
  ai_service        — AI 视觉问答服务（VQA/OCR/相似度/批量）
  element_checker   — 元素存在性检测 + 智能等待（XML 轮询）
  focus_detector    — 焦点检测（XML 找焦 + Canny + 帧差法 + 标记图）
  focus_checker     — 焦点状态增强（AI VQA 验证 + 标记图）
  focus_navigator   — 焦点路径规划（最短按键序列）
  log_checker       — Logcat 实时监控（崩溃/ANR/数据上报捕获）
  logger            — 统一日志输出
  reporter          — HTML 报告生成
  stub_parser       — 测试桩 JSON 解析
"""

from . import adb_utils
from . import ai_service
from . import element_checker
from . import focus_detector
from . import focus_checker
from . import focus_navigator
from . import log_checker
from . import logger
from . import reporter
from . import stub_parser
