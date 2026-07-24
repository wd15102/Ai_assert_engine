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
case_001 搜索曝光公共字段检查
    [Documentation]    搜索曝光
    到达搜索入口
    确认键
    等待  5
    搜索-输入搜索词    A
    清除历史上报数据
    返回键
    获取校验结果  {'logtype': 'searchshow'}    test_001   ${datatable_prefix_apk}_searchshow

case_001_01 searchshow事件公共字段新增开机参数
    [Documentation]    搜索曝光
    获取校验结果  {'logtype': 'searchshow'}    test_001   ${datatable_prefix_apk}_searchshow

case_002 搜索页输入字母A并返回
    [Documentation]    搜索曝光
    获取校验结果  {'logtype': 'searchshow'}    test_002   ${datatable_prefix_apk}_searchshow

case_008 搜索结果存在媒资搜索关联词-搜索曝光
    [Documentation]    搜索曝光
    获取校验结果  {'logtype': 'searchshow'}    test_008   ${datatable_prefix_apk}_searchshow

case_009 搜索结果不存在明星搜索关联词-搜索曝光
    [Documentation]    搜索曝光
    获取校验结果  {'logtype': 'searchshow'}    test_009   ${datatable_prefix_apk}_searchshow

case_002_1 searchshow事件增加视频结果总数
    [Documentation]    搜索曝光
    获取校验结果  {'logtype': 'searchshow'}    test_002   ${datatable_prefix_apk}_searchshow

case_003 搜索页输入字母A后返回搜索结果再输入A
    [Documentation]    搜索曝光
    到达搜索入口
    确认键
    等待  5
    搜索-输入搜索词    A
    清除历史上报数据
    搜索-输入搜索词    A
    获取校验结果  {'logtype': 'searchshow'}    test_003   ${datatable_prefix_apk}_searchshow

case_004 搜索结果为空，上报搜索曝光事件
    [Documentation]    搜索曝光
    到达搜索入口
    确认键
    等待  5
    搜索-输入搜索词    AAA
    清除历史上报数据
    搜索-输入搜索词    A
    获取校验结果  {'logtype': 'searchshow'}    test_004   ${datatable_prefix_apk}_searchshow

case_005 搜索页输入字母A，选择搜索结果的筛选条件为电影
    [Documentation]    搜索曝光
    到达搜索入口
    确认键
    等待  5
    搜索-输入搜索词  A
    点击搜索结果媒资  2
    按次数上移  1
#    按次数右移  1
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype': 'searchshow'}    test_005   ${datatable_prefix_apk}_searchshow

