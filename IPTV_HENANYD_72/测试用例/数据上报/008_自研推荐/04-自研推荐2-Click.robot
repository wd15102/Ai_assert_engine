*** Settings ***
Documentation    自研推荐2.0-Click事件
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
case_035 公共字段校验
    [Documentation]  推荐2.0点击
    返回首页
    返回精选页
    按次数右移  2
    切换频道  戏曲
    切换频道  智能推荐2
    清除历史上报数据
    向下
    FOR    ${i}    IN RANGE    30
       确认键   3
       详情页退出
       按次数下移  1
    END
#    获取校验结果  {'logtype':'click','rectype':'002'}    test_035    ${datatable_prefix_apk}_click_tuijian

case_036 点播关联推荐002点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'002'}    test_036    ${datatable_prefix_apk}_click_tuijian

case_037 直播关联推荐003点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'003'}    test_037    ${datatable_prefix_apk}_click_tuijian

case_038 点播猜你喜欢004点击
    [Documentation]  推荐2.0点击
    获取校验结果_不上报  {'logtype':'click','rectype':'004'}    test_038    ${datatable_prefix_apk}_click_tuijian

case_039 聚类标签推荐005点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'005'}    test_039    ${datatable_prefix_apk}_click_tuijian

case_040 点播排行榜-全部007a点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'007a'}    test_040    ${datatable_prefix_apk}_click_tuijian

case_041 点播排行榜-电影007b点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'007b'}    test_041    ${datatable_prefix_apk}_click_tuijian

case_042 点播排行榜-电视剧007c点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'007c'}    test_042    ${datatable_prefix_apk}_click_tuijian

case_043 点播排行榜-综艺007d点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'007d'}    test_043    ${datatable_prefix_apk}_click_tuijian

case_044 点播排行榜-少儿007e点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'007e'}    test_044    ${datatable_prefix_apk}_click_tuijian

case_045 点播排行榜-纪录片007f点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'007f'}    test_045    ${datatable_prefix_apk}_click_tuijian

case_046 点播排行榜-动漫007g点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'007g'}    test_046    ${datatable_prefix_apk}_click_tuijian

case_047 人气明星榜008点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'008'}    test_047    ${datatable_prefix_apk}_click_tuijian

case_048 点播看了还会看013点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'013'}    test_048    ${datatable_prefix_apk}_click_tuijian

case_049 点播飙升榜-全部014a点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'014a'}    test_049    ${datatable_prefix_apk}_click_tuijian

case_050 点播飙升榜-电影014b点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'014b'}    test_050    ${datatable_prefix_apk}_click_tuijian

case_051 点播飙升榜-电视剧014c点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'014c'}    test_051    ${datatable_prefix_apk}_click_tuijian

case_052 点播飙升榜-综艺014d点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'014d'}    test_052    ${datatable_prefix_apk}_click_tuijian

case_053 点播飙升榜-少儿014e点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'014e'}    test_053    ${datatable_prefix_apk}_click_tuijian

case_054 点播飙升榜-纪录片014f点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'014f'}    test_054    ${datatable_prefix_apk}_click_tuijian

case_055 点播飙升榜-动漫014g点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'014g'}    test_055    ${datatable_prefix_apk}_click_tuijian

case_056 点播口碑榜-全部015a点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'015a'}    test_056    ${datatable_prefix_apk}_click_tuijian

case_057 点播口碑榜-电影015b点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'015b'}    test_057    ${datatable_prefix_apk}_click_tuijian

case_058 点播口碑榜-电视剧015c点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'015c'}    test_058    ${datatable_prefix_apk}_click_tuijian

case_059 点播口碑榜-综艺015d点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'015d'}    test_059    ${datatable_prefix_apk}_click_tuijian

case_060 点播口碑榜-少儿015e点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'015e'}    test_060    ${datatable_prefix_apk}_click_tuijian

case_061 点播口碑榜-纪录片015f点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'015f'}    test_061    ${datatable_prefix_apk}_click_tuijian

case_062 点播口碑榜-动漫015g点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'015g'}    test_062    ${datatable_prefix_apk}_click_tuijian

case_063 地区维度推荐016点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'016'}    test_063    ${datatable_prefix_apk}_click_tuijian

case_064 产品包维度推荐017点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'017'}    test_064    ${datatable_prefix_apk}_click_tuijian

case_065 明星推荐018点击
    [Documentation]  推荐2.0点击
    获取校验结果  {'logtype':'click','rectype':'018'}    test_065    ${datatable_prefix_apk}_click_tuijian




