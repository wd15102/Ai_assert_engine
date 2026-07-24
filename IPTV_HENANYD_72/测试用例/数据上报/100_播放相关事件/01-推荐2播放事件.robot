*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/片库.robot
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_068 首页智能推荐播放点播媒资
    [Documentation]    启播事件
    到达推荐2.0首页入口
    清除历史上报数据
    确认键
    等待详情页出现
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_068   ${datatable_prefix_apk}_splay

case_068_1 推荐2.0模块点击媒资播放
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_068   ${datatable_prefix_apk}_splay

case_066 首页智能推荐播放点播媒资
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_066   ${datatable_prefix_apk}_play

case_066_1 推荐2.0模块媒资播放
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_066   ${datatable_prefix_apk}_play

case_066_2 所有播放相关事件改为post上报
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_066   ${datatable_prefix_apk}_play

case_033 推荐2.0媒资快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    等待媒资播放
    清除历史上报数据
    按秒快进  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_033   ${datatable_prefix_apk}_drag

case_033_1 推荐2.0媒资播放快进拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_033   ${datatable_prefix_apk}_drag

case_034 推荐2.0媒资快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_034   ${datatable_prefix_apk}_drag

case_034_1 推荐2.0媒资播放快退拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_034   ${datatable_prefix_apk}_drag

case_010 推荐2.0进入媒资播放暂停
    [Documentation]    pause事件
    等待  3
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_010   ${datatable_prefix_apk}_pause

case_010 推荐2.0进入媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_010   ${datatable_prefix_apk}_resume

case_114 推荐2.0播放，上报5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_114   ${datatable_prefix_apk}_hb

case_069 推荐2.0媒资播放，上报退出
    [Documentation]    stop事件
    清除历史上报数据
    返回首页
    获取校验结果      {'logtype': 'stop'}    test_069   ${datatable_prefix_apk}_stop

case_115 推荐2.0媒资播放，上报退出
    [Documentation]    心跳事件
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_115   ${datatable_prefix_apk}_hb