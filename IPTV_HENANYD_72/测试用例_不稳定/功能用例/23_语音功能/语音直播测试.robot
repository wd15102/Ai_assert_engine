*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../系统方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
case_001 直播名称切台
    [Documentation]  直播名称切台
    [Tags]  smoke
    返回精选页
    语音输入    我要看湖南卫视
    等待元素出现  ${直播播放器}
    校验焦点是否在内容描述上  湖南卫视高清

case_002 频道号切台
    [Documentation]  频道号切台
    等待元素出现  ${直播播放器}
    语音输入    我要看002频道
    等待文本出现  湖南经视高清
    等待文本出现  002

case_003 直播别名切台
    [Documentation]  直播别名切台
    等待元素出现  ${直播播放器}
    语音输入    我要看芒果台
    等待文本出现  湖南卫视高清
    等待文本出现  001

case_004 切换下一个直播频道
    [Documentation]  切换下一个直播频道
    等待元素出现  ${直播播放器}
    语音输入    下个频道
    等待文本出现  湖南经视高清
    等待文本出现  002

case_005 切换上一个直播频道
    [Documentation]  切换上一个直播频道
    等待元素出现  ${直播播放器}
    语音输入    上个频道
    等待文本出现  湖南卫视高清
    等待文本出现  001

case_006 非直播页面控制
    [Documentation]  非直播页面控制
    返回精选页
    语音输入    上个频道
    校验焦点是否在内容描述上  精选

case_007 搜索直播频道
    [Documentation]  搜索直播频道
    返回精选页
    语音输入    我想看湖南卫视
    等待文本出现  湖南卫视高清
    等待文本出现  001

case_008 搜索下线直播频道
    [Documentation]  搜索下线直播频道
    返回精选页
    语音输入    我想看CCTV20
    校验焦点是否在内容描述上  精选

case_009 搜索回看节目
    [Documentation]  搜索回看节目
    返回精选页
    语音输入    我想看昨天的湖南卫视
    等待回看列表出现

case_010 回看指定频道
    [Documentation]  回看指定频道
    等待回看列表出现

case_011 回看某天某频道
    [Documentation]  回看某天某频道
    ${today}  get sys date
    ${yesterday}    get sys date  -1    week
    ${2_days_ago}    get sys date  -2   week
    返回精选页
    语音输入    我想看前天的湖南卫视
    等待回看列表出现
    校验焦点是否在内容描述上  湖南卫视高清
    按次数右移  1
    校验焦点是否在内容描述上  ${2_days_ago}

case_012 回看未播出的节目
    [Documentation]  回看未播出的节目
    ${today}  get sys date  0   week
    ${tomorrow}    get sys date  1  date_1
    返回精选页
    语音输入    我想看明天的湖南卫视
    等待回看列表出现
    校验焦点是否在内容描述上  湖南卫视高清
    按次数右移  1
    校验焦点是否在内容描述上  今日

case_013 回看168小时前的节目
    [Documentation]  回看168小时前的节目
    ${today}  get sys date  0   week
    ${10_days_ago}    get sys date  -10  date_1
    ${10_days_ago_week}    get sys date  -10  week
    返回精选页
    语音输入    我想看10天前的湖南卫视
    等待回看列表出现
    校验焦点是否在内容描述上  湖南卫视高清
    按次数右移  1
    校验焦点是否在内容描述上  今日

case_014 回看快进指定时长
    [Documentation]  回看默认快进
    返回精选页
    语音输入    我想看昨天的湖南经视高清
    等待回看列表出现
    按次数右移  2    2
    确认键
    等待直播播放器出现
    语音输入  快进10分钟
    点播时移  600

case_015 回看快退指定时长
    [Documentation]  回看默认快退
    等待直播播放器出现
    语音输入  快退7分钟
    点播时移  180

case_016 回看默认快进
    [Documentation]  回看默认快进
    等待直播播放器出现
    语音输入  快进
    点播时移  210

case_017 回看默认快退
    [Documentation]  回看默认快进
    等待直播播放器出现
    语音输入  快退
    点播时移  180

case_018 回看暂停
    [Documentation]  回看默认快进
    等待直播播放器出现
    语音输入  暂停
    等待文本出现  继续播放

case_019 回看继续播放
    [Documentation]  回看默认快进
    等待文本出现  继续播放
    语音输入  暂停
    等待页面不出现文本信息  继续播放

case_020 语音回看
    [Documentation]  回看默认快进
    返回精选页
    语音输入    回看
    校验焦点是否在内容描述上  精选
#    等待回看列表出现




#直播快退
#直播快进
#搜索删除后的回看节目
#直播默认快退时间
#直播时移快进
#直播时移默认快进