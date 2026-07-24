#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
公共方法 — 首页模板巡检的关键字模块

对标 ccontrol 的 CommonEvent / CommonMethod，封装：
  - 机顶盒操控（导航、按键）
  - 模板裁剪（滚动 + XML 定位 + 截图）
  - AI 视觉验证（VQA / 详细分析）

用法：
  from 公共方法.公共方法 import 公共方法
  k = 公共方法()
  k.复位到首页()
  k.导航到频道("直播")
  k.逐模板裁剪(测试桩列表, "直播")
  k.验证排版("直播居中模版新")
  k.断言海报正常("首屏4横图通栏模板")
"""

import os
import time
import re
from PIL import Image

from lib import adb_utils as adb
from lib import stub_parser as stub
from engine.appium_nav import AppiumSession, navigate_to_channel
from lib.logger import log, log_step, log_separator
from engine.scroll_crop_engine import scroll_and_crop_all
from lib.ai_service import ai
from engine.template_prompt_builder import prompt_builder as pb_module


class 公共方法():
    """首页模板巡检的关键字"""

    def __init__(self, driver=None):
        """
        参数：
          driver — Appium WebDriver，不传则自动启动新 session
        """
        self.driver = driver
        self._session = None
        # 缓存：当前频道裁剪结果
        self._blocks = []
        self._channel_title = ''
        self._template_info = []
        self._pb = None  # 模板提示词构建器
        self._stub_path = None  # 当前测试桩路径

    # ══════════════════════════════════════════════════════
    # Session 管理
    # ══════════════════════════════════════════════════════

    def 启动(self) -> '公共方法':
        """启动 Appium Session（如已有则不动），返回 self 链式调用"""
        if self.driver is None:
            self._session = AppiumSession()
            self.driver = self._session.start()
            log(f'Appium Session 已启动: {self.driver.session_id}', 'OK')
        return self

    def 关闭(self):
        """关闭 Appium Session"""
        if self._session:
            self._session.stop()
            self.driver = None
            self._session = None
            log('Appium Session 已关闭', 'INFO')

    # ══════════════════════════════════════════════════════
    # 导航关键字
    # ══════════════════════════════════════════════════════

    def 复位到首页(self, wait=1.5) -> '公共方法':
        """HOME 键两次回到推荐频道"""
        adb.home()
        time.sleep(1)
        adb.home()
        time.sleep(wait)
        log('焦点已回到推荐频道', 'OK')
        return self

    def 导航到频道(self, title: str) -> '公共方法':
        """
        从当前频道导航到指定频道，并自动加载测试桩
        title: 导航菜单中的频道名，如 "直播"
        """
        log_separator()
        log(f'导航到频道: "{title}"', 'STEP')
        navigate_to_channel(self.driver, title)
        time.sleep(2)
        log('等待 2s 页面稳定', 'WAIT')
        # ── 自动加载测试桩 ──
        self._auto_load_stub(title)
        return self

    def _auto_load_stub(self, title: str):
        """根据频道名自动匹配测试桩并加载"""
        channels = stub.get_channel_list()
        match = None
        for ch in channels:
            if ch['title'] == title:
                match = ch
                break
        if not match:
            # 模糊匹配
            for ch in channels:
                if title in ch['title'] or ch['title'] in title:
                    match = ch
                    break
        if not match:
            log(f'未在导航菜单中找到频道 "{title}"', 'WARN')
            self._template_info = []
            self._pb = None
            return

        log(f'命中导航条目: sn={match["sn"]}, bindInstanceId={match["bindInstanceId"]}', 'INFO')
        self._stub_path = stub.find_channel_stub(match)
        if self._stub_path:
            self._template_info = stub.extract_template_info(self._stub_path)
            self._pb = pb_module.load(self._stub_path)
            tnames = [t.get('templateName', '?') for t in self._template_info]
            log(f'测试桩: {os.path.basename(self._stub_path)} ({len(self._template_info)} 个模板)', 'INFO')
            for n in tnames:
                log(f'  - {n}', 'INFO')
            # 自动注入 ai 上下文（builder 先注册，裁剪图目录裁剪后再注册）
            ai.load_context(self._pb)
        else:
            log(f'未找到匹配测试桩 (bindInstanceId={match["bindInstanceId"]})', 'WARN')
            self._template_info = []
            self._pb = None
            ai.clear_context()

    # ══════════════════════════════════════════════════════
    # 测试桩关键字
    # ══════════════════════════════════════════════════════

    def 加载测试桩(self, channel: dict) -> '公共方法':
        """
        加载频道对应的测试桩
        channel: get_channel_list() 返回的频道条目 {sn, title, bindInstanceId}
        """
        self._stub_path = stub.find_channel_stub(channel)
        if self._stub_path:
            self._template_info = stub.extract_template_info(self._stub_path)
            self._pb = pb_module.load(self._stub_path)
            tnames = [t.get('templateName', '?') for t in self._template_info]
            log(f'测试桩: {os.path.basename(self._stub_path)} ({len(self._template_info)} 个模板)', 'INFO')
            for n in tnames:
                log(f'  - {n}', 'INFO')
        else:
            log(f'未找到匹配测试桩 (channel={channel["title"]})', 'WARN')
            self._template_info = []
            self._pb = None
        return self

    def 配置测试桩(self, stub_path: str) -> '公共方法':
        """直接指定测试桩路径加载"""
        self._stub_path = stub_path
        self._template_info = stub.extract_template_info(stub_path)
        self._pb = pb_module.load(stub_path)
        tnames = [t.get('templateName', '?') for t in self._template_info]
        log(f'测试桩: {os.path.basename(stub_path)} ({len(self._template_info)} 个模板)', 'INFO')
        for n in tnames:
            log(f'  - {n}', 'INFO')
        return self

    # ══════════════════════════════════════════════════════
    # 裁剪关键字
    # ══════════════════════════════════════════════════════

    def 逐模板裁剪(self, channel_title: str = '') -> '公共方法':
        """
        调用 scroll_crop_engine 逐模板截图+裁剪
        channel_title: 频道名，如 "直播"，默认用测试桩名
        结果缓存在 self._blocks
        """
        title = channel_title or self._channel_title or '未知频道'
        self._channel_title = title
        log_step(f'逐模板裁剪: {title}')

        screenshots_dir = os.path.join(os.path.dirname(__file__), 'common_event', '..', 'screenshots')
        result = scroll_and_crop_all(
            driver=self.driver,
            adb_module=adb,
            channel_title=title,
            template_info=self._template_info,
            screenshots_dir=screenshots_dir,
        )
        self._blocks = result['blocks']
        log(f'裁剪完成: {len(self._blocks)} 个模块', 'OK')

        # 将裁剪图目录注入 ai 上下文（首个裁剪图的父目录即为 clips 目录）
        if self._blocks:
            clips_dir = os.path.dirname(self._blocks[0]['crop_path'])
            ai.load_context(self._pb, clips_dir=clips_dir)
        elif self._pb:
            ai.load_context(self._pb)

        # 回到顶部
        adb.home()
        time.sleep(1)

        return self

    def 打印裁剪清单(self) -> '公共方法':
        """打印所有裁剪图路径"""
        if not self._blocks:
            log('无裁剪块', 'WARN')
            return self
        log('--- 裁剪图清单 ---', 'INFO')
        for cb in self._blocks:
            sz = os.path.getsize(cb['crop_path']) // 1024
            log(f'  Block#{cb["sort"]} (Y={cb["y_start"]}-{cb["y_end"]}, {cb["card_count"]}卡片): {cb["crop_name"]} ({sz}KB)', 'FILE')
        log('--- 结束 ---', 'INFO')
        return self

    # ══════════════════════════════════════════════════════
    # AI 验证关键字（对标 ccontrol 的 self.ai.vqa()）
    # ══════════════════════════════════════════════════════

    def 验证排版(self, template_name: str = '', block_index: int = None) -> bool:
        """
        AI 验证排版正常、海报完整、文字无乱码
        返回 True=正常 / False=异常
        """
        crop_path = self._取截图(block_index)
        if not crop_path:
            return False
        tname = template_name or self._取模板名(block_index) or '未知模板'
        ok = ai.vqa_template(
            '排版正常、海报加载完整、无乱码无花屏？',
            self._pb, tname, image=crop_path, timeout=30,
        )
        if ok:
            log(f'  ✓ {tname} 排版正常', 'OK')
        else:
            log(f'  ⚠ {tname} 排版异常', 'WARN')
        return ok

    def 验证海报正常(self, template_name: str = '', block_index: int = None) -> bool:
        """AI 验证所有海报已加载，无白块灰块"""
        crop_path = self._取截图(block_index)
        if not crop_path:
            return False
        tname = template_name or self._取模板名(block_index) or '未知模板'
        ok = ai.vqa_template(
            '所有海报都已正常加载、没有白块灰块？',
            self._pb, tname, image=crop_path, timeout=30,
        )
        if ok:
            log(f'  ✓ {tname} 海报正常', 'OK')
        else:
            log(f'  ⚠ {tname} 海报异常', 'WARN')
        return ok

    def 验证文字无乱码(self, template_name: str = '', block_index: int = None) -> bool:
        """AI 验证文字无乱码方框问号"""
        crop_path = self._取截图(block_index)
        if not crop_path:
            return False
        tname = template_name or self._取模板名(block_index) or '未知模板'
        ok = ai.vqa_template(
            '所有标题/描述文字显示完整，没有乱码、方框、问号？',
            self._pb, tname, image=crop_path, timeout=30,
        )
        if ok:
            log(f'  ✓ {tname} 文字正常', 'OK')
        else:
            log(f'  ⚠ {tname} 文字异常', 'WARN')
        return ok

    def 验证焦点到位(self, template_name: str = '', block_index: int = None) -> bool:
        """AI 验证焦点框是否在该模板的第一个卡片上"""
        crop_path = self._取截图(block_index)
        if not crop_path:
            return False
        tname = template_name or self._取模板名(block_index) or '未知模板'
        return ai.check_focus(tname, card_index=0, image=crop_path)

    def 详细分析异常(self, template_name: str = '', block_index: int = None) -> str:
        """AI 详细分析异常点，返回文字描述"""
        crop_path = self._取截图(block_index)
        if not crop_path:
            return '无截图'
        tname = template_name or self._取模板名(block_index) or '未知模板'
        detail = ai.ask_template(
            '列出此截图与预期不符的异常点（排版/海报/文字），无异常则回复"正常"',
            self._pb, tname, image=crop_path, max_tokens=200, timeout=30,
        )
        log(f'  🧠 {tname} 详情: {detail[:120]}', 'AI')
        return detail

    def 通用视觉问答(self, question: str, block_index: int = None) -> str:
        """对裁剪图提任意问题，返回 AI 回答"""
        crop_path = self._取截图(block_index)
        if not crop_path:
            return '无截图'
        tname = self._取模板名(block_index) or '未知模板'
        return ai.ask_template(question, self._pb, tname, image=crop_path)

    def 裸问AI(self, question: str, block_index: int = None) -> bool:
        """纯 VQA 问答：问任意 yes/no 问题，返回 bool"""
        crop_path = self._取截图(block_index)
        if not crop_path:
            return False
        return ai.vqa(question, image=crop_path)

    # ══════════════════════════════════════════════════════
    # 按键关键字
    # ══════════════════════════════════════════════════════

    def 按键(self, key: str, times: int = 1, wait: float = 0.5) -> '公共方法':
        """按遥控器键（键名参考 adb_utils._KEY_NAMES）"""
        fn_map = {
            'up': adb.dpad_up, 'down': adb.dpad_down,
            'left': adb.dpad_left, 'right': adb.dpad_right,
            'enter': adb.enter, 'ok': adb.enter,
            'back': adb.back, 'home': adb.home,
            'menu': adb.menu,
        }
        fn = fn_map.get(key.lower())
        if fn:
            fn(times)
        else:
            adb.send_keyevent(key)
        time.sleep(wait)
        return self

    # ══════════════════════════════════════════════════════
    # 内部
    # ══════════════════════════════════════════════════════

    def _取截图(self, block_index: int = None) -> str:
        """获取指定索引的裁剪图路径"""
        if not self._blocks:
            log('尚无裁剪结果，请先调 逐模板裁剪()', 'WARN')
            return ''
        idx = block_index if block_index is not None else len(self._blocks) - 1
        if idx < 0 or idx >= len(self._blocks):
            log(f'block_index {idx} 越界 (0-{len(self._blocks)-1})', 'WARN')
            return ''
        return self._blocks[idx]['crop_path']

    def _取模板名(self, block_index: int = None) -> str:
        """获取指定索引的模板名"""
        if not self._template_info:
            return ''
        idx = block_index if block_index is not None else len(self._blocks) - 1
        if idx < 0 or idx >= len(self._template_info):
            return ''
        return (self._template_info[idx].get('templateName')
                or self._template_info[idx].get('templateId', ''))

    @property
    def blocks(self):
        """裁剪结果列表"""
        return self._blocks

    @property
    def 模板数(self) -> int:
        """当前频道的模板数"""
        return len(self._template_info)

    @property
    def 裁剪块数(self) -> int:
        """已裁剪到几个块"""
        return len(self._blocks)
