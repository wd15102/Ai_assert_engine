#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
首页模板自动巡查系统 — 主入口

用法:
  python run.py                    # 全量巡检
  python run.py --channel 直播      # 只跑一个频道
  python run.py --resume            # 跳过已完成的频道（待实现）
  python run.py --dry-run           # 只检查环境不跑
"""

import os
import sys
import time
import webbrowser
import argparse

# 让 Python 能找到项目根目录（config.py 所在位置）
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from lib import adb_utils as adb
from lib import stub_parser as stub
from lib import reporter as report
from engine.appium_nav import AppiumSession, navigate_to_channel

from engine_config import (
    OUTPUT_DIR, NORMAL_DIR, ABNORMAL_DIR,
    ADB_DEVICE, STUB_DIR, NAV_FILE,
)
from lib.logger import set_log_file, log, log_step, log_separator
from lib.element_checker import wait_page_stable, wait_for_text_on_screen


def patrol():
    """首页巡查主流程"""
    start_time = time.time()

    # ── 初始化日志 ──
    set_log_file()
    log_separator()
    log('首页模板自动巡查系统启动', 'DONE')
    log_separator()
    log(f'设备: {adb.current_device}', 'INFO')
    log(f'模型: {ai.GLM_MODEL}', 'INFO')
    log(f'输出目录: {OUTPUT_DIR}', 'INFO')

    report.ensure_dirs()

    # ── 设备检查 ──
    log_step('检查 ADB 设备')
    if not adb.check_device():
        log(f'设备 {adb.current_device} 不在线，尝试自动匹配...', 'WARN')
        new_dev = adb.auto_detect_device()
        if new_dev:
            adb.current_device = new_dev
            log(f'发现设备: {new_dev}', 'OK')
        else:
            log('没有可用的 ADB 设备！请检查连接。', 'ERROR')
            return
    else:
        log(f'设备 {adb.current_device} 已连接', 'OK')

    # ── 读取频道列表 ──
    log_step('读取频道列表')
    channels = stub.get_channel_list()
    if not channels:
        log('读取频道列表失败！请检查导航 JSON 文件。', 'ERROR')
        return

    log(f'共 {len(channels)} 个频道:', 'INFO')
    for c in channels:
        log(f'  sn={c["sn"]:2d}  "{c["title"]:12s}"  instanceId={c["bindInstanceId"]}', 'INFO')

    # ── 遍历频道（try/finally 保底: 中断时也生成报告）──
    all_results = []
    interrupted = False

    # 启动 Appium Session
    appium_session = AppiumSession()
    driver = appium_session.start()
    log(f'Appium Session 已启动: {driver.session_id}', 'OK')

    # 截图目录
    screenshots_dir = os.path.join(os.path.dirname(__file__), '..', 'screenshots')

    # ── 复位到精选频道 HOME 两次 ──
    log_step('复位 HOME（默认到精选频道）')
    adb.home()
    wait_page_stable(timeout=3)
    adb.home()
    wait_page_stable(timeout=5)
    log('焦点已回到精选频道', 'OK')

    try:
        for idx, ch in enumerate(channels):
            sn, title, bind_id = ch['sn'], ch['title'], ch['bindInstanceId']
            safe_name = title.replace('/', '_').replace('\\', '_').replace(' ', '_')

            # 跳过非内容频道
            if title in ['二级菜单', '全部']:
                log(f'跳过非内容频道: "{title}"', 'WARN')
                all_results.append({
                    'sn': sn, 'title': title, 'status': 'unknown',
                    'screenshots': [], 'templates': [], 'abnormalities': ['已跳过'],
                })
                continue

            log_separator()
            log(f'频道 [{idx+1}/{len(channels)}]: sn={sn}  title="{title}"', 'STEP')
            log(f'bindInstanceId={bind_id}', 'INFO')

            # 查找测试桩
            stub_path = stub.find_channel_stub(ch)
            template_info = []
            if stub_path:
                template_info = stub.extract_template_info(stub_path)
                log(f'测试桩: {os.path.basename(stub_path)} ({len(template_info)}个模板)', 'INFO')
                for t in template_info:
                    card_count = t['card_count']
                    name = t.get("templateName", t.get("templateId", "?"))
                    log(f'  模板: {name} ({card_count}个卡片)', 'INFO')
            else:
                log('未找到匹配测试桩，仅截图不进行 AI 分析', 'WARN')

            # 导航到频道
            navigate_to_channel(driver, title)
            wait_page_stable(timeout=5)
            log(f'页面稳定: "{title}"', 'OK')

            # ── 无测试桩 → 只截图1张，跳过AI ──
            if not stub_path:
                log('无匹配测试桩，仅截取1张全屏', 'WARN')
                shot = adb.scroll_and_screenshot_once(title, '_full')
                if shot:
                    report.copy_screenshot(shot['file'], NORMAL_DIR,
                                           title.replace('/', '_').replace('\\', '_').replace(' ', '_'))
                all_results.append({
                    'sn': sn, 'title': title, 'status': 'unknown',
                    'screenshots': [shot] if shot else [],
                    'templates': [], 'abnormalities': [],
                })
                continue

            if not ai.api_key_valid():
                log('API Key 未配置，仅截图不分析', 'WARN')
                shot = adb.scroll_and_screenshot_once(title, '_full')
                if shot:
                    report.copy_screenshot(shot['file'], NORMAL_DIR,
                                           title.replace('/', '_').replace('\\', '_').replace(' ', '_'))
                all_results.append({
                    'sn': sn, 'title': title, 'status': 'unknown',
                    'screenshots': [shot] if shot else [],
                    'templates': [], 'abnormalities': [],
                })
                continue

            # ══════════════════════════════════════════════
            # 方案B：边滚动边截图 → XML动态坐标裁剪
            # ══════════════════════════════════════════════
            from scroll_crop_engine import scroll_and_crop_all

            log_step('边滚动边裁剪（方案B）')
            result = scroll_and_crop_all(
                driver=driver,
                adb_module=adb,
                channel_title=title,
                template_info=template_info,
                screenshots_dir=screenshots_dir,
            )
            captured_blocks = result['blocks']
            all_screenshots = result['all_screenshots']
            log(f'方案B完成: {len(all_screenshots)}张截图, {len(captured_blocks)}个裁剪块', 'OK')

            # 3. 回到顶部（HOME 键）
            adb.home()
            wait_page_stable(timeout=3)

            # 4. 打印裁剪图清单
            if captured_blocks:
                log('--- 裁剪图清单 ---', 'INFO')
                for cb in captured_blocks:
                    log(f'  Block#{cb["sort"]} (Y={cb["y_start"]}-{cb["y_end"]}, {cb["card_count"]}卡片): {os.path.abspath(cb["crop_path"])}', 'FILE')
                log('--- 裁剪图清单结束 ---', 'INFO')

            # 5. 汇总
            status = 'normal'  # 纯裁剪不做 AI 判断，默认正常
            if all_screenshots:
                ref_shot = all_screenshots[0]['file']
                report.copy_screenshot(ref_shot, NORMAL_DIR, safe_name)
                log(f'截图已归档: normal/', 'SCREEN')

            all_results.append({
                'sn': sn, 'title': title, 'bindInstanceId': bind_id,
                'status': status,
                'screenshots': all_screenshots,
                'templates': [
                    {'templateName': t.get('templateName', t.get('templateId', '')),
                     'cardCount': t.get('card_count', 0)}
                    for t in template_info
                ],
                'blocks': captured_blocks,
                'abnormalities': [],
            })

            log(f'完成: "{title}"', 'OK')

    except KeyboardInterrupt:
        interrupted = True
        log('用户中断巡检！已产出的结果将生成部分报告。', 'WARN')
    except BaseException as e:
        interrupted = True
        log(f'巡检异常: {e}', 'ERROR')
        import traceback
        for line in traceback.format_exc().split('\n'):
            if line.strip():
                log(f'  {line}', 'ERROR')
    finally:
        # ── 无论如何都生成报告 ──
        elapsed = time.time() - start_time

        # 关闭 Appium Session
        appium_session.stop()
        log('Appium Session 已关闭', 'INFO')

        if not all_results:
            log('无任何巡检结果，跳过报告生成。', 'WARN')
            return

        log_separator()
        if interrupted:
            log(f'生成部分报告（已完成 {len(all_results)}/{len(channels)} 个频道）', 'WARN')
        else:
            log('生成完整报告', 'INFO')

        report_file = report.generate_html_report(all_results, elapsed)

        normal_count = sum(1 for r in all_results if r.get('status') == 'normal')
        abnormal_count = sum(1 for r in all_results if r.get('status') in ('abnormal', 'error'))
        warning_count = sum(1 for r in all_results if r.get('status') == 'warning')

        log_separator()
        log('巡查完成' + ('（部分）' if interrupted else ''), 'DONE')
        log_separator()
        log(f'总计:   {len(all_results)} 个频道, 耗时 {elapsed:.0f}秒', 'INFO')
        log(f'正常:   {normal_count}', 'OK')
        log(f'警告:   {warning_count}', 'INFO')
        log(f'异常:   {abnormal_count}', 'WARN')
        log(f'报告:   {report_file}', 'INFO')

        try:
            webbrowser.open(f'file://{report_file}')
            log('已打开浏览器', 'INFO')
        except Exception:
            pass

        log('截图已分类保存: normal/ 和 abnormal/', 'INFO')


def _navigate_to_channel(target_sn, channels):
    """从 HOME 默认焦点（精选 sn=4）导航到目标频道"""
    log(f'--- 导航到 sn={target_sn} ---', 'SEP')

    log('第1步/2: 按 2下 HOME 回默认频道', 'INFO')
    adb.home()
    adb.home()
    wait_page_stable(timeout=3)

    offset = target_sn - HOME_DEFAULT_SN
    if offset == 0:
        log('第2步/2: 已在目标（精选），无需移动', 'OK')
    elif offset > 0:
        log(f'第2步/2: 右键 x{offset} 从 sn=4 到 sn={target_sn}', 'KEY')
        adb.dpad_right(offset)
    else:
        log(f'第2步/2: 左键 x{abs(offset)} 从 sn=4 到 sn={target_sn}', 'KEY')
        adb.dpad_left(abs(offset))

    log('等待页面渲染...', 'WAIT')
    wait_page_stable(timeout=5)


# ══════════════════════════════════════════════════════════════
def preflight_check():
    """启动前环境检查，全部通过才进入主流程"""
    log('--- 启动前环境检查 ---', 'SEP')
    all_ok = True

    # 1. ADB 设备
    log('检查 ADB 设备...', 'INFO')
    if not adb.check_device():
        dev = adb.auto_detect_device()
        if dev:
            log(f'  设备自动匹配: {dev}', 'INFO')
        else:
            log('  ✗ 无可用 ADB 设备！请检查连接。', 'ERROR')
            all_ok = False
    else:
        log(f'  ✓ ADB 设备在线: {ADB_DEVICE}', 'OK')

    # 2. 测试桩目录
    log('检查测试桩目录...', 'INFO')
    if not os.path.isdir(STUB_DIR):
        log(f'  ✗ 测试桩目录不存在: {STUB_DIR}', 'ERROR')
        all_ok = False
    else:
        stub_count = len([f for f in os.listdir(STUB_DIR)
                         if f.endswith('.json') and not f.endswith('.bak')])
        log(f'  ✓ 测试桩目录: {STUB_DIR} ({stub_count}个JSON)', 'OK')
        if stub_count < 10:
            log(f'  ! 测试桩数量异常少({stub_count})，可能路径配置错误', 'WARN')

    # 3. 导航配置文件
    log('检查导航配置...', 'INFO')
    if not os.path.isfile(NAV_FILE):
        log(f'  ✗ 导航文件不存在: {NAV_FILE}', 'ERROR')
        all_ok = False
    else:
        channels = stub.get_channel_list()
        if channels:
            log(f'  ✓ 导航文件: {stub.load_json(NAV_FILE)["templateDatas"][0]["datas"][0]["title"]} 等 {len(channels)} 个频道', 'OK')
        else:
            log(f'  ! 导航文件读取异常（空列表）: {NAV_FILE}', 'WARN')

    # 4. API Key
    log('检查 AI API Key...', 'INFO')
    if ai.api_key_valid():
        log(f'  ✓ API Key 已配置 (模型: {ai.GLM_MODEL})', 'OK')
    else:
        log('  ✗ API Key 未配置！请在 config.py 或环境变量 ZHIPUAI_API_KEY 中设置', 'ERROR')
        all_ok = False

    # 5. 输出目录
    log('创建输出目录...', 'INFO')
    try:
        report.ensure_dirs()
        log(f'  ✓ 输出目录已就绪: {OUTPUT_DIR}', 'OK')
    except Exception as e:
        log(f'  ✗ 创建输出目录失败: {e}', 'ERROR')
        all_ok = False

    log_separator()
    if all_ok:
        log('环境检查全部通过 ✓', 'DONE')
    else:
        log('环境检查有失败项，请修复后重试 ✗', 'ERROR')
    log_separator()
    return all_ok


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='首页模板自动巡检系统',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''示例:
  python run.py                    # 全量巡检
  python run.py --channel 直播      # 只跑直播频道
  python run.py --dry-run           # 只检查环境
  python run.py --channel 直播,精选 # 跑多个频道
''')
    parser.add_argument('--channel', type=str, default='',
                        help='指定巡检频道（逗号分隔），默认全量')
    parser.add_argument('--resume', action='store_true',
                        help='断点续跑（跳过已完成频道）')
    parser.add_argument('--dry-run', action='store_true',
                        help='只检查环境，不执行巡检')

    args = parser.parse_args()

    set_log_file()
    log('首页模板自动巡查系统 v1.1', 'DONE')
    log(f'参数: channel={args.channel or "全量"}, resume={args.resume}, dry-run={args.dry_run}', 'INFO')
    log_separator()

    # 环境预检
    if not preflight_check():
        sys.exit(1)

    if args.dry_run:
        log('Dry-run 模式，环境检测通过，退出。', 'DONE')
        sys.exit(0)

    # 如指定频道，对频道列表做过滤
    if args.channel:
        channels = stub.get_channel_list()
        target_titles = [t.strip() for t in args.channel.split(',')]
        matched = [c for c in channels if c['title'] in target_titles]
        if not matched:
            available = ', '.join(c['title'] for c in channels)
            log(f'未找到指定频道 "{args.channel}"，可用频道: {available}', 'ERROR')
            sys.exit(1)
        log(f'过滤: 从 {len(channels)} 个频道中选中 {len(matched)} 个: {[m["title"] for m in matched]}', 'INFO')
        # 注入到 stub_parser 的 get_channel_list 返回
        import types
        original_get = stub.get_channel_list
        stub.get_channel_list = lambda: original_get() if args.channel == '' else matched

    patrol()
