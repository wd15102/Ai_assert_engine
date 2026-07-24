*** Settings ***
Documentation    首页PV和STAY事件
Library           AppiumLibrary
Resource          ../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../IPTV_JX_72/对象库/详情页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_064 行业版媒资启播
    [Documentation]  启播事件
    行业版切换内容到行业1
    返回首页
    返回精选页
    按次数左移  4
    等待  3
    按次数下移  2
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'splay'}    test_064    ${datatable_prefix_apk}_splay

case_063 行业版媒资播放VV事件
    [Documentation]  VV事件
    获取校验结果  {'logtype':'play','bid':'26.1.1.0'}    test_063    ${datatable_prefix_apk}_play

case_024 行业分屏进入点播播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_024   ${datatable_prefix_apk}_pause

case_086 行业版媒资播放5分钟心跳
    [Documentation]  心跳事件
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype':'hb','bid':'26.1.25'}    test_086    ${datatable_prefix_apk}_hb

case_024 行业分屏进入点播播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_024   ${datatable_prefix_apk}_resume

case_043 行业版快进拖拽上报Drag事件
    [Documentation]  Drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype':'drag'}    test_043    ${datatable_prefix_apk}_drag

case_044 行业版快退拖拽上报Drag事件
    [Documentation]  Drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果  {'logtype':'drag'}    test_044    ${datatable_prefix_apk}_drag

case_087 行业版媒资播放退出心跳
    [Documentation]  心跳事件
    清除历史上报数据
    返回首页
    获取校验结果  {'logtype':'hb','bid':'26.1.25'}    test_087    ${datatable_prefix_apk}_hb

case_043 行业版媒资播放退出上报stop事件
    [Documentation]  Stop事件
    获取校验结果  {'logtype':'stop'}    test_043    ${datatable_prefix_apk}_stop