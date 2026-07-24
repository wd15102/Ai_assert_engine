*** Settings ***
Documentation    自研推荐Click事件
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../IPTV_JX_72/对象库/我的.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 公共字段检查
    [Documentation]  推荐1.0点击
    返回首页
    返回精选页
    清除历史上报数据
    切换频道  电竞
    按次数下移  1
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_001    ${datatable_prefix_apk}_click_tuijian

case_002 频道页看了还会看013点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_002    ${datatable_prefix_apk}_click_tuijian

case_004 点播猜你喜欢004点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_004    ${datatable_prefix_apk}_click_tuijian

case_006 点播排行榜-全部007点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_006    ${datatable_prefix_apk}_click_tuijian

case_007 点播排行榜-电影007点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_007    ${datatable_prefix_apk}_click_tuijian

case_008 点播排行榜-电视剧007点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_008    ${datatable_prefix_apk}_click_tuijian

case_009 点播排行榜-综艺007点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_009    ${datatable_prefix_apk}_click_tuijian

case_010 点播排行榜-少儿007点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_010    ${datatable_prefix_apk}_click_tuijian

case_011 点播排行榜-纪录片007点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_011    ${datatable_prefix_apk}_click_tuijian

case_012 点播排行榜-动漫007点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_012    ${datatable_prefix_apk}_click_tuijian

case_013 人气明星榜008点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_013    ${datatable_prefix_apk}_click_tuijian

case_014 点播飙升榜-全部014点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_014    ${datatable_prefix_apk}_click_tuijian

case_015 点播飙升榜-电影014点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_015    ${datatable_prefix_apk}_click_tuijian

case_016 点播飙升榜-电视剧014点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_016    ${datatable_prefix_apk}_click_tuijian

case_017 点播飙升榜-综艺014点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_017    ${datatable_prefix_apk}_click_tuijian

case_018 点播飙升榜-少儿014点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_018    ${datatable_prefix_apk}_click_tuijian

case_019 点播飙升榜-纪录片014点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_019    ${datatable_prefix_apk}_click_tuijian

case_020 点播飙升榜-动漫014点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_020    ${datatable_prefix_apk}_click_tuijian

case_021 点播口碑榜-全部015点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_021    ${datatable_prefix_apk}_click_tuijian

case_022 点播口碑榜-电影015点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_022    ${datatable_prefix_apk}_click_tuijian

case_023 点播口碑榜-电视剧015点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_023    ${datatable_prefix_apk}_click_tuijian

case_024 点播口碑榜-综艺015点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_024    ${datatable_prefix_apk}_click_tuijian

case_025 点播口碑榜-少儿015点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_025    ${datatable_prefix_apk}_click_tuijian

case_026 点播口碑榜-纪录片015点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_026    ${datatable_prefix_apk}_click_tuijian

case_027 点播口碑榜-动漫015点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_027    ${datatable_prefix_apk}_click_tuijian

case_028 地区维度推荐016点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_028    ${datatable_prefix_apk}_click_tuijian

case_029 产品包维度推荐017点击
    [Documentation]  推荐1.0点击
    log to console  目前无此场景

case_030 明星推荐018点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_030    ${datatable_prefix_apk}_click_tuijian

case_032 聚类标签推荐005点击
    [Documentation]  推荐1.0点击
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_032    ${datatable_prefix_apk}_click_tuijian

case_003 详情页相关推荐002点击
    [Documentation]  推荐1.0点击
    返回首页
    返回精选页
    到达免费电视剧入口
    确认键
#    点击元素  ${免费电视剧}
    等待详情页出现
    按次数下移  5
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5','rectype':'002'}    test_003    ${datatable_prefix_apk}_click_tuijian

case_005 详情页看了还会看013点击
    [Documentation]  推荐1.0点击
    返回首页
    返回精选页
    到达免费电视剧入口
    确认键
#    点击元素  ${免费电视剧}
    等待详情页出现
    按次数下移  6
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5','rectype':'013'}    test_005    ${datatable_prefix_apk}_click_tuijian

case_033 历史记录推荐004点击
    [Documentation]  推荐1.0点击
    到达我的页面入口
    确认键
    等待我的页出现
    到达观看历史全部记录入口
    确认键
    点击文本  全部删除
    点击文本  确定
    清除历史上报数据
    进入媒资详情页  绯闻计划
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5','rectype':'004'}    test_033    ${datatable_prefix_apk}_click_tuijian

case_031 直播关联推荐003点击
    [Documentation]  推荐1.0点击
    返回首页
    数字键进直播  2
    直播呼出浮层
    按次数右移  2
    run keyword if  'HNDX' not in '${project}'  按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5','rectype':'003'}    test_031    ${datatable_prefix_apk}_click_tuijian

case_034 我的页推荐004点击
    [Documentation]  推荐1.0点击
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  4
    清除历史上报数据
    点击进入内容描述  绯闻计划
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5','rectype':'004'}    test_034    ${datatable_prefix_apk}_click_tuijian

case_035 推荐2.0点击公共字段检查
    [Documentation]  推荐2.0点击
    返回首页
    返回精选页
    按次数下移  3
    按键直到出现内容描述  少儿模板  下
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','bid':'rec_26.5.5.5'}    test_035    ${datatable_prefix_apk}_click_tuijian

case_402 点击精选频道移动算法数据接入通栏中的海报
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','lob':'mpos'}    test_402    ${datatable_prefix_apk}_click

case_402_01 点击频道页算法推荐的通栏
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','lob':'mpos'}    test_402    ${datatable_prefix_apk}_click