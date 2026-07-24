*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot

#Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 开机启动，设备心跳公共字段检查
    [Documentation]    设备心跳
    等待  30
    清除历史上报数据
    启动应用
    获取校验结果  {'logtype': 'dhb'}    test_001   ${datatable_prefix_apk}_dhb    

case_001_01 设备心跳事件改为post上报
    [Documentation]    设备心跳
    获取校验结果  {'logtype': 'dhb'}    test_001   ${datatable_prefix_apk}_dhb

case_002 开机启动，等待5分钟，检查设备心跳
    [Documentation]    设备心跳
    等待  250
    清除历史上报数据
    等待  60
    获取校验结果  {'logtype': 'dhb'}    test_002   ${datatable_prefix_apk}_dhb    
    
case_003 开机启动，等待15分钟，检查设备心跳
    [Documentation]    设备心跳
    等待  520
    清除历史上报数据
    等待  80
    获取校验结果  {'logtype': 'dhb'}    test_003   ${datatable_prefix_apk}_dhb    
    
