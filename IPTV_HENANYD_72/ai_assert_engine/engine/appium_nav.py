#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Appium 导航模块 — 替代 ADB 方向键盲按
利用 Appium UiAutomator2 Server 的 UI 树能力，实现：
  - 频道导航：根据 contentDescription 精确点击目标频道
  - 自适应导航栏滚动：目标不在可见区域 → 聚焦边缘 tab + DPAD 滚动 → 再确认
  - 焦点确认：读当前选中标签的 selected 属性
"""

import os
import time

from appium import webdriver
from appium.options.android import UiAutomator2Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import (
    TimeoutException,
    NoSuchElementException,
    StaleElementReferenceException,
    WebDriverException,
)

# ── 项目内依赖 ──
from lib.adb_utils import home, dpad_down, dpad_right, dpad_left, screenshot
from engine_config.config import ADB_DEVICE, PAGE_LOAD_DELAY
from lib.logger import log
from lib.element_checker import wait_page_stable, wait_for_text_on_screen



# ══════════════════════════════════════════════════════════════
# 常量
# ══════════════════════════════════════════════════════════════

APP_PACKAGE = 'com.huawei.tvbox'

# 导航栏 tab 的 XPath 定位
# 从 Robot 测试用例获得的定位规则：
#   //*[@resource-id="com.huawei.tvbox:id/channel_tabs"]/android.view.View
NAV_CONTAINER_XPATH = f'//*[@resource-id="{APP_PACKAGE}:id/channel_tabs"]'
NAV_TAB_XPATH = f'{NAV_CONTAINER_XPATH}/android.view.View'

# Appium 服务地址（与 appium_server_hendan.py 保持一致）
APPIUM_BASE_URL = 'http://127.0.0.1:4723/wd/hub'


# ══════════════════════════════════════════════════════════════
# Appium Session 管理
# ══════════════════════════════════════════════════════════════

class AppiumSession:
    """Appium WebDriver 会话上下文管理器"""

    def __init__(self):
        self.driver = None

    def start(self, no_reset=True):
        """创建 Appium WebDriver 会话"""
        options = UiAutomator2Options()
        options.platform_name = 'Android'
        options.device_name = ADB_DEVICE
        options.app_package = APP_PACKAGE
        options.app_activity = 'com.fonsview.mangotv.MainActivity'
        options.no_reset = no_reset
        options.full_reset = False
        options.new_command_timeout = 300  # 5分钟无命令超时

        log(f'Appium 连接: {APPIUM_BASE_URL}', 'INFO')
        self.driver = webdriver.Remote(APPIUM_BASE_URL, options=options)
        log(f'Appium Session 创建成功: {self.driver.session_id}', 'OK')
        return self.driver

    def stop(self):
        """关闭 Appium WebDriver 会话"""
        if self.driver:
            try:
                self.driver.quit()
                log('Appium Session 已关闭', 'INFO')
            except Exception as e:
                log(f'Appium 关闭异常: {e}', 'WARN')
            self.driver = None

    def __enter__(self):
        self.start()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.stop()


# ══════════════════════════════════════════════════════════════
# 导航栏操作
# ══════════════════════════════════════════════════════════════

def get_visible_tabs(driver):
    """
    获取当前屏幕上**可见**的所有频道 tab
    返回: {'精选': element, '直播': element, ...}
    注意：Appium 只返回当前渲染的 node，被遮挡的 tab 不在列表里
    """
    tabs = {}
    wait = WebDriverWait(driver, 10)
    try:
        elements = wait.until(
            EC.presence_of_all_elements_located((By.XPATH, NAV_TAB_XPATH))
        )
    except TimeoutException:
        log('导航栏 tab 未加载（超时）', 'WARN')
        return tabs

    for el in elements:
        cd = el.get_attribute('contentDescription')
        if cd:
            tabs[cd] = el

    log(f'导航栏可见: {list(tabs.keys())}', 'INFO')
    return tabs


def get_focused_channel(driver):
    """
    获取当前选中的频道名称
    通过 XPath `[@selected="true"]` 定位
    返回: str（如 "直播"）
    """
    try:
        focused_xpath = f'{NAV_TAB_XPATH}[@selected="true"]'
        el = driver.find_element(By.XPATH, focused_xpath)
        cd = el.get_attribute('contentDescription')
        return cd or ''
    except NoSuchElementException:
        return ''


def _get_edge_tab(tabs, side='right'):
    """
    从可见 tab 中取最左/最右那个 element
    通过 bounds 属性比较 x 坐标
    tabs: {'name': element}
    side: 'left' | 'right'
    返回: element 或 None
    """
    if not tabs:
        return None
    best = None
    best_x = -1 if side == 'right' else 99999
    for name, el in tabs.items():
        bounds = el.get_attribute('bounds')
        if not bounds:
            continue
        try:
            # bounds 格式: "[x1,y1][x2,y2]"
            x1 = int(bounds.split(',')[0].strip('['))
        except (ValueError, IndexError):
            continue
        if side == 'right':
            if x1 > best_x:
                best_x = x1
                best = el
        else:
            if x1 < best_x:
                best_x = x1
                best = el
    return best


def navigate_to_channel(driver, title, max_scroll=20):
    """
    导航到指定频道

    自适应策略：
    1. 如果目标 tab 在导航栏可见 → 直接 click
    2. 如果不可见 → 聚焦边缘 tab + DPAD 滚动导航栏 → 再检查
    3. 先往右找 max_scroll 次，再往左找（兜底）
    4. 到达目标后 click 切换频道内容
    返回 True/False
    """
    log(f'导航到频道: "{title}"', 'STEP')

    # ─── 辅助函数：检查并点击 ───
    def _try_click():
        tabs = get_visible_tabs(driver)
        if title in tabs:
            tabs[title].click()
            wait_page_stable(timeout=5)
            after = get_focused_channel(driver)
            log(f'点击 "{title}"，焦点验证: "{after}"',
                'OK' if after == title else 'WARN')
            return True, tabs
        current = get_focused_channel(driver)
        if current == title:
            log(f'已在目标频道: "{title}"', 'OK')
            return True, tabs
        return False, tabs

    # ─── 1. 直接尝试 ───
    ok, tabs = _try_click()
    if ok:
        return True

    # ─── 2. 向右滚动找 ───
    log(f'"{title}" 不在可见区域，向右滚动导航栏', 'INFO')
    for i in range(max_scroll):
        rightmost = _get_edge_tab(tabs, side='right')
        if rightmost:
            try:
                rightmost.click()
                time.sleep(0.3)
            except StaleElementReferenceException:
                log(f'  滚动#{i}: 右侧 tab 已失效（页面刷新），重试', 'WARN')
                time.sleep(0.5)
                continue
            except WebDriverException as e:
                log(f'  滚动#{i}: 右侧 tab 点击失败: {e}', 'WARN')
                time.sleep(0.5)
        dpad_right()
        wait_page_stable(timeout=2)
        ok, tabs = _try_click()
        if ok:
            return True

    # ─── 3. 向左滚动找 ───
    log(f'向右未找到 "{title}"，向左滚动导航栏', 'INFO')
    for i in range(max_scroll):
        leftmost = _get_edge_tab(tabs, side='left')
        if leftmost:
            try:
                leftmost.click()
                time.sleep(0.3)
            except StaleElementReferenceException:
                log(f'  滚动#{i}: 左侧 tab 已失效（页面刷新），重试', 'WARN')
                time.sleep(0.5)
                continue
            except WebDriverException as e:
                log(f'  滚动#{i}: 左侧 tab 点击失败: {e}', 'WARN')
                time.sleep(0.5)
        dpad_left()
        wait_page_stable(timeout=2)
        ok, tabs = _try_click()
        if ok:
            return True

    log(f'未能在导航栏找到频道: "{title}"', 'ERROR')
    return False
