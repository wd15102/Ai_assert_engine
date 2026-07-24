#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
日志智能分析器 — 基于 Agnes 2.0 Flash Thinking 模式的崩溃/ANR根因分析。

核心用途：
  巡检过程中 LogcatWatcher 捕获到崩溃/ANR 后 → 丢给 Agnes 做深层推理。

  不依赖图片，纯文本，零集成门槛。

用法：
  from lib.log_analyzer import LogAnalyzer

  analyzer = LogAnalyzer()
  report = analyzer.analyze(logcat_events)
  print(report['root_cause'])
  print(report['recommendations'])

  # 或直接用原始日志文本
  report = analyzer.analyze_raw(raw_log_text, source_label='开机自启日志')
"""

import os
import sys
import json
import re
from typing import Optional, List, Dict, Any
from datetime import datetime

# ── 路径 ──
_PROJECT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(_PROJECT)
sys.path.insert(0, _PROJECT)

from lib.logger import log_info, log_ok, log_warn, log_error, log_step

# ── 委托到 AIService ──
from lib.ai_service import ai as _ai_svc


class LogAnalyzer:
    """
    日志智能分析器 — 将 logcat 事件/原始日志丢给 Agnes 2.0 Flash
    Thinking 模式推理根因。
    """

    # ── 系统级别提示词 ──
    SYSTEM_PROMPT = (
        "你是一个 Android 机顶盒/OTT 应用崩溃诊断专家。\n"
        "请分析提供的 logcat 日志，以中文输出分析报告。\n"
        "必须严格按照以下 JSON 格式输出（不要加 markdown 代码块）：\n"
        "{\n"
        '  "overview": "整体情况概述（几句话）",\n'
        '  "total_events": 分析到的日志条数,\n'
        '  "crash_root_causes": [\n'
        '    {"issue": "具体问题描述", "severity": "critical/high/medium/low", '
        '"evidence": "日志中的关键证据原文"}\n'
        '  ],\n'
        '  "anr_root_causes": [\n'
        '    {"issue": "具体问题描述", "severity": "critical/high/medium/low", '
        '"evidence": "日志中的关键证据原文"}\n'
        '  ],\n'
        '  "other_issues": [\n'
        '    {"issue": "其他关注点", "severity": "high/medium/low", '
        '"evidence": "日志中的关键证据原文"}\n'
        '  ],\n'
        '  "recommendations": [\n'
        '    "具体修复建议1",\n'
        '    "具体修复建议2"\n'
        '  ],\n'
        '  "confidence": "high/medium/low"\n'
        "}\n"
        "注意：\n"
        "- severity 按影响程度分级\n"
        "- evidence 必须是日志原文摘录，不要编造\n"
        "- confidence 描述你对分析结果的信心程度\n"
        "- 如果日志中没有任何异常，则 crash_root_causes/anr_root_causes 为空数组"
    )

    def __init__(self, model: str = 'glm-4.7-flash'):
        self._model = model

    # ════════════════════════════════════════════════════════════
    # 公开接口
    # ════════════════════════════════════════════════════════════

    def analyze(self, events: List[dict],
                source_label: str = '',
                thinking_budget: int = 4096) -> Optional[Dict[str, Any]]:
        """
        从 LogcatWatcher 的事件列表构造日志文本并分析。

        Args:
            events: LogcatWatcher.get_events() 返回的事件列表
            source_label: 来源描述，如"开机自启"、"直播频道巡检"
            thinking_budget: Thinking 模式的 token 预算（默认 4096）

        Returns:
            结构化分析结果 dict，或 None（失败时）
        """
        if not events:
            log_warn('LogAnalyzer: 事件列表为空，跳过分析')
            return None

        # 构建日志文本
        lines = self._build_log_text(events)
        return self.analyze_raw(lines, source_label=source_label,
                                thinking_budget=thinking_budget)

    def analyze_raw(self, log_text: str,
                    source_label: str = '',
                    thinking_budget: int = 4096) -> Optional[Dict[str, Any]]:
        """
        分析原始日志文本。

        Args:
            log_text: 纯文本日志内容（建议 ≤200K 字符）
            source_label: 来源描述
            thinking_budget: Thinking 模式 token 预算

        Returns:
            结构化分析结果 dict，或 None
        """
        if not log_text or not log_text.strip():
            log_warn('LogAnalyzer: 日志文本为空')
            return None

        # 截断保护（512K 上下文，但省点钱）
        max_chars = 200000
        if len(log_text) > max_chars:
            log_warn(f'日志文本 {len(log_text)} 字符，截断至 {max_chars}')
            log_text = log_text[:max_chars] + f'\n... [截断, 原始 {len(log_text)} 字符]'

        label = f' [{source_label}]' if source_label else ''
        log_info(f'Agnes 日志分析{label}: 输入 {len(log_text)} 字符')

        prompt = f"""以下是 Android 机顶盒的 logcat 日志{label}，请分析其中的崩溃、ANR 和其他异常：

{log_text}

请严格按 JSON 格式输出分析结果。"""

        try:
            result = self._call_with_thinking(prompt, thinking_budget)
            if result is None:
                log_error('Agnes API 调用失败')
                return None

            content = result['content']
            # 解析 JSON
            parsed = self._extract_json(content)
            if parsed is None:
                log_warn('Agnes 返回内容未包含有效 JSON，退回原始文本')
                return {
                    'overview': 'JSON 解析失败，以下为原始分析内容',
                    'raw_analysis': content,
                    'total_events': 0,
                    'crash_root_causes': [],
                    'anr_root_causes': [],
                    'other_issues': [],
                    'recommendations': [],
                    'confidence': 'low',
                }

            log_ok(f'Agnes 日志分析完成: '
                   f'{len(parsed.get("crash_root_causes",[]))} 个崩溃根因, '
                   f'{len(parsed.get("anr_root_causes",[]))} 个 ANR 根因')
            return parsed

        except Exception as e:
            log_error(f'Agnes 日志分析异常: {e}')
            return None

    def analyze_with_watcher(self, watcher, min_level: str = 'WARN',
                              source_label: str = '',
                              thinking_budget: int = 4096) -> Optional[Dict[str, Any]]:
        """
        从 LogcatWatcher 实例拉取事件并分析。

        Args:
            watcher: LogcatWatcher 实例（已运行过）
            min_level: 最低日志级别（默认 WARN）
            source_label: 来源描述
            thinking_budget: Thinking 模式 token 预算

        Returns:
            结构化分析结果
        """
        events = watcher.get_events(min_level=min_level)
        return self.analyze(events, source_label=source_label,
                            thinking_budget=thinking_budget)

    # ════════════════════════════════════════════════════════════
    # 内部方法
    # ════════════════════════════════════════════════════════════

    @staticmethod
    def _build_log_text(events: List[dict]) -> str:
        """将事件列表格式化为 logcat 风格文本。"""
        lines = []
        lines.append('=' * 60)
        lines.append(f'Logcat 事件转储 — {len(events)} 条')
        lines.append(f'时间: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
        lines.append('=' * 60)
        lines.append('')

        for i, e in enumerate(events):
            ts = e.get('timestamp', '')
            level = e.get('level', 'INFO')
            tag = e.get('tag', '')
            msg = e.get('msg', '')
            is_crash = e.get('is_crash', False)
            is_anr = e.get('is_anr', False)

            marker = ''
            if is_crash:
                marker = ' [CRASH]'
            elif is_anr:
                marker = ' [ANR]'

            lines.append(f'{ts} {level:5s}{marker} {tag}: {msg}')

        return '\n'.join(lines)

    @staticmethod
    def _extract_json(text: str) -> Optional[dict]:
        """从 AI 回复中提取 JSON 对象。"""
        # 先试直接解析
        text = text.strip()
        if text.startswith('{') and text.endswith('}'):
            try:
                return json.loads(text)
            except json.JSONDecodeError:
                pass

        # 找 ```json ... ``` 代码块
        m = re.search(r'```(?:json)?\s*\n?({.*?})\s*\n?```', text, re.DOTALL)
        if m:
            try:
                return json.loads(m.group(1))
            except json.JSONDecodeError:
                pass

        # 找最外层的 {}
        brace_depth = 0
        start = -1
        candidates = []
        for i, ch in enumerate(text):
            if ch == '{':
                if brace_depth == 0:
                    start = i
                brace_depth += 1
            elif ch == '}':
                brace_depth -= 1
                if brace_depth == 0 and start >= 0:
                    candidates.append(text[start:i + 1])
                    start = -1

        for c in reversed(candidates):
            try:
                return json.loads(c)
            except json.JSONDecodeError:
                continue

        return None

    def _call_with_thinking(self, prompt: str,
                            thinking_budget: int = 4096) -> Optional[dict]:
        """通过 AIService.ask_text 委托到指定模型。"""
        # 构建完整 prompt（含 system prompt）
        full_prompt = f"{self.SYSTEM_PROMPT}\n\n{prompt}"

        content = _ai_svc.ask_text(
            full_prompt,
            model=self._model,
            temperature=0.3,
            max_tokens=4096,
            timeout=120,
            verbose=True,
        )
        if content is None:
            return None

        return {'content': content, 'elapsed_ms': 0, 'model': self._model}


# ════════════════════════════════════════════════════════════
# 便捷函数 — 直接调用不用实例化
# ════════════════════════════════════════════════════════════

_DEFAULT_ANALYZER = None

def _get_analyzer() -> LogAnalyzer:
    global _DEFAULT_ANALYZER
    if _DEFAULT_ANALYZER is None:
        _DEFAULT_ANALYZER = LogAnalyzer()
    return _DEFAULT_ANALYZER


def analyze_logs(log_text: str, source_label: str = '') -> Optional[dict]:
    """便捷调用：分析原始日志文本。"""
    return _get_analyzer().analyze_raw(log_text, source_label=source_label)


def analyze_events(events: list, source_label: str = '') -> Optional[dict]:
    """便捷调用：分析 LogcatWatcher 事件列表。"""
    return _get_analyzer().analyze(events, source_label=source_label)


