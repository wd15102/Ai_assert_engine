*** Settings ***
Documentation    搜索点击事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_040 点击搜索页中的清空历史
    [Documentation]  点击事件
    到达搜索入口
    确认键
    等待元素出现  ${搜索键盘区}
    清除历史上报数据
    点击元素  ${清空历史}
    获取校验结果  {'logtype':'click'}    test_040    ${datatable_prefix_apk}_click

#case_041 点击搜索页中的语音遥控
#    [Documentation]  点击事件
#    清除历史上报数据
#    点击元素  ${语音遥控}
#    等待  3
#    获取校验结果  {'logtype':'click'}    test_041    ${datatable_prefix_apk}_click

case_042 点击未输入字母时大家都在搜中的第1个海报
    [Documentation]  点击事件
    按次数返回  1
    清除历史上报数据
    点击搜索推荐媒资  1
    确认键
    获取校验结果  {'logtype':'click'}    test_042    ${datatable_prefix_apk}_click

case_043 点击未输入字母时大家都在搜中的第2个海报
    [Documentation]  点击事件
    按次数返回  1
    清除历史上报数据
    点击搜索推荐媒资  2
    确认键
    获取校验结果  {'logtype':'click'}    test_043    ${datatable_prefix_apk}_click

case_044 点击搜索无结果中大家都在搜中的第1个海报
    [Documentation]  点击事件
    到达搜索入口
    确认键
    等待搜索页出现
    搜索-输入搜索词  AAAAAA
    清除历史上报数据
    点击搜索结果媒资  1
    确认键
    获取校验结果  {'logtype':'click'}    test_044    ${datatable_prefix_apk}_click

case_045 点击搜索无结果中大家都在搜中的第2个海报
    [Documentation]  点击事件
    按次数返回  1
    清除历史上报数据
    点击搜索结果媒资  2
    确认键
    获取校验结果  {'logtype':'click'}    test_045    ${datatable_prefix_apk}_click

case_046 点击搜索历史中的第1条记录
    [Documentation]  点击事件
    到达搜索入口
    确认键
    等待搜索页出现
    清除历史上报数据
    点击搜索历史媒资  1
    获取校验结果  {'logtype':'click'}    test_046    ${datatable_prefix_apk}_click

case_047 点击搜索历史中的第2条记录
    [Documentation]  点击事件
    按次数返回  1
    清除历史上报数据
    点击搜索历史媒资  2
    获取校验结果  {'logtype':'click'}    test_047    ${datatable_prefix_apk}_click

