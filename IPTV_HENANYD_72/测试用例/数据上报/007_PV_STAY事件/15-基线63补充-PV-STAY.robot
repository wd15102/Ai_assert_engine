*** Settings ***
Documentation    直播回看时移PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_231 回看列表切换分类
    [Documentation]  PV事件
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数左移  1
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'pv'}    test_231    ${datatable_prefix_apk}_pv

case_232 精选页进入会员页
    [Documentation]  PV事件
    返回首页
    返回精选页
    到达开通会员入口
    清除历史上报数据
    确认键
    等待订购中心出现
#    获取校验结果  {'logtype':'pv'}    test_232    ${datatable_prefix_apk}_pv

case_233 会员页返回精选页
    [Documentation]  PV事件
    清除历史上报数据
    返回首页
    获取校验结果  {'logtype':'pv'}    test_233    ${datatable_prefix_apk}_pv

