*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../IPTV_JX_72/对象库/专项测试.robot
Resource          ../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     run keywords  启动现网环境
Suite Teardown      退出应用

*** Test Cases ***
专项测试指定媒资巡检测试
    [Documentation]    专项测试：指定媒资巡检测试
    ${play_error_log}  catenate  SEPARATOR=   ${log_path}     /messagelog/play_log.txt
    打印日志  ----------------------------------开始指定媒资巡检测试----------------------------------
    沉浸模式进入标准模式
    home键
    按次数上移  3
    按次数右移  3
    确认键
    等待页面出现元素信息  ${搜索键盘区}
    按文件内容巡检指定媒资  ${play_error_log}
