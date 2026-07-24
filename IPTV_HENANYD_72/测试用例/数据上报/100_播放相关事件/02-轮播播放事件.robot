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
case_094 轮播主题小窗播放_启播
    [Documentation]    启播事件
    到达轮播主题小窗入口
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_094   ${datatable_prefix_apk}_splay

case_090 轮播主题小窗播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_090   ${datatable_prefix_apk}_play

case_116 轮播主题小窗播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_116   ${datatable_prefix_apk}_hb

case_070 轮播主题小窗播放_退出stop
    [Documentation]    stop事件
    清除历史上报数据
    按返回直到出现内容  跳轮播主题-指定频道
    校验焦点是否在内容描述上  跳轮播主题-指定频道
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_070   ${datatable_prefix_apk}_stop

case_117 轮播主题小窗播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_117   ${datatable_prefix_apk}_hb

case_095 轮播主题小窗切换频道_启播
    [Documentation]    启播事件
    确认键  8
    清除历史上报数据
    按次数上移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_095   ${datatable_prefix_apk}_splay

case_091 轮播主题小窗切换频道_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_091   ${datatable_prefix_apk}_play

case_071 轮播主题小窗切换频道_退出stop
    [Documentation]    stop事件
    清除历史上报数据
    按返回直到出现内容  跳轮播主题-指定频道
    校验焦点是否在内容描述上  跳轮播主题-指定频道
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_071   ${datatable_prefix_apk}_stop

case_118 轮播主题小窗切换频道_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_118   ${datatable_prefix_apk}_hb

case_096 轮播主题全屏播放_启播
    [Documentation]    启播事件
    按次数右移  1
    校验焦点是否在内容描述上  跳轮播主题全屏-指定频道
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_096   ${datatable_prefix_apk}_splay

case_092 轮播主题全屏播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_092   ${datatable_prefix_apk}_play

case_017 轮播主题进入全屏播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_017   ${datatable_prefix_apk}_pause

case_017 轮播主题进入全屏播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'resume'}    test_017   ${datatable_prefix_apk}_resume

case_119 轮播主题全屏播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_119   ${datatable_prefix_apk}_hb

case_120 轮播主题全屏播放_10分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_120   ${datatable_prefix_apk}_hb

case_072 轮播主题全屏播放_退出stop
    [Documentation]    stop事件
    清除历史上报数据
    按返回直到出现内容  跳轮播主题全屏-指定频道
    校验焦点是否在内容描述上  跳轮播主题全屏-指定频道
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_072   ${datatable_prefix_apk}_stop

case_121 轮播主题全屏播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_121   ${datatable_prefix_apk}_hb

case_097 轮播主题全屏切换频道_启播
    [Documentation]    启播事件
    确认键  10
    清除历史上报数据
    按次数上移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_097   ${datatable_prefix_apk}_splay

case_093 轮播主题全屏切换频道_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_093   ${datatable_prefix_apk}_play

case_073 轮播主题全屏切换频道_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_073   ${datatable_prefix_apk}_stop

case_122 轮播主题全屏切换频道_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_122   ${datatable_prefix_apk}_hb

case_098 进入轮播小屏，大小屏切换，检查启播
    [Documentation]    启播事件
    按返回直到出现内容  跳轮播主题全屏-指定频道
    校验焦点是否在内容描述上  跳轮播主题全屏-指定频道
    按次数左移  1
    确认键  10
    清除历史上报数据
    确认键
    等待元素出现  ${轮播全屏列表浮层}
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_098   ${datatable_prefix_apk}_splay

case_094 进入轮播小屏，大小屏切换，检查VV
    [Documentation]    VV事件
    等待  5
    清除历史上报数据
    按返回直到出现文本  按“OK”键全屏观看
#    按次数返回  1    5
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_094   ${datatable_prefix_apk}_play

case_074 小窗播放频道，大小屏切换，检查上报的stop事件
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_074   ${datatable_prefix_apk}_stop

case_123 小窗播放频道，大小屏切换，检查上报的心跳事件
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_123   ${datatable_prefix_apk}_hb

case_075 进入主题轮播页面，通过菜单键离开，检查上报的stop事件
    [Documentation]    stop事件
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_075   ${datatable_prefix_apk}_stop

case_124 轮播页面，通过菜单键离开，检查上报的心跳事件
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_124   ${datatable_prefix_apk}_hb

case_076 进入主题轮播页面，通过首页键离开，检查上报的stop事件
    [Documentation]    stop事件
    到达轮播主题小窗入口
    确认键  10
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_076   ${datatable_prefix_apk}_stop

case_125 轮播页面，通过首页键离开，检查上报的心跳事件
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_125   ${datatable_prefix_apk}_hb

case_099 轮播分屏通栏模板小窗播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  纪实
    清除历史上报数据
    切换频道  VIP
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_099   ${datatable_prefix_apk}_splay

case_095 轮播分屏通栏模板小窗播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_095   ${datatable_prefix_apk}_play

case_126 轮播分屏通栏模板小窗播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_126   ${datatable_prefix_apk}_hb

case_127 轮播分屏通栏模板小窗播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数左移  1
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_127   ${datatable_prefix_apk}_hb

case_077 轮播分屏通栏模板小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_077   ${datatable_prefix_apk}_stop

case_100 轮播分屏通栏模板小窗切频道_启播
    [Documentation]    启播事件
    按次数右移  1    5
    按次数下移  1
    按次数右移  1    2
    按次数下移  1    2
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_100   ${datatable_prefix_apk}_splay

case_096 轮播分屏通栏模板小窗切频道_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_096   ${datatable_prefix_apk}_play

case_128 轮播分屏通栏模板小窗切频道_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_128   ${datatable_prefix_apk}_hb

case_078 轮播分屏通栏模板小窗切频道_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_078   ${datatable_prefix_apk}_stop

case_101 轮播分屏通栏模板，大小屏切换，检查启播
    [Documentation]    启播事件
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_101   ${datatable_prefix_apk}_splay

case_097 轮播分屏通栏模板，大小屏切换，检查VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_097   ${datatable_prefix_apk}_play

case_129 轮播分屏通栏模板，大小屏切换，检查心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_129   ${datatable_prefix_apk}_hb

case_079 轮播分屏通栏模板，大小屏切换，检查stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_079   ${datatable_prefix_apk}_stop

case_102 轮播分屏通栏模板全屏播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数上移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_102   ${datatable_prefix_apk}_splay

case_103 轮播分屏通栏模板全屏切频道_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_103   ${datatable_prefix_apk}_splay

case_098 轮播分屏通栏模板全屏播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_098   ${datatable_prefix_apk}_play

case_099 轮播分屏通栏模板全屏切频道_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_099   ${datatable_prefix_apk}_play

case_130 轮播分屏通栏模板全屏切频道_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_130   ${datatable_prefix_apk}_hb

case_131 轮播分屏通栏模板全屏播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_131   ${datatable_prefix_apk}_hb

case_080 轮播分屏通栏模板全屏播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_080   ${datatable_prefix_apk}_stop

case_081 轮播分屏通栏模板全屏切频道_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_081   ${datatable_prefix_apk}_stop

case_018 轮播分屏进入全屏播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_018   ${datatable_prefix_apk}_pause

case_018 轮播分屏进入全屏播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'resume'}    test_018   ${datatable_prefix_apk}_resume

case_132 轮播分屏通栏模板全屏播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_132   ${datatable_prefix_apk}_hb

case_133 轮播分屏通栏模板全屏播放_10分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_133   ${datatable_prefix_apk}_hb

case_134 轮播分屏通栏模板，通过菜单键离开，检查退出心跳
    [Documentation]    心跳事件
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_134   ${datatable_prefix_apk}_hb

case_082 轮播分屏通栏模板，通过菜单键离开，检查退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_082   ${datatable_prefix_apk}_stop

case_135 轮播分屏通栏模板，通过首页键离开，检查退出心跳
    [Documentation]    心跳事件
    返回首页
    切换频道  少儿频道
    切换频道  纪实
    切换频道  VIP
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_135   ${datatable_prefix_apk}_hb

case_083 轮播分屏通栏模板，通过首页键离开，检查退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_083   ${datatable_prefix_apk}_stop

