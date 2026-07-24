*** Settings ***
Documentation    首页PV和STAY事件
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 PV事件公共字段检查
    [Documentation]  PV事件
    清除历史上报数据
    重新启动
    获取校验结果  {'logtype':'pv'}    test_001    ${datatable_prefix_apk}_pv

case_001 开机启动进入精选页
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_001    ${datatable_prefix_apk}_pv

case_001_02 所有PV事件改为post上报
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_001    ${datatable_prefix_apk}_pv

case_001_03 PV事件公共字段新增开机参数
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_001    ${datatable_prefix_apk}_pv

case_002 从精选频道切换到直播频道
    [Documentation]  PV事件
    返回首页
    返回精选页
    等待  5
    清除历史上报数据
    切换频道    直播
    获取校验结果  {'logtype':'pv'}    test_002    ${datatable_prefix_apk}_pv

case_002 首页分屏B切换到分屏A
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_002    ${datatable_prefix_apk}_pv

case_001 STAY事件公共字段检查
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_001    ${datatable_prefix_apk}_stay

case_001_01 STAY事件公共字段新增开机参数
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_001    ${datatable_prefix_apk}_stay

case_002 开机启动进入精选页停留后切换到直播频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_002    ${datatable_prefix_apk}_stay

case_002 首页分屏A切换到分屏B
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_002    ${datatable_prefix_apk}_stay

case_002_02 所有STAY事件改为post上报
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_002    ${datatable_prefix_apk}_stay

case_003 从直播频道返回到精选频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道  精选
    获取校验结果  {'logtype':'pv'}    test_003    ${datatable_prefix_apk}_pv

case_003 从直播频道返回到精选频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_003    ${datatable_prefix_apk}_stay

case_004 从精选频道切换到直播频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    直播
    获取校验结果  {'logtype':'stay'}    test_004    ${datatable_prefix_apk}_stay

case_004 从直播频道切换到全部频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    全部
    获取校验结果  {'logtype':'pv'}    test_004    ${datatable_prefix_apk}_pv

case_005 从直播频道切换到全部频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_005    ${datatable_prefix_apk}_stay

case_005 从全部频道返回到直播频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    直播
    获取校验结果  {'logtype':'pv'}    test_005    ${datatable_prefix_apk}_pv

case_006 从全部频道返回到直播频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_006    ${datatable_prefix_apk}_stay

case_007 从直播频道切换到精选频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    精选
    获取校验结果  {'logtype':'stay'}    test_007    ${datatable_prefix_apk}_stay

case_006 从精选频道切换到电视剧频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    电视剧
    获取校验结果  {'logtype':'pv'}    test_006    ${datatable_prefix_apk}_pv

case_006 常规模式首页频道切换
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_006    ${datatable_prefix_apk}_pv

case_008 从精选频道切换到电视剧频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_008    ${datatable_prefix_apk}_stay

case_007 从电视剧频道返回到精选频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    精选
    获取校验结果  {'logtype':'pv'}    test_007    ${datatable_prefix_apk}_pv

case_009 从电视剧频道返回到精选频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_009    ${datatable_prefix_apk}_stay

case_010 从电视剧频道返回后，再从精选频道切换到电视剧频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    电视剧
    获取校验结果  {'logtype':'stay'}    test_010    ${datatable_prefix_apk}_stay

case_008 从电视剧频道切换到电影频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    电影
    获取校验结果  {'logtype':'pv'}    test_008    ${datatable_prefix_apk}_pv

case_008 黑白模式首页频道切换
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_008    ${datatable_prefix_apk}_pv

case_011 从电视剧频道切换到电影频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_011    ${datatable_prefix_apk}_stay

case_009 从电影频道返回到电视剧频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    电视剧
    获取校验结果  {'logtype':'pv'}    test_009    ${datatable_prefix_apk}_pv

case_012 从电影频道返回到电视剧频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_012    ${datatable_prefix_apk}_stay

case_013 从电影频道返回后，再从电视剧频道切换到电影频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    电影
    获取校验结果  {'logtype':'stay'}    test_013    ${datatable_prefix_apk}_stay

case_010 从电影频道切换到少儿频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    少儿频道
    获取校验结果  {'logtype':'pv'}    test_010    ${datatable_prefix_apk}_pv

case_014 从电影频道切换到少儿频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_014    ${datatable_prefix_apk}_stay

case_011 从少儿频道返回到电影频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    电影
    获取校验结果  {'logtype':'pv'}    test_011    ${datatable_prefix_apk}_pv

case_015 从少儿频道返回到电影频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_015    ${datatable_prefix_apk}_stay

case_016 从少儿频道返回后，再从电影频道切换到少儿频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    少儿频道
    获取校验结果  {'logtype':'stay'}    test_016    ${datatable_prefix_apk}_stay

case_012 从少儿频道切换到综艺频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    综艺
    获取校验结果  {'logtype':'pv'}    test_012    ${datatable_prefix_apk}_pv

case_017 从少儿频道切换到综艺频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_017    ${datatable_prefix_apk}_stay

case_013 从综艺频道返回到少儿频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    少儿频道
    获取校验结果  {'logtype':'pv'}    test_013    ${datatable_prefix_apk}_pv

case_018 从综艺频道返回到少儿频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_018    ${datatable_prefix_apk}_stay

case_019 从综艺频道返回后，再从少儿频道切换到综艺频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    综艺
    获取校验结果  {'logtype':'stay'}    test_019    ${datatable_prefix_apk}_stay

case_014 从综艺频道切换到动漫频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    动漫
    获取校验结果  {'logtype':'pv'}    test_014    ${datatable_prefix_apk}_pv

case_020 从综艺频道切换到动漫频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_020    ${datatable_prefix_apk}_stay

case_015 从动漫频道返回到综艺频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    综艺
    获取校验结果  {'logtype':'pv'}    test_015    ${datatable_prefix_apk}_pv

case_021 从动漫频道返回到综艺频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_021    ${datatable_prefix_apk}_stay

case_022 从动漫频道返回后，再从综艺频道切换到动漫频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    动漫
    获取校验结果  {'logtype':'stay'}    test_022    ${datatable_prefix_apk}_stay

case_016 从动漫频道切换到电竞频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    电竞
    获取校验结果  {'logtype':'pv'}    test_016    ${datatable_prefix_apk}_pv

case_023 从动漫频道切换到电竞频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_023    ${datatable_prefix_apk}_stay

case_017 从电竞频道返回到动漫频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    动漫
    获取校验结果  {'logtype':'pv'}    test_017    ${datatable_prefix_apk}_pv

case_024 从电竞频道返回到动漫频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_024    ${datatable_prefix_apk}_stay

case_025 从电竞频道返回后，再从动漫频道切换到电竞频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    电竞
    获取校验结果  {'logtype':'stay'}    test_025    ${datatable_prefix_apk}_stay

case_018 从电竞频道切换到纪录片频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    纪实
    获取校验结果  {'logtype':'pv'}    test_018    ${datatable_prefix_apk}_pv

case_026 从电竞频道切换到纪录片频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_026    ${datatable_prefix_apk}_stay

case_019 从纪录片频道返回到电竞频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    电竞
    获取校验结果  {'logtype':'pv'}    test_019    ${datatable_prefix_apk}_pv

case_027 从纪录片频道返回到电竞频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_027    ${datatable_prefix_apk}_stay

case_028 从纪录片频道返回后，再从电竞频道切换到纪录片频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    纪实
    获取校验结果  {'logtype':'stay'}    test_028    ${datatable_prefix_apk}_stay

case_020 从纪录片频道切换到戏曲频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    戏曲
    获取校验结果  {'logtype':'pv'}    test_020    ${datatable_prefix_apk}_pv

case_029 从纪录片频道切换到戏曲频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_029    ${datatable_prefix_apk}_stay

case_021 从戏曲频道返回到纪录片频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    纪实
    获取校验结果  {'logtype':'pv'}    test_021    ${datatable_prefix_apk}_pv

case_030 从戏曲频道返回到纪录片频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_030    ${datatable_prefix_apk}_stay

case_031 从戏曲频道返回后，再从纪录片频道切换到戏曲频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    戏曲
    获取校验结果  {'logtype':'stay'}    test_031    ${datatable_prefix_apk}_stay

case_022 从戏曲频道切换到VIP频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    VIP
    获取校验结果  {'logtype':'pv'}    test_022    ${datatable_prefix_apk}_pv

case_032 从戏曲频道切换到VIP频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_032    ${datatable_prefix_apk}_stay

case_023 从VIP频道返回到戏曲频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    戏曲
    获取校验结果  {'logtype':'pv'}    test_023    ${datatable_prefix_apk}_pv

case_033 从VIP频道返回到戏曲频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_033    ${datatable_prefix_apk}_stay

case_034 从VIP频道返回后，再从戏曲频道切换到VIP频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    VIP
    获取校验结果  {'logtype':'stay'}    test_034    ${datatable_prefix_apk}_stay

case_024 从VIP频道切换到专题频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    专题
    获取校验结果  {'logtype':'pv'}    test_024    ${datatable_prefix_apk}_pv

进入选片大师分屏，展示选片大师内容
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_024    ${datatable_prefix_apk}_pv

case_035 从VIP频道切换到专题频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_035    ${datatable_prefix_apk}_stay

case_025 从专题频道返回到VIP频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    VIP
    获取校验结果  {'logtype':'pv'}    test_025    ${datatable_prefix_apk}_pv

case_036 从专题频道返回到VIP频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_036    ${datatable_prefix_apk}_stay

进入选片大师分屏，展示选片大师内容后退出
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_036    ${datatable_prefix_apk}_stay

case_037 从专题频道返回后，再从VIP频道切换到专题频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    专题
    获取校验结果  {'logtype':'stay'}    test_037    ${datatable_prefix_apk}_stay

case_026 从专题频道切换到4K频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    4K
    获取校验结果  {'logtype':'pv'}    test_026    ${datatable_prefix_apk}_pv

case_038 从专题频道切换到4K频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_038    ${datatable_prefix_apk}_stay

case_027 从4K频道返回到专题频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    专题
    获取校验结果  {'logtype':'pv'}    test_027    ${datatable_prefix_apk}_pv

case_039 从4K频道返回到专题频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_039    ${datatable_prefix_apk}_stay

case_040 从专题频道切换到4K频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    4K
    获取校验结果  {'logtype':'stay'}    test_040    ${datatable_prefix_apk}_stay

case_028 从4K频道切换到本地频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    本地
    获取校验结果  {'logtype':'pv'}    test_028    ${datatable_prefix_apk}_pv

case_041 从4K频道切换到本地频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_041    ${datatable_prefix_apk}_stay

case_029 从本地频道返回到4K频道
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    4K
    获取校验结果  {'logtype':'pv'}    test_029    ${datatable_prefix_apk}_pv

case_042 从本地频道返回到4K频道
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_042    ${datatable_prefix_apk}_stay

case_043 从4K频道切换到本地频道
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道    本地
    获取校验结果  {'logtype':'stay'}    test_043    ${datatable_prefix_apk}_stay

case_030 频道页切换时ymbm_ch获取不到值
    [Documentation]  PV事件
    清除历史上报数据
    切换频道    测试
    获取校验结果  {'logtype':'pv'}    test_030    ${datatable_prefix_apk}_pv

#case_188 精选频道进入屏保页
#    [Documentation]  PV事件
#    log to console  暂无屏保功能
#    到达我的页面入口
#    确认键
#    显示服务和帮助
#    点击文本  设置
#    等待文本出现  绑定微信
#    按次数下移  4
#    按次数左移  3
#    清除历史上报数据
#    等待元素出现  ${屏保提示}  70
#    获取校验结果  {'logtype':'pv'}    test_188    ${datatable_prefix_apk}_pv

#case_190 屏保页进入媒资详情页
#    [Documentation]  PV事件
#    log to console  暂无屏保功能
#    清除历史上报数据
#    确认键
#    等待详情页出现
#    获取校验结果  {'logtype':'pv'}    test_190    ${datatable_prefix_apk}_pv

#从屏保页进入媒资详情页
#    [Documentation]  STAY事件
#    log to console  暂无屏保功能
#    获取校验结果  {'logtype':'stay'}    test_174    ${datatable_prefix_apk}_stay

#从媒资详情页返回
#    [Documentation]  STAY事件
#    log to console  暂无屏保功能
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'stay'}    test_175    ${datatable_prefix_apk}_stay

#屏保页返回精选频道
#    [Documentation]  PV事件
#    log to console  暂无屏保功能
#    返回首页
#    等待元素出现  ${屏保提示}  70
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'pv'}    test_189    ${datatable_prefix_apk}_pv

#从精选频道进入屏保页停留后返回
#    [Documentation]  STAY事件
#    log to console  暂无屏保功能
#    获取校验结果  {'logtype':'stay'}    test_172    ${datatable_prefix_apk}_stay

#从屏保页返回精选频道停留后切换频道
#    [Documentation]  STAY事件
#    log to console  暂无屏保功能
#    清除历史上报数据
#    切换频道  电视剧
#    获取校验结果  {'logtype':'stay'}    test_173    ${datatable_prefix_apk}_stay



