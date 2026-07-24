*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../IPTV_HNYD_64/对象库/公共方法.robot
Resource          ../../../IPTV_HNYD_64/对象库/专项测试.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
专项测试电视剧媒资播放测试
    [Documentation]    专项测试：媒资播放测试
    删除日志文件
    进入指定栏目   电视剧    电视剧
    片库列表循环  75   30

专项测试电影媒资播放测试
    [Documentation]    专项测试：媒资播放测试
    等待  10
    进入指定栏目   电视剧    电影
    片库列表循环  173   100

专项测试动漫媒资播放测试
    [Documentation]    专项测试：媒资播放测试
    等待  5
    进入指定栏目   电视剧    动漫
    片库列表循环  63   30

专项测试少儿媒资播放测试
    [Documentation]    专项测试：媒资播放测试
    等待  10
    进入指定栏目   电视剧    少儿
    片库列表循环  36   30

专项测试综艺媒资播放测试
    [Documentation]    专项测试：媒资播放测试
    等待  10
    进入指定栏目   电视剧    综艺
    片库列表循环  15   30

专项测试纪实媒资播放测试
    [Documentation]    专项测试：媒资播放测试
    等待  10
    进入指定栏目   电视剧    纪实
    片库列表循环  21   30

#专项测试调试
#    [Documentation]    专项测试：媒资播放测试
#    打印媒资播放失败日志文件  开始测试
#    删除文件内容  快乐大本营 2011

