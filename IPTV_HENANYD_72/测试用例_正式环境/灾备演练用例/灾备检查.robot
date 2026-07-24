*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../系统方法.robot

Suite Setup     run keywords  启动现网环境   AND   设置日志大小
Suite Teardown      退出应用
Test Teardown   打印设备日志

*** Test Cases ***
case_001首页分屏内容检查
    [Documentation]    首页分屏内容检查
    清空设备日志
    返回首页
    home键
    循环检查分屏内容加载情况
    按次数返回  1    5
    设备截屏

#首页分屏海报图片检查
点播详情页检查
    [Documentation]    点播详情页检查
    清空设备日志
    返回首页
    返回精选页
    执行命令  am start -d "mgtviptvburrow://vod/vod_detail_page?from=${platform_name}&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}"
    等待详情页出现
    等待文本出现  全屏
    等待文本出现  开通会员
    设备截屏
    详情页检查瀑布流

点播播控检查
    [Documentation]    点播播控检查
    清空设备日志
    返回精选页
    执行命令  am start -d "mgtviptvburrow://vod/vod_detail_page?from=${platform_name}&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}"
    等待详情页出现
    按次数左移  1
    确认键
    按秒快进  2
    按秒快退  2
    暂停键
    暂停恢复
    点播全屏播放浮层选集  2

搜索检查
    [Documentation]    搜索检查
    清空设备日志
    返回精选页
    按次数上移  2
    按键直到焦点位于内容描述上  搜索   右
    确认键
    等待搜索页出现
    搜索-输入搜索词  ZTA

明星页检查
    [Documentation]    明星页检查
    清空设备日志
    返回精选页
    执行命令  am start -d "mgtviptvburrow://star/star_page?from=${platform_name}&actionSourceId=${platform_name}&star_id=${打洞_明星ID}"
    等待明星页出现
    等待页面出现元素信息  ${明星作品分类}
    等待页面出现内容描述信息  张天爱
    设备截屏

频道直播播放检查
    [Documentation]    频道直播播放检查
    清空设备日志
    返回精选页
    数字键进直播  001
    等待直播播放器出现
    设备截屏

频道时移播放检查
    [Documentation]    频道时移播放检查
    清空设备日志
    等待直播播放器出现
    按秒快退  3
    设备截屏

频道回看播放检查
    [Documentation]    频道回看播放检查
    清空设备日志
    返回精选页
    执行命令  am start -d "mgtviptvburrow://live/play_back_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现元素信息  ${回看频道}    10
    设备截屏

短视频检查
    [Documentation]    短视频检查
    清空设备日志
    返回精选页
    执行命令  am start -d "mgtviptvburrow://short_video/short_video_player?from=${platform_name}&actionSourceId=${platform_name}&&topic_id=211&sub_topic_id=108&part_id=VRS123456"
    等待短视频主题页出现
    设备截屏

片库检查
    [Documentation]    片库检查
    清空设备日志
    返回精选页
    执行命令  am start -d "mgtviptvburrow://pianku/pianku_list_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现元素信息  ${片库搜索}    10
    设备截屏

专题检查
    [Documentation]    专题检查
    清空设备日志
    返回精选页
    执行命令  am start -d "mgtviptvburrow://subject/subject_page?from=${platform_name}&actionSourceId=${platform_name}&subject_id=${打洞_专题ID}"
    等待页面出现元素信息  ${专题内容区}    10
    设备截屏

我的页面检查
    [Documentation]    我的页面检查
    清空设备日志
    执行命令  am start -d "mgtviptvburrow://mine/mine_info?from=${platform_name}&actionSourceId=${platform_name}"
    等待我的页出现
    设备截屏

观看历史功能检查
    [Documentation]    观看历史功能检查
    清空设备日志
    到达首页观看记录入口
    设置本地映射  disable
    确认键
    等待页面出现元素信息  ${观看历史}
    清空观看历史
    设置本地映射  enable
    到达搜索入口
    确认键
    等待搜索页出现
    搜索-输入搜索词  FTFBZJMWJ
    点击搜索结果媒资  1
    确认键
    等待详情页出现
    等待  20
    到达首页观看记录入口
    设置本地映射  disable
    确认键
    等待页面出现元素信息  ${观看历史}
    校验内容描述出现次数  反贪风暴之加密危机     1
    设置本地映射  enable
    到达首页观看记录入口
    确认键
    等待页面出现元素信息  ${观看历史}
    设备截屏

媒资收藏功能检查
    [Documentation]    媒资收藏功能检查
    清空设备日志
    设置本地映射  enable
    到达我的页面入口
    确认键
    等待页面出现元素信息  ${版本信息}  10
    到达我的收藏全部记录入口
    设置本地映射  disable
    确认键
    等待页面出现元素信息  ${观看历史}
    清空观看历史
    设置本地映射  enable
    到达搜索入口
    确认键
    等待搜索页出现
    搜索-输入搜索词  FTFBZJMWJ
    点击搜索结果媒资  1
    确认键
    等待详情页出现
    按次数上移  3
    按次数右移  1
    确认键
    到达我的页面入口
    确认键
    等待页面出现元素信息  ${版本信息}  10
    到达我的收藏全部记录入口
    设置本地映射  disable
    确认键
    等待页面出现元素信息  ${观看历史}
    校验内容描述出现次数  反贪风暴之加密危机      1
    设置本地映射  enable
    设备截屏

专题收藏功能检查
    [Documentation]    媒资收藏功能检查
    清空设备日志
    到达首页观看记录入口
    设置本地映射  disable
    确认键
    等待页面出现元素信息  ${观看历史}
    按次数下移  2
    清空观看历史
    设置本地映射  enable
    返回首页
    返回精选页
    切换频道  电视剧
    点击内容描述  APK专题
    按次数上移  2
    确认键
    到达首页观看记录入口
    设置本地映射  disable
    确认键
    等待页面出现元素信息  ${观看历史}
    按次数下移  2
    ${count}=   run keyword if  'HNDX' not in '${project}'  set variable   1    ELSE    set variable   0
    校验内容描述出现次数    这些续集守护你的不老童心  ${count}
    设置本地映射  enable
    设备截屏

WEB页面检查
    [Documentation]    WEB页面检查
    清空设备日志
    返回精选页
    执行命令  am start -d "mgtviptvburrow://web/web_page??from=${platform_name}&actionSourceId=${platform_name}&url=${打洞_H5页面}"
    等待订购中心出现
    设备截屏

消息检查
    [Documentation]    消息检查
    清空设备日志
    返回精选页
    执行命令  am start -d "mgtviptvburrow://message/message_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现文本信息  全部消息    10
    设备截屏

即映检查
    [Documentation]    即映检查
    返回精选页
    执行命令  am start -d "mgtviptvburrow://immersion/immersion_page?from=${platform_name}&actionSourceId=${platform_name}&poolId=4"
    设备截屏

#选片大师页面检查
#子频道专题检查
#广告检查
#简约模式检查
#少儿模式检查
#爱奇艺媒资播放
#腾讯媒资播放
#酷喵媒资播放
#快乐看检查

