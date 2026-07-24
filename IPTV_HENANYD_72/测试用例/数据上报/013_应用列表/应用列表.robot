*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 应用列表公共字段检查
    [Tags]  iptv  P0
    [Documentation]    appls事件
    清除历史上报数据
    重新启动
    获取校验结果  {'logtype':'appls','bid':'26.9.1'}    test_001   ${datatable_prefix_apk}_appls

case_002 盒端启用应用程序，并检查应用列表事件
    [Tags]  iptv  P0
    [Documentation]    appls事件
    获取校验结果  {'logtype':'appls','bid':'26.9.1'}    test_002   ${datatable_prefix_apk}_appls

case_001 桌面自升级公共字段校验
    [Documentation]    应用安装事件
    获取校验结果  {'logtype':'downup','uact':'rqi'}    test_001   ${datatable_prefix_apk}_downup

case_002 桌面自升级发起升级检测
    [Documentation]    应用安装事件
    获取校验结果  {'logtype':'downup','uact':'rqi'}    test_002   ${datatable_prefix_apk}_downup

case_005 桌面自升级获取到接口无新版本返回
    [Documentation]    应用安装事件
    获取校验结果  {'logtype':'downup','uact':'reu'}    test_005   ${datatable_prefix_apk}_downup

case_001 桌面热修复公共字段检查
    [Documentation]    热修复事件
    获取校验结果  {'logtype':'hotup','uact':'prq'}    test_001   ${datatable_prefix_apk}_hotup

case_001 桌面热修复发起升级接口请求
    [Documentation]    热修复事件
    获取校验结果  {'logtype':'hotup','uact':'prq'}    test_001   ${datatable_prefix_apk}_hotup

#case_001 插件更新事件公共字段
#    [Documentation]    插件更新事件
#    按次数下移  4
#    按次数右移  1
#    清除历史上报数据
#    确认键  15
#    获取校验结果  {'logtype':'plug_in','uact':'rq'}    test_001   ${datatable_prefix_apk}_plugin
#
#case_001 静默升级插件请求接口成功
#    [Documentation]    插件更新事件
#    获取校验结果  {'logtype':'plug_in','uact':'rq'}    test_001   ${datatable_prefix_apk}_plugin
#
#case_002 插件下载前判断存储空间
#    [Documentation]    插件更新事件
#    获取校验结果  {'logtype':'plug_in','uact':'issp'}    test_002   ${datatable_prefix_apk}_plugin
#
#case_003 下载插件安装包成功
#    [Documentation]    插件更新事件
#    获取校验结果  {'logtype':'plug_in','uact':'dl'}    test_003   ${datatable_prefix_apk}_plugin
#
#case_004 插件md5值校验成功
#    [Documentation]    插件更新事件
#    获取校验结果  {'logtype':'plug_in','uact':'md5'}    test_004   ${datatable_prefix_apk}_plugin
#
#case_005 插件安装成功
#    [Documentation]    插件更新事件
#    获取校验结果  {'logtype':'plug_in','uact':'inst'}    test_005   ${datatable_prefix_apk}_plugin
#
#case_006 初次启动插件包
#    [Documentation]    插件更新事件
#    获取校验结果  {'logtype':'plug_in','uact':'cpl'}    test_006   ${datatable_prefix_apk}_plugin