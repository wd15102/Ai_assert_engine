#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Charles 抓包模块 — 通过 Charles Web API 控制抓包和导出会话数据
"""

import json
import time
from typing import Optional, Dict, List, Any

from lib.adb_utils import _log

try:
    import requests
    HAS_REQUESTS = True
except ImportError:
    HAS_REQUESTS = False


class CharlesCapturer:
    """通过 Charles Web API 控制抓包会话
    
    Charles 需在 Tools > Allow access to the web API 中开启远程控制
    Web API 默认端口与代理端口相同
    """

    def __init__(self, charles_url: str = 'http://192.168.202.181:8899'):
        self.charles_url = charles_url.rstrip('/')
        self.available = False
        if HAS_REQUESTS:
            self.session = requests.Session()
            self.session.timeout = 10
        else:
            self.session = None

    def check_available(self) -> bool:
        """检测 Charles Web API 是否可用"""
        if not HAS_REQUESTS:
            _log('requests 模块未安装，跳过 Charles API', 'WARN')
            return False
        try:
            # Charles Web API 端点: GET /session/start
            r = self.session.get(f'{self.charles_url}/session/start', timeout=5)
            self.available = (r.status_code == 200)
            if self.available:
                _log(f'Charles Web API 可用: {self.charles_url}', 'OK')
            return self.available
        except requests.ConnectionError:
            _log(f'Charles Web API 连接失败: {self.charles_url}', 'WARN')
            self.available = False
            return False
        except Exception as e:
            _log(f'Charles API 检测异常: {e}', 'WARN')
            self.available = False
            return False

    def start_recording(self) -> bool:
        """开始录制会话"""
        try:
            r = self.session.get(f'{self.charles_url}/session/start', timeout=10)
            ok = r.status_code == 200
            if ok:
                _log('Charles 开始录制', 'OK')
            return ok
        except Exception as e:
            _log(f'Charles start 失败: {e}', 'WARN')
            return False

    def stop_recording(self) -> bool:
        """停止录制会话"""
        try:
            r = self.session.get(f'{self.charles_url}/session/stop', timeout=10)
            ok = r.status_code == 200
            if ok:
                _log('Charles 停止录制', 'OK')
            return ok
        except Exception as e:
            _log(f'Charles stop 失败: {e}', 'WARN')
            return False

    def clear_session(self) -> bool:
        """清空当前会话记录"""
        try:
            r = self.session.get(f'{self.charles_url}/session/clear', timeout=10)
            ok = r.status_code == 200
            if ok:
                _log('Charles 清空会话', 'OK')
            return ok
        except Exception as e:
            _log(f'Charles clear 失败: {e}', 'WARN')
            return False

    def export_session_json(self) -> Optional[List[Dict]]:
        """导出会话数据为 JSON 格式，返回接口列表"""
        try:
            r = self.session.get(
                f'{self.charles_url}/session/export',
                params={'format': 'json'},
                timeout=30
            )
            if r.status_code != 200:
                _log(f'Charles export 返回 {r.status_code}', 'WARN')
                return None

            data = r.json()
            # Charles JSON 结构: { "sessions": [ { "transactions": [...] } ] }
            transactions = []
            sessions = data.get('sessions', [])
            for session in sessions:
                txs = session.get('transactions', [])
                transactions.extend(txs)

            _log(f'Charles 导出 {len(transactions)} 条请求记录', 'OK')
            return transactions

        except Exception as e:
            _log(f'Charles export 失败: {e}', 'WARN')
            return None

    def export_session_xml(self) -> Optional[str]:
        """导出会话数据为 XML 格式（Har 格式），返回 XML 字符串"""
        try:
            r = self.session.get(
                f'{self.charles_url}/session/export',
                params={'format': 'xml'},
                timeout=30
            )
            if r.status_code == 200:
                return r.text
            return None
        except Exception as e:
            _log(f'Charles export XML 失败: {e}', 'WARN')
            return None

    def get_notes(self) -> Optional[str]:
        """获取会话备注"""
        try:
            r = self.session.get(f'{self.charles_url}/session/notes', timeout=10)
            if r.status_code == 200:
                return r.text
            return None
        except Exception:
            return None

    def set_notes(self, notes: str) -> bool:
        """设置会话备注"""
        try:
            r = self.session.post(
                f'{self.charles_url}/session/notes',
                data=notes,
                timeout=10
            )
            return r.status_code == 200
        except Exception:
            return False


def parse_charles_transactions(transactions: List[Dict]) -> List[Dict]:
    """解析 Charles 事务列表，提取关键信息"""
    results = []
    for tx in transactions:
        entry = {
            'url': tx.get('url', ''),
            'method': tx.get('method', 'GET'),
            'host': tx.get('host', ''),
            'path': tx.get('path', ''),
            'query': tx.get('query', ''),
            'status': tx.get('status', ''),
            'duration': tx.get('duration', 0),
            'request_headers': tx.get('request', {}).get('headers', {}) if isinstance(tx.get('request'), dict) else {},
            'response_headers': tx.get('response', {}).get('headers', {}) if isinstance(tx.get('response'), dict) else {},
            'request_body': tx.get('request', {}).get('body', '') if isinstance(tx.get('request'), dict) else '',
            'response_body': tx.get('response', {}).get('body', '') if isinstance(tx.get('response'), dict) else '',
            'time': tx.get('time', ''),
        }
        results.append(entry)
    return results
