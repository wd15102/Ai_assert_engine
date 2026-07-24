*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../../系统方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
case_001 打洞到点播详情页
    [Documentation]    打洞框架
    返回首页
    返回精选页
    执行命令  am start -d "mgtviptvburrow://vod/vod_detail_page?from=${platform_name}&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}"
    等待详情页出现
    详情页退出
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_002 打洞到点播详情页指定分集
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://vod/vod_detail_page?from=${platform_name}&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}&playIndex=3"
    等待详情页出现
    按次数下移  1
    校验焦点是否在内容描述上  3
    详情页退出
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_003 打洞到点播详情页screenModel=0
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://vod/vod_detail_page?from=${platform_name}&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}&screenModel=0"
    等待详情页出现
    详情页退出
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_004 打洞到点播详情页指定分集screenModel=0
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://vod/vod_detail_page?from=${platform_name}&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}&playIndex=3&screenModel=0"
    等待详情页出现
    按次数下移  1
    校验焦点是否在内容描述上  3
    详情页退出
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_005 打洞到点播全屏页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://vod/vod_detail_page?from=com.mg.testjump&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}&screenModel=1"
    等待页面出现元素信息  ${点播全屏播放器}    10
    播放退出
    详情页退出
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_006 打洞到点播全屏页指定分集
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://vod/vod_detail_page?from=com.mg.testjump&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}&playIndex=3&screenModel=1"
    等待页面出现元素信息  ${点播全屏播放器}    10
    按次数右移  1    5
    向下  1
    校验焦点是否在内容描述上  3  10
    播放退出
    详情页退出
    校验焦点是否在内容描述上  精选

case_007 打洞到搜索页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://search/search_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现元素信息  ${搜索键盘区}    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_008 打洞到片库页默认栏目
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://pianku/pianku_list_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现元素信息  ${片库搜索}    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_009 打洞到片库页指定一级栏目
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://pianku/pianku_list_page?from=${platform_name}&actionSourceId=${platform_name}&rootCategoryId=${打洞_片库一级ID}"
    等待页面出现元素信息  ${片库搜索}    10
    校验元素文本出现的次数  电视剧    1
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_010 打洞到片库页指定二级栏目
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://pianku/pianku_list_page?from=${platform_name}&actionSourceId=${platform_name}&rootCategoryId=${打洞_片库一级ID}&categoryId=${打洞_片库二级ID}"
    等待页面出现元素信息  ${片库搜索}    10
    校验内容描述出现次数  警匪战争   1
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_011 打洞到播放历史页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://mine/record_detail_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现元素信息  ${观看历史}    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_012 打洞到播放历史页tabPos=1
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://mine/record_detail_page?from=${platform_name}&actionSourceId=${platform_name}&tabPos=1"
    等待页面出现元素信息  ${观看历史}    10
    校验焦点是否在文本上  观看历史
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_013 打洞到节目收藏页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://mine/record_detail_page?from=${platform_name}&actionSourceId=${platform_name}&tabPos=3"
    等待页面出现元素信息  ${观看历史}    10
    校验焦点是否在文本上  节目收藏
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_014 打洞到专题收藏页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://mine/record_detail_page?from=${platform_name}&actionSourceId=${platform_name}&tabPos=4"
    等待页面出现元素信息  ${观看历史}    10
    校验焦点是否在文本上  专题收藏
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_015 打洞到H5页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://web/web_page??from=${platform_name}&actionSourceId=${platform_name}&url=${打洞_H5页面}"
    等待页面出现元素信息  ${订购中心}    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_016 打洞到首页频道
    [Documentation]    打洞框架
    到达搜索入口
    确认键
    等待页面出现元素信息  ${搜索键盘区}    10
    执行命令  am start -d "mgtviptvburrow://channel/channel_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现元素信息  ${首页logo}

case_017 打洞到首页指定频道
    [Documentation]    打洞框架
    到达搜索入口
    确认键
    等待页面出现元素信息  ${搜索键盘区}    10
    执行命令  am start -d "mgtviptvburrow://channel/channel_page?from=${platform_name}&actionSourceId=${platform_name}&bindInstanceId=jingxuan_6.0"
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_018 打洞到不存在的频道
    [Documentation]    打洞框架
    到达搜索入口
    确认键
    等待页面出现元素信息  ${搜索键盘区}    10
    执行命令  am start -d "mgtviptvburrow://channel/channel_page?from=${platform_name}&actionSourceId=${platform_name}&bindInstanceId=jingxuanxxx"
    等待页面出现元素信息  ${首页logo}
    等待页面出现元素信息  ${免费电影}

case_019 打洞到我的页面
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://mine/mine_info?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现元素信息  ${版本信息}    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_020 打洞到用户反馈页面
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://feedback/feedback_list?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现文本信息  问题反馈    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_021 打洞到会员卡兑换页面
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://mine/exchange_card_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现文本信息  会员卡激活    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_022 打洞到绑定手机页面
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://settings/settings_bindphone?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现文本信息  绑定手机号    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_023 打洞到绑定微信页面
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://mine/weChat_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现文本信息  绑定微信    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_024 打洞到会员片库页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://pianku/vippianku_list_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现文本信息  会员片库    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_025 打洞到直播页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://live/live_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现元素信息  ${直播播放器}  10
    等待  5
    播放退出
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_026 打洞到指定直播频道
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://live/live_page?from=${platform_name}&actionSourceId=${platform_name}&channelId=${打洞_直播频道}"
    等待文本出现  湖南经视高清
    等待元素出现  ${直播播放器}
    播放退出
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_027 打洞到回看页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://live/play_back_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现元素信息  ${回看频道}    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_028 打洞到指定回看频道
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://live/play_back_page?from=${platform_name}&actionSourceId=${platform_name}&channelId=${打洞_直播频道}"
    等待页面出现元素信息  ${回看频道}    10
    校验内容描述出现次数  湖南经视高清   1
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_029 打洞到原生专题
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://subject/subject_page?from=${platform_name}&actionSourceId=${platform_name}&subject_id=${打洞_专题ID}"
    等待页面出现元素信息  ${专题内容区}    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

#case_030 打洞到web专题
#    [Documentation]    打洞框架
#    log to console  暂无WEB专题
#    返回首页
#    返回精选页
#    执行命令  am start -d "mgtviptvburrow://subject/web_subject_page?from=${platform_name}&actionSourceId=${platform_name}&subject_id=201"
#    等待页面出现元素信息  ${详情页收藏}    10
#    按次数下移  2
#    校验焦点是否在内容描述上  3
#    按次数返回  1
#    等待页面出现元素信息  ${首页logo}
#    校验焦点是否在内容描述上  精选
#
#case_031 打洞到收银台
#    [Documentation]    打洞框架
#    log to console  暂无法跳转
#    返回首页
#    返回精选页
#    执行命令  am start -a android.intent.action.MAIN -d 'mgtviptvburrow://mine/order_page?from=123&actionSourceId=Telecom&url=product_list=%7B%22source%22%3A%2211%22%2C%22video_id%22%3Anull%2C%22video_name%22%3Anull%2C%22video_type%22%3Anull%2C%22product_id%22am start -a android.intent.action.MAIN -d 'mgtviptvburrow://mine/order_page?from=123&actionSourceId=Telecom&url=product_list=%7B%22source%22%3A%2211%22%2C%22video_id%22%3Anull%2C%22video_name%22%3Anull%2C%22video_type%22%3Anull%2C%22product_id%22%3A%22318%2C3774%22%2C%22back_url%22%3A%22http%3A%2F%2F10.255.1.195%3A25603%2FAPI_UBP%2Forder%2Fhunan%2Fct%2Fcallback%2F123456%22%7D'
#    等待页面出现元素信息  ${详情页收藏}    10
#    按次数下移  2
#    校验焦点是否在内容描述上  3
#    按次数返回  1
#    等待页面出现元素信息  ${首页logo}
#    校验焦点是否在内容描述上  精选

case_032 打洞到用户反馈结果
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://feedback/feedback_result?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现文本信息  反馈成功    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_033 打洞到明星页
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://star/star_page?from=${platform_name}&actionSourceId=${platform_name}&star_id=${打洞_明星ID}"
    等待页面出现元素信息  ${明星作品分类}    10
    等待页面出现内容描述信息  张天爱
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_034 打洞到消息
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://message/message_page?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现文本信息  全部消息    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_035 打洞到设置
    [Documentation]    打洞框架
    返回精选页
    执行命令  am start -d "mgtviptvburrow://settings/settings_list?from=${platform_name}&actionSourceId=${platform_name}"
    等待页面出现文本信息  设置    10
    按次数返回  1
    等待页面出现元素信息  ${首页logo}
    校验焦点是否在内容描述上  精选

case_036 web打洞到全屏播放后返回
    [Documentation]    打洞框架
    到达开通会员入口
    确认键  5
    等待页面出现元素信息  ${订购中心}  10
    执行命令    am start -d "mgtviptvburrow://vod/vod_detail_page?from=com.mg.testjump&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}&screenModel=1"
    等待页面出现元素信息  ${点播全屏播放器}    10
    播放退出
    详情页退出
    等待页面出现元素信息  ${订购中心}  10

case_037 打洞到全屏播放后返回，无小窗
    [Documentation]    打洞框架
    到达开通会员入口
    确认键  5
    等待页面出现元素信息  ${订购中心}  10
    执行命令    am start -d "mgtviptvburrow://vod/vod_detail_page?from=${platform_name}&actionSourceId=${platform_name}&seriesId=${打洞_媒资ID}&screenModel=1"
    等待页面出现元素信息  ${点播全屏播放器}    10
    播放退出
    等待页面出现元素信息  ${订购中心}  10