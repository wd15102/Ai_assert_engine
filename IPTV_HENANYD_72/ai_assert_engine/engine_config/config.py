#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
配置文件 — 首页模板自动巡查系统
所有路径、参数、API 密钥统一管理
"""

import os


# ============================================================
# 项目路径
# ============================================================

PROJECT_ROOT = r'D:\WorkCode\DP\DP_AutoTest\IPTV_HENANYD_72'

# 测试桩目录
STUB_DIR = os.path.join(PROJECT_ROOT, '测试桩')

# 导航配置文件（guidePlusList 一级导航菜单）
NAV_FILE = os.path.join(STUB_DIR, 'guidePlusList_一级导航菜单.json')


# ============================================================
# 输出目录
# ============================================================

OUTPUT_DIR = os.path.join(PROJECT_ROOT, r'ai_assert_engine\测试报告')

SCREENSHOT_DIR = os.path.normpath(os.path.join(OUTPUT_DIR, '../screenshots'))
NORMAL_DIR = os.path.join(OUTPUT_DIR, 'normal')
ABNORMAL_DIR = os.path.join(OUTPUT_DIR, 'abnormal')
REPORT_DIR = os.path.join(OUTPUT_DIR, 'reports')

# 日志目录（输出目录的上级 /logs）
LOG_DIR = os.path.join(os.path.dirname(OUTPUT_DIR), 'logs')


# ============================================================
# ADB 设备
# ============================================================

ADB_DEVICE = '192.168.100.2:5555'


# ============================================================
# 崩溃监控目标包名
# ============================================================

# 只监控此包名的崩溃，系统进程/Appium驱动等非被测应用崩溃自动过滤
CRASH_MONITOR_PKG = 'com.huawei.tvbox'


# ============================================================
# 首页焦点参数
# ============================================================

HOME_DEFAULT_SN = 4  # HOME 键默认落点频道（精选）


# ============================================================
# 模型注册表 — ai.ask(model='xxx') 统一路由
# ============================================================

# 每个模型三个字段：api_key / api_url / supports_vision
MODELS = {
    # ── 默认 GLM 视觉模型（视觉+文本，base64直传） ──
    'glm-4v-flash': {
        'api_key': os.environ.get('ZHIPUAI_API_KEY', '3af1f336f13b434ba414a8a75663b87d.GUfJMYjro7vp4x6c'),
        'api_url': 'https://open.bigmodel.cn/api/paas/v4/chat/completions',
        'supports_vision': True,
    },
    # 访问量过大
    'glm-4.6v-flash': {
        'api_key': os.environ.get('ZHIPUAI_API_KEY', '3af1f336f13b434ba414a8a75663b87d.GUfJMYjro7vp4x6c'),
        'api_url': 'https://open.bigmodel.cn/api/paas/v4/chat/completions',
        'supports_vision': True,
    },
    # 带推理模式 耗时会增加  先当备选模型
    'glm-4.1v-thinking-flash': {
        'api_key': os.environ.get('ZHIPUAI_API_KEY', '3af1f336f13b434ba414a8a75663b87d.GUfJMYjro7vp4x6c'),
        'api_url': 'https://open.bigmodel.cn/api/paas/v4/chat/completions',
        'supports_vision': True,
    },
    # ── GLM-4.7-Flash（纯文本+混合思考，免费） ──
    'glm-4.7-flash': {
        'api_key': os.environ.get('ZHIPUAI_API_KEY', '3af1f336f13b434ba414a8a75663b87d.GUfJMYjro7vp4x6c'),
        'api_url': 'https://open.bigmodel.cn/api/paas/v4/chat/completions',
        'supports_vision': False,  # 纯文本模型
    },
    'sensenova-6.7-flash-lite': {
        'api_key': os.environ.get('API_KEY', 'sk-FIxfXjaA78h3pOvyCfO1BpErNCpCO3s9'),
        'api_url': 'https://token.sensenova.cn/v1',
        'supports_vision': True,  # #商汤科技大模型  限时免费  每日5H
    },


# 美团的龙猫模型
    'LongCat-2.0': {
        'api_key': os.environ.get('ZHIPUAI_API_KEY', 'ak_2DS7k54vI9o29c24iR3lu0cs7p513'),
        'api_url': 'https://api.longcat.chat/openai/v1/chat/completions',
        'supports_vision': False, # 缓存命中率很高
    },

    # ── Agnes 2.5 Flash（纯文本+Thinking 推理，备用） ──
    # 注册地址: https://agnes-ai.com
    'agnes-2.0-flash': {
        'api_key': os.environ.get('AGNES_API_KEY', 'sk-32erCJ0JRHtnLfx2I5OkgGEJ5vDVpAszPaUesKlFt55gtdD4'),
        'api_url': 'https://apihub.agnes-ai.com/v1/chat/completions',
        'supports_vision': False,  # 仅 image_url，不支持 base64
    },
}

# ── 默认模型（向后兼容） ──

DEFAULT_MODEL = 'glm-4v-flash'

# ============================================================
# 按键 / 等待延迟（秒）
# ============================================================

KEY_DELAY = 1.5          # 普通按键间隔
PAGE_LOAD_DELAY = 2.5    # 页面加载等待
SCROLL_DELAY = 1.0       # 滚动后等待
ANALYZE_TIMEOUT = 90     # AI API 超时
ANALYZE_MAX_TOKENS = 1024  # 最大输出token（glm-4v-flash）
MAX_SCREENSHOTS_PER_CHANNEL = 5


# ============================================================
# 焦点框颜色（BGR 格式）
# ============================================================

# draw_focus_mark 默认框颜色，(B, G, R) 元组
# 常用：绿(0,255,0)  红  (0,0,255) 蓝(255,0,0) 黄 (0,255,255) 橙 (0, 165, 255)   白	(255, 255, 255)
FOCUS_BOX_COLOR = (0,255,255)
