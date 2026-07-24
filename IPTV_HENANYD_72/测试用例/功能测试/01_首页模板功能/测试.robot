*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_HENANYD_72/对象库/公共方法.robot
Resource          ../../../../IPTV_HENANYD_72/对象库/首页.robot
Resource          ../../../../IPTV_HENANYD_72/对象库/直播回看时移.robot
Resource          ../../../../IPTV_HENANYD_72/对象库/详情页.robot
Resource          ../../../../IPTV_HENANYD_72/系统方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
 case_005 新直播居中模板页面检查
    [Documentation]    首页通栏模板-新直播居中模板  common_live_mid2_template
    [Tags]  smoke
    按次数返回  1
    返回首页
    返回精选页
    返回首页
    切换频道  直播
    等待页面出现元素信息  ${直播小窗播放器}
    等待页面出现元素信息  ${直播小窗口正在播放的节目}
    按次数下移    2
    等待页面出现元素信息  ${回看}