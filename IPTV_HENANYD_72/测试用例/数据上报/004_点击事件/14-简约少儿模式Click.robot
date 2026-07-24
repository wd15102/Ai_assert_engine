*** Settings ***
Documentation    模式切换点击事件
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_267 简约版点击顶部切换模式fpa上报
    [Documentation]  点击事件
    到达切换模式入口
    确认键
    点击元素  ${简约版}
    等待元素出现  ${简约切换模式}
    等待元素出现  ${简约直播小窗播放器}
    按次数上移  2
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_267    ${datatable_prefix_apk}_click

case_268 简约版点击顶部搜索fpa上报
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_268    ${datatable_prefix_apk}_click

case_269 少儿版点击顶部切换模式fpa上报
    [Documentation]  点击事件
    按返回直到出现元素   ${简约切换模式}
    按次数上移  2
    按次数右移  1
    确认键
    点击元素  ${少儿版}
    等待元素出现  ${少儿切换模式}
    按次数上移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_269    ${datatable_prefix_apk}_click

case_270 少儿版点击顶部搜索fpa上报
    [Documentation]  点击事件
    按次数返回  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_270    ${datatable_prefix_apk}_click
