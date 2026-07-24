*** Settings ***
Documentation    播单VV事件测试
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case001 播单播放完整观看点播媒资
    [Tags]  P2
    到达我的页面入口
    确认键
    到达我的播单入口
    确认键
    清除历史上报数据
    点击文本  	我站在桥上看风景 第1集
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_049   ${datatable_prefix_apk}_play

case002 播单播放无前贴广告媒资
    [Tags]  P2
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_049   ${datatable_prefix_apk}_play

case003 播单全屏播放点播媒资
    [Tags]  P2
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_049   ${datatable_prefix_apk}_play

case004 播单播放试看点播媒资
    [Tags]  P2
    按返回直到出现文本  我的播单
    清除历史上报数据
    点击文本  	蜘蛛侠平行宇宙
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_050   ${datatable_prefix_apk}_play

case005 播单播放正片播媒资
    [Tags]  P2
    按返回直到出现文本  我的播单
    清除历史上报数据
    点击文本  	我站在桥上看风景 第1集
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_051   ${datatable_prefix_apk}_play

case006 全屏页自动连播播放点播视频
    [Tags]  P2
    清除历史上报数据
    按秒快进  20
    等待页面出现文本信息  正在播放  30
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_058   ${datatable_prefix_apk}_play

case007 非自动连播播放点播视频
    [Tags]  P2
    按返回直到出现文本  我的播单
    点击文本  	我站在桥上看风景 第1集
    等待  5
    按次数下移  2
    清除历史上报数据
    点击文本  我站在桥上看风景 第2集
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_057   ${datatable_prefix_apk}_play

case008 播单播放点播媒资第一集
    [Tags]  P2
    按返回直到出现文本  我的播单
    清除历史上报数据
    点击文本  	我站在桥上看风景 第1集
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_055   ${datatable_prefix_apk}_play

case009 播单播放点播媒资第二集
    [Tags]  P2
    按返回直到出现文本  我的播单
    清除历史上报数据
    点击文本  	我站在桥上看风景 第2集
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_056   ${datatable_prefix_apk}_play

