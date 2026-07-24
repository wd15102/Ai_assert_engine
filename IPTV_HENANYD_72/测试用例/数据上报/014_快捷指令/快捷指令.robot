*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../遥控按键.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 快捷指令公共字段检查
    [Tags]  iptv  P0
    [Documentation]    快捷指令
    清除历史上报数据
    数字键进直播  1
    获取校验结果  {'logtype':'quickclick'}    test_001   ${datatable_prefix_apk}_quickclick

case_002 输入快捷指令，自动跳转
    [Tags]  iptv  P0
    [Documentation]    快捷指令
    获取校验结果  {'logtype':'quickclick'}    test_002   ${datatable_prefix_apk}_quickclick

case_003 输入快捷指令，自动跳转WEB
    [Tags]  iptv  P0
    [Documentation]    快捷指令
    返回首页
    返回精选页
    清除历史上报数据
    数字输入进入快捷指令  1000
    获取校验结果  {'logtype':'quickclick'}    test_003   ${datatable_prefix_apk}_quickclick

case_004 输入快捷指令，自动跳转详情页
    [Tags]  iptv  P0
    [Documentation]    快捷指令
    返回首页
    返回精选页
    清除历史上报数据
    数字输入进入快捷指令  1001
    获取校验结果  {'logtype':'quickclick'}    test_004   ${datatable_prefix_apk}_quickclick

case_005 输入快捷指令，快捷指令指引
    [Tags]  iptv  P0
    [Documentation]    快捷指令
    返回首页
    返回精选页
    清除历史上报数据
    数字输入进入快捷指令  9999
    获取校验结果  {'logtype':'quickclick'}    test_005   ${datatable_prefix_apk}_quickclick

case_006 输入快捷指令，自动跳转到搜索
    [Tags]  iptv  P0
    [Documentation]    快捷指令
    返回首页
    返回精选页
    清除历史上报数据
    数字输入进入快捷指令  1002
    获取校验结果  {'logtype':'quickclick'}    test_006   ${datatable_prefix_apk}_quickclick

case_007 输入快捷指令，自动跳转到播放记录
    [Tags]  iptv  P0
    [Documentation]    快捷指令
    返回首页
    返回精选页
    清除历史上报数据
    数字输入进入快捷指令  1023
    获取校验结果  {'logtype':'quickclick'}    test_007   ${datatable_prefix_apk}_quickclick

case_008 输入快捷指令，自动跳转到我的
    [Tags]  iptv  P0
    [Documentation]    快捷指令
    返回首页
    返回精选页
    清除历史上报数据
    数字输入进入快捷指令  1003
    获取校验结果  {'logtype':'quickclick'}    test_008   ${datatable_prefix_apk}_quickclick

case_009 输入快捷指令，自动跳转到问题反馈
    [Tags]  iptv  P0
    [Documentation]    快捷指令
    返回首页
    返回精选页
    清除历史上报数据
    数字输入进入快捷指令  1004
    获取校验结果  {'logtype':'quickclick'}    test_009   ${datatable_prefix_apk}_quickclick

