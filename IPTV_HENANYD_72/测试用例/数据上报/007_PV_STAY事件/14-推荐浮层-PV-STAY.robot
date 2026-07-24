*** Settings ***
Documentation    推荐浮层PV事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_212 直播放播推荐浮层跳转到点播
    [Documentation]  PV事件
    返回首页
    数字键进直播  002
    直播呼出浮层
    按次数右移  1
    清除历史上报数据
    点击内容描述  绯闻计划
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_212    ${datatable_prefix_apk}_pv

case_212_1 直播播放推荐进入全屏播放
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_212    ${datatable_prefix_apk}_pv

case_212_2 直播推荐进入点播详情页cid上报
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_212    ${datatable_prefix_apk}_pv

#case_213 直播暂停推荐浮层跳转到点播
#    [Documentation]  PV事件
#    返回首页
#    数字键进直播  01
#    暂停键
#    等待页面出现文本信息  广告
#    返回键
#    暂停键
#    等待页面出现文本信息  广告
#    按次数上移  2
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_213    ${datatable_prefix_apk}_pv
#
#case_214 直播退出推荐浮层跳转到点播
#    [Documentation]  PV事件
#    返回首页
#    数字键进直播  01
#    等待  5
#    暂停键
#    等待页面出现文本信息  广告
#    返回键
#    按返回直到出现元素  ${退出}
#    按次数上移  2
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_214    ${datatable_prefix_apk}_pv
#
#case_215 时移暂停推荐浮层跳转到点播
#    [Documentation]  PV事件
#    返回首页
#    数字键进直播  01
#    按秒快退  3
#    暂停键
#    等待页面出现文本信息  广告
#    返回键
#    暂停键
#    等待页面出现文本信息  广告
#    按次数上移  2
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_215    ${datatable_prefix_apk}_pv
#
#case_216 时移退出推荐浮层跳转到点播
#    [Documentation]  PV事件
#    返回首页
#    数字键进直播  01
#    按秒快退  3
#    暂停键
#    等待页面出现文本信息  广告
#    返回键
#    按返回直到出现元素  ${退出}
#    按次数上移  2
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_216    ${datatable_prefix_apk}_pv
#
#case_217 回看暂停推荐浮层跳转到点播
#    [Documentation]  PV事件
#    返回首页
#    切换频道  直播
#    直播频道进入回看列表
#    按次数右移  1
#    按次数上移  1
#    点击内容描述  00:00 分段1
#    等待媒资播放
#    暂停键
#    等待页面出现文本信息  广告
#    按次数上移  2
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_217    ${datatable_prefix_apk}_pv
#
#case_218 回看退出推荐浮层跳转到点播
#    [Documentation]  PV事件
#    返回首页
#    切换频道  直播
#    直播频道进入回看列表
#    按次数右移  1
#    按次数上移  1
#    点击内容描述  00:00 分段1
#    等待媒资播放
#    按返回直到出现元素  ${退出}
#    按次数上移  2
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_218    ${datatable_prefix_apk}_pv
#
#case_219 点播暂停推荐浮层跳转到点播
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    点击元素  ${免费电视剧}
#    等待页面出现元素信息  ${详情页收藏}
#    点击元素  ${全屏}
#    等待媒资播放
#    向右
#    暂停键
#    等待页面出现文本信息  广告
#    按次数上移  2
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_219    ${datatable_prefix_apk}_pv
#
#case_220 点播退出推荐浮层跳转到点播
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    点击元素  ${免费电视剧}
#    等待页面出现元素信息  ${详情页收藏}
#    点击元素  ${全屏}
#    等待媒资播放
#    向右
#    按返回直到出现元素  ${退出}
#    按次数上移  2
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_220    ${datatable_prefix_apk}_pv