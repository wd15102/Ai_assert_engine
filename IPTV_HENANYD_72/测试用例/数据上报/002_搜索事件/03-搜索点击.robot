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
case_000 搜索点击公共字段检查
    [Documentation]    搜索点击
    到达搜索入口
    确认键
    搜索-输入搜索词    A
    清除历史上报数据
    点击搜索结果媒资  1
    确认键
    获取校验结果  {'logtype':'searchclick'}    test_001   ${datatable_prefix_apk}_searchclick

case_001 用户进入搜索页，输入字母A，点击第一个媒资
    [Documentation]    搜索点击
    获取校验结果  {'logtype':'searchclick'}    test_001   ${datatable_prefix_apk}_searchclick

case_001_01 searchclick事件公共字段新增开机参数
    [Documentation]    搜索点击
    获取校验结果  {'logtype':'searchclick'}    test_001   ${datatable_prefix_apk}_searchclick

case_014 搜索结果存在媒资搜索关联词-搜索点击
    [Documentation]    搜索点击
    获取校验结果  {'logtype':'searchclick'}    test_014   ${datatable_prefix_apk}_searchclick

case_015 搜索结果不存在明星搜索关联词-搜索点击
    [Documentation]    搜索点击
    获取校验结果  {'logtype':'searchclick'}    test_015   ${datatable_prefix_apk}_searchclick

case_016 搜索结果不存在应用搜索关联词-搜索点击
    [Documentation]    搜索点击
    获取校验结果  {'logtype':'searchclick'}    test_016   ${datatable_prefix_apk}_searchclick

case_001_02 searchclick事件增加视频结果总数和后端下发的信息
    [Documentation]    搜索点击
    获取校验结果  {'logtype':'searchclick'}    test_001   ${datatable_prefix_apk}_searchclick

case_002 用户进入搜索页，输入字母A，点击第二个媒资
    [Documentation]    搜索点击
    按次数返回  1
    清空搜索结果
    搜索-输入搜索词    A
    清除历史上报数据
    点击搜索结果媒资    2
    确认键
    获取校验结果  {'logtype':'searchclick'}    test_002   ${datatable_prefix_apk}_searchclick

case_003 用户进入搜索页，输入字母A，点击第7个媒资
    [Documentation]    搜索点击
    按次数返回  1
    清空搜索结果
    搜索-输入搜索词    A
    清除历史上报数据
    点击搜索结果媒资    7
    确认键
    获取校验结果  {'logtype':'searchclick'}    test_003   ${datatable_prefix_apk}_searchclick

case_004 用户进入搜索页，输入字母A，点击第一个明星
    [Documentation]    搜索点击
    到达搜索入口
    确认键
    搜索-输入搜索词    A
    点击搜索结果媒资  1
    按次数上移  1
    按次数右移  11
    确认键
    清除历史上报数据
    按次数下移  1    2
    确认键
    获取校验结果  {'logtype':'searchclick'}    test_004   ${datatable_prefix_apk}_searchclick

case_005 用户进入搜索页，输入字母A，点击第二个明星
    [Documentation]    搜索点击
    按次数返回  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'searchclick'}    test_005   ${datatable_prefix_apk}_searchclick

case_006 用户进入搜索页，输入字母A，选择电影，点击第一个媒资
    [Documentation]    搜索点击
    按次数返回  1
    按次数上移  1
    按次数左移  10
    确认键
    清除历史上报数据
    按次数下移  1
    确认键
    获取校验结果  {'logtype':'searchclick'}    test_006   ${datatable_prefix_apk}_searchclick

case_007 用户进入搜索页，输入字母A，点击第一个媒资
    [Documentation]    搜索点击
    详情页退出
    清空搜索结果
    搜索-输入搜索词    A
    清除历史上报数据
    点击搜索结果媒资  1
    确认键  5
    获取校验结果  {'logtype':'searchclick'}    test_007   ${datatable_prefix_apk}_searchclick

case_008 用户进入搜索页，不输入字母，点击第一个媒资
    [Documentation]    搜索点击
    详情页退出
    清空搜索结果
    清除历史上报数据
    点击搜索推荐媒资  1
    确认键  5
    获取校验结果_不上报  {'logtype':'searchclick'}    test_008   ${datatable_prefix_apk}_searchclick

case_009 用户进入搜索页，不输入字母，点击搜索历史中第一条记录
    [Documentation]    搜索点击
    详情页退出
    清空搜索结果
    清除历史上报数据
    点击搜索历史媒资  1
    获取校验结果_不上报  {'logtype':'searchclick'}    test_009   ${datatable_prefix_apk}_searchclick

case_010 用户进入搜索页，选择搜索类型为影视，输入字母A，点击第一个媒资
    [Documentation]    搜索点击
    log to console  无搜索类型区分

case_011 用户进入搜索页，选择搜索类型为应用，输入字母A，点击第一个应用
    [Documentation]    搜索点击
    log to console  无搜索类型区分


