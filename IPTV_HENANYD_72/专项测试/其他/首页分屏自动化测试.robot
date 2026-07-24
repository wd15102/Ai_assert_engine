*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../IPTV_JX_72/对象库/专项测试.robot
Resource          ../../../系统方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
case_001 选片大师分屏加载内容测试
    [Documentation]  判断选片大师分屏加载是否成功
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  16200
        分屏随机切换
        随机进行指定的操作  10   5
    END


