*** Settings ***
Documentation    后花园测试
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown  用例失败截屏

*** Test Cases ***
case_001 进入频道后花园
    [Documentation]    进入频道后花园
    [Tags]  smoke
    返回首页
    菜单键
    等待元素出现  ${全局菜单精选}
    按次数上移  2
    按次数下移  1
    按次数上移  3
    按次数下移  2
    等待页面出现元素信息  ${免费电视剧}    30
    等待页面出现文本信息  后花园频道

case_002 进入频道后花园点击跳转
    [Documentation]    进入频道后花园点击跳转
    点击元素  ${免费电视剧}
    等待页面出现文本信息  我站在桥上看风景 DVD版

case_004 后花园模式响应快捷指令
    [Documentation]    后花园模式响应快捷指令
    数字输入进入快捷指令  1002
    等待搜索页出现

case_003 退出频道后花园
    [Documentation]    退出频道后花园
    [Tags]  smoke
    返回精选页
    菜单键
    等待元素出现  ${全局菜单精选}
    按次数下移  2
    按次数上移  3
    按次数下移  1
    按次数上移  2
    等待页面出现元素信息  ${免费电视剧}    30
    等待页面不出现文本信息  后花园频道



