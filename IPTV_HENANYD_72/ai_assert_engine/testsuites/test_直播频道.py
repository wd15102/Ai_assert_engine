#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
直播频道模板自动巡检 — 配置即用例

用法（在 ai_assert_engine 目录下）：
  py -3.9 testsuites\test_直播频道.py
"""
import sys, os

# ── 解决 Windows GBK 终端 emoji 报错 ──
if sys.stdout.encoding and sys.stdout.encoding.upper() != 'UTF-8':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except AttributeError:
        pass
if sys.stderr.encoding and sys.stderr.encoding.upper() != 'UTF-8':
    try:
        sys.stderr.reconfigure(encoding='utf-8')
    except AttributeError:
        pass

_PROJECT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(_PROJECT)
sys.path.insert(0, _PROJECT)

# ── 统一输出目录：screenshots/中文_check ──
SCREENSHOTS_DIR = os.path.join(_PROJECT, 'screenshots')

from lib.logger import set_log_file
from lib.channel_runner import ChannelRunner


def main():
    set_log_file()
    runner = ChannelRunner(
        channel_name="直播",
        bind_instance_id="zhibo_6.0",
        output_dir=os.path.join(SCREENSHOTS_DIR, '直播_check'),
        screenshot_prefix='直播',
        checkpoint_key='直播频道',
    )
    runner.run()


if __name__ == '__main__':
    main()
