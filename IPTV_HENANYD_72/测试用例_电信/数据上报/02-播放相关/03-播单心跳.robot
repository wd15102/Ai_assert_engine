*** Settings ***
Documentation    播单心跳
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case001 播单播放点播媒资5分钟
    [Tags]  P2    
    到达我的页面入口
    确认键
    等待  5
    到达我的播单入口
    确认键
    点击文本  	我站在桥上看风景 第1集
    等待  220
    清除历史上报数据
    等待  100
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_197   ${datatable_prefix_apk}_hb

case002 播单播放点播媒资第一个心跳
    [Tags]  P2    
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_199   ${datatable_prefix_apk}_hb

case003 播单播放免费媒资
    [Tags]  P2    
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_203   ${datatable_prefix_apk}_hb

case004 播单播放正片媒资上报心跳
    [Tags]  P2    
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_205   ${datatable_prefix_apk}_hb

case005 播单播放免费非试看媒资上报心跳
    [Tags]  P2    
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_201   ${datatable_prefix_apk}_hb

case006 播单播放点播媒资第二个心跳
    [Tags]  P2    
    清除历史上报数据
    等待  300
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_200   ${datatable_prefix_apk}_hb

case007 播单播放点播媒资手动退出
    [Tags]  P2    
    清除历史上报数据
    按返回直到出现文本  我的播单
    等待  5
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_198   ${datatable_prefix_apk}_hb

case008 播单播放付费试看媒资上报心跳
    [Tags]  P2    
    点击文本    蜘蛛侠平行宇宙
    清除历史上报数据
    按返回直到出现文本  我的播单
    等待  5
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_202   ${datatable_prefix_apk}_hb

case009 播单播放付费媒资
    [Tags]  P2    
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_204   ${datatable_prefix_apk}_hb

case010 播单播放非自动连播上报心跳
    [Tags]  P2
    到达我的页面入口
    确认键
    到达我的播单入口
    确认键
    点击文本    我站在桥上看风景 第1集
    等待  2
    按次数下移  2
    点击文本  我站在桥上看风景 第2集
    等待  220
    清除历史上报数据
    等待  100
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_207   ${datatable_prefix_apk}_hb

case011 播单播放自动连播上报心跳
    [Tags]  P2    
    按返回直到出现文本  我的播单
    点击文本    我站在桥上看风景 第1集
    按秒快进  12
    等待页面出现文本信息  正在播放：我站在桥上看风景 第2集  60
    等待  220
    清除历史上报数据
    等待  100
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_208   ${datatable_prefix_apk}_hb

case012 播单播放手动切换到下一集上报退出心跳
    [Tags]  P2    
    按返回直到出现文本  我的播单
    点击文本    我站在桥上看风景 第1集
    按次数下移  2
    清除历史上报数据
    点击文本  我站在桥上看风景 第2集
    等待  5
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_209   ${datatable_prefix_apk}_hb

case013 播单播放自动切换到下一集上报退出心跳
    [Tags]  P2    
    按返回直到出现文本  我的播单
    点击文本    我站在桥上看风景 第1集
    清除历史上报数据
    按秒快进  10
    等待  10
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_210   ${datatable_prefix_apk}_hb

case014 播单播放试看结束上报退出心跳
    [Tags]  P2    
    按返回直到出现文本  我的播单
    点击文本    蜘蛛侠平行宇宙
    清除历史上报数据
    按秒快进  3
    等待  5
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_212   ${datatable_prefix_apk}_hb

case015 播单播放试看媒资点击确认上报退出心跳
    [Tags]  P2    
    按返回直到出现文本  我的播单
    点击文本    蜘蛛侠平行宇宙
    清除历史上报数据
    确认键
    确认键
    等待  5
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_211   ${datatable_prefix_apk}_hb