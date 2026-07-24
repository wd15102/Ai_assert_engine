*** Settings ***
Documentation    明星页方法
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot


*** Keywords ***
到达明星页
    [Documentation]  到达明星页
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    按次数下移  4
    按次数左移  1
    确认键
    等待明星页出现