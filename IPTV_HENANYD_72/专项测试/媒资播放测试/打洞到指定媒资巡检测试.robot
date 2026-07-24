*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../IPTV_JX_72/对象库/专项测试.robot
Resource          ../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     run keywords  启动现网环境
Suite Teardown      退出应用

*** Test Cases ***
专项测试打洞到指定媒资巡检测试
    [Documentation]    专项测试：打洞到指定媒资巡检测试
    ${play_error_log}  catenate  SEPARATOR=   ${log_path}     /messagelog/play_log.txt
    打印日志  ----------------------------------开始指定媒资巡检测试----------------------------------
    home键
    按文件内容打洞巡检指定媒资  ${play_error_log}
