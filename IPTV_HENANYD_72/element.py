#!/usr/bin/env python
# -*- coding: utf-8 -*-
from config import project
from config import app_package
from config import plugin_apk


#全局
当前焦点 = '//*[@focused="true" and @focusable="true"]'
platform_time = 'IPTV_HENANYD'  if 'henanyd' in project.lower() else 'IPTV_HNYD_OTT'  if 'ott' in project.lower() else  'IPTV_HNYD'
platform_name = 'Telecom'  if 'hndx' in project.lower() else  'liantong'  if 'hnlt' in project.lower() else  'yidong'
app_package1 = app_package if plugin_apk==0 else app_package+'.plugin'
noReset = bool('flase') if plugin_apk==0 else bool('true')
首页分屏 = app_package1 + ':id/tab'
咪咕政企 = '//*[@content-desc="切换平台"]'

#设置
# 设置区 = 'com.shcmcc.setting:id/rl_main_settings_home'       #M301A
设置区 = "//*[contains(@text,'请输入设置密码')]" if 'hndx' in project.lower() else 'com.shcmcc.setting:id/setting_main_1'       #MGV2000
# 设置区 = 'com.android.smart.terminal.settings:id/wifiactivity_isconn_btn_conn'     #杰赛

# 首页
# 精选分屏
首页logo = app_package1 + ':id/top_menu_view'
导航栏 = app_package1 + ':id/channel_tabs'
精选直播 = app_package1 + ':id/function_btn_first_view'
精选回看 = app_package1 + ':id/function_btn_second_view'
精选观看历史 = app_package1 + ':id/function_new_history'
精选 = 'accessibility_id=精选'
内容框 = app_package1 + ':id/content'
免费电影 = 'xpath=//android.view.View[contains(@content-desc,\'免费电影\')]'
试看电影 = 'xpath=//android.view.View[contains(@content-desc,\'试看电影\')]'
付费电影 = 'xpath=//android.view.View[contains(@content-desc,\'付费电影\')]'
免费电视剧 = 'xpath=//android.view.View[contains(@content-desc,\'免费电视剧\')]'
付费电视剧 = 'xpath=//android.view.View[contains(@content-desc,\'付费电视剧\')]'
试看综艺 = 'xpath=//android.view.View[contains(@content-desc,\'试看综艺\')]'
免费综艺 = 'xpath=//android.view.View[contains(@content-desc,\'免费综艺\')]'
付费综艺 = 'xpath=//android.view.View[contains(@content-desc,\'付费综艺\')]'
观看记录 = app_package1 + ':id/history_entrance'
搜索 = '//android.view.View[contains(@content-desc,\'搜索\')]'
回到顶部 = app_package1 + ':id/btn_back_top_top'
搜索更多 = app_package1 + ':id/btn_search_more'
pathch信息 = app_package1 + ':id/title_patch_info'
少儿模板功能位一 = app_package1 + ':id/child_template_first_view'
少儿模板功能位二 = app_package1 + ':id/child_template_second_view'
启动焦点 = '精选' if 'hndx' in project.lower() else '精选'
顶部通栏 = '//*[@resource-id="' + app_package1 + ':id/fashion_channels"]/../android.widget.ImageView'
大IP模板推荐位 = app_package1 + ':id/emphasis_other_data'
大IP模板推荐位一 = '//*[@resource-id="' + app_package1 + ':id/emphasis_other_data"]/android.view.View[@index="0"]'
大IP模板推荐位五 = '//*[@resource-id="' + app_package1 + ':id/emphasis_other_data"]/android.view.View[@index="4"]'
大IP模板播放窗 = app_package1 + ':id/emphasis_content_focus'
会员模板功能位一 = app_package1 + ':id/first_entrance'
会员模板功能位二 = app_package1 + ':id/second_entrance'
会员模板功能位三 = app_package1 + ':id/third_entrance'
播放列表左侧功能位一 = app_package1 + ':id/live_side_item_1'
播放列表左侧功能位二 = app_package1 + ':id/live_side_item_2'
播放列表左侧功能位六 = app_package1 + ':id/live_side_item_6'
播放列表播放窗 = app_package1 + ':id/focus_view'
播放列表右侧播放位一 = app_package1 + ':id/play_list_indicator_item_1'
播放列表右侧播放位二 = app_package1 + ':id/play_list_indicator_item_2'
播放列表右侧播放位五 = app_package1 + ':id/play_list_indicator_item_5'
播放列表右侧播放位六 = app_package1 + ':id/play_list_indicator_item_6'
播放列表右侧播放位七 = app_package1 + ':id/play_list_indicator_item_7'
应用快捷入口_管理应用 = '//androidx.recyclerview.widget.RecyclerView[1]/android.view.View[@index="0"]'
应用快捷入口_第一个应用 = '//androidx.recyclerview.widget.RecyclerView[1]/android.view.View[@index="1"]'
应用快捷入口_第二个应用 = '//androidx.recyclerview.widget.RecyclerView[1]/android.view.View[@index="2"]'
应用快捷入口_第三个应用 = '//androidx.recyclerview.widget.RecyclerView[1]/android.view.View[@index="3"]'
应用快捷入口_第四个应用 = '//androidx.recyclerview.widget.RecyclerView[1]/android.view.View[@index="4"]'

# 直播分屏
直播小窗播放器 = app_package1 + ':id/focus_view'
# 直播小窗口正在播放的节目 =
回看 = 'xpath=//android.view.View[@content-desc="回看"]'
湖南卫视 = app_package1 + ':id/live_right_item_1'
北京卫视 = app_package1 + ':id/live_right_item_2'
湖南公共 = app_package1 + ':id/live_right_item_4'
安徽卫视 = app_package1 + ':id/live_right_item_5'

#电视剧分屏
二维码通栏 = app_package1 + ':id/qrcode_bg_view'
二维码 = app_package1 + ':id/qrcode_view'

#电影分屏
沉浸式闪图功能键 = app_package1 + ':id/promotion_info_view'
闪图播放器 = '//*[@resource-id="' + app_package1 + ':id/fashion_channels"]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.view.View[1]'

#少儿分屏
通栏标题 = '//*[@resource-id="' + app_package1 + ':id/title_container"]'

#测试分屏
# 闪图自动播放 = 'xpath=//android.view.View[@content-desc="即将自动播放"]'
闪图自动播放 = '//*[@resource-id="' + app_package1 + ':id/content"]//android.widget.FrameLayout/android.widget.FrameLayout[2]/android.view.View[1]'

# 全局菜单
全局菜单精选 = '//*[@resource-id="' + app_package1 + ':id/golbal_menu_item" and @content-desc="精选"]'
全局菜单直播 = '//*[@resource-id="' + app_package1 + ':id/golbal_menu_item" and @content-desc="直播"]'
全局菜单回看 = '//*[@resource-id="' + app_package1 + ':id/golbal_menu_item" and @content-desc="回看"]'
全局菜单搜索 = '//*[@resource-id="' + app_package1 + ':id/golbal_menu_item" and @content-desc="搜索"]'
全局菜单历史记录 = '//*[@resource-id="' + app_package1 + ':id/golbal_menu_item" and @content-desc="历史记录"]'

# 回看列表
回看频道 = app_package1 + ':id/id_playback_channel_rv'
回看节目 = app_package1 + ':id/id_playback_bill_rv' if 'hndx' in project.lower() else app_package1 + ':id/id_mgplayer_playbill_content'
回看第一个节目 = '//*[@resource-id="' + app_package1 + ':id/id_playback_bill_rv"]/android.view.View[@index="0"]'
回看第二个节目 = '//*[@resource-id="' + app_package1 + ':id/id_playback_bill_rv"]/android.view.View[@index="1"]'
回看列表回看节目 = app_package1 + ':id/play_back_playbill_item_content'
回看隐藏条 = app_package1 + ':id/id_iv_bill_hide'

# 直播播放器
直播播放器 = app_package1 + ':id/live_prj_video_player_view'
回看图标 = app_package1 + ':id/loft_live_play_type_icon'
时移图标 = app_package1 + ':id/loft_live_play_type_icon'
推荐图 = app_package1 + ':id/sdk_template_task_reminder_container_ll'
今日 = 'accessibility_id=今日'
回看浮层='//*[@resource-id="' + app_package1 + ':id/rl_root"]/android.widget.FrameLayout[1]'
全部 = 'accessibility_id=全部'
退出 = app_package1 + ':id/ad_dialog_right_btn'
试看结束 = app_package1 + ':id/live_preview_view_order_hint_stv'
回看列表直播节目 = '//*[@resource-id="' + app_package1 + ':id/id_playback_bill_rv"]/android.widget.RelativeLayout[last()]'
退出播放 = app_package1 + ':id/ad_dialog_right_btn'
直播暂停图标 = app_package1 + ':id/sdk_player_framework_play_state'
浮层向右提示 = '//*[@resource-id="' + app_package1 + ':id/live_prj_video_player_view"]/../../android.widget.FrameLayout/android.view.View'
浮层向左提示 = '//*[@resource-id="' + app_package1 + ':id/live_prj_video_player_view"]/../../android.widget.FrameLayout/android.view.View'
直播当前时间 = '//*[@resource-id="' + app_package1 + ':id/loft_live_play_info_head_time"]'
时移开始时间 = '//*[@resource-id="' + app_package1 + ':id/sdk_player_framework_current_play_time"]'
时移结束时间 = '//*[@resource-id="' + app_package1 + ':id/sdk_player_framework_total_play_time"]'
直播频道向下切换 = '上' if 'hnlt' in project.lower() else '上' if 'hndx' in project.lower() else '下'
直播频道向上切换 = '下' if 'hnlt' in project.lower() else '下' if 'hndx' in project.lower() else '上'
直播暂停 = app_package1 + ':id/live_pause_icon'
直播列表 = app_package1 + ':id/iptv_liveprj_civ_live'
播控信息 = app_package1 + ':id/loft_live_play_info_head_live'
为您推荐 = '精彩推荐' if 'hndx' in project.lower() else '为您推荐'
直播推荐最后一个媒资 = '秋香' if 'hndx' in project.lower() else '超能陆战队'

# 九屏同看
九屏同看 = app_package1 + ':id/live_nine_recycler'
九屏同看_频道 = '//*[@resource-id="' + app_package1 + ':id/live_nine_recycler_item"]'
九屏同看_频道一 = '//*[@resource-id="' + app_package1 + ':id/live_nine_recycler_item" and @index=0]'
九屏同看_频道二 = '//*[@resource-id="' + app_package1 + ':id/live_nine_recycler_item" and @index=1]'
九屏同看_频道三 = '//*[@resource-id="' + app_package1 + ':id/live_nine_recycler_item" and @index=2]'
九屏同看_频道四 = '//*[@resource-id="' + app_package1 + ':id/live_nine_recycler_item" and @index=3]'
九屏同看_频道九 = '//*[@resource-id="' + app_package1 + ':id/live_nine_recycler_item" and @index=8]'

# 片库
片库列表 = app_package1 + ':id/iptv_pianku_detail_category_rlv'
片库搜索 = '//*[@resource-id="' + app_package1 + ':id/iptv_pianku_top_menu_view"]/android.view.View[@content-desc="搜索"]'
片库筛选 = app_package1 + ':id/iptv_pianku_detail_select_item_view'
片库影片区 = app_package1 + ':id/iptv_pianku_video_list_rlv'
片库分类区 = app_package1 + ':id/iptv_pianku_all_category_rlv'
片库向左图标 = app_package1 + ':id/iptv_pianku_left_shade_view'
片库第一个栏目 = '//*[@resource-id="' + app_package1 + ':id/iptv_pianku_detail_category_rlv"]/android.view.View[@index="0"]'
片库第二个栏目 = '//*[@resource-id="' + app_package1 + ':id/iptv_pianku_detail_category_rlv"]/android.view.View[@index="1"]'
筛选第一条件区 = '//*[@resource-id="' + app_package1 + ':id/iptv_pianku_select_rlv"]/androidx.recyclerview.widget.RecyclerView[1]'
筛选第二条件区 = '//*[@resource-id="' + app_package1 + ':id/iptv_pianku_select_rlv"]/androidx.recyclerview.widget.RecyclerView[2]'

# 搜索
搜索结果 = app_package1 + ':id/search_result_count_tv'
搜索为空 = app_package1 + ':id/search_empty_tip'
搜索推荐 = app_package1 + ':id/search_result_tab_title'
搜索全空 = app_package1 + ':id/search_default_tv'
清空搜索 = 'xpath=//android.widget.TextView[contains(@text,\'清空\')]'
删除搜索 = 'xpath=//android.widget.TextView[contains(@text,\'删除\')]'
全键盘 = app_package1 + ':id/search_switch_full_btn'
九宫格 = app_package1 + ':id/search_switch_t9_btn'
清空历史 = app_package1 + ':id/search_history_clear_btn'
搜索历史第一位 = '//*[@resource-id="' + app_package1 + ':id/search_history_recycler_view"]/android.widget.TextView[1]'
语音遥控 = app_package1 + ':id/search_bot_text'
搜索框为空 = app_package1 + ':id/search_notice_txt'
搜索框 = app_package1 + ':id/search_edit_text'
搜索区 = app_package1 + ':id/searchboard_input_parent'
搜索清除功能区 = app_package1 + ':id/search_input_operator_layout'
搜索键盘区 = app_package1 + ':id/input_keyboard_fragment'
搜索切换区 = app_package1 + ':id/search_switch_layout'
搜索媒资区 = app_package1 + ':id/search_media_recycler_view'
搜索历史区 = app_package1 + ':id/search_top_layout'
搜索结果区 = app_package1 + ':id/search_result_panel'
搜索分类区 = app_package1 + ':id/search_tab_recycler_view'
搜索全键盘 = app_package1 + ':id/full_keyboard_gridview'
搜索T9键盘 = app_package1 + ':id/t9_keyboard_gridview'
搜索键盘_5 = '//*[@resource-id="' + app_package1 + ':id/t9_keyboard_gridview"]/android.widget.RelativeLayout[@index=\'4\']'
九宫格展开 = '//*[@resource-id="' + app_package1 + ':id/t9_keyboard_layout"]/android.widget.RelativeLayout[1]/android.widget.RelativeLayout'
搜索媒资海报 = app_package1 + ':id/media_item_view'
搜索媒资标题 = app_package1 + ':id/media_item_view'
搜索全部分类 = '//android.widget.TextView[@text=\'全部\']/parent::*'
搜索电影分类 = '//android.widget.TextView[@text=\'电影\']/parent::*'

#视频搜索结果页
视频搜索结果列表 = app_package1 + ':id/video_list_rv'

# 详情页
小视频窗 = app_package1 + ':id/sdk_player_framework_play_state'
点播小窗进度条 = app_package1 + ':id/vod_detail_small_seekbar'
点播当前播放时间 = '//*[@resource-id="' + app_package1 + ':id/sdk_player_framework_current_play_time"]'
点播总时长 = '//*[@resource-id="' + app_package1 + ':id/sdk_player_framework_total_play_time"]'
点播全屏状态 = app_package1 + ':id/full_play_state'
全屏 = app_package1 + ':id/vod_small_vod_button_fullscreen_view'
购买 = app_package1 + ':id/vod_small_split_vod_button_buy_view' if 'hndx' in project.lower() else app_package1 + ':id/vod_small_split_vod_button_buy_view'
加入播放 = app_package1 + ':id/vod_small_vod_button_play_list'
详情页顶部菜单 = app_package1 + ':id/vod_detail_top_menu_view'
剧集列表 = "//*[@resource-id='" + app_package1 + ":id/vod_series_rlv']/*[@index='{}']"
剧集列表_1 = '//*[@resource-id="' + app_package1 + ':id/vod_series_rlv"]/android.view.View[@index=\'0\']'
电视剧第1集 = '//android.view.View[@content-desc=\'1\']'
全部剧集 = 'xpath=//*[@resource-id="' + app_package1 + ':id/vod_series_section_rlv"]/android.view.View[@index=\'0\']'
全部剧集_1 = 'xpath=//*[@resource-id="' + app_package1 + ':id/vod_series_section_rlv"]/android.view.View[@index=\'1\']'
全部剧集_具体剧集 = 'xpath=//*[@resource-id="' + app_package1 + ':id/vod_all_series_dialog_rlv"]/android.view.View[@index=\'{}\']'
全部剧集页面_1 = 'xpath=//*[@resource-id="' + app_package1 + ':id/vod_all_series_dialog_rlv"]/android.view.View[@index=\'0\']'
全屏剧集列表浮层_1 = '//*[@resource-id="' + app_package1 + ':id/vodplayer_dynamic_setting_item_title_selected" and @text="选集"]/../../android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.support.v7.widget.RecyclerView[1]/android.view.View[@index=\'0\']'
全屏全部剧集浮层_1 = '//*[@resource-id="' + app_package1 + ':id/vodplayer_dynamic_setting_item_title_selected" and @text="选集"]/../../android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.support.v7.widget.RecyclerView[2]/android.view.View[@index=\'0\']'
全屏花絮看点浮层_1 = '//*[@resource-id="' + app_package1 + ':id/vodplayer_dynamic_setting_item_title_selected" and @text="片花"]/../../android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.support.v7.widget.RecyclerView[1]/android.view.View[@index=\'0\']'
绯闻计划 = 'accessibility_id=绯闻计划'
血色蔷薇 = 'accessibility_id=血色蔷薇'
选集 = app_package1 + ':id/iptv_vod_series_tab_item_title'
花絮 = '//*[@resource-id="' + app_package1 + ':id/iptv_vod_series_tab_item_title" and @text="片花"]'
影片名 = app_package1 + ':id/vod_small_view_film_name_tv'
正在试看 = app_package1 + ':id/vod_full_trying_order_text'
媒资详情 = app_package1 + ':id/vod_small_info_more'
详情页广告 = app_package1 + ':id/vod_small_vod_image_first_view'
详情页推广 = app_package1 + ':id/vod_small_vod_image_second_view'
详情页收藏 = app_package1 + ':id/vod_small_collect_view'
详情页选集区域 = app_package1 + ':id/vod_series_full_bottom_layout'
详情页退出挽留 = app_package1 + ':id/vod_retain_rv'
详情页toast提示 = '//*[@resource-id="' + app_package1 + ':id/iptv_vod_detail_root_layout"]/android.view.View'
明星区域 = ''
推荐区域 = ''

#第三方SDK详情页
欢喜全屏 = 'com.mgtv.iptv.plugin.huanxi:id/vod_small_vod_button_fullscreen_view' if 'ott' in project.lower() else 'com.mgtv.iptv.plugin.huanxi.hnydiptv:id/vod_small_vod_button_fullscreen_view'

#点播
点播播放器 = app_package1 + ':id/vod_detail_surface_parent'
点播全屏播放器 = app_package1 + ':id/vod_full_setting_overlay'
点播暂停图标 = app_package1 + ':id/sdk_player_framework_play_state'
点播时长 = app_package1 + ':id/tv_total_play_time'
点播时间 = app_package1 + ':id/tv_time'
点播打点推荐 = app_package1 + ':id/iptv_loft_vod_tv_hint'
点播清晰度选中图标 = app_package1 + ':id/vodplayer_dynamic_setting_radio_item_radio_icon_view'




#视频搜索结果页
视频搜索结果页视频窗图片 = app_package1 + ':id/video_place_holder_img'
视频搜索结果页视频播放窗 = '//*[@resource-id="' + app_package1 + ':id/rootView"]/../android.widget.FrameLayout[2]/android.widget.FrameLayout'
视频搜索结果页作者认证图标 = app_package1 + ':id/video_uploader_auth'

# 我的
# 版本信息 = app_package1 + ':id/version_text'
版本信息 = app_package1 + ':id/rv_mine'
版本信息_新 = app_package1 + ':id/rv_mine' if 'hndx' in project.lower() else app_package1 + ':id/rv_mine' if 'hnlt' in project.lower() else app_package1 + ':id/iptv_personal_device_info_version'
消费记录 = 'accessibility_id=消费记录'
我的订购 = 'accessibility_id=我的订购'
绑定微信 = 'accessibility_id=绑定微信'
会员卡激活 = 'accessibility_id=会员卡激活'
我的收藏 = '//android.widget.TextView[@text="我的收藏"]'
我的预约 = '//android.widget.TextView[@text="我的预约"]'
设置 = '//android.view.View[@content-desc="设置"]'
手机遥控 = '//android.view.View[@content-desc="手机遥控"]'
新手指引 = '//android.view.View[@content-desc="新手指引"]'
常见问题 = '//android.view.View[@content-desc="常见问题"]'
常见问题默认焦点 = '使用故障' if 'hndx' in project.lower() else '广告相关'
客服反馈 = '//android.view.View[contains(@content-desc,\'客服反馈\')]'
问题反馈 = '//android.view.View[contains(@content-desc,\'问题反馈\')]'
关于我们 = '//android.view.View[@content-desc="关于我们"]'
惊天破 = 'xpath=//android.view.View[contains(@content-desc,\'惊天破\')]'
全部记录 = '//*[@resource-id="' + app_package1 + ':id/history_rv"]/android.view.View[@index=\'5\']'
全部赞过 = app_package1 + ':id/mypraise_entrance'
短视频标签_全部收藏 = app_package1 + ':id/mytag_entrance'

#观看历史
热门推荐 = app_package1 + ':id/rec_data_title'
观看历史 = '//android.widget.TextView[@text="观看历史"]'
我赞过的 = '//android.widget.TextView[@text="我赞过的"]'
全部删除 = app_package1 + ':id/person_detail_delete_all_btn'
删除 = app_package1 + ':id/person_detail_delete_btn'


# 原生专题
专题收藏 = app_package1 + ':id/subject_img_collect'
专题内容区 = app_package1 + ':id/subject_recyclerview'
专题背景图 = app_package1 + ':id/subject_img_bk'

#组合专题
组合专题顶部广告 = '//*[@resource-id="' + app_package1 + ':id/top_menu_view"]/android.view.View[1]'
组合专题顶部搜索 = '//*[@resource-id="' + app_package1 + ':id/top_menu_view"]/android.view.View[2]'
组合专题顶部会员 = '//*[@resource-id="' + app_package1 + ':id/top_menu_view"]/android.view.View[3]'
组合专题顶部我的 = '//*[@resource-id="' + app_package1 + ':id/top_menu_view"]/android.view.View[4]'


#体育赛事
体育赛程图标 = '//*[@resource-id="' + app_package1 + ':id/iptv_sport_info_bk"]'

# web
网页 = app_package1 + ':id/webview'

# 切换模式
沉浸版 = '//*[@resource-id="' + app_package1 + ':id/rv_ver"]/android.view.View[1]'
时尚版 = '//*[@resource-id="' + app_package1 + ':id/rv_ver"]/android.view.View[2]'
简约版 = '//*[@resource-id="' + app_package1 + ':id/rv_ver"]/android.view.View[4]'
少儿版 = '//*[@resource-id="' + app_package1 + ':id/rv_ver"]/android.view.View[3]'
教育版 = '//*[@resource-id="' + app_package1 + ':id/rv_ver"]/android.view.View[5]'

# 少儿验证页
数字一 = app_package1 + ':id/tv_element_first'
数字二 = app_package1 + ':id/tv_element_second'
计算符 = app_package1 + ':id/tv_operator_first'
计算符2 = app_package1 + ':id/tv_operator_second'
答案 = "//*[starts-with(@resource-id, '" + app_package1 + ":id/tv_choice_result_') and @text='{}']"
计算答案 = app_package1 + ':id/tv_element_result'
备选答案一 = app_package1 + ':id/tv_choice_result_zero'

#轮播
轮播全屏列表浮层 = '//*[@resource-id="' + app_package1 + ':id/channel_title_rv_full"]'
轮播小窗 = '//*[@resource-id="' + app_package1 + ':id/iptv_lunbo_video_player_view"]'

# 屏保
屏保提示 = app_package1 + ':id/screen_saver_tips'

# 会员片库
开通会员 = app_package1 + ':id/iptv_pianku_vip_activity_vipimg'
会员片库标题 = app_package1 + ':id/iptv_pianku_vip_activity_title'
会员片库顶部 = app_package1 + ':id/iptv_pianku_vip_item_tab_root_view'
会员片库tab = app_package1 + ':id/iptv_pianku_vip_tab_txt'
会员片库频道 = app_package1 + ':id/iptv_pianku_vip_category_txt'
会员片库类别 = app_package1 + ':id/iptv_pianku_vip_kind_txt'
会员片库媒资 = app_package1 + ':id/iptv_pianku_vip_item_list_root_view'
会员片库更多会员 = app_package1 + ':id/iptv_pianku_vip_activity_more_img'
会员片库行数 = app_package1 + ':id/iptv_pianku_vip_currentpage'

#简约版本
简约直播小窗播放器 = app_package1 + ':id/focus_view'
简约观看记录 = app_package1 + ':id/play_list_more_focus_view'
简约观看历史区 = app_package1 + ':id/rv_brief_play'
简约频道区 = app_package1 + ':id/rv_brief_rec'
简约切换模式 = '//android.view.View[@content-desc=\'退出老年模式\']'
简约搜索 = '//android.view.View[@content-desc=\'搜索\']'

#少儿版本
少儿首页 = 'xpath=//android.view.View[contains(@content-desc,\'母亲\')]'
少儿切换模式 = '//android.view.View[@content-desc=\'少儿切换模式\']'
少儿搜索 = '//android.view.View[@content-desc=\'少儿搜索\']'
少儿会员 = '//android.view.View[@content-desc=\'少儿会员\']'
少儿个人 =  '//android.view.View[@content-desc=\'少儿我的\']'
少儿开通会员 = app_package1 + ':id/child_template_first_view'
少儿直播 = app_package1 + ':id/child_template_second_view'
少儿最新上线 = '//*[@resource-id="' + app_package1 + ':id/content"]/android.view.View[@index=\'6\']'
少儿版本信息 = app_package1 + ':id/title_version_info'

#广告
暂停退出广告 = app_package1 + ':id/ad_dialog_banner_image' if 'hndx' in project.lower() else app_package1 + ':id/ad_dialog_banner_tag'
加载 = app_package1 + ':id/sdkplayer_loading_loading_tv'


#片库
筛选 = app_package1 + ':id/iptv_pianku_detail_select_item_view'


#打洞参数配置
打洞_媒资ID ='5d784bc58f5a04b232f604c9b9cd59b6' if 'hndx' in project.lower() else '0ef9280447454f1a9142b1302020ec38' if 'hnlt' in project.lower() else '00000001000000000030000000311718' if 'ott' in project.lower() else '32019112517134787801990686856781'
打洞_片库一级ID ='00000001000000001002000000000021'
打洞_片库二级ID ='00000001000000001002000000000044'
打洞_H5页面 = 'http://10.255.0.219/en/zbw/dxorder/index.html%23/index/0' if 'hndx' in project.lower() else 'http://mgtvweb.hn165.com:8080/poster/zt/zbw/order-test/index.html' if 'hnlt' in project.lower() else 'http://otthnydseminar.yys.mgtv.com:6600/zt/oc/order_center_page.html' if 'ott' in project.lower() else 'http://192.168.168.160:8080/poster/oc/order_center_page.html'
打洞_直播频道 ='00000001000000000002000000027983'
打洞_专题ID = '06386c2a0fdf458894c34e2f78267ccc'
打洞_明星ID = 'ef46b647e3594ca3aa234574b790da8d'

# 我的
播单位置1 = '//*[@content-desc="我的播单"]/following-sibling::*[1]/*/android.view.View[1][@focused="true"]'
播单海报 = 'com.hunantv.operator:id/poster_view'
播单删除标识 = 'com.hunantv.operator:id/iv_delete_status'

# 平台兼容
最左侧分屏 ='行业' if 'hnyd' in project.lower() else '二级菜单'
详情页呼出浮层 = '1' if 'hndx' in project.lower() else '2'

#沉浸模式
#首页
左边logo = app_package1 + ':id/home_immersion_left_top_logo'
右边logo = app_package1 + ':id/home_immersion_right_top_logo'
