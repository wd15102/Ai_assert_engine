#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Logcat 抓包模块 — 通过 ADB logcat 捕获网络请求（降级方案）
捕获 OKHttp/Retrofit 等网络框架的日志，提取 URL 和参数
"""

import re
import time
from typing import Optional, List, Dict
from datetime import datetime

from lib.adb_utils import adb_shell, _log


class LogcatCapturer:
    """通过 ADB logcat 捕获网络请求日志"""

    # 常见的网络日志 TAG
    NETWORK_TAGS = [
        'OkHttp', 'Retrofit', 'HttpURLConnection', 'okhttp3',
        'System.out', 'System.err', 'Qos', 'Subtitle_Service',
        'MediaPlayer', 'AmlogicPlayer', 'qmInfo',
    ]

    # URL 匹配正则
    URL_PATTERN = re.compile(
        r'https?://[^\s\'"<>]+',
        re.IGNORECASE
    )

    # 排除的 URL 模式（广告、埋点、心跳等）
    EXCLUDE_PATTERNS = [
        re.compile(r'google-analytics', re.I),
        re.compile(r'umeng', re.I),
        re.compile(r'talkingdata', re.I),
        re.compile(r'beacon', re.I),
        re.compile(r'heartbeat', re.I),
        re.compile(r'localhost', re.I),
        re.compile(r'127\.0\.0\.1', re.I),
        re.compile(r'\.(png|jpg|jpeg|gif|webp|mp4|m3u8|ts)(\?|$)', re.I),
    ]

    def __init__(self, device: str = None):
        self.device = device
        self.start_time = None
        self.end_time = None

    def clear_logcat(self) -> bool:
        """清空 logcat 缓冲区"""
        try:
            adb_shell(['logcat', '-c'])
            _log('logcat 已清空', 'OK')
            return True
        except Exception as e:
            _log(f'清空 logcat 失败: {e}', 'WARN')
            return False

    def start_capture(self):
        """开始捕获（记录起始时间）"""
        self.start_time = datetime.now()
        self.clear_logcat()
        _log(f'开始 logcat 捕获: {self.start_time.strftime("%H:%M:%S")}', 'OK')

    def stop_capture(self) -> List[Dict]:
        """停止捕获并返回解析后的网络请求列表"""
        self.end_time = datetime.now()
        _log(f'停止 logcat 捕获: {self.end_time.strftime("%H:%M:%S")}', 'INFO')

        raw_lines = self._dump_logcat()
        requests = self._parse_logcat_lines(raw_lines)
        _log(f'logcat 解析出 {len(requests)} 条网络请求', 'OK')
        return requests

    def _dump_logcat(self) -> List[str]:
        """获取 logcat 输出"""
        try:
            # 获取最近的所有日志
            output = adb_shell(['logcat', '-d', '-t', '5000'], timeout=15)
            if not output:
                return []
            return output.split('\n')
        except Exception as e:
            _log(f'获取 logcat 失败: {e}', 'WARN')
            return []

    def _parse_logcat_lines(self, lines: List[str]) -> List[Dict]:
        """解析 logcat 行，提取网络请求"""
        requests = []
        seen_urls = set()

        for line in lines:
            if not line.strip():
                continue

            # 提取 URL
            urls = self.URL_PATTERN.findall(line)
            for url in urls:
                # 去重
                url_key = url[:200]  # 截断用于去重
                if url_key in seen_urls:
                    continue

                # 排除无关 URL
                if self._should_exclude(url):
                    continue

                seen_urls.add(url_key)

                # 解析 URL 组件
                parsed = self._parse_url(url)
                if parsed:
                    # 提取时间戳和TAG
                    ts, tag = self._extract_meta(line)
                    parsed['timestamp'] = ts
                    parsed['source_tag'] = tag
                    parsed['raw_line'] = line[:300]
                    requests.append(parsed)

        return requests

    def _should_exclude(self, url: str) -> bool:
        """判断 URL 是否应该被排除"""
        for pattern in self.EXCLUDE_PATTERNS:
            if pattern.search(url):
                return True
        return False

    def _parse_url(self, url: str) -> Optional[Dict]:
        """解析 URL 为结构化数据"""
        try:
            # 简单解析
            from urllib.parse import urlparse, parse_qs
            parsed = urlparse(url)
            params = parse_qs(parsed.query)

            # 简化参数值（只取第一个值）
            simple_params = {}
            for k, v in params.items():
                simple_params[k] = v[0] if v else ''

            return {
                'url': url,
                'method': 'GET',  # logcat 无法确定方法，默认 GET
                'host': parsed.hostname or '',
                'path': parsed.path or '',
                'query': parsed.query,
                'params': simple_params,
                'scheme': parsed.scheme,
                'port': parsed.port,
            }
        except Exception:
            return None

    def _extract_meta(self, line: str) -> tuple:
        """从 logcat 行提取时间戳和 TAG"""
        # logcat 格式: MM-DD HH:MM:SS.mmm PID TID LEVEL TAG: message
        ts = ''
        tag = ''
        parts = line.split(None, 5)
        if len(parts) >= 6:
            ts = f'{parts[0]} {parts[1]}'
            tag = parts[4].rstrip(':') if len(parts) > 4 else ''
        return ts, tag

    def capture_during_action(self, action_func, *args, **kwargs) -> List[Dict]:
        """在执行动作期间捕获 logcat

        action_func: 要执行的函数（如按键操作）
        """
        self.start_capture()
        try:
            result = action_func(*args, **kwargs)
        except Exception as e:
            _log(f'动作执行异常: {e}', 'ERROR')
            result = None
        requests = self.stop_capture()
        return requests, result


def filter_api_requests(requests: List[Dict]) -> List[Dict]:
    """过滤出 API 请求（排除静态资源、视频流等）"""
    api_requests = []
    api_patterns = [
        re.compile(r'/api/', re.I),
        re.compile(r'/epg/', re.I),
        re.compile(r'/vod/', re.I),
        re.compile(r'/detail', re.I),
        re.compile(r'/info', re.I),
        re.compile(r'/query', re.I),
        re.compile(r'/list', re.I),
        re.compile(r'/search', re.I),
        re.compile(r'/recommend', re.I),
        re.compile(r'/episode', re.I),
        re.compile(r'/play', re.I),
        re.compile(r'/stream', re.I),
        re.compile(r'/content', re.I),
        re.compile(r'/program', re.I),
        re.compile(r'/channel', re.I),
        re.compile(r'/template', re.I),
        re.compile(r'/guide', re.I),
        re.compile(r'/init', re.I),
        re.compile(r'/config', re.I),
        re.compile(r'/get', re.I),
        re.compile(r'/post', re.I),
        re.compile(r'\.json$', re.I),
        re.compile(r'\.do$', re.I),
        re.compile(r'\.action$', re.I),
    ]

    exclude_patterns = [
        re.compile(r'\.(png|jpg|jpeg|gif|webp|ico|svg|css|js|mp4|m3u8|ts|mp3|woff|ttf)(\?|$)', re.I),
        re.compile(r'google-analytics|umeng|talkingdata|beacon|heartbeat', re.I),
        re.compile(r'localhost|127\.0\.0\.1', re.I),
    ]

    for req in requests:
        url = req.get('url', '')
        path = req.get('path', '')

        # 排除静态资源
        excluded = False
        for pat in exclude_patterns:
            if pat.search(url):
                excluded = True
                break
        if excluded:
            continue

        # 匹配 API 模式
        for pat in api_patterns:
            if pat.search(path) or pat.search(url):
                api_requests.append(req)
                break

    return api_requests
