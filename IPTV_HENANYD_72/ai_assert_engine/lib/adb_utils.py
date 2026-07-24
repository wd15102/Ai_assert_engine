#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ADB 硬件交互模块 — 截屏、按键事件、设备管理
"""

import os
import subprocess
import time
import re
import threading
from datetime import datetime
from typing import Optional
from appium.options.common import AppiumOptions
import psutil

from engine_config.config import ADB_DEVICE, SCREENSHOT_DIR, KEY_DELAY, PAGE_LOAD_DELAY, SCROLL_DELAY

_KEY_NAMES = {
    '3': 'HOME', '4': 'BACK', '19': 'UP', '20': 'DOWN',
    '21': 'LEFT', '22': 'RIGHT', '23': 'OK', '66': 'ENTER', '82': 'MENU',
}

# uiautomator dump 不支持并发，共享锁供本模块和 element_checker 使用
DUMP_LOCK = threading.Lock()

current_device = ADB_DEVICE


def _log(msg, level='INFO'):
    from lib.logger  import log
    log(msg, level)


# ══════════════════════════════════════════════════════════════
# 底层 ADB
# ══════════════════════════════════════════════════════════════

def adb_shell(cmd, timeout=10):
    """执行 ADB 设备级 shell 命令（自动加 -s device），返回 stdout"""
    full_cmd = ['adb', '-s', current_device] + cmd
    try:
        r = subprocess.run(full_cmd, capture_output=True, timeout=timeout)
        return r.stdout.decode('utf-8', errors='replace').strip()
    except subprocess.TimeoutExpired:
        _log(f'ADB 超时: {" ".join(cmd)}', 'WARN')
        return ''
    except Exception as e:
        _log(f'ADB 错误: {e}', 'ERROR')
        return ''


def adb_raw(cmd, timeout=10):
    """执行 ADB 全局命令（不加 -s device），适用于 devices/kill-server 等"""
    full_cmd = ['adb'] + cmd
    try:
        r = subprocess.run(full_cmd, capture_output=True, timeout=timeout)
        return r.stdout.decode('utf-8', errors='replace').strip()
    except subprocess.TimeoutExpired:
        _log(f'ADB 超时: {" ".join(cmd)}', 'WARN')
        return ''
    except Exception as e:
        _log(f'ADB 错误: {e}', 'ERROR')
        return ''


def adb_shell_raw(cmd, timeout=10):
    """
    执行 ADB shell 命令（避免 subprocess.run 的 shell=True 转义问题）
    返回 (process, stdout, stderr)，调用方自行 manage timeout
    """
    full_cmd = ['adb', '-s', current_device, 'shell', cmd]
    try:
        r = subprocess.run(full_cmd, capture_output=True, timeout=timeout)
        return r.stdout.decode('utf-8', errors='replace').strip()
    except subprocess.TimeoutExpired:
        _log(f'ADB shell 超时: {cmd}', 'WARN')
        return ''
    except Exception as e:
        _log(f'ADB shell 错误: {e}', 'ERROR')
        return ''


def adb_async_cmd(cmd, shell=False, **kw):
    """异步执行 ADB 命令，返回 Popen 对象"""
    if shell:
        full_cmd = cmd
    else:
        full_cmd = ['adb', '-s', current_device] + cmd
    _log(f'ADB 异步: {" ".join(full_cmd) if not shell else cmd}', 'INFO')
    return subprocess.Popen(full_cmd, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE, shell=shell)


def check_device():
    """检查 ADB 设备是否在线（devices 命令不带 -s）"""
    output = adb_raw(['devices'])
    if current_device in output:
        return True
    # 也可能是 'device' 状态
    for line in output.split('\n'):
        if line.startswith(current_device) and 'device' in line:
            return True
    return False


def auto_detect_device():
    """自动检测第一个在线的 ADB 设备"""
    output = adb_raw(['devices'])
    for line in output.split('\n'):
        if 'device' in line and 'devices' not in line and 'offline' not in line:
            return line.split('\t')[0]
    return None


# ══════════════════════════════════════════════════════════════
# 按键事件系统
# ══════════════════════════════════════════════════════════════

def keyevent(key_code):
    """发送按键事件到设备"""
    name = _KEY_NAMES.get(str(key_code), f'key_{key_code}')
    _log(f'按键: {name} ({key_code})', 'KEY')
    adb_shell(['shell', 'input', 'keyevent', str(key_code)])
    time.sleep(KEY_DELAY)


def home():
    """按下 HOME 键"""
    _log('HOME 键', 'KEY')
    keyevent('3')
    time.sleep(PAGE_LOAD_DELAY)


def back():
    """按下 BACK 键"""
    _log('BACK 键', 'KEY')
    keyevent('4')
    time.sleep(1)


def ok():
    """按下 OK/ENTER 键"""
    _log('OK 键', 'KEY')
    keyevent('23')
    time.sleep(PAGE_LOAD_DELAY)


def menu():
    """按下 MENU 键"""
    _log('MENU 键', 'KEY')
    keyevent('82')
    time.sleep(KEY_DELAY)


def dpad_up(count=1):
    """按上键 N 次"""
    if count <= 0:
        return
    _log(f'上键 x{count}', 'KEY')
    for _ in range(count):
        keyevent('19')
        time.sleep(0.5)


def dpad_down(count=1):
    """按下键 N 次"""
    if count <= 0:
        return
    _log(f'下键 x{count}', 'KEY')
    for _ in range(count):
        keyevent('20')
        time.sleep(0.5)


def dpad_left(count=1):
    """按左键 N 次"""
    if count <= 0:
        return
    _log(f'左键 x{count}', 'KEY')
    for _ in range(count):
        keyevent('21')
        time.sleep(0.5)


def dpad_right(count=1):
    """按右键 N 次"""
    if count <= 0:
        return
    _log(f'右键 x{count}', 'KEY')
    for _ in range(count):
        keyevent('22')
        time.sleep(0.5)


# ══════════════════════════════════════════════════════════════
# 截屏 & UI 树
# ══════════════════════════════════════════════════════════════

def _ensure_accessibility_service():
    """启用 AccessibilityService（某些 ROM 默认关闭导致 dump 返回 null root node）"""
    try:
        enabled = adb_shell(['shell', 'settings', 'get', 'secure', 'enabled_accessibility_services'])
        if enabled is None or 'null' in enabled or 'uiautomator' not in enabled.lower():
            _log('AccessibilityService 未启用，正在开启...', 'WARN')
            adb_shell(['shell', 'settings', 'put', 'secure', 'enabled_accessibility_services',
                       'com.android.uiautomator/com.android.uiautomator.UiAutomatorService'])
            adb_shell(['shell', 'settings', 'put', 'secure', 'accessibility_enabled', '1'])
            time.sleep(2)
            _log('AccessibilityService 已启用', 'OK')
            return True
        return True
    except Exception as e:
        _log(f'启用 AccessibilityService 异常: {e}', 'WARN')
        return False


def warmup_uiautomator():
    """预热 uiautomator 服务（压缩模式，减内存）"""
    with DUMP_LOCK:
        adb_shell(['shell', 'uiautomator', 'dump', '--compressed', '/sdcard/_warmup'], timeout=10)
        time.sleep(0.5)
        adb_shell(['shell', 'rm', '-f', '/sdcard/_warmup'])


def _exec_out_dump(out_dir: str) -> Optional[str]:
    """exec-out 流式 dump，绕设备存储（OOM 降级策略 B）"""
    try:
        local_path = os.path.join(out_dir, 'uiautomator_dump.xml')
        os.makedirs(out_dir, exist_ok=True)
        cmd = ['adb', '-s', current_device, 'exec-out', 'uiautomator', 'dump', '--compressed', '-']
        result = subprocess.run(
            cmd, capture_output=True, timeout=20,
            creationflags=subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0
        )
        if result.returncode == 0 and result.stdout and b'<' in result.stdout:
            with open(local_path, 'wb') as f:
                f.write(result.stdout)
            _log(f'exec-out dump 成功', 'OK')
            return local_path
        else:
            _log(f'exec-out 失败 rc={result.returncode} stderr={result.stderr[:120].decode(errors="replace")}', 'WARN')
        return None
    except subprocess.TimeoutExpired:
        _log('exec-out dump 超时 20s', 'WARN')
        return None
    except FileNotFoundError:
        _log('adb 不在 PATH 中', 'WARN')
        return None
    except Exception as e:
        _log(f'exec-out 异常: {e}', 'WARN')
        return None


def kill_stale_uiautomator() -> bool:
    """杀残留 uiautomator 进程，启用服务，重启场景。
    
    注意：
      - 只杀系统自带的 uiautomator 守护进程（pid 通常 < 5000）
      - 跳过 Appium 的 io.appium.uiautomator2.server / .test 进程
      - 跳过已经注册为 Appium session 的 io.appium.uiautomator2.server
    """
    try:
        _log('清理残留 uiautomator 进程...', 'WARN')
        # 先 dump 一下 ps 看有哪些 uiautomator 进程
        raw = adb_shell(['shell', 'ps', '-A', '|', 'grep', '-i', 'uiautomator'])
        if not raw or not raw.strip():
            raw = adb_shell(['shell', 'ps', '|', 'grep', '-i', 'uiautomator'])
        if not raw or not raw.strip():
            _log('无 uiautomator 进程，跳过', 'OK')
            return True

        _log(f'当前 uiautomator 进程:\n{raw}', 'INFO')

        # 按行解析，跳过 Appium 的进程
        appium_pids = set()
        stale_pids = []
        for line in raw.strip().split('\n'):
            line = line.strip()
            if not line:
                continue
            # 提取 PID（不同 ps 格式：第一列或第二列）
            parts = line.split()
            # 找 PID：通常是第二列（USER PID ...）
            # ps -A 格式: USER PID PPID VSZ RSS WCHAN ADDR S NAME
            pid = None
            for col in parts:
                if col.isdigit() and len(col) < 6:  # PID 通常是 < 5 位数字
                    pid = col
                    break
            if not pid:
                continue

            # 跳过 Appium 的 uiautomator2 server
            if 'io.appium.uiautomator2' in line.lower():
                appium_pids.add(pid)
                _log(f'  跳过 Appium 进程 PID={pid}: {line[:80]}', 'INFO')
                continue

            stale_pids.append(pid)

        if appium_pids:
            _log(f'Appium uiautomator2 server 进程 ({len(appium_pids)} 个) 已跳过', 'OK')

        # 只杀残留的非 Appium 进程
        if stale_pids:
            adb_shell(['shell', 'kill', '-9'] + stale_pids[:10], timeout=5)
            time.sleep(0.5)
            _log(f'已清理 {len(stale_pids[:10])} 个残留 uiautomator 进程', 'OK')
        else:
            _log('无需要清理的残留进程', 'OK')

        # 重新拉一下系统服务（触发 zygote 重新 spawn）
        adb_shell(['shell', 'uiautomator'], timeout=5)
        time.sleep(0.5)
        return True
    except Exception as e:
        _log(f'清理 uiautomator 进程异常: {e}', 'WARN')
        return False



def dump_uiautomator(out_dir: str = None, retries: int = 2, time_budget: float = 0) -> Optional[str]:
    """
    导出 uiautomator dump XML，返回本地 XML 路径。
    失败返回 None（调用方应降级到截图+OCR）。

    根因：GK6323V100C 机顶盒内存吃紧，
    `uiautomator dump` 序列化 UI 树时被内核 OOM Kill。
    此外残留 uiautomator 僵尸进程也会阻塞新调用。

    策略（降级链，按优先级）：
      D) Appium WebDriver HTTP API（首选，常驻服务不 fork，不 OOM，~1-2s）
         → /wd/hub/session/{id}/source
      A) shell uiautomator dump --compressed（压缩减少 ~50% 内存）
         检测到 Killed 立即放弃 retry
      C) 杀残留 uiautomator 进程 → 等待稳定 → 再执行策略 A
      E) uiautomator2 Python 库直连（如已安装）

    time_budget: >0 时，策略 A/C 每一步前检查剩余时间，超时立即返回 None。
                 避免被 shell dump 的 15s timeout 卡死 caller 的 deadline。
    """
    _start = time.time()

    def _remaining() -> float:
        if time_budget <= 0:
            return 9999
        elapsed = time.time() - _start
        return max(0, time_budget - elapsed)

    def _budget_exceeded() -> bool:
        if time_budget <= 0:
            return False
        elapsed = time.time() - _start
        return elapsed >= time_budget

    with DUMP_LOCK:
        local_dir = out_dir or (os.path.dirname(SCREENSHOT_DIR) if os.path.isdir(SCREENSHOT_DIR) else os.getcwd())

        # ── 策略 D: Appium WebDriver HTTP API（首选）──
        # 常驻 uiautomator2-server APK，不 fork 进程，不触发 OOM，每次 ~1-2s
        appium_xml = _dump_via_appium(local_dir)
        if appium_xml:
            return appium_xml
        if _budget_exceeded():
            _log(f'时间预算耗尽（{time_budget}s），跳过 shell dump 链', 'WARN')
            return None

        # Appium 不可用 → 降级到 shell dump 链
        _ensure_accessibility_service()
        warmup_uiautomator()

        # ── 策略 A: shell 模式 + --compressed ──
        for attempt in range(retries):
            if _budget_exceeded():
                _log('时间预算耗尽，中断策略 A', 'WARN')
                break
            shell_timeout = min(15, max(1, _remaining()))
            remote = '/sdcard/uiautomator_dump.xml'
            adb_shell(['shell', 'rm', '-f', remote])
            out = adb_shell(['shell', 'uiautomator', 'dump', '--compressed', remote], timeout=shell_timeout) or ''

            if 'Killed' in out:
                _log('dump 被 Killed（OOM）', 'WARN')
                break

            if 'dumped' in out:
                adb_shell(['pull', remote, os.path.join(local_dir, 'uiautomator_dump.xml')])
                adb_shell(['shell', 'rm', '-f', remote])
                local_path = os.path.join(local_dir, 'uiautomator_dump.xml')
                if os.path.exists(local_path) and os.path.getsize(local_path) > 0:
                    return local_path

            # 已有 budget 检测，可以 sleep 但不超过剩余时间
            if _budget_exceeded():
                break
            time.sleep(min(0.5, _remaining() - 0.1))

        # ── 策略 C: 杀僵尸进程 → 2s 稳定 → 再策略 A ──
        if not _budget_exceeded():
            _log('尝试杀残留进程并等待稳定...', 'WARN')
            if kill_stale_uiautomator():
                time.sleep(min(2, _remaining()))
                for attempt in range(retries):
                    if _budget_exceeded():
                        break
                    shell_timeout = min(15, max(1, _remaining()))
                    remote = '/sdcard/uiautomator_dump.xml'
                    adb_shell(['shell', 'rm', '-f', remote])
                    out = adb_shell(['shell', 'uiautomator', 'dump', '--compressed', remote], timeout=shell_timeout) or ''
                    if 'Killed' not in out and 'dumped' in out:
                        adb_shell(['pull', remote, os.path.join(local_dir, 'uiautomator_dump.xml')])
                        adb_shell(['shell', 'rm', '-f', remote])
                        local_path = os.path.join(local_dir, 'uiautomator_dump.xml')
                        if os.path.exists(local_path) and os.path.getsize(local_path) > 0:
                            _log('杀进程重试后 dump 成功', 'OK')
                            return local_path
                    if _budget_exceeded():
                        break
                    time.sleep(min(0.5, _remaining() - 0.1))
        else:
            _log(f'时间预算耗尽（{time_budget:.1f}s），跳过策略 C', 'WARN')

        # ── 策略 E: uiautomator2 Python 库直连 ──
        _log('尝试 uiautomator2 Python 库直连...', 'WARN')
        u2_xml = _dump_via_uiautomator2(local_dir)
        if u2_xml:
            return u2_xml

        _log('uiautomator dump 所有策略均失败，调用方请降级到截图+OCR', 'WARN')
        return None



# ══════════════════════════════════════════════════════════════
# dump 降级策略 D: Appium WebDriver HTTP API
# ══════════════════════════════════════════════════════════════
# adb shell uiautomator dump 每次 fork 新 dalvik 进程 → OOM,
# Appium 的常驻 uiautomator2-server APK 不走 fork → 不 OOM.
# 使用项目已有 appium_preset.py / appium_server_hendan.py 协议，
# 直接从 test_library.TVTestLibrary 读取已有 session。

_APPIUM_SESSION_CACHE = None  # (port, session_id, driver)
_APPIUM_PORT = None


def _start_appium_server() -> int:
    """启动 Appium server（subprocess），返回 port"""
    global _APPIUM_PORT

    # 检查 _APPIUM_PORT 是否还活着
    if _APPIUM_PORT is not None:
        try:
            import requests
            r = requests.get(f'http://127.0.0.1:{_APPIUM_PORT}/wd/hub/status', timeout=2)
            if r.status_code == 200:
                _log(f'Appium 复用已有服务 port {_APPIUM_PORT}', 'OK')
                return _APPIUM_PORT
        except Exception:
            pass
        _APPIUM_PORT = None

    # 不全局杀 Appium！只杀目标端口上僵死的进程
    import random
    for _ in range(5):
        port = random.randint(4723, 4999)
        # 查端口是否空闲
        import socket
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            sock.settimeout(0.5)
            result = sock.connect_ex(('127.0.0.1', port))
            if result == 0:
                # 端口被占用，检查是不是 Appium
                try:
                    import requests
                    r = requests.get(f'http://127.0.0.1:{port}/wd/hub/status', timeout=1)
                    if r.status_code == 200:
                        # 已经有 Appium 了，直接复用
                        _APPIUM_PORT = port
                        _log(f'Appium 复用已有服务 port {port}', 'OK')
                        return port
                except Exception:
                    pass
                # 端口被占用但非 Appium，试下一个
                continue
        except Exception:
            pass
        finally:
            sock.close()
        # 端口空闲 → 用它
        break
    else:
        # 所有随机端口都不可用，用 4723
        port = 4723

    # 构建干净环境变量
    parts = os.environ.get('PATH', '').split(';')
    real_node = r'C:\Program Files\nodejs'
    filtered = [p for p in parts if 'QClaw' not in p.upper()]
    if real_node not in filtered:
        filtered.insert(0, real_node)
    env = dict(os.environ)
    env['PATH'] = ';'.join(filtered)
    env['ANDROID_HOME'] = r'D:\Android'

    log_dir = os.path.join(os.path.dirname(__file__), '..', '..', 'Result')
    os.makedirs(log_dir, exist_ok=True)
    log_path = os.path.join(log_dir, f'appium_{port}.log')

    cmd = f'appium --session-override --log-timestamp --local-timezone --base-path /wd/hub --port {port}'
    _log(f'Appium 启动: {cmd}', 'INFO')

    log_fh = open(log_path, 'ab')
    subprocess.Popen(
        args=cmd, stdin=None, stdout=log_fh,
        stderr=subprocess.STDOUT, shell=True, env=env,
    )

    # 等待就绪
    status_url = f'http://127.0.0.1:{port}/wd/hub/status'
    for _ in range(30):
        time.sleep(2)
        try:
            import requests
            r = requests.get(status_url, timeout=3)
            if r.status_code == 200:
                _APPIUM_PORT = port
                _log(f'Appium ready on port {port}', 'OK')
                return port
        except Exception:
            pass

    _log(f'Appium 未在 60s 内就绪', 'WARN')
    return port


def _ensure_appium_session() -> Optional[tuple]:
    """确保有活跃的 Appium session，返回 (port, session_id, driver)"""
    global _APPIUM_SESSION_CACHE

    import requests

    # 缓存有效 → 直接返回
    if _APPIUM_SESSION_CACHE is not None and len(_APPIUM_SESSION_CACHE) >= 2:
        port, sid = _APPIUM_SESSION_CACHE[0], _APPIUM_SESSION_CACHE[1]
        try:
            r = requests.get(f'http://127.0.0.1:{port}/wd/hub/session/{sid}', timeout=3)
            if r.status_code == 200:
                # 有 driver 对象才验证 page_source
                driver = _APPIUM_SESSION_CACHE[2] if len(_APPIUM_SESSION_CACHE) >= 3 else None
                if driver is not None:
                    try:
                        _ = driver.page_source
                        if _ and '<' in _:
                            _log(f'Appium 复用缓存 session {sid}', 'OK')
                            return _APPIUM_SESSION_CACHE
                    except Exception:
                        pass
                else:
                    # 外部扫描 session（无 driver 对象），相信 HTTP 状态
                    _log(f'Appium 复用缓存 session {sid}（HTTP）', 'OK')
                    return _APPIUM_SESSION_CACHE
        except Exception:
            pass
        _log('Appium 缓存 session 过期，重建', 'INFO')
        _APPIUM_SESSION_CACHE = None

    # 扫描已有 session
    for port in range(4723, 4731):
        try:
            r = requests.get(f'http://127.0.0.1:{port}/wd/hub/sessions', timeout=2)
            if r.status_code != 200:
                continue
            data = r.json()
            sessions = data.get('value', data.get('data', []))
            if sessions:
                raw = sessions[0]
                sid = raw.get('id') if isinstance(raw, dict) else raw
                _APPIUM_PORT = port
                # 拿到 session 但没 driver 对象 → 只能走 HTTP API
                _APPIUM_SESSION_CACHE = (port, sid, None)
                return _APPIUM_SESSION_CACHE
        except Exception:
            continue

    # 启动 Appium + 创建 session
    try:
        from appium import webdriver
    except ImportError:
        _log('Appium-Python-Client 未安装', 'WARN')
        return None

    port = _start_appium_server()

    cap = {
        'platformName': 'Android',
        'deviceName': 'android',
        'automationName': 'UiAutomator2',
        'appPackage': 'com.huawei.tvbox',
        'appActivity': 'com.fonsview.mangotv.MainActivity',
        'noReset': True,
        'newCommandTimeout': 600,
        'autoGrantPermissions': True,
    }

    url = f'http://127.0.0.1:{port}/wd/hub'
    _log(f'Appium 创建 session: {url}', 'INFO')

    try:
        options = AppiumOptions()
        options.load_capabilities(cap)
        driver = webdriver.Remote(url, options=options)
        sid = driver.session_id
        _APPIUM_SESSION_CACHE = (port, sid, driver)
        _log(f'Appium session created: {sid}', 'OK')
        return _APPIUM_SESSION_CACHE
    except Exception as e:
        _log(f'Appium session 创建失败: {e}', 'WARN')
        return None


def prewarm_appium() -> bool:
    """
    预热 Appium：强制创建 session 并做一次 dump 验证。
    在脚本 main() 开头调用一次，避免后续每步都等 20-30s 启动。
    返回 True 表示预热成功。
    """
    _log('预热 Appium...', 'INFO')
    try:
        import requests
    except ImportError:
        _log('requests 未安装，跳过预热', 'WARN')
        return False
    session = _ensure_appium_session()
    if not session:
        _log('Appium 预热失败', 'WARN')
        return False
    # 做一次 dump 验证
    from lib.adb_utils import dump_uiautomator
    xml = dump_uiautomator(retries=0)
    if xml:
        _log('Appium 预热完成，首次 dump 成功', 'OK')
    else:
        _log('Appium session 可用但首次 dump 失败，session 已存活', 'OK')
    return True


def _find_appium_session() -> Optional[tuple]:
    """[已弃用] 保留兼容，内部转发到 _ensure_appium_session"""
    return _ensure_appium_session()


def _dump_via_appium(local_dir: str) -> Optional[str]:
    """
    策略 D（首选）: 通过 Appium 获取 page source。
    常驻 uiautomator2-server APK，不 fork 进程，不触发 OOM，每次 ~1-2s。
    首次调用自动启动 Appium + 创建 session（~15-60s），后续调用极快。
    """
    try:
        import requests

        session = _ensure_appium_session()
        if not session:
            _log('Appium session 不可用', 'WARN')
            return None

        port, sid, driver = session

        # 优先用 driver.page_source（更快）
        if driver is not None:
            try:
                xml_text = driver.page_source
                if xml_text and '<' in xml_text:
                    local_path = os.path.join(local_dir, 'appium_dump.xml')
                    with open(local_path, 'w', encoding='utf-8') as f:
                        f.write(xml_text)
                    size_kb = os.path.getsize(local_path) / 1024
                    _log(f'Appium dump 成功 ({size_kb:.0f} KB)', 'OK')
                    return local_path
            except Exception as e:
                _log(f'driver.page_source 失败: {e}，降级 HTTP API', 'WARN')

        # 降级：HTTP API
        url = f'http://127.0.0.1:{port}/wd/hub/session/{sid}/source'
        r = requests.get(url, timeout=30)
        if r.status_code != 200:
            _log(f'Appium source 返回 {r.status_code}', 'WARN')
            return None

        xml_text = r.text
        if xml_text.strip().startswith('{'):
            try:
                xml_text = r.json().get('value', r.json().get('data', xml_text))
            except Exception:
                pass

        if not xml_text or '<' not in str(xml_text):
            _log('Appium source 内容为空或非 XML', 'WARN')
            return None

        local_path = os.path.join(local_dir, 'appium_dump.xml')
        with open(local_path, 'w', encoding='utf-8') as f:
            f.write(str(xml_text))
        size_kb = os.path.getsize(local_path) / 1024
        _log(f'Appium dump 成功 ({size_kb:.0f} KB)', 'OK')
        return local_path

    except ImportError:
        _log('requests 模块未安装，跳过策略 D', 'WARN')
        return None
    except requests.exceptions.ConnectionError:
        _log('Appium server 连接失败', 'WARN')
        return None
    except Exception as e:
        _log(f'Appium dump 异常: {e}', 'WARN')
        return None


# ══════════════════════════════════════════════════════════════
# dump 降级策略 E: uiautomator2 Python 库直连
# ══════════════════════════════════════════════════════════════

def _dump_via_uiautomator2(local_dir: str) -> Optional[str]:
    """策略 E: 通过 uiautomator2 Python 库直连设备。
    uiautomator2 安装常驻 APK (app-uiautomator2-server.apk)，HTTP 通信，不 fork。
    """
    try:
        import uiautomator2 as u2
        d = u2.connect(ADB_DEVICE)
        xml_text = d.dump_hierarchy(compressed=True)
        if not xml_text or '<' not in xml_text:
            _log('uiautomator2 dump 内容为空', 'WARN')
            return None

        local_path = os.path.join(local_dir, 'u2_dump.xml')
        with open(local_path, 'w', encoding='utf-8') as f:
            f.write(xml_text)
        size_kb = os.path.getsize(local_path) / 1024
        _log(f'uiautomator2 dump 成功 ({size_kb:.0f} KB)', 'OK')
        return local_path

    except ImportError:
        _log('uiautomator2 模块未安装，跳过策略 E', 'WARN')
        return None
    except Exception as e:
        _log(f'uiautomator2 dump 异常: {e}', 'WARN')
        return None



def screenshot(filename):
    """
    截屏并保存到本地
    返回本地完整路径，失败返回 None
    """
    remote = f'/sdcard/{filename}'
    adb_shell(['shell', 'screencap', '-p', remote])
    local = os.path.join(SCREENSHOT_DIR, filename)
    adb_shell(['pull', remote, local])
    adb_shell(['shell', 'rm', remote])

    if os.path.exists(local) and os.path.getsize(local) > 0:
        size_kb = os.path.getsize(local) / 1024
        _log(f'保存: {filename} ({size_kb:.1f} KB)', 'SCREEN')
        return local

    # 重试一次
    _log('截屏失败，正在重试...', 'WARN')
    time.sleep(1)
    adb_shell(['shell', 'screencap', '-p', remote])
    adb_shell(['pull', remote, local])
    adb_shell(['shell', 'rm', remote])

    if os.path.exists(local) and os.path.getsize(local) > 0:
        size_kb = os.path.getsize(local) / 1024
        _log(f'保存(重试): {filename} ({size_kb:.1f} KB)', 'SCREEN')
        return local

    _log(f'截屏失败: {filename}', 'ERROR')
    return None


def adb_swipe_scroll(count=1, start_y=960, end_y=300):
    """
    通过 adb shell input swipe 执行真正的页面滚动（替代 DPAD_DOWN 焦点移动）。
    Android TV 首页 DPAD_DOWN 只移焦点不滚屏，必须用 swipe 手势。
    从下往上 swipe → 页面向上滚动（露出底部内容）。
    不使用 Appium，adb 直连设备，兼容性最好。
    """
    import warnings
    _log(f'手势滚动: {count}次 (y={start_y}→{end_y})', 'KEY')
    for i in range(count):
        adb_raw(['shell', 'input', 'swipe', '960', str(start_y), '960', str(end_y)])
        if i == 0:
            _log(f'  滚动 #{i+1}', 'KEY')
        time.sleep(0.5)
    time.sleep(1.5)
    _log(f'滚动完成: {count} 次', 'OK')


def scroll_down_only(count=1):
    """只按向下键，不截图"""
    if count <= 0:
        return
    _log(f'向下滚动 {count} 次（不截图）', 'KEY')
    for _ in range(count):
        keyevent('20')
        time.sleep(0.3)
    time.sleep(SCROLL_DELAY)


def scroll_and_screenshot_once(channel_name, suffix=''):
    """
    只截一张当前屏幕（不滚动），用后缀区分
    返回 {'file': path, 'filename': name} 或 None
    """
    safe_name = re.sub(r'[/\\ :]', '_', channel_name)
    ts = datetime.now().strftime('%Y%m%d_%H%M%S')
    filename = f'{safe_name}{suffix}_{ts}.png'
    path = screenshot(filename)
    if path:
        return {'file': path, 'filename': filename, 'scroll_pos': 0}
    return None


def scroll_and_screenshot(channel_name, max_scrolls=5):
    """
    【旧版】滚动并裁屏 — 向下滚动并在每个位置截屏
    已弃用，推荐用 scroll_down_only + scroll_and_screenshot_once 组合
    保留兼容
    """
    safe_name = re.sub(r'[/\\ :]', '_', channel_name)

    _log('--- 滚动位置 0（初始） ---', 'SEP')
    ts = datetime.now().strftime('%Y%m%d_%H%M%S')
    path = screenshot(f'{safe_name}_0_{ts}.png')
    results = []
    if path:
        results.append({'file': path, 'filename': f'{safe_name}_0_{ts}.png', 'scroll_pos': 0})

    for i in range(1, max_scrolls + 1):
        _log(f'--- 向下滚动 #{i} ---', 'SEP')
        dpad_down()
        _log(f'等待 {SCROLL_DELAY}s 滚动稳定...', 'WAIT')
        time.sleep(SCROLL_DELAY)
        ts = datetime.now().strftime('%Y%m%d_%H%M%S')
        path = screenshot(f'{safe_name}_{i}_{ts}.png')
        if path:
            results.append({'file': path, 'filename': f'{safe_name}_{i}_{ts}.png', 'scroll_pos': i})
        time.sleep(0.5)

    _log(f'共截取 {len(results)} 张截图', 'SCREEN')
    return results


# ══════════════════════════════════════════════════════════════
# 增强能力 — 从 TestLibrary/AdbUtils.py 移植
# ══════════════════════════════════════════════════════════════

# ── 设备信息 ──


def get_device_info(device_id=None):
    """获取设备品牌、型号、系统版本、分辨率"""
    info = {}
    raw = adb_shell(['shell', 'getprop', 'ro.product.manufacturer'])
    info['manufacturer'] = raw.strip()
    raw = adb_shell(['shell', 'getprop', 'ro.product.model'])
    info['model'] = raw.strip()
    raw = adb_shell(['shell', 'getprop', 'ro.build.version.release'])
    info['android_version'] = raw.strip()
    raw = adb_shell(['shell', 'getprop', 'ro.build.version.sdk'])
    info['sdk'] = raw.strip()
    # 分辨率
    raw = adb_shell(['shell', 'wm', 'size'])
    m = re.search(r'(\d+)x(\d+)', raw)
    if m:
        info['width'] = int(m.group(1))
        info['height'] = int(m.group(2))
    return info


def list_online_devices():
    """列出所有在线的 ADB 设备"""
    output = adb_raw(['devices'])
    devices = []
    for line in output.split('\n'):
        if 'device' in line and 'devices' not in line and 'offline' not in line:
            devices.append(line.split('\t')[0])
    return devices


def is_device_connected(device_id=None):
    """检查指定设备是否在线"""
    did = device_id or current_device
    return did in list_online_devices()


def is_process_running(pkg_name):
    """检查包名的进程是否存活"""
    raw = adb_shell(['shell', 'ps', '-A'])
    for line in raw.split('\n'):
        if pkg_name in line and 'grep' not in line:
            return True
    return False


def get_pid(pkg_name):
    """获取指定包名进程的 PID"""
    raw = adb_shell(['shell', 'pgrep', '-f', pkg_name])
    if raw and raw.isdigit():
        return int(raw)
    return None


def get_package_version(pkg_name):
    """获取已安装应用的 versionCode 和 versionName"""
    info = adb_shell(['shell', 'dumpsys', 'package', pkg_name])
    code_re = re.compile(r'versionCode=(\d+)')
    name_re = re.compile(r'versionName=(.+)')
    code = code_re.search(info)
    name = name_re.search(info)
    return (code.group(1) if code else '',
            name.group(1).strip() if name else '')


def get_top_activity():
    """获取当前前台 Activity 名"""
    raw = adb_shell(['shell', 'dumpsys', 'activity', 'top'])
    for line in raw.split('\n'):
        line = line.strip()
        if 'ACTIVITY' in line and '/' in line:
            parts = line.split()
            for p in parts:
                if '/' in p and not p.startswith('ACTIVITY'):
                    return p.split('/')[1]
    return ''


def get_current_package():
    """获取当前前台包名"""
    top = get_top_activity()
    if top:
        raw = adb_shell(['shell', 'dumpsys', 'window'])
        for line in raw.split('\n'):
            if 'mCurrentFocus' in line:
                m = re.search(r'(\S+?)/', line)
                if m:
                    return m.group(1)
    return ''


# ── 进程管理 ──


def kill_process(pkg_name):
    """强制停止指定包名的进程"""
    adb_shell(['shell', 'am', 'force-stop', pkg_name])
    _log(f'强制停止: {pkg_name}', 'KEY')


def pm_clear(pkg_name):
    """清除应用缓存"""
    adb_shell(['shell', 'pm', 'clear', pkg_name])
    _log(f'清除缓存: {pkg_name}', 'INFO')


def is_app_installed(pkg_name):
    """检查应用是否安装"""
    raw = adb_shell(['shell', 'pm', 'list', 'packages', pkg_name])
    return pkg_name in raw


# ── 网络限速（弱网模拟） ──


def speed_limit(rate=10, interface='wlan0'):
    """
    限速模拟弱网
    rate: 限速 kbit（默认 10kbit ≈ 1.25KB/s，极弱网）
    interface: 网卡接口名（默认 wlan0，机顶盒通常是 eth0）
    注意：需要 root 权限
    """
    _log(f'限速: {rate}kbit on {interface}', 'WARN')
    adb_raw(['root'])
    time.sleep(1)
    adb_shell(['shell', 'tc', 'qdisc', 'add', 'dev', interface,
               'root', 'handle', '1:', 'htb', 'default', '10'])
    adb_shell(['shell', 'tc', 'class', 'add', 'dev', interface,
               'parent', '1:', 'classid', '1:10', 'htb',
               'rate', f'{rate}kbit', 'ceil', f'{rate}kbit'])
    _log(f'限速生效: {rate}kbit', 'OK')


def speed_limit_disable(interface='wlan0'):
    """解除限速"""
    _log(f'解除限速: {interface}', 'WARN')
    adb_shell(['shell', 'tc', 'qdisc', 'del', 'dev', interface, 'root'])
    _log('限速已解除', 'OK')


# ── 屏幕录像 ──

_record_process = None


def start_screen_record():
    """开始屏幕录像（adb shell screenrecord 异步启动）"""
    global _record_process
    _record_process = subprocess.Popen(
        ['adb', '-s', current_device, 'shell',
         'screenrecord', '/sdcard/screenrecord.mp4'],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE
    )
    _log('开始屏幕录像', 'INFO')


def stop_screen_record(local_path=None):
    """
    停止屏幕录像并拉取到本地
    local_path: 保存到本地的路径（不含扩展名），默认 SCREENSHOT_DIR
    返回本地 mp4 路径，失败返回 None
    """
    global _record_process
    if _record_process is None:
        _log('无进行中的录像', 'WARN')
        return None

    try:
        far_proc = psutil.Process(_record_process.pid)
        for chi_proc in far_proc.children(recursive=True):
            chi_proc.kill()
        far_proc.kill()
    except Exception as e:
        _log(f'录像进程终止异常: {e}', 'WARN')
    _record_process = None

    time.sleep(1)

    out_path = local_path or os.path.join(
        SCREENSHOT_DIR, f'record_{datetime.now().strftime("%Y%m%d_%H%M%S")}')
    out_path = out_path + '.mp4'

    adb_shell(['pull', '/sdcard/screenrecord.mp4', out_path])
    adb_shell(['shell', 'rm', '-f', '/sdcard/screenrecord.mp4'])

    if os.path.exists(out_path) and os.path.getsize(out_path) > 0:
        _log(f'录像保存: {out_path}', 'FILE')
        return out_path
    _log('录像拉取失败', 'ERROR')
    return None


# ── 内存分析 ──


def dump_heap(pkg_name, save_path=None):
    """
    生成并下载 hprof 堆转储文件（用于内存泄漏分析）
    pkg_name: 应用包名，如 'com.huawei.tvbox'
    save_path: 保存路径，默认 SCREENSHOT_DIR
    返回本地 hprof 路径
    """
    out_path = save_path or os.path.join(
        SCREENSHOT_DIR, f'{pkg_name}_dumpheap.hprof')

    heap_file = f'/data/local/tmp/{pkg_name}_dumpheap.hprof'
    adb_shell(['shell', 'rm', heap_file])
    ret = adb_shell(['shell', 'am', 'dumpheap', pkg_name, heap_file],
                    timeout=60)
    if 'not debuggable' in ret:
        _log(f'{pkg_name} 不是 debuggable 模式，无法 dumpheap', 'WARN')
        return None

    _log('等待 dump 完成（10s）...', 'WAIT')
    time.sleep(10)

    adb_shell(['pull', heap_file, out_path])
    adb_shell(['shell', 'rm', heap_file])

    if os.path.exists(out_path) and os.path.getsize(out_path) > 0:
        _log(f'Heap Dump: {out_path} ({os.path.getsize(out_path)//1024}KB)', 'FILE')
        return out_path
    _log('Heap Dump 失败', 'ERROR')
    return None


# ── APK 管理 ──


def install_apk(apk_path):
    """安装 APK（自动处理重试）"""
    if not os.path.exists(apk_path):
        _log(f'APK 不存在: {apk_path}', 'ERROR')
        return False

    remote = '/data/local/tmp/install.apk'
    adb_shell(['push', apk_path, remote], timeout=180)

    for attempt in range(3):
        _log(f'安装 APK 尝试 #{attempt+1}', 'INFO')
        ret = adb_shell(['shell', 'pm', 'install', '-r', '-t', remote],
                        timeout=180)
        if 'Success' in ret:
            _log(f'安装成功: {apk_path}', 'OK')
            return True
        if 'INSTALL_PARSE_FAILED_NO_CERTIFICATES' in ret:
            _log(f'安装失败（签名问题）: {ret}', 'ERROR')
            break
        if 'INSTALL_FAILED_VERSION_DOWNGRADE' in ret:
            ret = adb_shell(['shell', 'pm', 'install', '-r', '-t', '-d', remote],
                            timeout=180)
            if 'Success' in ret:
                _log(f'安装成功（降级）: {apk_path}', 'OK')
                return True
        time.sleep(2)

    adb_shell(['shell', 'rm', remote])
    return False


def uninstall_apk(pkg_name):
    """卸载 APK"""
    ret = adb_shell(['shell', 'pm', 'uninstall', pkg_name], timeout=30)
    ok = 'Success' in ret
    _log(f'卸载 {pkg_name}: {"成功" if ok else "失败"}', 'OK' if ok else 'ERROR')
    return ok


# ── 按键指令转换（供 FocusNavigator 使用） ──


def apply_focus_steps(steps):
    """
    将 FocusNavigator 返回的方向序列转换为按键。
    steps: ['向上', '向右', '向下', '确定']
    """
    DIR_MAP = {'向上': '19', '向下': '20', '向左': '21', '向右': '22', '确定': '23'}
    for s in steps:
        code = DIR_MAP.get(s)
        if code:
            keyevent(code)
        if s == '确定':
            break


# ══════════════════════════════════════════════════════════════
# P3：高频等待工具 — 基于 XML 轮询，替代 sleep 硬等
# ══════════════════════════════════════════════════════════════

def wait_until_text_appears(text, timeout=10, interval=0.5):
    """
    轮询 XML，等待指定文本出现在屏幕上。
    替代 sleep(PAGE_LOAD_DELAY)。

    text:    要匹配的文本（模糊匹配 text 或 content-desc 属性）
    timeout: 超时秒数
    interval:轮询间隔
    返回 True/False
    """
    if not text:
        return False
    deadline = time.time() + timeout
    while time.time() < deadline:
        xml_path = '/sdcard/adb_wait_dump.xml'
        adb_shell(['shell', 'rm', '-f', xml_path])
        out = adb_shell(['shell', 'uiautomator', 'dump', xml_path], timeout=15)
        if 'dumped' in out or 'UI hierchary dumped' in out:
            raw = adb_shell(['shell', 'cat', xml_path], timeout=10)
            if text in raw:
                _log(f'[WAIT] 文本 "{text}" 已出现', 'OK')
                return True
        time.sleep(interval)
    _log(f'[WAIT] 等待文本 "{text}" 超时 {timeout}s', 'WARN')
    return False


def wait_until_element_present(desc_or_text, timeout=10, interval=0.5):
    """
    轮询 XML，等待指定 content-desc 或 text 的元素出现。
    适用于导航确认（如"直播频道"标签出现后才截图）。

    desc_or_text: 元素文本或 content-desc（模糊匹配）
    timeout:      超时秒数
    返回 True/False
    """
    if not desc_or_text:
        return False
    deadline = time.time() + timeout
    while time.time() < deadline:
        xml_path = '/sdcard/adb_wait_dump.xml'
        adb_shell(['shell', 'rm', '-f', xml_path])
        out = adb_shell(['shell', 'uiautomator', 'dump', xml_path], timeout=15)
        if 'dumped' in out or 'UI hierchary dumped' in out:
            raw = adb_shell(['shell', 'cat', xml_path], timeout=10)
            if desc_or_text in raw:
                _log(f'[WAIT] 元素 "{desc_or_text}" 已出现', 'OK')
                return True
        time.sleep(interval)
    _log(f'[WAIT] 等待元素 "{desc_or_text}" 超时 {timeout}s', 'WARN')
    return False


def is_text_on_screen(text):
    """
    单次检查：当前屏幕是否有指定文本。
    不等待，一次 dump 即返回。
    """
    if not text:
        return False
    xml_path = '/sdcard/adb_wait_dump.xml'
    adb_shell(['shell', 'rm', '-f', xml_path])
    out = adb_shell(['shell', 'uiautomator', 'dump', xml_path], timeout=15)
    if 'dumped' in out or 'UI hierchary dumped' in out:
        raw = adb_shell(['shell', 'cat', xml_path], timeout=10)
        return text in raw
    return False
