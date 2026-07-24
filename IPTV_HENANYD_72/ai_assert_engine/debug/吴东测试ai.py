#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
@Project ：DP_AutoTest 
@File    ：吴东测试ai.py
@IDE     ：PyCharm 
@Author  ：Mgtv-wudong
@Date    ：2026/7/5 17:04 
'''
from lib.ai_service import ai
from engine.template_prompt_builder import TemplatePromptBuilder
from engine_config.config import PROJECT_ROOT
import os
stub_path = os.path.join(PROJECT_ROOT,  "测试桩", "GetInitMetaData_直播频道.json")
# 焦点判断

# res = ai.vqa("当前焦点是直播居中模板左侧的第一个海报上吗？")
# print(res)

#
# # 加载频道检查点
builder = TemplatePromptBuilder()
# builder.load(stub_path=stub_path)
#
# # 用法1：获取单个模板的 system_prompt
# sp = builder.build_for_template("直播居中模版新")
img = r"D:\\WorkCode\\DP\\DP_AutoTest\\IPTV_HENANYD_72\\ai_assert_engine\\live_check\\focus_marked.png"
res = ai.ask("当前焦点框在哪",model="LongCat-2.0",mark_focus=False,image=img)

print(res)
# 用法2：获取全部模板的整体提示词（整页分析）
# sp_all = builder.build_for_channel()
# res1 = ai.ask("描述导航栏下方可见的所有模板", system_prompt=sp_all)

# 加载测试桩 + 裁剪目录
builder = TemplatePromptBuilder()
builder.load(stub_path)
ai.load_context(builder, r"D:\...\screenshots\直播_check\_clips")

# 之后调用就不用传 image 了——ai 自动去 _clips 目录里按模板名匹配裁剪图
result = ai.vqa_template("海报是否正常？", "直播居中模版新")
