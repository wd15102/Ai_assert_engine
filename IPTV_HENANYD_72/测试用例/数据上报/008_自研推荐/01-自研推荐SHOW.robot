*** Settings ***
Documentation    自研推荐SHOW事件
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
    [Documentation]  推荐1.0曝光
    返回首页
    返回精选页
    清除历史上报数据
    切换频道  电竞
    按方向移动  下    27
    获取校验结果  {'logtype':'show','rectype':'013'}    test_001    ${datatable_prefix_apk}_show_tuijian

case_002 频道页看了还会看013曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'013'}    test_002    ${datatable_prefix_apk}_show_tuijian

case_004 点播猜你喜欢004曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'004'}    test_004    ${datatable_prefix_apk}_show_tuijian

case_006 点播排行榜-全部007曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'007a'}    test_006    ${datatable_prefix_apk}_show_tuijian

case_007 点播排行榜-电影007曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'007b'}    test_007    ${datatable_prefix_apk}_show_tuijian

case_008 点播排行榜-电视剧007曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'007c'}    test_008    ${datatable_prefix_apk}_show_tuijian

case_009 点播排行榜-综艺007曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'007d'}    test_009    ${datatable_prefix_apk}_show_tuijian

case_010 点播排行榜-少儿007曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'007e'}    test_010    ${datatable_prefix_apk}_show_tuijian

case_011 点播排行榜-纪录片007曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'007f'}    test_011    ${datatable_prefix_apk}_show_tuijian

case_012 点播排行榜-动漫007曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'007g'}    test_012    ${datatable_prefix_apk}_show_tuijian

case_013 人气明星榜008曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'008'}    test_013    ${datatable_prefix_apk}_show_tuijian

case_014 点播飙升榜-全部014曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'014a'}    test_014    ${datatable_prefix_apk}_show_tuijian

case_015 点播飙升榜-电影014曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'014b'}    test_015    ${datatable_prefix_apk}_show_tuijian

case_016 点播飙升榜-电视剧014曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'014c'}    test_016    ${datatable_prefix_apk}_show_tuijian

case_017 点播飙升榜-综艺014曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'014d'}    test_017    ${datatable_prefix_apk}_show_tuijian

case_018 点播飙升榜-少儿014曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'014e'}    test_018    ${datatable_prefix_apk}_show_tuijian

case_019 点播飙升榜-纪录片014曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'014f'}    test_019    ${datatable_prefix_apk}_show_tuijian

case_020 点播飙升榜-动漫014曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'014g'}    test_020    ${datatable_prefix_apk}_show_tuijian

case_021 点播口碑榜-全部015曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'015a'}    test_021    ${datatable_prefix_apk}_show_tuijian

case_022 点播口碑榜-电影015曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'015b'}    test_022    ${datatable_prefix_apk}_show_tuijian

case_023 点播口碑榜-电视剧015曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'015c'}    test_023    ${datatable_prefix_apk}_show_tuijian

case_024 点播口碑榜-综艺015曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'015d'}    test_024    ${datatable_prefix_apk}_show_tuijian

case_025 点播口碑榜-少儿015曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'015e'}    test_025    ${datatable_prefix_apk}_show_tuijian

case_026 点播口碑榜-纪录片015曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'015f'}    test_026    ${datatable_prefix_apk}_show_tuijian

case_027 点播口碑榜-动漫015曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'015g'}    test_027    ${datatable_prefix_apk}_show_tuijian

case_028 地区维度推荐016曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'016'}    test_028    ${datatable_prefix_apk}_show_tuijian

case_029 产品包维度推荐017曝光
    [Documentation]  推荐1.0曝光
    log to console  目前无此场景

case_030 明星推荐018曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'018'}    test_030    ${datatable_prefix_apk}_show_tuijian

case_032 聚类标签推荐005曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'005'}    test_032    ${datatable_prefix_apk}_show_tuijian

case_003 详情页相关推荐002曝光
    [Documentation]  推荐1.0曝光
    返回首页
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    清除历史上报数据
    按方向移动  下    6
    获取校验结果  {'logtype':'show','rectype':'002'}    test_003    ${datatable_prefix_apk}_show_tuijian

case_005 详情页看了还会看013曝光
    [Documentation]  推荐1.0曝光
    获取校验结果  {'logtype':'show','rectype':'013'}    test_005    ${datatable_prefix_apk}_show_tuijian

case_033 历史记录推荐004曝光
    [Documentation]  推荐1.0曝光
    到达我的页面入口
    确认键
    等待我的页出现
    到达观看历史全部记录入口
    确认键
    点击文本  全部删除
    清除历史上报数据
    点击文本  确定
    等待  3
    获取校验结果  {'logtype':'show','rectype':'004'}    test_033    ${datatable_prefix_apk}_show_tuijian

case_031 直播关联推荐003曝光
    [Documentation]  推荐1.0曝光
    返回首页
    数字键进直播  002
    清除历史上报数据
    直播呼出浮层
    按次数右移  1    3
    获取校验结果  {'logtype':'show','rectype':'003'}    test_031    ${datatable_prefix_apk}_show_tuijian

case_034 我的页推荐004曝光
    [Documentation]  推荐1.0曝光
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  2
    等待  3
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'show','rectype':'004'}    test_034    ${datatable_prefix_apk}_show_tuijian

case_035 推荐2.0曝光公共字段检查
    [Documentation]  推荐2.0曝光
    返回首页
    返回精选页
    切换频道  电视剧
    返回精选页
    按次数下移  1
    清除历史上报数据
    按次数下移  1
    等待  3
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_035    ${datatable_prefix_apk}_show_tuijian


