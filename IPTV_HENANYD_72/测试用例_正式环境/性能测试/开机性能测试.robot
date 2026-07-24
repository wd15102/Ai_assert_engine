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
    沉浸模式进入标准模式
    打开调试开关
    开始抓取日志
    FOR    ${i}   IN RANGE    10
        杀进程重启应用
        等待  5
        home键
        等待元素出现  ${首页logo}
        等待  10
    END
    关闭抓取日志
    根据关键词提取日志内容  pageName:app_start,endType:1,diffTime:   A

进入详情页性能测试
    [Documentation]    专项测试：进入详情页性能测试
    开始抓取日志
    home键
    切换频道  电影
    等待  15
    关闭微信引导弹窗
    按次数下移  1
    等待  5
    FOR    ${i}   IN RANGE   10
        关闭微信引导弹窗
        确认键
        等待详情页出现
        按次数返回  1
        详情页退出
        等待元素出现  ${首页logo}
    END
    关闭抓取日志
    根据关键词提取日志内容  pageName:v_play,endType:1,diffTime:  B