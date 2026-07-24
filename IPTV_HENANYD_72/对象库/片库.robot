*** Settings ***
Documentation    片库方法
Library  AppiumLibrary
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot
Resource   ../../IPTV_HENANYD_72/对象库/搜索.robot

*** Keywords ***
导航栏进入片库
    [Documentation]  从首页导航栏进入片库
    确认键
    wait until page contains element    ${片库列表}   10

片库进入搜索
    [Documentation]  从片库页中进入搜索页
    按次数上移  2
    按次数右移  1
    校验焦点是否在内容描述上  搜索
    确认键
    等待搜索页出现


