#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
河南移动 IPTV 专用 Appium Server Wrapper
- 继承 TestLibrary.appium_server.AppiumServer
- 解决 Appium 3.x 路由兼容（--base-path /wd/hub）
- 解决 QClaw node.cmd PATH 垫片冲突
- 解决 ANDROID_HOME 不被 multiprocessing.Process 继承的问题
- 不修改 TestLibrary 任何文件
"""
import os
import time
import subprocess
import requests
import random
import threading

from TestLibrary.appium_server import AppiumServer, RunServer


# ---------------------------------------------------------------------------
# 构建纯净环境变量（给 Appium 子进程用）
# ---------------------------------------------------------------------------
def _build_appium_env():
    """
    构造 Appium 子进程用的完整环境变量：
    1. PATH 过滤 QClaw 垫片 + 真实 nodejs 在最前
    2. ANDROID_HOME 固定为 D:\Android
    3. 其他保持系统环境
    """
    parts = os.environ.get('PATH', '').split(';')
    real_node = r'C:\Program Files\nodejs'
    filtered = [p for p in parts if 'QClaw' not in p.upper()]
    if real_node not in filtered:
        filtered.insert(0, real_node)
    new_path = ';'.join(filtered)

    env = dict(os.environ)  # 拷贝系统环境
    env['PATH'] = new_path
    env['ANDROID_HOME'] = r'D:\Android'
    return env


# ---------------------------------------------------------------------------
# Wrapper: AppiumServer
# ---------------------------------------------------------------------------
class AppiumServerHendan(AppiumServer):
    """
    行为与父类一致，仅增强：
    1. 启动命令追加 --base-path /wd/hub
    2. 用 subprocess.Popen 直接启动（绕过 multiprocessing.Process 环境丢失问题）
    3. 传入完整环境变量（PATH + ANDROID_HOME）
    """

    def start_server(self, random_port=None, output=None):
        return self._start_server_impl(random_port, output)

    def _start_server_impl(self, random_port, output):
        base_cmd = 'appium --session-override --log-timestamp --local-timezone --base-path /wd/hub'
        check_path = '/wd/hub/status'

        if random_port:
            for _ in range(5):
                self.port = random.randint(4723, 5000)
                self._cmd = f'{base_cmd} --port {self.port}'
                url = f'http://127.0.0.1:{self.port}{check_path}'
                if not self._is_running(url):
                    break
            else:
                self._cmd = f'{base_cmd} --port {self.port}'
                url = f'http://127.0.0.1:{self.port}{check_path}'
        else:
            self.port = 4723
            self._cmd = base_cmd
            url = f'http://127.0.0.1:4723{check_path}'

        # 日志路径
        if output:
            log_path = os.path.join(output, f'appium_{self.port}.log')
        else:
            log_path = os.path.join(os.path.dirname(__file__), '../Result', f'appium_{self.port}.log')
        os.makedirs(os.path.dirname(log_path), exist_ok=True)

        print(f'[AppiumServerHendan] Start cmd: {self._cmd}')
        print(f'[AppiumServerHendan] Check URL : {url}')
        print(f'[AppiumServerHendan] Log path  : {log_path}')
        print(f'[AppiumServerHendan] ANDROID_HOME: D:\\Android')

        # 直接用 subprocess.Popen 启动，传入完整环境
        env = _build_appium_env()
        log_fh = open(log_path, 'ab')
        self._process = subprocess.Popen(
            args=self._cmd,
            stdin=None,
            stdout=log_fh,
            stderr=subprocess.STDOUT,
            shell=True,
            env=env
        )

        # 等待启动（最多 60 秒）
        for _ in range(30):
            time.sleep(2)
            if self._is_running(url):
                print(f'[AppiumServerHendan] Appium ready on port {self.port}')
                return self.port
        print('[AppiumServerHendan] WARN: Appium not ready after 60s')
        return self.port

    def _is_running(self, url):
        try:
            resp = requests.get(url, timeout=3)
            return resp.status_code == 200
        except Exception:
            return False

    @staticmethod
    def stop_server():
        """精确杀 appium 相关 node 进程"""
        import psutil
        killed = []
        for proc in psutil.process_iter(['pid', 'name', 'cmdline']):
            try:
                cmdline = ' '.join(proc.info['cmdline'] or [])
                if 'appium' in cmdline.lower() and proc.info['name'] == 'node.exe':
                    proc.kill()
                    killed.append(proc.info['pid'])
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                pass
        if killed:
            print(f'[AppiumServerHendan] Killed appium PIDs: {killed}')


# ---------------------------------------------------------------------------
# 供 case_run.py 调用
# ---------------------------------------------------------------------------
def start_appium_server_hendan(random_port=False, output=None):
    server = AppiumServerHendan()
    server.stop_server()
    port = server.start_server(random_port=random_port, output=output)
    return port


if __name__ == '__main__':
    s = AppiumServerHendan()
    s.stop_server()
    port = s.start_server(random_port=True, output=None)
    print(f'Appium running on port {port}')
    time.sleep(5)
    s.stop_server()
