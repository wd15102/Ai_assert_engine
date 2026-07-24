# -*- coding: utf-8 -*-
"""
debug_strategy_d.py — 测试 dump 策略 D (Appium HTTP API page source)
═══════════════════════════════════════════════════════════════════

用法：
  py -3.9 debug\debug_strategy_d.py

流程：
  1. 直接 subprocess.Popen 启动 Appium server（绕过 .venv 里残缺的 requests import）
  2. 通过 Appium Python Client 创建 session（连设备）
  3. driver.page_source → 保存 XML
  4. 打印元素统计
  5. 清理 session + server
"""

import json, sys, os, time, re, subprocess, random, psutil

_PROJECT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(_PROJECT)
sys.path.insert(0, _PROJECT)

_OUT = os.path.join(_PROJECT, 'debug')
os.makedirs(_OUT, exist_ok=True)

APP_PACKAGE = 'com.huawei.tvbox'
APP_ACTIVITY = 'com.fonsview.mangotv.MainActivity'


def _ts():
    return time.strftime('%Y%m%d_%H%M%S')


def _build_appium_env():
    """构造 Appium 子进程的干净环境变量（同 appium_server_hendan.py 逻辑）"""
    parts = os.environ.get('PATH', '').split(';')
    real_node = r'C:\Program Files\nodejs'
    filtered = [p for p in parts if 'QClaw' not in p.upper()]
    if real_node not in filtered:
        filtered.insert(0, real_node)
    new_path = ';'.join(filtered)

    env = dict(os.environ)
    env['PATH'] = new_path
    env['ANDROID_HOME'] = r'D:\Android'
    return env


def kill_appium_procs():
    """杀掉残留的 appium node 进程"""
    killed = 0
    for proc in psutil.process_iter(['pid', 'name', 'cmdline']):
        try:
            cmd = ' '.join(proc.info['cmdline'] or [])
            if 'appium' in cmd.lower() and proc.info['name'] == 'node.exe':
                proc.kill()
                killed += 1
        except (psutil.NoSuchProcess, psutil.AccessDenied):
            pass
    if killed:
        print(f'[Appium] killed {killed} stale processes')


def start_appium():
    """subprocess 启动 Appium server，返回 port"""
    kill_appium_procs()

    # 随机选一个空闲端口
    for _ in range(5):
        port = random.randint(4723, 4999)
        status_url = f'http://127.0.0.1:{port}/wd/hub/status'
        try:
            import requests
            r = requests.get(status_url, timeout=1)
            if r.status_code == 200:
                continue  # 已被占用
        except Exception:
            break

    log_dir = os.path.join(os.path.dirname(_PROJECT), 'Result')
    os.makedirs(log_dir, exist_ok=True)
    log_path = os.path.join(log_dir, f'appium_debug_{port}.log')

    cmd = f'appium --session-override --log-timestamp --local-timezone --base-path /wd/hub --port {port}'
    print(f'[Appium] cmd: {cmd}')
    print(f'[Appium] log: {log_path}')

    env = _build_appium_env()
    log_fh = open(log_path, 'ab')
    proc = subprocess.Popen(
        args=cmd, stdin=None, stdout=log_fh,
        stderr=subprocess.STDOUT, shell=True, env=env,
    )

    # 等最多 60s
    status_url = f'http://127.0.0.1:{port}/wd/hub/status'
    for _ in range(30):
        time.sleep(2)
        try:
            r = requests.get(status_url, timeout=3)
            if r.status_code == 200:
                print(f'[Appium] ready on port {port}')
                return port
        except Exception:
            pass

    print('[Appium] WARN: not ready after 60s')
    return port


def create_session(port):
    """创建 Appium session，返回 (driver, session_id)"""
    try:
        from appium import webdriver
    except ImportError:
        print('[FAIL] Appium-Python-Client 未安装 → pip install Appium-Python-Client')
        return None, None

    cap = {
        'platformName': 'Android',
        'deviceName': 'android',
        'automationName': 'UiAutomator2',
        'appPackage': APP_PACKAGE,
        'appActivity': APP_ACTIVITY,
        'noReset': True,
        'newCommandTimeout': 600,
        'autoGrantPermissions': True,
    }
    url = f'http://127.0.0.1:{port}/wd/hub'
    print(f'[Session] {url}')
    print(f'[Session] caps: {json.dumps(cap, indent=2, ensure_ascii=False)}')

    t_start = time.time()
    try:
        driver = webdriver.Remote(url, cap)
        dt = time.time() - t_start
        print(f'[Session] session_id={driver.session_id}  耗时={dt:.1f}s')
        return driver, driver.session_id
    except Exception as e:
        print(f'[FAIL] {e}')
        import traceback
        traceback.print_exc()
        return None, None


def analyze_xml(xml_text):
    """分析 XML 内容"""
    import xml.etree.ElementTree as ET
    fixed = re.sub(r'<\s+(\w)', r'<\1', xml_text)
    fixed = re.sub(r'<\s*/(\w)', r'</\1', fixed)
    root = ET.fromstring(fixed)
    all_elems = list(root.iter())
    print(f'  总元素: {len(all_elems)}')

    for elem in root.iter():
        rid = elem.attrib.get('resource-id', '')
        if 'content' in rid and 'RecyclerView' in elem.attrib.get('class', ''):
            children = list(elem)
            print(f'  RecyclerView(id=content): {len(children)} 子节点')
            for i, c in enumerate(children):
                a = c.attrib
                desc = a.get('content-desc', '')[:60]
                bnd = a.get('bounds', '')
                cls = a.get('class', '')[-35:]
                f = '⭐' if a.get('focused') == 'true' else '  '
                print(f'    [{i:3d}] {f} {cls:37s} {bnd:22s}  "{desc}"')
            return children
    return []


def main():
    print('=' * 60)
    print('debug_strategy_d — Appium page source 测试')
    print('=' * 60)

    driver = None
    port = None

    try:
        port = start_appium()
        driver, sid = create_session(port)
        if driver is None:
            sys.exit(1)

        time.sleep(3)

        print('\n[page_source]...')
        t0 = time.time()
        xml_text = driver.page_source
        dt = time.time() - t0
        kb = len(xml_text) / 1024
        print(f'  耗时={dt:.1f}s 大小={kb:.1f}KB')

        fname = f'appium_page_source_{_ts()}.xml'
        out_path = os.path.join(_OUT, fname)
        with open(out_path, 'w', encoding='utf-8') as fh:
            fh.write(xml_text)
        print(f'  保存: {out_path}')

        print('\n[分析]')
        analyze_xml(xml_text)

        print('\n' + '=' * 60)
        print('[OK] 策略 D 测试通过')
        print(f'  XML: {out_path}  ({kb:.1f}KB, {dt:.1f}s)')
        print('=' * 60)

    finally:
        if driver:
            try:
                driver.quit()
            except Exception:
                pass
        kill_appium_procs()


if __name__ == '__main__':
    main()
