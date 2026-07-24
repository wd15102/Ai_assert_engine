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
case_001 搜索事件公共字段检查
    [Documentation]    搜索事件
    到达搜索入口
    确认键
    清除历史上报数据
    搜索-输入搜索词    A
    获取校验结果  {'logtype': 'iptvsearch'}    test_001   ${datatable_prefix_apk}_iptvsearch

case_002 搜索页输入字母A
    [Documentation]    搜索事件
    获取校验结果  {'logtype': 'iptvsearch'}    test_002   ${datatable_prefix_apk}_iptvsearch

case_002_01 iptvsearch事件公共字段新增开机参数
    [Documentation]    搜索事件
    获取校验结果  {'logtype': 'iptvsearch'}    test_002   ${datatable_prefix_apk}_iptvsearch

case_002_02 iptvsearch事件增加视频结果总数
    [Documentation]    搜索事件
    获取校验结果  {'logtype': 'iptvsearch'}    test_002   ${datatable_prefix_apk}_iptvsearch

case_014 搜索结果存在媒资搜索关联词-搜索事件
    [Documentation]    搜索事件
    点击搜索结果媒资  1
    按次数左移  1
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'iptvsearch'}    test_014   ${datatable_prefix_apk}_iptvsearch

case_015 搜索结果不存在明星媒资搜索关联词-搜索事件
    [Documentation]    搜索事件
    获取校验结果  {'logtype': 'iptvsearch'}    test_015   ${datatable_prefix_apk}_iptvsearch

case_003 继续输入字母A
    [Documentation]    搜索事件
    清空搜索结果
    搜索-输入搜索词  A
    清除历史上报数据
    搜索-输入搜索词  A
    获取校验结果  {'logtype': 'iptvsearch'}    test_003   ${datatable_prefix_apk}_iptvsearch

case_004 删除字母A
    [Documentation]    搜索事件
    清除历史上报数据
    搜索-删除单个搜索词
    获取校验结果  {'logtype': 'iptvsearch'}    test_004   ${datatable_prefix_apk}_iptvsearch

case_005 清空搜索字符
    [Documentation]    搜索事件
    清除历史上报数据
    清空搜索结果
    获取校验结果_不上报  {'logtype': 'iptvsearch'}    test_005   ${datatable_prefix_apk}_iptvsearch

case_006 搜索结果为空，上报搜索事件
    [Documentation]    搜索事件
    搜索-输入搜索词    AAA
    等待  5
    清除历史上报数据
    搜索-输入搜索词    A
    获取校验结果  {'logtype': 'iptvsearch'}    test_006   ${datatable_prefix_apk}_iptvsearch

case_007 使用全键盘搜索字母A
    [Documentation]    搜索事件
    清空搜索结果
    清除历史上报数据
    搜索-输入搜索词    A
    获取校验结果  {'logtype': 'iptvsearch'}    test_007   ${datatable_prefix_apk}_iptvsearch

case_008 使用九宫格搜索字母A
    [Documentation]    搜索事件
    清空搜索结果
    清除历史上报数据
    搜索-九宫格输入搜索词  A
    获取校验结果  {'logtype': 'iptvsearch'}    test_008   ${datatable_prefix_apk}_iptvsearch

case_009 点击搜索结果中的筛选条件电影
    [Documentation]    搜索事件
    到达搜索入口
    确认键
    等待  5
    搜索-输入搜索词    A
    点击搜索结果媒资  2
    按次数上移  1
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype': 'iptvsearch'}    test_009   ${datatable_prefix_apk}_iptvsearch

#case_010 选择搜索类型为电影，输入字母A
#    [Documentation]    搜索事件
#    获取校验结果  {'logtype': 'iptvsearch'}    test_010   ${datatable_prefix_apk}_iptvsearch
#
#case_011 选择搜索类型为app，输入字母A
#    [Documentation]    搜索事件
#    log to console  无APP搜索类型

