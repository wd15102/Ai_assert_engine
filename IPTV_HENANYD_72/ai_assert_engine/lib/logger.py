#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
日志模块 — 带文件写入的统一日志系统
"""

import os
from datetime import datetime
from engine_config.config import LOG_DIR

_LOG_FILE = None


def set_log_file(file_path=None):
    """设置日志文件路径，如不传入则自动生成"""
    global _LOG_FILE
    if file_path:
        _LOG_FILE = file_path
    else:
        os.makedirs(LOG_DIR, exist_ok=True)
        _LOG_FILE = os.path.join(
            LOG_DIR,
            f'patrol_{datetime.now().strftime("%Y%m%d_%H%M%S")}.log'
        )
    return _LOG_FILE


_ICONS = {
    'INFO': '  [*]', 'OK': '  [V]', 'WARN': '  [!]',
    'ERROR': '  [X]', 'STEP': '  [>]', 'DONE': '  [V]',
    'KEY': '  [K]', 'WAIT': '  [~]', 'AI': '  [AI]',
    'SCREEN': '  [SC]', 'AI_REQ': '  [>>]', 'AI_RSP': '  [<<]',
    'SEP': '',
}


def log(msg, level='INFO'):
    """统一日志输出，同时打印到终端并写入文件"""
    ts = datetime.now().strftime('%H:%M:%S')
    icon = _ICONS.get(level, '  [*]')

    if level == 'SEP':
        line = msg
    else:
        line = f'[{ts}] {icon} {msg}'

    # Windows GBK 终端兜底
    try:
        print(line)
    except UnicodeEncodeError:
        print(line.encode('gbk', errors='replace').decode('gbk'))

    if _LOG_FILE:
        try:
            with open(_LOG_FILE, 'a', encoding='utf-8') as lf:
                lf.write(line + '\n')
        except Exception:
            pass


def log_step(msg):
    """输出步骤分隔提示"""
    log(f'--- {msg} ---', 'SEP')


def log_ok(msg):
    """输出成功级别的日志"""
    log(msg, 'OK')


def log_warn(msg):
    """输出警告级别的日志"""
    log(msg, 'WARN')


def log_error(msg):
    """输出错误级别的日志"""
    log(msg, 'ERROR')


def log_info(msg):
    """输出信息级别的日志"""
    log(msg, 'INFO')


def log_separator():
    """输出分隔线"""
    log('=' * 60, 'INFO')
