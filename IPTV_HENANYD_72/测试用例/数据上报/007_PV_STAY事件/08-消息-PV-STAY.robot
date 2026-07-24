*** Settings ***
Documentation    消息PV和STAY事件
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_096 精选页进入消息页
    [Documentation]  PV事件
    到达消息页面入口
    清除历史上报数据
    确认键
    等待消息页出现
    获取校验结果  {'logtype':'pv'}    test_096    ${datatable_prefix_apk}_pv

case_097 从精选频道进入消息页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_097    ${datatable_prefix_apk}_stay

case_098 全部消息进入未读消息页
    [Documentation]  PV事件
    到达消息页面入口
    确认键
    等待消息页出现
    清除历史上报数据
    点击文本    未读消息
    获取校验结果  {'logtype':'pv'}    test_098    ${datatable_prefix_apk}_pv

case_097 消息页返回精选页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_097    ${datatable_prefix_apk}_pv

case_098 从全部消息进入未读消息页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_098    ${datatable_prefix_apk}_stay

case_099 从未读消息页返回全部消息停留后返回
    [Documentation]  STAY事件
    到达消息页面入口
    确认键
    等待消息页出现
    点击文本    未读消息
    点击文本    全部消息
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_099    ${datatable_prefix_apk}_stay

