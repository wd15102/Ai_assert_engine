*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_016 搜索结果存在明星搜索关联词-搜索事件
    [Documentation]    搜索事件
    到达搜索入口
    确认键
    搜索-输入搜索词  ZT
    清除历史上报数据
    搜索-输入搜索词  A
    获取校验结果  {'logtype': 'iptvsearch'}    test_016   ${datatable_prefix_apk}_iptvsearch

case_017 搜索结果不存在应用媒资搜索关联词-搜索事件
    [Documentation]    搜索事件
    获取校验结果  {'logtype': 'iptvsearch'}    test_017   ${datatable_prefix_apk}_iptvsearch

case_017 搜索结果存在明星搜索关联词-搜索点击
    [Documentation]    搜索点击
    点击搜索结果媒资  1
    按次数返回  1
    按次数左移  1
    按键直到焦点位于文本上  张天爱    下
    按次数右移  1
    按次数上移  1
    按键直到焦点位于内容描述上  明星  右
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'searchclick'}    test_017   ${datatable_prefix_apk}_searchclick

case_018 搜索结果不存在媒资搜索关联词-搜索点击
    [Documentation]    搜索点击
    获取校验结果  {'logtype':'searchclick'}    test_018   ${datatable_prefix_apk}_searchclick

case_010 搜索结果存在明星搜索关联词-搜索曝光
    [Documentation]    搜索曝光
    按键直到出现文本信息  清空
    清除历史上报数据
    搜索-输入搜索词  A
    获取校验结果  {'logtype': 'searchshow'}    test_010   ${datatable_prefix_apk}_searchshow

case_011 搜索结果不存在应用搜索关联词-搜索曝光
    [Documentation]    搜索曝光
    获取校验结果  {'logtype': 'searchshow'}    test_011   ${datatable_prefix_apk}_searchshow

case_018 搜索结果不存在媒资搜索关联词-搜索事件
    [Documentation]    搜索事件
    清除历史上报数据
    搜索-输入搜索词  A
    获取校验结果  {'logtype': 'iptvsearch'}    test_018   ${datatable_prefix_apk}_iptvsearch

case_012 搜索结果不存在媒资搜索关联词-搜索曝光
    [Documentation]    搜索曝光
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype': 'searchshow'}    test_012   ${datatable_prefix_apk}_searchshow

case_013 搜索结果存在应用搜索关联词-搜索事件
    [Documentation]    搜索事件
    log to console  无应用搜索

case_014 搜索结果存在应用搜索关联词-搜索曝光
    [Documentation]    搜索曝光
    log to console  无应用搜索

case_015 搜索结果存在应用搜索关联词-搜索点击
    [Documentation]    搜索点击
    log to console  无应用搜索












