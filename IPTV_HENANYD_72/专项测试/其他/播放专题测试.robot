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
case_001 小窗播放专题测试
    [Documentation]  小窗播放专题测试
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    到达小窗播放专题入口
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  18000
        校验焦点是否在内容描述上  小窗播放专题
        确认键
        等待页面出现内容描述信息  春秋魏晋
        按次数右移  2    5
        确认键  5
        按次数返回  1    10
        等待页面出现内容描述信息  春秋魏晋
        按次数左移  2    5
        按次数返回  1    3
    END

case_002 短视频播放专题测试
    [Documentation]  短视频播放专题测试
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    到达短视频模板专题入口
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  18000
        校验焦点是否在内容描述上  短视频模板专题
        确认键
        等待文本出现  短视频模板专题
        按次数下移  1    5
        确认键  5
        按次数返回  1    10
        等待文本出现  短视频模板专题
        按次数下移  1    5
        确认键  5
        按次数返回  1    10
        等待文本出现  短视频模板专题
        按次数下移  1    5
        确认键  5
        按次数返回  1    10
        等待文本出现  短视频模板专题
        按次数下移  1    5
        确认键  5
        按次数返回  1    10
        等待文本出现  短视频模板专题
        按次数上移  1    5
        确认键  5
        按次数返回  1    10
        等待文本出现  短视频模板专题
        按次数上移  1    5
        确认键  5
        按次数返回  1    10
        等待文本出现  短视频模板专题
        按次数上移  1    5
        确认键  5
        按次数返回  1    10
        等待文本出现  短视频模板专题
        按次数上移  1    5
        确认键  5
        按次数返回  1    10
        等待文本出现  短视频模板专题
        按次数返回  1    5
    END

