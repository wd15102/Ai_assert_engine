*** Settings ***
Documentation    自研推荐2.0-Show事件
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
    [Documentation]  推荐2.0曝光
    返回首页
    返回精选页
    按次数右移  2
    切换频道  戏曲
    清除历史上报数据
    切换频道  智能推荐2
    校验焦点是否在内容描述上  智能推荐2

case_036 点播关联推荐002曝光
    [Documentation]  推荐2.0曝光
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16','rectype':'002'}    test_036    ${datatable_prefix_apk}_show_tuijian

case_037 直播关联推荐003曝光
    [Documentation]  推荐2.0曝光
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16','rectype':'003'}    test_037    ${datatable_prefix_apk}_show_tuijian

case_066 当有冷数据锁定时，整体模块曝光按推荐上报，点击冷数据时按常规数据上报，点击推荐数据时按推荐数据上报
    [Documentation]  推荐2.0曝光
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16','rectype':'003'}    test_037    ${datatable_prefix_apk}_show_tuijian

直播频道推荐模块曝光
    [Documentation]  推荐2.0曝光
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16','rectype':'003'}    test_037    ${datatable_prefix_apk}_show_tuijian

case_038 点播猜你喜欢004曝光
    [Documentation]  推荐2.0曝光
    按次数下移  2
    清除历史上报数据
    向下  2
    获取校验结果_不上报  {'logtype':'show','bid':'rec_26.1.16','modulepos':'3'}    test_038    ${datatable_prefix_apk}_show_tuijian

case_039 聚类标签推荐005曝光
    [Documentation]  推荐2.0曝光
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16','modulepos':'4'}    test_039    ${datatable_prefix_apk}_show_tuijian

case_040 点播排行榜-全部007a曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16','modulepos':'5'}    test_040    ${datatable_prefix_apk}_show_tuijian

case_041 点播排行榜-电影007b曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16','modulepos':'6'}    test_041    ${datatable_prefix_apk}_show_tuijian

case_042 点播排行榜-电视剧007c曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16','modulepos':'7'}    test_042    ${datatable_prefix_apk}_show_tuijian

case_043 点播排行榜-综艺007d曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    按次数下移  2    2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16','modulepos':'8'}    test_043    ${datatable_prefix_apk}_show_tuijian

case_044 点播排行榜-少儿007e曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_044    ${datatable_prefix_apk}_show_tuijian

case_045 点播排行榜-纪录片007f曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_045    ${datatable_prefix_apk}_show_tuijian

case_046 点播排行榜-动漫007g曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_046    ${datatable_prefix_apk}_show_tuijian

case_047 人气明星榜008曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_047    ${datatable_prefix_apk}_show_tuijian

case_048 点播看了还会看013曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_048    ${datatable_prefix_apk}_show_tuijian

case_049 点播飙升榜-全部014a曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_049    ${datatable_prefix_apk}_show_tuijian

case_050 点播飙升榜-电影014b曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_050    ${datatable_prefix_apk}_show_tuijian

case_051 点播飙升榜-电视剧014c曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_051    ${datatable_prefix_apk}_show_tuijian

case_052 点播飙升榜-综艺014d曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_052    ${datatable_prefix_apk}_show_tuijian

case_053 点播飙升榜-少儿014e曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_053    ${datatable_prefix_apk}_show_tuijian

case_054 点播飙升榜-纪录片014f曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_054    ${datatable_prefix_apk}_show_tuijian

case_055 点播飙升榜-动漫014g曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_055    ${datatable_prefix_apk}_show_tuijian

case_056 点播口碑榜-全部015a曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_056    ${datatable_prefix_apk}_show_tuijian

case_057 点播口碑榜-电影015b曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_057    ${datatable_prefix_apk}_show_tuijian

case_058 点播口碑榜-电视剧015c曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_058    ${datatable_prefix_apk}_show_tuijian

case_059 点播口碑榜-综艺015d曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_059    ${datatable_prefix_apk}_show_tuijian

case_060 点播口碑榜-少儿015e曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_060    ${datatable_prefix_apk}_show_tuijian

case_061 点播口碑榜-纪录片015f曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_061    ${datatable_prefix_apk}_show_tuijian

case_062 点播口碑榜-动漫015g曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_062    ${datatable_prefix_apk}_show_tuijian

case_063 地区维度推荐016曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_063    ${datatable_prefix_apk}_show_tuijian

case_064 产品包维度推荐017曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_064    ${datatable_prefix_apk}_show_tuijian

case_065 明星推荐018曝光
    [Documentation]  推荐2.0曝光
    清除历史上报数据
    向下  2
    获取校验结果  {'logtype':'show','bid':'rec_26.1.16'}    test_065    ${datatable_prefix_apk}_show_tuijian




