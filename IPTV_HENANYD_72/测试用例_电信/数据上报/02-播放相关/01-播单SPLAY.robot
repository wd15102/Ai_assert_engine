*** Settings ***
Documentation    播单splay事件测试
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case001 播单播放免费电影正片媒资
    [Tags]  P2
    到达我的页面入口
    确认键
    到达我的播单入口
    确认键
    清除历史上报数据
    点击文本  惊天破国语
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_054   ${datatable_prefix_apk}_splay

case002 播单播放试看电影正片媒资
    [Tags]  P2
    按返回直到出现文本  我的播单
    清除历史上报数据
    点击文本  蜘蛛侠平行宇宙
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_055   ${datatable_prefix_apk}_splay

case003 播单播放免费电视剧正片媒资
    [Tags]  P2
    按返回直到出现文本  我的播单
    清除历史上报数据
    点击文本  	我站在桥上看风景 第1集
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_056   ${datatable_prefix_apk}_splay

case004 播单自动连播电视剧媒资
    [Tags]  P2
    清除历史上报数据
    按秒快进  15
    等待  30
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_057   ${datatable_prefix_apk}_splay

case005 播单手动连播电视剧媒资
    [Tags]  P2
    按返回直到出现文本  我的播单
    点击文本  我站在桥上看风景 第1集
    等待  5
    按次数下移  2
    清除历史上报数据
    点击文本  我站在桥上看风景 第2集
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_058   ${datatable_prefix_apk}_splay

case006 播单播放免费电视剧正片媒资
    [Tags]  P2
    按返回直到出现文本  我的播单
    清除历史上报数据
    点击文本  	我站在桥上看风景 第1集
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_059   ${datatable_prefix_apk}_splay

case007 播单播放免费电视剧正片媒资
    [Tags]  P2
    按返回直到出现文本  我的播单
    清除历史上报数据
    点击文本  	我站在桥上看风景 第2集
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_060   ${datatable_prefix_apk}_splay
