#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
实时 Logcat 监控模块 — P2：崩溃/ANR 检测 + 数据上报关键字捕获
══════════════════════════════════════════════════════════════════

从 TestLibrary/GetLogcat.py 提取核心能力，适配 AI 项目。

核心用途：
  1. 巡检过程中实时监控 → 崩溃/ANR 秒级发现
  2. 数据上报关键字捕获 → 补充 Robot 数据上报校验的缺口
  3. 长时间巡检 → 日志自动切割 + 内存友好

用法：
  from lib.log_checker import LogcatWatcher

  watcher = LogcatWatcher()
  watcher.start(filters=['hylink', 'mangotv'])

  # ... 执行操作 ...

  events = watcher.stop()
  for e in events:
      print(e['level'], e['tag'], e['msg'][:60])
"""

import os
import re
import threading
import time
from collections import deque
from datetime import datetime
from typing import Optional, List, Callable

from engine_config.config import LOG_DIR, CRASH_MONITOR_PKG


def _log(msg, level='INFO'):
    from lib.logger import log
    log(msg, level)


# ══════════════════════════════════════════════════════════════
# 崩溃 / ANR 检测模式
# ══════════════════════════════════════════════════════════════

class LogcatWatcher:
    """
    Logcat 实时监控器。

    功能：
      - 后台线程持续读取 logcat
      - 崩溃（FATAL EXCEPTION / CRASH）自动标记
      - ANR（ANR in）自动标记
      - 自定义关键字过滤（如 hylink 上报事件）
      - 窗口模式：支持捕获一段时间内的全部日志

    用法：
      watcher = LogcatWatcher()
      watcher.start()           # 默认监控崩溃+ANR

      # 执行操作...

      # 取最近的事件
      events = watcher.get_events(min_level='WARN')
      if watcher.has_crash():
          print('发现崩溃!')

      watcher.stop()
    """

    # ── 崩溃/ANR 正则 ──
    FATAL_PATTERNS = [
        re.compile(r'FATAL\s+EXCEPTION', re.I),
        # ⚠ 不匹配 AndroidRuntime: Process...pid: — 正常进程退出日志，不是崩溃
        # ⚠ quality-crash / xcrash 等 tag 中的 "crash" 不该被匹配，排除 \w 和 - 作为前导
        re.compile(r'(?<![-\w])CRASH:\s', re.I),
        re.compile(r'SIG(SEGV|ABRT|ILL|FPE|BUS|PIPE)', re.I),
        re.compile(r'Fatal\s+signal\s+\d+\s+\(SIG', re.I),
    ]

    ANR_PATTERNS = [
        re.compile(r'ANR\s+in\s', re.I),
        re.compile(r'is\s+not\s+responding', re.I),
    ]

    LEVEL_MAP = {
        'F': 'FATAL', 'E': 'ERROR', 'W': 'WARN',
        'I': 'INFO', 'D': 'DEBUG', 'V': 'VERBOSE',
    }

    def __init__(self, max_events: int = 1000, monitor_pkg: str = None):
        """
        max_events: 缓存中最多保留的日志条目（防内存泄漏）
        monitor_pkg: 只监控此包名的崩溃，其他包名自动过滤/降级；
                     传 None 则使用 config.py 的 CRASH_MONITOR_PKG
        """
        self._thread: Optional[threading.Thread] = None
        self._running = False
        self._events: deque = deque(maxlen=max_events)
        self._crash_count = 0
        self._anr_count = 0
        self._filters: List[str] = []
        self._start_time: Optional[float] = None
        self._monitor_pkg = monitor_pkg or CRASH_MONITOR_PKG
        # 崩溃去重压缩
        self._crash_throttle: dict = {}  # key=(tag, msg_prefix) -> {'count': int, 'last_logged': int}

    # ══════════════════════════════════════════════════════════
    # 控制
    # ══════════════════════════════════════════════════════════

    def start(self, filters: List[str] = None):
        """
        启动 logcat 监控。

        filters: 关键字白名单（行中包含任意一个关键字才记录），
                 传 None 表示记录所有 >= WARN 的日志。
        """
        if self._running:
            _log('LogcatWatcher 已在运行', 'WARN')
            return

        self._filters = filters or []
        self._events.clear()
        self._crash_count = 0
        self._anr_count = 0
        self._start_time = time.time()
        self._running = True

        self._thread = threading.Thread(target=self._worker,
                                         daemon=True,
                                         name='LogcatWatcher')
        self._thread.start()
        _log('Logcat 监控已启动', 'INFO')

    def stop(self) -> List[dict]:
        """
        停止 logcat 监控，返回捕获到的所有事件。
        每个事件: {timestamp, level, pid, tag, msg, is_crash, is_anr}
        """
        if not self._running:
            _log('LogcatWatcher 未在运行', 'WARN')
            return list(self._events)

        self._running = False
        if self._thread:
            self._thread.join(timeout=5)
            self._thread = None

        elapsed = time.time() - self._start_time if self._start_time else 0
        _log(f'Logcat 监控已停止（运行 {elapsed:.0f}s，'
             f'捕获 {len(self._events)} 条）', 'INFO')
        if self._crash_count:
            _log(f'崩溃次数: {self._crash_count}', 'ERROR')
        if self._anr_count:
            _log(f'ANR 次数: {self._anr_count}', 'ERROR')

        return list(self._events)

    def reset(self):
        """清空缓存（不停止监控）"""
        self._events.clear()
        self._crash_count = 0
        self._anr_count = 0
        _log('Logcat 缓存已清空', 'INFO')

    # ══════════════════════════════════════════════════════════
    # 查询
    # ══════════════════════════════════════════════════════════

    def get_events(self, min_level: str = 'WARN') -> List[dict]:
        """
        获取事件列表，按时间排序。

        min_level: 最低级别（FATAL > ERROR > WARN > INFO > DEBUG > VERBOSE）
        """
        level_order = {'FATAL': 0, 'ERROR': 1, 'WARN': 2,
                       'INFO': 3, 'DEBUG': 4, 'VERBOSE': 5}
        min_order = level_order.get(min_level.upper(), 2)
        return [
            e for e in self._events
            if level_order.get(e['level'], 99) <= min_order
        ]

    def has_crash(self) -> bool:
        """检查是否有崩溃事件"""
        return self._crash_count > 0

    def has_anr(self) -> bool:
        """检查是否有 ANR 事件"""
        return self._anr_count > 0

    def get_crash_events(self) -> List[dict]:
        """获取所有崩溃事件"""
        return [e for e in self._events if e['is_crash']]

    def get_anr_events(self) -> List[dict]:
        """获取所有 ANR 事件"""
        return [e for e in self._events if e['is_anr']]

    def filter_events(self, keyword: str) -> List[dict]:
        """按关键字过滤事件"""
        return [e for e in self._events if keyword in e['msg']]

    # ══════════════════════════════════════════════════════════
    # 便捷方法：按操作分段捕获上传事件
    # ══════════════════════════════════════════════════════════

    def capture_upload_events(self, keyword: str = 'hylink',
                              timeout: float = 10) -> List[dict]:
        """
        捕获一段时间内的上报事件。

        适用于：巡检完一个频道后，截取该场景下的所有上报事件。

        keyword: 上报关键字（hylink / 数据上报 / callback 等）
        timeout:  监控时长（秒）
        """
        before = len(self._events)
        time.sleep(timeout)
        events = list(self._events)[before:]
        return [e for e in events if keyword in (e.get('tag', '') + e.get('msg', '')).lower()]

    # ══════════════════════════════════════════════════════════
    # 内部 worker
    # ══════════════════════════════════════════════════════════

    def _worker(self):
        """后台线程：持续读取 logcat"""
        # 直接用 subprocess.Popen 流式读取（logcat 永不结束，不能用 subprocess.run）
        import subprocess
        try:
            full_cmd = ['adb', 'logcat', '-v', 'threadtime']
            proc = subprocess.Popen(
                full_cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                bufsize=1,
                universal_newlines=True,
                encoding='utf-8',
                errors='replace',
            )

            raw_buffer = []  # 保存原始 logcat 行，用于崩溃时落盘
            line_count = 0

            while self._running:
                line = proc.stdout.readline()
                if not line:
                    time.sleep(0.1)
                    continue

                line = line.strip()
                if not line:
                    continue

                # 保留原始行（用于崩溃时保存完整 logcat）
                raw_buffer.append(line)

                # 解析标准 logcat 格式
                parsed = self._parse_line(line)
                if parsed:
                    # 过滤器
                    if self._filters:
                        if not any(f.lower() in (parsed['msg'] + parsed['tag']).lower()
                                   for f in self._filters):
                            continue
                    else:
                        # 默认：只记录 WARN 及以上 + 崩溃/ANR
                        if (parsed['level'] not in ('FATAL', 'ERROR', 'WARN')
                                and not parsed['is_crash']
                                and not parsed['is_anr']):
                            continue

                    self._events.append(parsed)
                    if parsed['is_crash']:
                        filter_verdict = self._filter_crash(parsed)
                        if filter_verdict == 'error':
                            self._crash_count += 1
                            self._log_crash_throttled(parsed, raw_buffer)
                        elif filter_verdict == 'warn':
                            # 非目标应用崩溃降级为 WARN（如 libc 段错误、Fatal signal）
                            self._log_warn_crash(parsed)
                        # 'ignore' → 完全忽略
                    if parsed['is_anr']:
                        self._anr_count += 1
                        _log(f'[ANR] {parsed["tag"]}: {parsed["msg"][:100]}', 'ERROR')

                line_count += 1
                # 防 OOM 保护（每 10 万行检查一次）
                if line_count > 100000:
                    warns = [i for i, e in enumerate(self._events)
                             if e['level'] == 'WARN' or e['level'] == 'INFO']
                    for idx in sorted(warns[:50], reverse=True):
                        try:
                            del self._events[idx]
                        except IndexError:
                            pass
                    line_count = 0
                    # raw_buffer 也裁剪，保留最近 5000 行
                    if len(raw_buffer) > 5000:
                        raw_buffer = raw_buffer[-5000:]

            proc.kill()

        except Exception as e:
            _log(f'Logcat 监控异常: {e}', 'ERROR')
            self._running = False

    def _save_crash_log(self, pkg: str, raw_buffer: list):
        """将原始 logcat 保存到文件，文件名: 时间_包名.log"""
        try:
            ts = datetime.now().strftime('%Y%m%d_%H%M%S')
            safe_pkg = pkg.replace('.', '_').replace(':', '').replace(' ', '_')
            log_dir = os.path.join(LOG_DIR, 'crash_logs')
            os.makedirs(log_dir, exist_ok=True)
            filename = f'{ts}_{safe_pkg}.txt'
            filepath = os.path.join(log_dir, filename)
            with open(filepath, 'w', encoding='utf-8') as f:
                for raw_line in raw_buffer:
                    f.write(raw_line + '\n')
            _log(f'原始 logcat 已保存: {filepath}', 'FILE')
        except Exception as e:
            _log(f'保存崩溃日志失败: {e}', 'ERROR')

    # ── 已知系统级 tag（解析时 pkg 不可用，但 tag 本身就是系统组件名）──
    _SYSTEM_TAGS = {'androidruntime', 'libc', 'debug', 'keventd', 'servicemanager', 'init'}

    def _filter_crash(self, parsed: dict) -> str:
        """
        判断崩溃事件是否与目标应用有关。

        Returns:
            'error':  属于目标应用（com.huawei.tvbox）的崩溃 → 正常上报
            'warn':   非目标应用的系统级错误 → 降级为 WARN 日志
            'ignore': 完全无关的驱动/底库崩溃 → 不记录
        """
        pkg = (parsed.get('pkg') or '').strip()
        tag = (parsed.get('tag') or '').strip().lower()
        msg = parsed.get('msg', '') or ''
        full_line = f'{tag}: {msg}'.lower()

        # ── 已知系统 tag 优先判决 ──
        # 即使 pkg 为空，AndroidRuntime/libc 等也是系统组件，不应放行
        if tag in self._SYSTEM_TAGS:
            # 包名是空或 tag 本身（如 pkg=AndroidRuntime 是 tag 兜底）时
            effective_pkg = pkg if pkg and pkg.lower() != tag else ''
            if effective_pkg == self._monitor_pkg:
                return 'error'
            # 系统组件级崩溃 → 降级处理
            if tag == 'libc':
                if 'uiautomator' in full_line:
                    return 'ignore'
                return 'warn'
            return 'warn'

        # 宽容模式：非系统 tag 且无包名 → 不误杀
        if not pkg:
            return 'error'

        # 包名直接匹配目标应用
        if pkg == self._monitor_pkg:
            return 'error'

        # ── 以下均为非目标包名 ──

        # Fatal signal → 降级为 WARN
        if re.search(r'fatal\s+signal', full_line):
            return 'warn'

        # 其他非目标包名 → 忽略
        return 'ignore'

    def _get_crash_pkg(self, parsed: dict) -> str:
        """获取崩溃事件的有效包名（兜底 tag 作为身份标识）"""
        pkg = parsed.get('pkg', '')
        if not pkg:
            pkg_match = re.search(
                r'Process:\s*(\S+)', parsed['msg']
            ) or re.search(
                r'Process\s+(\S+)', parsed['msg']
            )
            pkg = pkg_match.group(1) if pkg_match else parsed.get('tag', '?')
        return pkg

    def _log_warn_crash(self, parsed: dict):
        """降级打印非目标崩溃（仅首次记录）"""
        pkg = self._get_crash_pkg(parsed)
        pid = parsed.get('pid', '?')
        msg_prefix = parsed['msg'][:60]
        key = (parsed['tag'], msg_prefix)

        if key not in self._crash_throttle:
            self._crash_throttle[key] = {'count': 1, 'last_logged': 1}
            _log(f'[非目标崩溃] pkg={pkg} pid={pid} | {parsed["tag"]}: {parsed["msg"][:120]}', 'WARN')

    def _log_crash_throttled(self, parsed: dict, raw_buffer: list):
        """崩溃日志去重压缩：同一种崩溃只在首次和每 N 次打印一次。
        并保存原始 logcat 到文件。
        """
        # 提取包名
        pkg = self._get_crash_pkg(parsed)
        pid = parsed.get('pid', '?')

        # 用 tag + 消息前 60 字作为去重 key
        msg_prefix = parsed['msg'][:60]
        key = (parsed['tag'], msg_prefix)

        entry = self._crash_throttle.get(key)
        if entry is None:
            # 首次出现：打印包名+进程号 → 保存原始日志
            self._crash_throttle[key] = {'count': 1, 'last_logged': 1}
            _log(f'[CRASH] pkg={pkg} pid={pid} | {parsed["tag"]}: {parsed["msg"][:120]}', 'ERROR')
            self._save_crash_log(pkg, raw_buffer)
            return

        entry['count'] += 1
        count = entry['count']

        # 每 50 次打印一次风暴汇总
        if count % 50 == 0:
            _log(f'[CRASH] ⚡ 风暴: pkg={pkg} pid={pid} | {parsed["tag"]} ({key[1][:40]}...) 已捕获 {count} 次', 'ERROR')

    def _parse_line(self, line: str) -> Optional[dict]:
        """解析单行 logcat 格式"""
        # 标准格式:
        # 08-21 14:23:45.123  1234  5678 E AndroidRuntime: ...
        # 或
        # ---------- beginning of ...
        if line.startswith('-----') or line.startswith('---------'):
            return None

        try:
            # 格式: date time  pid  tid  level  tag: msg
            match = re.match(
                r'(\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\.\d+)\s+'
                r'(\d+)\s+(\d+)\s+'
                r'([FEWIDV])\s+'
                r'([^:]+?):\s(.+)',
                line
            )
            if not match:
                return None

            ts = match.group(1)
            pid = match.group(2)
            level_code = match.group(4)
            tag = match.group(5).strip()
            msg = match.group(6).strip()

            level = self.LEVEL_MAP.get(level_code, 'INFO')
            full_line = f'{tag}: {msg}'

            # 崩溃检测
            is_crash = any(p.search(full_line) for p in self.FATAL_PATTERNS)
            # ANR 检测
            is_anr = any(p.search(full_line) for p in self.ANR_PATTERNS)

            # 提取包名（从 Process: com.xxx, PID: 或 Process com.xxx 行）
            pkg = ''
            if 'Process' in msg:
                pm = re.search(r'Process:\s*(\S+)', msg) or re.search(r'Process\s+(\S+)', msg)
                if pm:
                    pkg = pm.group(1)

            return {
                'timestamp': ts,
                'level': level,
                'pid': pid,
                'tag': tag,
                'msg': msg,
                'line': full_line,
                'is_crash': is_crash,
                'is_anr': is_anr,
                'pkg': pkg,
            }
        except Exception:
            return None
