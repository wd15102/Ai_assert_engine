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
case_202 轮播插入频道播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    数字键进直播  003
    等待  60
    清除历史上报数据
    直播切台  下
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_202   ${datatable_prefix_apk}_splay

case_195 轮播插入频道播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_195   ${datatable_prefix_apk}_play

case_072 轮播插入频道播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_072   ${datatable_prefix_apk}_pause

case_072 轮播插入频道播放_暂停后恢复
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_072   ${datatable_prefix_apk}_resume

case_298 轮播插入频道播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_298   ${datatable_prefix_apk}_hb

case_188 轮播插入频道播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_188   ${datatable_prefix_apk}_drag

case_299 轮播插入频道播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_299   ${datatable_prefix_apk}_hb

case_206 轮播插入频道播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_206   ${datatable_prefix_apk}_stop

case_073 轮播插入频道时移播放_暂停
    [Documentation]    pause事件
    等待  5
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_073   ${datatable_prefix_apk}_pause

case_073 轮播插入频道时移播放_暂停后恢复
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_073   ${datatable_prefix_apk}_resume

case_189 轮播插入频道播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快进  5
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_189   ${datatable_prefix_apk}_drag

case_300 轮播插入频道时移播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_300   ${datatable_prefix_apk}_hb

case_207 轮播插入频道时移播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_207   ${datatable_prefix_apk}_stop
