*** Settings ***
Documentation    片库PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/片库.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_063 从频道页的导航栏进入片库页
    [Documentation]  PV事件
    返回首页
    返回精选页
    切换频道  电视剧
    清除历史上报数据
    导航栏进入片库
    获取校验结果  {'logtype':'pv'}    test_063    ${datatable_prefix_apk}_pv

case_063 首页导航栏进入片库页cid上报
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_063    ${datatable_prefix_apk}_pv

case_065 从片库页返回频道页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_065    ${datatable_prefix_apk}_pv

case_069 从频道页的导航栏进入片库页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_069    ${datatable_prefix_apk}_stay

case_250 片库内切换一级分类cid上报
    [Documentation]  PV事件
    导航栏进入片库
    按次数左移  1
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'pv'}    test_250    ${datatable_prefix_apk}_pv

case_064 从频道页内模块进入片库页
    [Documentation]  PV事件
    按次数返回  2
    按次数下移  3
    按次数左移  1
    清除历史上报数据
    确认键
    等待片库内容出现
    获取校验结果  {'logtype':'pv'}    test_064    ${datatable_prefix_apk}_pv

case_064 频道页内进入片库页cid上报
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_064    ${datatable_prefix_apk}_pv

case_066 片库页中切换标签
    [Documentation]  PV事件
    清除历史上报数据
    向下
    等待片库内容出现
    获取校验结果  {'logtype':'pv'}    test_066    ${datatable_prefix_apk}_pv

case_066 片库内切换二级分类cid上报
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_066    ${datatable_prefix_apk}_pv

case_070 从片库页中切换标签停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_070    ${datatable_prefix_apk}_stay

case_067 片库页中进入搜索页
    [Documentation]  PV事件
    返回精选页
    切换频道  电视剧
    导航栏进入片库
    等待  5
    清除历史上报数据
    片库进入搜索
    获取校验结果  {'logtype':'pv','cntp':'so_search'}    test_067    ${datatable_prefix_apk}_pv

case_068 搜索页返回片库页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_068    ${datatable_prefix_apk}_pv

case_071 从片库页中进入搜索页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_071    ${datatable_prefix_apk}_stay

case_072 从搜索页返回片库主页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_072    ${datatable_prefix_apk}_stay

case_069 片库页中进入点播详情页
    [Documentation]  PV事件
    按次数返回  1    2
    导航栏进入片库
    清除历史上报数据
    点击内容描述  完美关系 DVD版
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_069    ${datatable_prefix_apk}_pv

case_069 片库进入点播详情页cid上报
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_069    ${datatable_prefix_apk}_pv

case_070 点播详情页返回片库页
    [Documentation]  PV事件
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype':'pv'}    test_070    ${datatable_prefix_apk}_pv

case_073 从片库页中进入点播详情页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_073    ${datatable_prefix_apk}_stay

case_221 片库中切换到筛选
    [Documentation]  PV事件
    返回首页
    切换频道  电视剧
    确认键
    等待页面出现内容描述信息  筛选
    清除历史上报数据
    向上
    校验焦点是否在内容描述上  筛选
    获取校验结果  {'logtype':'pv'}    test_221    ${datatable_prefix_apk}_pv

case_222 筛选中选中第一个筛选条件
    [Documentation]  PV事件
    按次数右移  2
    清除历史上报数据
    确认键
    等待页面出现文本信息  筛选结果：内地  10
    获取校验结果  {'logtype':'pv'}    test_222    ${datatable_prefix_apk}_pv

case_223 筛选中选中第二个筛选条件
    [Documentation]  PV事件
    按次数下移  1
    按次数右移  1
    清除历史上报数据
    确认键
    等待页面出现文本信息  筛选结果：内地 / 2022  10
    获取校验结果  {'logtype':'pv'}    test_223    ${datatable_prefix_apk}_pv

case_223 片库内切换筛选标签cid上报
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_223    ${datatable_prefix_apk}_pv