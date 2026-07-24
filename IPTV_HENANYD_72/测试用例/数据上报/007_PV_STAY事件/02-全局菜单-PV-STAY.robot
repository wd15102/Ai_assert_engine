*** Settings ***
Documentation    全局菜单PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/全局菜单.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_031 APK页面呼出全局菜单页
    [Documentation]  PV事件
    数字键进直播  001
    清除历史上报数据
    菜单键
    获取校验结果  {'logtype':'pv'}    test_031    ${datatable_prefix_apk}_pv

case_044 呼出全局菜单页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    全局菜单进入精选
    获取校验结果  {'logtype':'stay','cntp':'h_menu'}    test_044    ${datatable_prefix_apk}_stay

case_032 从全局菜单中进入精选频道
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_032    ${datatable_prefix_apk}_pv

case_045 从全局菜单中进入频道页停留后切换频道
    [Documentation]  STAY事件
    菜单键
    清除历史上报数据
    全局菜单进入直播
    获取校验结果  {'logtype':'stay','cntp':'ch_channel'}    test_045    ${datatable_prefix_apk}_stay

case_033 从全局菜单中进入直播页
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_033    ${datatable_prefix_apk}_pv

case_034 从直播页返回精选频道
    [Documentation]  PV事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'pv'}    test_034    ${datatable_prefix_apk}_pv

case_046 从全局菜单中进入直播页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_046    ${datatable_prefix_apk}_stay

case_035 从全局菜单中进入回看页
    [Documentation]  PV事件
    菜单键
    清除历史上报数据
    全局菜单进入回看
    获取校验结果  {'logtype':'pv'}    test_035    ${datatable_prefix_apk}_pv

case_036 从回看页返回精选频道
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_036    ${datatable_prefix_apk}_pv

case_047 从全局菜单中进入回看页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_047    ${datatable_prefix_apk}_stay

case_037 从全局菜单中进入搜索页
    [Documentation]  PV事件
    菜单键
    清除历史上报数据
    全局菜单进入搜索
    获取校验结果  {'logtype':'pv'}    test_037    ${datatable_prefix_apk}_pv

case_038 从搜索页返回精选频道
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_038    ${datatable_prefix_apk}_pv

case_048 从全局菜单中进入搜索页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_048    ${datatable_prefix_apk}_stay

case_039 从全局菜单中进入播放历史页
    [Documentation]  PV事件
    菜单键
    清除历史上报数据
    全局菜单进入历史记录
    获取校验结果  {'logtype':'pv'}    test_039    ${datatable_prefix_apk}_pv

case_040 从播放历史页返回精选频道
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_040    ${datatable_prefix_apk}_pv

case_049 从全局菜单中进入播放历史页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_049    ${datatable_prefix_apk}_stay

case_031 web页面按菜单键呼出全局菜单
    [Documentation]  PV事件
    到达开通会员入口
    确认键
    等待订购中心出现
    清除历史上报数据
    菜单键
    获取校验结果  {'logtype':'pv'}    test_031    ${datatable_prefix_apk}_pv

case_044 web页面呼出全局菜单后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay','cntp':'h_menu'}    test_044    ${datatable_prefix_apk}_stay