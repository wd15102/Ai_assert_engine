*** Settings ***
Documentation    模式切换点击事件
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_060 时尚模式下点击切换模式页时尚版
    [Documentation]  点击事件
    到达切换模式入口
    确认键
    清除历史上报数据
    点击元素  ${时尚版}
    获取校验结果  {'logtype':'click'}    test_060    ${datatable_prefix_apk}_click

case_061 时尚模式下点击切换模式页简约版
    [Documentation]  点击事件
    到达切换模式入口
    确认键
    清除历史上报数据
    点击元素  ${简约版}
    等待元素出现  ${简约直播小窗播放器}
    获取校验结果  {'logtype':'click'}    test_061    ${datatable_prefix_apk}_click

case_064 简约模式下点击切换模式页简约版
    [Documentation]  点击事件
    按次数上移  2
    按次数右移  1
    确认键  3
    清除历史上报数据
    点击元素  ${简约版}
    获取校验结果  {'logtype':'click'}    test_064    ${datatable_prefix_apk}_click

case_063 简约模式下点击切换模式页时尚版
    [Documentation]  点击事件
    按次数上移  2
    按次数右移  1
    确认键
    清除历史上报数据
    点击元素  ${时尚版}
    获取校验结果  {'logtype':'click'}    test_063    ${datatable_prefix_apk}_click

case_062 时尚模式下点击切换模式页少儿版
    [Documentation]  点击事件
    到达切换模式入口
    确认键  3
    清除历史上报数据
    点击元素  ${少儿版}
    获取校验结果  {'logtype':'click'}    test_062    ${datatable_prefix_apk}_click

case_068 少儿模式下点击切换模式页少儿版
    [Documentation]  点击事件
    按次数上移  2
    确认键
    点击验证页答案
    清除历史上报数据
    点击元素  ${少儿版}
    获取校验结果  {'logtype':'click'}    test_068    ${datatable_prefix_apk}_click

case_069 点击少儿验证页的答案
    [Documentation]  点击事件
    按次数上移  2
    确认键
    清除历史上报数据
    点击验证页答案
    获取校验结果  {'logtype':'click'}    test_069    ${datatable_prefix_apk}_click

case_067 少儿模式下点击切换模式页简约版
    [Documentation]  点击事件
    清除历史上报数据
    点击元素  ${简约版}
    获取校验结果  {'logtype':'click'}    test_067    ${datatable_prefix_apk}_click

case_065 简约模式下点击切换模式页少儿版
    [Documentation]  点击事件
    等待  3
    按次数上移  2
    按次数右移  1
    确认键  3
    清除历史上报数据
    点击元素  ${少儿版}
    获取校验结果  {'logtype':'click'}    test_065    ${datatable_prefix_apk}_click

case_066 少儿模式下点击切换模式页时尚版
    [Documentation]  点击事件
    等待  3
    按次数上移  2
    确认键
    点击验证页答案
    清除历史上报数据
    点击元素  ${时尚版}
    获取校验结果  {'logtype':'click'}    test_066    ${datatable_prefix_apk}_click

