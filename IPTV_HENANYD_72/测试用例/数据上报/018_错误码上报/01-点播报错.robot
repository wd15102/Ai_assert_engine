*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 Error事件公共字段检查
    [Documentation]    Error事件
    返回首页
    返回精选页
    切换频道  电视剧
    按次数下移  7
    按次数左移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'error','bid':'26.13.20'}    test_001   ${datatable_prefix_apk}_error

case_002 应用类--视频详细信息请求失败,错误码1002008
    [Documentation]    Error事件
    按次数返回  1
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'error','bid':'26.13.20'}    test_002   ${datatable_prefix_apk}_error

case_003 点播视频播放启动参数错误，错误码1003010
    [Documentation]    Error事件
    按次数返回  1
    按次数右移  1
    清除历史上报数据
    确认键  65
    获取校验结果  {'logtype': 'error','bid':'26.13.20'}    test_003   ${datatable_prefix_apk}_error

case_004 应用类--接口数据解析失败,错误码1001005
    [Documentation]    Error事件
    按次数返回  1
    按次数右移  1
    清除历史上报数据
    确认键  15
    获取校验结果  {'logtype': 'error','bid':'26.13.20'}    test_004   ${datatable_prefix_apk}_error

