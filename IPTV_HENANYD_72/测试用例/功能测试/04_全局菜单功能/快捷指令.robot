*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../系统方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
case_001 详情页响应快捷指令
    [Documentation]     我的页面响应快捷指令
    返回精选页
    按次数下移  1
    确认键
    等待详情页出现
    数字输入进入快捷指令  1003
    等待我的页出现

case_002 跳转到我的
    [Documentation]     跳转到我的
    等待我的页出现

case_003 我的页面响应快捷指令
    [Documentation]     我的页面响应快捷指令
    等待我的页出现
    数字输入进入快捷指令  1013
    等待回看列表出现

case_004 跳转到回看展示界面
    [Documentation]     跳转到回看展示界面
    等待元素出现  ${回看频道}

case_005 回看页面响应快捷指令
    [Documentation]     回看页面响应快捷指令
    等待元素出现  ${回看频道}
    数字输入进入快捷指令  1010
    等待直播播放器出现

case_006 跳转到直播展示界面
    [Documentation]     跳转到直播展示界面
    等待直播播放器出现

case_007 跳转到播放器
    [Documentation]     跳转到播放器
    等待直播播放器出现

case_008 时移页面响应快捷指令
    [Documentation]     时移页面响应快捷指令
    等待直播播放器出现
    等待  5
    按秒快退  5
    数字输入进入快捷指令  1017
    等待专题出现

case_009 跳转到专题页面
    [Documentation]     跳转到专题页面
    等待专题出现

case_010 专题页面响应快捷指令
    [Documentation]     专题页面响应快捷指令
    等待专题出现
    数字输入进入快捷指令  1000
    等待订购中心出现

case_011 跳转到全屏Web页面
    [Documentation]     跳转到全屏Web页面
    等待订购中心出现

case_012 会员订购页面不响应快捷指令
    [Documentation]     会员订购页面响应快捷指令
    等待订购中心出现
    数字输入进入快捷指令  1002
    等待订购中心出现
    返回精选页
    数字输入进入快捷指令  1002
    等待搜索页出现

case_013 跳转到搜索
    [Documentation]     跳转到搜索
    等待搜索页出现

case_014 搜索页面响应快捷指令
    [Documentation]     搜索页面响应快捷指令
    等待搜索页出现
    run keyword if  'HNDX' in '${project}'  按次数返回  1    3
    数字输入进入快捷指令  1023
    等待观看历史页出现

case_015 跳转到播放记录
    [Documentation]     跳转到播放记录
    等待观看历史页出现

case_016 跳转到我的二级页面
    [Documentation]     跳转到我的二级页面
    等待观看历史页出现

case_017 播放记录响应快捷指令
    [Documentation]     播放记录响应快捷指令
    等待观看历史页出现
    数字输入进入快捷指令  1006
    等待元素出现  ${九屏同看_频道}
    等待  5

case_018 跳转到九屏同看
    [Documentation]     跳转到九屏同看
    等待元素出现  ${九屏同看_频道}

case_019 九屏同看响应快捷指令
    [Documentation]     九屏同看响应快捷指令
    等待元素出现  ${九屏同看_频道}
    数字输入进入快捷指令  1009
    等待页面出现文本信息  未读消息

case_020 跳转到消息系统
    [Documentation]     跳转到消息系统
    等待页面出现文本信息  未读消息

case_021 消息系统响应快捷指令
    [Documentation]     消息系统响应快捷指令
    等待页面出现文本信息  未读消息
    数字输入进入快捷指令  1008
    run keyword if  'HNDX' not in '${project}'  等待页面出现内容描述信息  管理收藏频道
    run keyword if  'HNDX' in '${project}'  等待页面出现内容描述信息  添加/取消收藏

case_022 跳转到直播收藏
    [Documentation]     消息系统响应快捷指令
    run keyword if  'HNDX' not in '${project}'  等待页面出现内容描述信息  管理收藏频道
    run keyword if  'HNDX' in '${project}'  等待页面出现内容描述信息  添加/取消收藏

case_023 直播收藏页面响应快捷指令
    [Documentation]     直播收藏页面响应快捷指令
    数字输入进入快捷指令  1015
    等待元素出现  ${时尚版}

case_024 跳转到切换版本
    [Documentation]     跳转到切换版本
    等待元素出现  ${时尚版}

case_025 切换模式页面响应快捷指令
    [Documentation]     切换模式页面响应快捷指令
    等待元素出现  ${时尚版}
    数字输入进入快捷指令  1018
    等待片库内容出现

case_026 跳转到列表页
    [Documentation]     跳转到列表页
    等待片库内容出现

case_027 片库响应快捷指令
    [Documentation]     片库响应快捷指令
    等待片库内容出现
    数字输入进入快捷指令  1020
    等待元素出现  ${会员片库标题}

case_028 跳转到会员片库
    [Documentation]     跳转到会员片库
    等待元素出现  ${会员片库标题}

case_029 会员片库响应快捷指令
    [Documentation]     片库响应快捷指令
    等待元素出现  ${会员片库标题}
    数字输入进入快捷指令  1021
    等待明星页出现

case_030 跳转到明星详情页
    [Documentation]     跳转到会员片库
    等待明星页出现

case_031 明星详情页响应快捷指令
    [Documentation]     片库响应快捷指令
    等待明星页出现
    数字输入进入快捷指令  1001
    等待详情页出现

case_032 跳转到详情页
    [Documentation]     跳转到详情页
    等待详情页出现

case_033 跳转到小视频选择播放
    [Documentation]     跳转到小视频选择播放
    等待详情页出现

case_034 跳转到小视频自动播放
    [Documentation]     跳转到小视频自动播放
    等待详情页出现

case_035 全局菜单页面响应快捷指令
    [Documentation]     全局菜单页面响应快捷指令
    log to console  用例已废除

case_036 跳转到我的收藏
    [Documentation]     跳转到我的收藏
    数字输入进入快捷指令  1005
    等待观看历史页出现
    校验焦点是否在内容描述上  节目收藏

case_037 跳转到问题反馈
    [Documentation]     跳转到问题反馈
    数字输入进入快捷指令  1004
    等待文本出现  问题反馈

case_038 跳转到设置界面
    [Documentation]     跳转到设置界面
    数字输入进入快捷指令  1011
    等待文本出现  设置

case_039 跳转到模板页面
    [Documentation]     跳转到模板页面
    数字输入进入快捷指令  1012
    等待页面出现内容描述信息  选片大师独立页面   20
    校验焦点是否在内容描述上  综艺

case_040 跳转到顶部
    [Documentation]     跳转到顶部
    数字输入进入快捷指令  1016

case_041 跳转到排行榜
    [Documentation]     跳转到排行榜
    数字输入进入快捷指令  1001

case_042 快捷指令跳转延时1000ms
    [Documentation]     跳转到排行榜
    输入数字  1004  0
    校验元素文本出现的次数  问题反馈   0   0
    等待  2
    校验元素文本出现的次数  问题反馈   1

case_043 快捷指令输入口按OK键跳转
    [Documentation]     跳转到排行榜
    输入数字  1021
    确认键  1
    等待明星页出现