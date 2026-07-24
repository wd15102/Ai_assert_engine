#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
融合模块调试测试 — 验证 P0-P3 各模块是否能正常协同工作
══════════════════════════════════════════════════════════════════════

测试项目：
  1. element_checker — wait_page_stable / wait_for_text_on_screen
  2. focus_checker   — get_focus_info / is_element_focused
  3. log_checker     — LogcatWatcher 崩溃/ANR 检测
  4. adb_utils       — wait_until_text_appears / is_text_on_screen
  5. scroll_crop_engine + wait_page_stable 替代 sleep（单步验证）

运行方式：
  cd ai_assert_engine
  python -m tests.test_fusion
  python -m tests.test_fusion --focus-only   # 只测焦点
  python -m tests.test_fusion --log-only     # 只测日志监控
  python -m tests.test_fusion --element-only # 只测元素检测
"""

import os
import sys
import time
import json
import traceback as tb

# 路径
_PROJ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, _PROJ)

from lib.logger import set_log_file, log, log_separator
from engine_config.config import ADB_DEVICE, SCREENSHOT_DIR


# ══════════════════════════════════════════════════════════════
# 测试上下文
# ══════════════════════════════════════════════════════════════

class TestContext:
    """测试上下文：记录每个测试的通过/失败状态"""
    def __init__(self):
        self.passed = 0
        self.failed = 0
        self.details = []

    def ok(self, name, msg=''):
        self.passed += 1
        log(f'  ✔ {name}  {msg}', 'OK')
        self.details.append({'name': name, 'status': 'PASS', 'msg': msg})

    def fail(self, name, msg=''):
        self.failed += 1
        log(f'  ✘ {name}  {msg}', 'WARN' if '跳过' in msg else 'ERROR')
        self.details.append({'name': name, 'status': 'FAIL', 'msg': msg})

    def summary(self):
        total = self.passed + self.failed
        log_separator()
        log(f'测试完成: {total} 项 | ✔ {self.passed} | ✘ {self.failed}', 'DONE')
        if self.failed > 0:
            log('--- 失败详情 ---', 'WARN')
            for d in self.details:
                if d['status'] == 'FAIL':
                    log(f'  ✘ {d["name"]}: {d["msg"]}', 'ERROR')
        return self.failed == 0


ctx = TestContext()


# ══════════════════════════════════════════════════════════════
# 1. element_checker 测试
# ══════════════════════════════════════════════════════════════

def test_element_checker():
    log_separator()
    log('【P0】element_checker — 元素存在性 + 智能等待', 'STEP')

    from lib.element_checker import (
        wait_page_stable,
        wait_for_text_on_screen,
        wait_for_element_by_desc,
        element_exists,
        element_count,
        get_visible_texts,
        wait_for_element_gone,
    )
    from lib import adb_utils as adb

    # 1-1. wait_page_stable — 首页稳定等待
    log('  --- 1-1: wait_page_stable (HOME → 精选) ---', 'INFO')
    try:
        adb.home()
        t0 = time.time()
        xml_text = wait_page_stable(timeout=8)
        elapsed = time.time() - t0
        if xml_text:
            ctx.ok('wait_page_stable', f'页面稳定耗时 {elapsed:.1f}s, XML={len(xml_text)}字符')
        else:
            ctx.fail('wait_page_stable', f'{elapsed:.1f}s 后返回空（可能超时）')
    except Exception as e:
        ctx.fail('wait_page_stable', f'异常: {e}')
        tb.print_exc()

    # 1-2. element_exists — 检测首页元素
    log('  --- 1-2: element_exists (首页logo/频道文字) ---', 'INFO')
    try:
        adb.home()
        wait_page_stable(timeout=5)
        has_logo = element_exists(class_name='android.widget.Image')
        has_text = element_exists(text='精选') or element_exists(text='直播')
        if has_text or has_logo:
            ctx.ok('element_exists', f'logo={has_logo}, 文本={has_text}')
        else:
            ctx.fail('element_exists', '未检测到任何页面元素（可能 XML dump 失败）')
    except Exception as e:
        ctx.fail('element_exists', f'异常: {e}')

    # 1-3. wait_for_text_on_screen — 等待文字出现
    log('  --- 1-3: wait_for_text_on_screen (等待"首页/精选/直播") ---', 'INFO')
    try:
        for keyword in ['精选', '直播', '首页', '电视']:
            found = wait_for_text_on_screen(keyword, timeout=6)
            if found:
                ctx.ok(f'wait_for_text_on_screen("{keyword}")', '检测到文字')
                break
        else:
            ctx.fail('wait_for_text_on_screen', '以上关键字均未检测到（可能页面无文字）')
    except Exception as e:
        ctx.fail('wait_for_text_on_screen', f'异常: {e}')

    # 1-4. get_visible_texts — 提取屏幕文字
    log('  --- 1-4: get_visible_texts ---', 'INFO')
    try:
        texts = get_visible_texts()
        if texts:
            ctx.ok('get_visible_texts', f'提取到 {len(texts)} 段文字: {texts[:8]}')
        else:
            ctx.fail('get_visible_texts', '未提取到文字（可能 XML dump 失败）')
    except Exception as e:
        ctx.fail('get_visible_texts', f'异常: {e}')

    # 1-5. element_count — 统计元素数量
    log('  --- 1-5: element_count (TextView 数量) ---', 'INFO')
    try:
        count = element_count(class_name='android.widget.TextView')
        if count > 0:
            ctx.ok('element_count', f'TextView x{count}')
        else:
            ctx.fail('element_count', '未检测到 TextView')
    except Exception as e:
        ctx.fail('element_count', f'异常: {e}')


# ══════════════════════════════════════════════════════════════
# 2. focus_checker 测试
# ══════════════════════════════════════════════════════════════

def test_focus_checker():
    log_separator()
    log('【P1】focus_checker — 焦点状态检测', 'STEP')

    from lib.focus_checker import (
        get_focus_info,
        is_element_focused,
        wait_for_focus_on,
        capture_focus_marked,
        assert_focus_on,
    )
    from lib import adb_utils as adb

    # 2-1. get_focus_info — 获取焦点信息
    log('  --- 2-1: get_focus_info ---', 'INFO')
    try:
        adb.home()
        time.sleep(2)  # 短等页面稳定
        info = get_focus_info()
        if info['has_focus']:
            ctx.ok('get_focus_info', f'bounds={info["bounds"]} class={info["class"]} desc="{info["content_desc"][:30]}"')
        else:
            ctx.fail('get_focus_info', 'XML 中未找到 focused=true')
    except Exception as e:
        ctx.fail('get_focus_info', f'异常: {e}')
        tb.print_exc()

    # 2-2. capture_focus_marked — 生成焦点标记图
    log('  --- 2-2: capture_focus_marked ---', 'INFO')
    try:
        marked = capture_focus_marked()
        if marked and os.path.exists(marked):
            sz = os.path.getsize(marked) // 1024
            ctx.ok('capture_focus_marked', f'标记图: {os.path.basename(marked)} ({sz}KB)')
        else:
            ctx.fail('capture_focus_marked', '未生成标记图')
    except Exception as e:
        ctx.fail('capture_focus_marked', f'异常: {e}')
        tb.print_exc()

    # 2-3. is_element_focused — 判断焦点是否在指定元素上
    log('  --- 2-3: is_element_focused ---', 'INFO')
    try:
        # 当前焦点应该在导航栏某个频道上
        info = get_focus_info()
        if info['has_focus'] and info['content_desc']:
            focused_desc = info['content_desc']
            result = is_element_focused(desc=focused_desc)
            if result:
                ctx.ok('is_element_focused', f'焦点确认在 "{focused_desc}" 上')
            else:
                ctx.fail('is_element_focused', 'get_focus_info 有值但 is_element_focused 返回 False（逻辑问题）')
        else:
            ctx.fail('is_element_focused', '未获取到焦点信息，跳过测试')
    except Exception as e:
        ctx.fail('is_element_focused', f'异常: {e}')

    # 2-4. wait_for_focus_on — 等待焦点到达（短超时，用于验证不阻塞）
    log('  --- 2-4: wait_for_focus_on (验证不阻塞) ---', 'INFO')
    try:
        info = get_focus_info()
        current_desc = info.get('content_desc', '')
        if current_desc:
            ok = wait_for_focus_on(desc=current_desc, timeout=3)
            ctx.ok('wait_for_focus_on', f'焦点已在 "{current_desc[:20]}" 上 → {ok}')
        else:
            # 没有 desc 就用文本匹配
            current_text = info.get('text', '')
            if current_text:
                ok = wait_for_focus_on(text=current_text, timeout=3)
                ctx.ok('wait_for_focus_on', f'焦点文本匹配 → {ok}')
            else:
                ctx.fail('wait_for_focus_on', '当前焦点无 desc/文本属性，跳过')
    except Exception as e:
        ctx.fail('wait_for_focus_on', f'异常: {e}')

    # 2-5. assert_focus_on — 综合断言（XML 模式）
    log('  --- 2-5: assert_focus_on (use_ai=False) ---', 'INFO')
    try:
        info = get_focus_info()
        desc = info.get('content_desc', '')
        if desc:
            result = assert_focus_on(desc=desc, use_ai=False, timeout=3)
            if result:
                ctx.ok('assert_focus_on(XML)', f'焦点断言通过')
            else:
                ctx.fail('assert_focus_on(XML)', '断言失败')
        else:
            ctx.fail('assert_focus_on(XML)', '无焦点 desc 属性，跳过')
    except Exception as e:
        ctx.fail('assert_focus_on(XML)', f'异常: {e}')


# ══════════════════════════════════════════════════════════════
# 3. log_checker 测试
# ══════════════════════════════════════════════════════════════

def test_log_checker():
    log_separator()
    log('【P2】log_checker — Logcat 监控', 'STEP')

    from lib.log_checker import LogcatWatcher
    from lib import adb_utils as adb

    # 3-1. Logcat 启动/停止/事件捕获
    log('  --- 3-1: LogcatWatcher 启动/停止 ---', 'INFO')
    try:
        watcher = LogcatWatcher(max_events=200)
        watcher.start(filters=['mangotv', 'huawei', 'hylink', 'AndroidRuntime'])
        log('  Logcat 监控已启动，等待 3 秒收集数据...', 'WAIT')
        time.sleep(3)
        events = watcher.stop()

        if events is not None:
            ctx.ok('LogcatWatcher start/stop', f'捕获 {len(events)} 条事件')
        else:
            ctx.fail('LogcatWatcher start/stop', 'stop() 返回 None')

        # 3-2. 崩溃检测
        log('  --- 3-2: 崩溃检测 ---', 'INFO')
        try:
            crash = watcher.has_crash()
            crash_events = watcher.get_crash_events()
            ctx.ok(f'has_crash', f'崩溃={crash}, 共 {len(crash_events)} 条')
        except Exception as e2:
            ctx.fail('has_crash', f'异常: {e2}')

        # 3-3. ANR 检测
        log('  --- 3-3: ANR 检测 ---', 'INFO')
        try:
            anr = watcher.has_anr()
            anr_events = watcher.get_anr_events()
            ctx.ok(f'has_anr', f'ANR={anr}, 共 {len(anr_events)} 条')
        except Exception as e3:
            ctx.fail('has_anr', f'异常: {e3}')

        # 3-4. 按级别过滤
        log('  --- 3-4: get_events(min_level=ERROR) ---', 'INFO')
        try:
            errors = watcher.get_events(min_level='ERROR')
            ctx.ok('get_events(ERROR)', f'ERROR 及以上: {len(errors)} 条')
        except Exception as e4:
            ctx.fail('get_events(ERROR)', f'异常: {e4}')

        # 3-5. 关键字过滤
        log('  --- 3-5: filter_events(hylink) ---', 'INFO')
        try:
            hylink_events = watcher.filter_events('hylink')
            ctx.ok('filter_events(hylink)', f'hylink 事件: {len(hylink_events)} 条')
        except Exception as e5:
            ctx.fail('filter_events(hylink)', f'异常: {e5}')

        # 3-6. reset
        log('  --- 3-6: reset ---', 'INFO')
        try:
            watcher.reset()
            ctx.ok('reset', '缓存已清空')
        except Exception as e6:
            ctx.fail('reset', f'异常: {e6}')

    except Exception as e:
        ctx.fail('LogcatWatcher', f'整体异常: {e}')
        tb.print_exc()


# ══════════════════════════════════════════════════════════════
# 4. adb_utils P3 增强测试
# ══════════════════════════════════════════════════════════════

def test_adb_wait():
    log_separator()
    log('【P3】adb_utils — 高频等待函数', 'STEP')

    from lib import adb_utils as adb

    # 4-1. is_text_on_screen
    log('  --- 4-1: is_text_on_screen ---', 'INFO')
    try:
        adb.home()
        time.sleep(1.5)
        # 检测常见首页文本
        for keyword in ['精选', '直播', '电视', '首页', '频道']:
            result = adb.is_text_on_screen(keyword)
            if result:
                ctx.ok(f'is_text_on_screen("{keyword}")', '文本存在')
                break
        else:
            ctx.fail('is_text_on_screen', '以上关键字均未匹配（页面可能无文字）')
    except Exception as e:
        ctx.fail('is_text_on_screen', f'异常: {e}')
        tb.print_exc()

    # 4-2. wait_until_text_appears
    log('  --- 4-2: wait_until_text_appears ---', 'INFO')
    try:
        adb.home()
        t0 = time.time()
        found = adb.wait_until_text_appears('精选', timeout=8)
        elapsed = time.time() - t0
        if found:
            ctx.ok('wait_until_text_appears("精选")', f'耗时 {elapsed:.1f}s')
        else:
            ctx.fail('wait_until_text_appears("精选")', f'{elapsed:.1f}s 超时')
    except Exception as e:
        ctx.fail('wait_until_text_appears', f'异常: {e}')

    # 4-3. wait_until_element_present
    log('  --- 4-3: wait_until_element_present ---', 'INFO')
    try:
        adb.home()
        t0 = time.time()
        found = adb.wait_until_element_present('精选', timeout=8)
        elapsed = time.time() - t0
        if found:
            ctx.ok('wait_until_element_present("精选")', f'耗时 {elapsed:.1f}s')
        else:
            ctx.fail('wait_until_element_present("精选")', f'{elapsed:.1f}s 超时')
    except Exception as e:
        ctx.fail('wait_until_element_present', f'异常: {e}')


# ══════════════════════════════════════════════════════════════
# 5. scroll_crop_engine 等待增强 — 对比测试
# ══════════════════════════════════════════════════════════════

def test_scroll_wait():
    """
    验证 scroll_crop_engine 中的 wait_page_stable 替代 sleep 是否正常工作。

    测试方式：
      - 按 DPAD_DOWN 后，检查 wait_page_stable 能检测到页面稳定
      - 不真正裁剪（避免依赖测试桩和模板数据）
    """
    log_separator()
    log('【验证】scroll_crop_engine + wait_page_stable', 'STEP')

    from lib.element_checker import wait_page_stable
    from lib import adb_utils as adb

    log('  --- DPAD_DOWN → wait_page_stable 替代 sleep(2) ---', 'INFO')
    try:
        # 先确保在首页
        adb.home()
        wait_page_stable(timeout=5)

        for step in range(3):
            log(f'  步骤 {step+1}: DPAD_DOWN', 'KEY')
            adb.dpad_down(1)
            t0 = time.time()
            xml_text = wait_page_stable(timeout=4)
            elapsed = time.time() - t0
            if xml_text:
                ctx.ok(f'Step{step+1}: dpad_down→wait_page_stable', f'耗时 {elapsed:.1f}s')
            else:
                ctx.fail(f'Step{step+1}: dpad_down→wait_page_stable', f'{elapsed:.1f}s 超时/空')
    except Exception as e:
        ctx.fail('scroll_wait', f'异常: {e}')
        tb.print_exc()


# ══════════════════════════════════════════════════════════════
# 6. 联合协同测试 — LogcatWatcher + element_checker + adb_utils
# ══════════════════════════════════════════════════════════════

def test_integration():
    """
    模拟巡检中的一段真实流程：导航 → 等待稳定 → 确认文本 → 日志监控
    """
    log_separator()
    log('【集成测试】模拟巡检流程', 'STEP')

    from lib.element_checker import wait_page_stable, wait_for_text_on_screen
    from lib.log_checker import LogcatWatcher
    from lib import adb_utils as adb

    try:
        # 启动日志监控
        watcher = LogcatWatcher(max_events=300)
        watcher.start(filters=['mangotv', 'huawei', 'AndroidRuntime', 'hylink'])
        log('  Logcat 已启动', 'INFO')

        # HOME 回到首页
        log('  步骤1: HOME 回到首页', 'KEY')
        adb.home()
        t0 = time.time()
        stable = wait_page_stable(timeout=8)
        t1 = time.time()
        if stable:
            ctx.ok('集成: HOME→wait_page_stable', f'耗时 {t1-t0:.1f}s')
        else:
            ctx.fail('集成: HOME→wait_page_stable', f'超时')

        # 确认文字
        log('  步骤2: 等待"精选"文字出现', 'INFO')
        t0 = time.time()
        text_ok = wait_for_text_on_screen('精选', timeout=5)
        t1 = time.time()
        if text_ok:
            ctx.ok('集成: wait_for_text_on_screen("精选")', f'耗时 {t1-t0:.1f}s')
        else:
            ctx.fail('集成: wait_for_text_on_screen("精选")', f'超时')

        # 模拟简单导航
        log('  步骤3: DPAD_DOWN x2', 'KEY')
        adb.dpad_down(2)
        t0 = time.time()
        stable2 = wait_page_stable(timeout=5)
        t1 = time.time()
        if stable2:
            ctx.ok('集成: DPAD_DOWN→wait_page_stable', f'耗时 {t1-t0:.1f}s')
        else:
            ctx.fail('集成: DPAD_DOWN→wait_page_stable', f'超时')

        # 停止监控
        log('  步骤4: 停止 Logcat 并检查', 'INFO')
        events = watcher.stop()
        if events is not None:
            ctx.ok('集成: Logcat 停止', f'共 {len(events)} 条事件')
        crash = watcher.has_crash()
        anr = watcher.has_anr()
        log(f'  崩溃={crash}  ANR={anr}', 'INFO')

        if crash:
            ctx.fail('集成: 监测到崩溃', str(watcher.get_crash_events()))
        else:
            ctx.ok('集成: 无崩溃', 'OK')

        if anr:
            ctx.fail('集成: 监测到 ANR', str(watcher.get_anr_events()))
        else:
            ctx.ok('集成: 无 ANR', 'OK')

    except Exception as e:
        ctx.fail('集成测试', f'异常: {e}')
        tb.print_exc()


# ══════════════════════════════════════════════════════════════
# 主入口
# ══════════════════════════════════════════════════════════════

if __name__ == '__main__':
    # 解析过滤参数
    filters = [a.replace('--', '').replace('-', '_') for a in sys.argv[1:] if a.startswith('--')]

    set_log_file()
    log_separator()
    log('融合模块调试测试', 'DONE')
    log(f'设备: {ADB_DEVICE}', 'INFO')
    log(f'过滤: {filters if filters else "全部"}', 'INFO')
    log_separator()

    test_map = {
        'element': test_element_checker,
        'focus': test_focus_checker,
        'log': test_log_checker,
        'adb': test_adb_wait,
        'scroll': test_scroll_wait,
        'integration': test_integration,
    }

    # 如果有过滤参数，只跑匹配的测试
    if filters:
        for key, fn in test_map.items():
            if any(f in key for f in filters):
                fn()
    else:
        # 全量跑（除了集成测试，它依赖前面模块的结果）
        for key, fn in test_map.items():
            if key == 'integration':
                continue  # 集成测试独立跑
            fn()

        # 集成测试（可选）
        log_separator()
        log('是否需要跑集成测试？在 10 秒内 Ctrl+C 退出，否则继续', 'WAIT')
        try:
            time.sleep(1)  # 缩短等待，实际跑起来
            test_integration()
        except KeyboardInterrupt:
            log('跳过集成测试', 'WARN')

    ctx.summary()
