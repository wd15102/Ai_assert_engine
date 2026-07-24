*** Settings ***
Documentation    专题PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_094 精选页进入专题列表页
    [Documentation]  PV事件
    返回首页
    返回精选页
    确认键
    切换频道    电视剧
    清除历史上报数据
    点击内容描述  APK专题
    等待专题出现
    获取校验结果  {'logtype':'pv'}    test_094    ${datatable_prefix_apk}_pv

case_095 专题列表页返回精选页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_095    ${datatable_prefix_apk}_pv

case_096 从精选频道进入专题列表页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_096    ${datatable_prefix_apk}_stay

case_243 专题进入点播详情页clid上报
    [Documentation]  PV事件
    点击内容描述  APK专题
    等待专题出现
    清除历史上报数据
    确认键  5
    等待媒资播放
    获取校验结果  {'logtype':'pv'}    test_243    ${datatable_prefix_apk}_pv

