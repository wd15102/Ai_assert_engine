#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
接口分析工具 — 主入口
连设备 → 抓包 → 分析 → 生成报告

用法:
    python -m 接口分析.main                  # 默认模式
    python -m 接口分析.main --charles-only   # 仅 Charles
    python -m 接口分析.main --logcat-only    # 仅 logcat
    python -m 接口分析.main --device 192.168.202.121:5555
"""

import os
import sys
import time
import argparse
from datetime import datetime
from typing import Optional, List, Dict

# 添加父目录到路径
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from lib.adb_utils import (
    adb_shell, screenshot, ok, back, check_device,
    get_current_package, get_top_activity, _log
)
from engine_config.config import ADB_DEVICE, SCREENSHOT_DIR

try:
    from .charles_capturer import CharlesCapturer, parse_charles_transactions
    from .logcat_capturer import LogcatCapturer, filter_api_requests
    from .api_analyzer import ApiAnalyzer
    from .report_generator import ReportGenerator
except ImportError:
    from charles_capturer import CharlesCapturer, parse_charles_transactions
    from logcat_capturer import LogcatCapturer, filter_api_requests
    from api_analyzer import ApiAnalyzer
    from report_generator import ReportGenerator


def check_prerequisites() -> bool:
    """检查前置条件"""
    _log('检查前置条件...', 'INFO')

    # 检查 ADB 设备
    if not check_device():
        _log(f'ADB 设备不在线: {ADB_DEVICE}', 'ERROR')
        return False

    current_pkg = get_current_package()
    _log(f'当前包名: {current_pkg}', 'INFO')

    top_activity = get_top_activity()
    _log(f'当前 Activity: {top_activity}', 'INFO')

    return True


def capture_via_charles(charles_url: str, navigate_func) -> Optional[List[Dict]]:
    """通过 Charles 捕获网络请求"""
    _log('尝试 Charles 代理抓包...', 'INFO')
    capturer = CharlesCapturer(charles_url)

    if not capturer.check_available():
        _log('Charles Web API 不可用', 'WARN')
        return None

    # 清空会话 → 开始录制 → 执行导航 → 停止录制 → 导出数据
    capturer.clear_session()
    time.sleep(0.5)
    capturer.start_recording()
    time.sleep(0.5)

    # 执行导航动作（进入详情页）
    navigate_func()

    time.sleep(3)  # 等待页面加载完成
    capturer.stop_recording()

    # 导出数据
    transactions = capturer.export_session_json()
    if transactions:
        return parse_charles_transactions(transactions)
    return None


def capture_via_logcat(navigate_func) -> List[Dict]:
    """通过 ADB logcat 捕获网络请求"""
    _log('使用 ADB logcat 抓包...', 'INFO')
    capturer = LogcatCapturer()

    def action():
        navigate_func()
        time.sleep(3)  # 等待页面加载

    requests, _ = capturer.capture_during_action(action)

    # 过滤 API 请求
    api_requests = filter_api_requests(requests)

    # 也把原始请求加入（包含非 API 但有价值的数据）
    all_requests = api_requests + [r for r in requests if r not in api_requests]

    # 去重
    seen = set()
    unique = []
    for req in all_requests:
        url = req.get('url', '')
        if url not in seen:
            seen.add(url)
            unique.append(req)

    return unique


def navigate_to_detail_page():
    """导航到详情页（按 OK 键进入当前焦点影片）"""
    _log('按 OK 键进入详情页...', 'INFO')
    ok()  # 发送 OK 键事件
    time.sleep(2)


def take_screenshot(filename: str = None) -> Optional[str]:
    """截取当前屏幕"""
    if not filename:
        filename = f'detail_page_{datetime.now().strftime("%Y%m%d_%H%M%S")}.png'
    try:
        path = screenshot(filename)
        if path:
            _log(f'截图保存: {path}', 'SCREEN')
        return path
    except Exception as e:
        _log(f'截图失败: {e}', 'WARN')
        return None


def run_analysis(charles_url: str = 'http://192.168.202.181:8899',
                 device: str = None,
                 charles_only: bool = False,
                 logcat_only: bool = False,
                 output_dir: str = None) -> Optional[str]:
    """运行完整的接口分析流程

    返回生成的报告路径
    """
    # 更新设备地址
    if device:
        import lib.adb_utils as adu
        adu.current_device = device

    # 检查前置条件
    if not check_prerequisites():
        return None

    # 截图：进入详情页前的列表页
    _log('截取列表页截图...', 'INFO')
    list_screenshot = take_screenshot(
        f'list_page_{datetime.now().strftime("%Y%m%d_%H%M%S")}.png'
    )

    # ═══ 抓包阶段 ═══
    requests = []
    capture_method = 'logcat'

    if not logcat_only:
        # 优先尝试 Charles
        charles_data = capture_via_charles(charles_url, navigate_to_detail_page)
        if charles_data:
            requests = charles_data
            capture_method = 'charles'
            _log(f'Charles 抓包成功: {len(requests)} 条记录', 'OK')
        else:
            _log('Charles 抓包失败或无数据，降级到 logcat', 'WARN')

    if not requests and not charles_only:
        # 降级到 logcat
        # 先返回列表页
        _log('返回列表页，重新通过 logcat 抓包...', 'INFO')
        back()
        time.sleep(1.5)

        logcat_data = capture_via_logcat(navigate_to_detail_page)
        if logcat_data:
            requests = logcat_data
            capture_method = 'logcat'
            _log(f'logcat 抓包成功: {len(requests)} 条记录', 'OK')

    if not requests:
        _log('抓包失败: 未捕获到任何网络请求', 'ERROR')
        return None

    # 截图：进入详情页后的截图
    _log('截取详情页截图...', 'INFO')
    detail_screenshot = take_screenshot(
        f'detail_page_{datetime.now().strftime("%Y%m%d_%H%M%S")}.png'
    )

    # ═══ 分析阶段 ═══
    _log('开始分析接口...', 'INFO')
    analyzer = ApiAnalyzer()
    summary = analyzer.analyze(requests)

    # UI 映射
    analyzer.map_to_ui_elements()

    # ═══ 生成报告 ═══
    _log('生成交互式 HTML 报告...', 'INFO')
    reporter = ReportGenerator(output_dir=output_dir)

    report_path = reporter.generate(
        analyzer=analyzer,
        capture_method=capture_method,
        device=device or ADB_DEVICE,
        screenshot_path=detail_screenshot,
    )

    # ═══ 输出摘要 ═══
    _log('═══ 分析完成 ═══', 'SEP')
    _log(f'报告路径: {report_path}', 'OK')
    _log(f'接口总数: {len(requests)}', 'OK')
    _log(f'核心接口: {sum(1 for r in requests if r.get("is_core"))}', 'OK')
    _log(f'捕获方式: {capture_method}', 'OK')

    return report_path


def main():
    """命令行入口"""
    parser = argparse.ArgumentParser(description='影视详情页接口分析工具')
    parser.add_argument('--device', default=None, help='ADB 设备地址 (默认从 config.py 读取)')
    parser.add_argument('--charles-url', default='http://192.168.202.181:8899', help='Charles Web API 地址')
    parser.add_argument('--charles-only', action='store_true', help='仅使用 Charles 抓包')
    parser.add_argument('--logcat-only', action='store_true', help='仅使用 logcat 抓包')
    parser.add_argument('--output-dir', default=None, help='报告输出目录')

    args = parser.parse_args()

    report_path = run_analysis(
        charles_url=args.charles_url,
        device=args.device,
        charles_only=args.charles_only,
        logcat_only=args.logcat_only,
        output_dir=args.output_dir,
    )

    if report_path:
        print(f'\n✅ 报告已生成: {report_path}')
    else:
        print('\n❌ 分析失败，请检查设备连接和 Charles 配置')


if __name__ == '__main__':
    main()
