*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     run keywords  启动现网环境
Suite Teardown      退出应用
Test Teardown   关闭抓取日志

*** Test Cases ***
开机性能测试
    [Documentation]    专项测试：开机性能测试
    开始抓取日志
    FOR    ${i}   IN RANGE    5
        杀进程重启应用
        等待  5
        home键
        等待元素出现  ${首页logo}
        等待  10
    END
    关闭抓取日志
    根据关键词提取日志内容  onFinish startAppCosumingTime networkType:volley,spTime:

进入详情页性能测试
    [Documentation]    专项测试：进入详情页性能测试
    开始抓取日志
    home键
    按次数右移  2
    按次数下移  2
    命令打开debug日志
    FOR    ${i}   IN RANGE    5
        确认键
        等待详情页出现
        按次数返回  1
        等待元素出现  ${首页logo}
    END
    关闭抓取日志
    根据关键词提取日志内容  pageName:v_play,endType:1,diffTime:  B