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
case_109 简约版直播媒资播放_启播
    [Documentation]    启播事件
    到达切换模式入口
    确认键
    清除历史上报数据
    点击元素  ${简约版}
    等待元素出现  ${简约直播小窗播放器}
    等待媒资播放
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_109   ${datatable_prefix_apk}_splay

case_105 简约版直播媒资播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_105   ${datatable_prefix_apk}_play

case_022 简约版进入直播播放暂停
    [Documentation]    pause事件
    按次数下移  2
    校验焦点是否在元素上  ${简约直播小窗播放器}
    确认键  10
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_022   ${datatable_prefix_apk}_pause

case_022 简约版进入直播播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_022   ${datatable_prefix_apk}_resume

case_039 简约版直播媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  2
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_039   ${datatable_prefix_apk}_drag

case_040 简约版直播媒资播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快进  4
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_040   ${datatable_prefix_apk}_drag

case_148 简约版直播媒资播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_148   ${datatable_prefix_apk}_hb

case_149 简约版直播媒资播放_退出心跳
    [Documentation]    心跳事件
    按次数返回  1
    按次数上移  1
    按次数左移  1
    清除历史上报数据
    确认键
    等待观看历史页出现
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_149   ${datatable_prefix_apk}_hb

case_041 简约版直播媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_041   ${datatable_prefix_apk}_stop

case_108 简约版点播媒资播放_启播
    [Documentation]    启播事件
    按次数右移  1
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_108   ${datatable_prefix_apk}_splay

case_104 简约版点播媒资播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_104   ${datatable_prefix_apk}_play

case_041 简约版点播媒资播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快进  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_041   ${datatable_prefix_apk}_drag

case_042 简约版点播媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_042   ${datatable_prefix_apk}_drag

case_023 简约版进入点播播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_023   ${datatable_prefix_apk}_pause

case_023 简约版进入点播播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_023   ${datatable_prefix_apk}_resume

case_146 简约版点播媒资播放_5分钟心跳
    [Documentation]    心跳事件
    等待  190
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_146   ${datatable_prefix_apk}_hb

case_147 简约版点播媒资播放_退出心跳
    [Documentation]    心跳事件
    按次数返回  1
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_147   ${datatable_prefix_apk}_hb

case_042 简约版点播媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_042   ${datatable_prefix_apk}_stop

case_110 少儿版点播媒资播放_启播
    [Documentation]    启播事件
    按返回直到出现元素  ${简约直播小窗播放器}
    按次数上移  3
    按次数右移  1
    确认键
    点击元素  ${少儿版}
    等待元素出现  ${少儿开通会员}
    等待  10
    按次数左移  1
    校验焦点是否在内容描述上  母亲
    清除历史上报数据
    确认键
    等待详情页出现
    等待媒资播放
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_110   ${datatable_prefix_apk}_splay

case_106 少儿版点播媒资播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_106   ${datatable_prefix_apk}_play

case_061 少儿版点播媒资播放_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    按秒快进  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_061   ${datatable_prefix_apk}_drag

case_062 少儿版点播媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_062   ${datatable_prefix_apk}_drag

case_021 少儿版进入点播播放暂停
    [Documentation]    pause事件
    等待  3
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_021   ${datatable_prefix_apk}_pause

case_021 少儿版进入点播播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_021   ${datatable_prefix_apk}_resume

case_150 少儿版点播媒资播放_5分钟心跳
    [Documentation]    心跳事件
    等待  190
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_150   ${datatable_prefix_apk}_hb

case_151 少儿版点播媒资播放_退出心跳
    [Documentation]    心跳事件
    按次数返回  1
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_151   ${datatable_prefix_apk}_hb

case_090 少儿版点播媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_090   ${datatable_prefix_apk}_stop

case_111 少儿版直播媒资播放_启播
    [Documentation]    启播事件
    按次数下移  2
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_111   ${datatable_prefix_apk}_splay

case_107 少儿版直播媒资播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_107   ${datatable_prefix_apk}_play

case_020 少儿版进入直播播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_020   ${datatable_prefix_apk}_pause

case_020 少儿版进入直播播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_020   ${datatable_prefix_apk}_resume

case_063 少儿版直播媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_063   ${datatable_prefix_apk}_drag

case_064 少儿版直播媒资播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快进  5
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_064   ${datatable_prefix_apk}_drag

case_152 少儿版直播媒资播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_152   ${datatable_prefix_apk}_hb

case_153 少儿版直播媒资播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_153   ${datatable_prefix_apk}_hb

case_091 少儿版直播媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_091   ${datatable_prefix_apk}_stop

