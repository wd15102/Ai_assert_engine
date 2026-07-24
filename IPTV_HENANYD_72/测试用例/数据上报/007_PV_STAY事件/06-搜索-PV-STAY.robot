*** Settings ***
Documentation    搜索PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_092 精选页进入搜索页
    [Documentation]  PV事件
    到达搜索入口
    清除历史上报数据
    确认键
    等待搜索页出现
    获取校验结果  {'logtype':'pv'}    test_092    ${datatable_prefix_apk}_pv

case_093 搜索页返回精选页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_093    ${datatable_prefix_apk}_pv

case_095 从精选频道进入搜索页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_095    ${datatable_prefix_apk}_stay

