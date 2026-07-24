*** Settings ***
Documentation    首页方法
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot
Resource   ../../IPTV_HENANYD_72/系统方法.robot

*** Keywords ***
即映点赞状态判断
    [Documentation]  即映点赞状态判断
    [Arguments]  ${name}=False
    ${status}   获取元素属性  ${即映点赞}  selected
    run keyword if  '${status}' == '${name}'     log to console  状态正常
    ...  ELSE   fail  状态异常
