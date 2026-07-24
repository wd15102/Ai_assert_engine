*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../系统方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
case_001 首页/桌面键值检查
    [Documentation]    首页/桌面键值检查
    [Tags]  smoke
    返回首页
    返回精选页
    点击元素  ${试看电影}
    等待页面出现元素信息  ${详情页收藏}
    home键
    等待页面出现元素信息  ${首页logo}
    到达搜索入口
    确认键
    等待  5
    等待搜索页出现
    home键
    等待页面出现元素信息  ${首页logo}

case_010 首页默认分屏按首页键刷新
    [Documentation]    首页默认分屏按首页键刷新
    等待页面出现元素信息  ${首页logo}
    等待元素出现  ${免费电影}
    清除历史上报数据
    home键
    获取校验结果  {'logtype':'pv'}    test_001    ${datatable_prefix_apk}_pv

case_002 返回键键值检查
    [Documentation]    返回键键值检查
    [Tags]  smoke
    返回首页
    返回精选页
    点击元素  ${试看电影}
    等待页面出现元素信息  ${详情页收藏}
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    到达搜索入口
    确认键
    等待  5
    等待搜索页出现
    按次数返回  1
    等待页面出现元素信息  ${首页logo}

case_003 系统设置键键值检查
    [Documentation]    系统设置键键值检查
    返回首页
    返回精选页
    设置键
    等待页面出现元素信息  ${设置区}
    等待页面不出现元素信息  ${首页logo}
    home键
    等待页面出现元素信息  ${首页logo}

case_004 数字键键值检查
    [Documentation]    数字键键值检查
    返回首页
    返回精选页
    数字键进直播  002
    确认键
    等待页面不出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  湖南经视高清

case_011 直播页按同频道数字键不刷新
    [Documentation]    直播页按同频道数字键不刷新
    清除历史上报数据
    数字键进直播  002
    获取校验结果_不上报  {'logtype':'pv'}    test_051    ${datatable_prefix_apk}_pv

case_012 直播页按直播键不刷新
    [Documentation]    直播页按直播键不刷新
    清除历史上报数据
    F1键
    获取校验结果_不上报  {'logtype':'pv'}    test_051    ${datatable_prefix_apk}_pv

case_005 频道+/-键键值检查
    [Documentation]    频道+/-键键值检查
    等待  8
    确认键
    校验焦点是否在内容描述上  湖南经视高清
    等待  8
    频道-
    确认键
    校验焦点是否在内容描述上  湖南卫视高清
    等待  8
    频道+
    确认键
    校验焦点是否在内容描述上  湖南经视高清

case_006 快进/快退键值检查
    [Documentation]    快进/快退键值检查
    返回首页
    返回精选页
    按秒快进  5
    等待  5
    校验焦点是否在内容描述上  播放模块推荐
    按秒快退  5
    等待  5
    校验焦点是否在内容描述上_模糊匹配  ${最左侧分屏}

case_007 暂停/播放键键值检查
    [Documentation]    暂停/播放键键值检查
    返回首页
    返回精选页
    到达免费电影入口
    确认键  5
    确认键  5
    暂停键
    校验元素文本出现的次数  继续播放   1

case_008 菜单键键值检查
    [Documentation]    菜单键键值检查
    返回首页
    返回精选页
    菜单键
    等待页面出现元素信息  ${全局菜单精选}
    点击元素  ${全局菜单精选}
    等待页面不出现元素信息  ${全局菜单精选}

case_009 上/下页键值检查
    [Documentation]    上/下页键值检查
    返回首页
    返回精选页
    返回键
    向下
    校验焦点是否在内容描述上  免费电影-惊天破
    按次数下移  10
    校验内容描述出现次数  免费电影-惊天破    0
    按次数上移  10
    校验内容描述出现次数  免费电影-惊天破    1

case_013 回看页按回看键不刷新
    [Documentation]    回看页按回看键不刷新
    run keyword if  'HNYD' not in '${project}'  绿键
    run keyword if  'HNYD' in '${project}'  F2键
    等待回看列表出现
    清除历史上报数据
    run keyword if  'HNYD' not in '${project}'  绿键
    run keyword if  'HNYD' in '${project}'  F2键
    获取校验结果_不上报  {'logtype':'pv'}    test_041    ${datatable_prefix_apk}_pv
