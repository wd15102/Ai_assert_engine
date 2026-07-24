*** Settings ***
Documentation    专题PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_183 精选频道进入会员片库页
    [Documentation]  PV事件
    返回精选页
    确认键
    切换频道    电视剧
    清除历史上报数据
    点击内容描述  会员片库
    等待文本出现  影视会员
    获取校验结果  {'logtype':'pv'}    test_183    ${datatable_prefix_apk}_pv

case_183 从电视剧频道进入会员片库页停留后返回
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_183    ${datatable_prefix_apk}_pv

case_184 从会员片库返回精选频道
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_184    ${datatable_prefix_apk}_pv

case_167 首页进入会员片库后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_167    ${datatable_prefix_apk}_stay

case_168 从VIP片库返回精选频道停留后切换频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道  精选
    获取校验结果  {'logtype':'stay'}    test_168    ${datatable_prefix_apk}_stay

case_185 从影视会员切换到少儿会员
    [Documentation]  PV事件
    切换频道  电视剧
    点击内容描述  会员片库
    等待文本出现  影视会员
    等待  3
    清除历史上报数据
    向右
    获取校验结果  {'logtype':'pv'}    test_185    ${datatable_prefix_apk}_pv

case_169 从影视会员切换到少儿会员
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_169    ${datatable_prefix_apk}_stay

case_186 从影视会员的电影切换到综艺
    [Documentation]  PV事件
    向左
    点击文本  综艺
    清除历史上报数据
    点击文本  综艺
    获取校验结果  {'logtype':'pv'}    test_186    ${datatable_prefix_apk}_pv

case_170 从影视会员的电影切换到综艺
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_170    ${datatable_prefix_apk}_stay

case_187 从影视会员电影的动作切换到恐怖
    [Documentation]  PV事件
    点击文本  电影
    点击文本  电影
    等待  3
    清除历史上报数据
    点击文本  恐怖
    获取校验结果  {'logtype':'pv'}    test_187    ${datatable_prefix_apk}_pv

case_171 从影视会员电影的动作切换到恐怖
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_171    ${datatable_prefix_apk}_stay