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
case_027 数字键进入直播_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    清除历史上报数据
    数字键进直播  001
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_027   ${datatable_prefix_apk}_splay

case_027 数字键进入直播_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_027   ${datatable_prefix_apk}_play

case_013 直播播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_013   ${datatable_prefix_apk}_pause

case_013 直播播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_013   ${datatable_prefix_apk}_resume

case_034 数字键进入直播_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_034   ${datatable_prefix_apk}_hb

case_034 数字键进入直播_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_034   ${datatable_prefix_apk}_stop

case_026 直播播放多次暂停
    [Documentation]    pause事件
    等待  5
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_026   ${datatable_prefix_apk}_pause

case_026 直播播放多次暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_026   ${datatable_prefix_apk}_resume

case_026 直播全屏上下键切台_启播
    [Documentation]    启播事件
    清除历史上报数据
    直播切台    下
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_026   ${datatable_prefix_apk}_splay

case_026 直播全屏上下键切台_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_026   ${datatable_prefix_apk}_play

case_029 直播全屏浮层切台_启播
    [Documentation]    启播事件
    直播呼出浮层
    按次数上移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_029   ${datatable_prefix_apk}_splay

case_029 直播全屏浮层切台_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_029   ${datatable_prefix_apk}_play

case_035 直播全屏上下键切台_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_035   ${datatable_prefix_apk}_hb

case_025 直播全屏上下键切台_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_025   ${datatable_prefix_apk}_stop

case_039 直播全屏浮层切台_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_039   ${datatable_prefix_apk}_hb

case_027 直播全屏浮层切台_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_027   ${datatable_prefix_apk}_stop

case_024 直播小窗播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    清除历史上报数据
    切换频道  直播
    等待  5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_024   ${datatable_prefix_apk}_splay

case_024 直播小窗播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_024   ${datatable_prefix_apk}_play

case_030 直播小窗播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_030   ${datatable_prefix_apk}_hb

case_036 直播大小屏切换_启播
    [Documentation]    启播事件
    按次数下移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_036   ${datatable_prefix_apk}_splay

case_033 直播分屏进入直播_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_033   ${datatable_prefix_apk}_splay

case_036 直播大小屏切换_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_036   ${datatable_prefix_apk}_play

case_033 直播分屏进入直播_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_033   ${datatable_prefix_apk}_play

case_032 直播大小屏切换_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_032   ${datatable_prefix_apk}_hb

case_024 直播大小屏切换_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_024   ${datatable_prefix_apk}_stop

case_040 直播分屏进入直播_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_040   ${datatable_prefix_apk}_hb

case_103 直播分屏进入直播_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_103   ${datatable_prefix_apk}_stop

case_031 直播小窗播放_退出心跳
    [Documentation]    心跳事件
    等待  5
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_031   ${datatable_prefix_apk}_hb

case_023 直播小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_023   ${datatable_prefix_apk}_stop

case_048 直播小窗播放首页键退出_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_048   ${datatable_prefix_apk}_hb

case_107 直播小窗播放首页键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_107   ${datatable_prefix_apk}_stop

case_031 首页进入直播_启播
    [Documentation]    启播事件
    清除历史上报数据
    点击元素  ${精选直播}
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_031   ${datatable_prefix_apk}_splay

case_035 直播全屏播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_035   ${datatable_prefix_apk}_splay

case_031 首页进入直播_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_031   ${datatable_prefix_apk}_play

case_035 直播全屏播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_035   ${datatable_prefix_apk}_play

case_036 直播全屏播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_036   ${datatable_prefix_apk}_hb

case_033 首页进入直播_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_033   ${datatable_prefix_apk}_hb

case_038 直播全屏播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_038   ${datatable_prefix_apk}_hb

case_101 首页进入直播_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_101   ${datatable_prefix_apk}_stop

case_026 直播全屏播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_026   ${datatable_prefix_apk}_stop

case_025 全局菜单进入直播_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    菜单键
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_025   ${datatable_prefix_apk}_splay

case_025 全局菜单进入直播_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_025   ${datatable_prefix_apk}_play

case_037 全局菜单进入直播_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_037   ${datatable_prefix_apk}_hb

case_102 全局菜单进入直播_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_102   ${datatable_prefix_apk}_stop

case_038 快退进入时移播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    数字键进直播  001
    清除历史上报数据
    按秒快退  4
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_038   ${datatable_prefix_apk}_splay

case_038 快退进入时移播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_038   ${datatable_prefix_apk}_play

case_020 快退进入时移播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_020   ${datatable_prefix_apk}_drag

case_021 快退进入时移播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_021   ${datatable_prefix_apk}_drag

case_014 时移播放暂停
    [Documentation]    pause事件
    等待  3
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_014   ${datatable_prefix_apk}_pause

case_014 时移播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_014   ${datatable_prefix_apk}_resume

case_058 快退进入时移播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_058   ${datatable_prefix_apk}_hb

case_060 快退进入时移播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按秒快进  6
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_060   ${datatable_prefix_apk}_hb

case_028 快退进入时移播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_028   ${datatable_prefix_apk}_stop

case_030 时移进入直播_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_030   ${datatable_prefix_apk}_splay

case_030 时移进入直播_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_030   ${datatable_prefix_apk}_play

case_022 时移进入直播_快进拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_022   ${datatable_prefix_apk}_drag

case_042 时移进入直播_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_042   ${datatable_prefix_apk}_hb

case_104 时移进入直播_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_104   ${datatable_prefix_apk}_stop

case_044 直播进入回看_启播
    [Documentation]    启播事件
    退出应用
    启动应用
    返回首页
    返回精选页
    数字键进直播  002
    清除历史上报数据
    直播播放进回看播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_044   ${datatable_prefix_apk}_splay

case_044 直播进入回看_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_044   ${datatable_prefix_apk}_play

case_083 直播进入回看_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_083   ${datatable_prefix_apk}_drag

case_084 直播进入回看_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_084   ${datatable_prefix_apk}_drag

case_015 回看播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_015   ${datatable_prefix_apk}_pause

case_015 回看播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_015   ${datatable_prefix_apk}_resume

case_027 回看播放多次暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_027   ${datatable_prefix_apk}_pause

case_027 回看播放多次暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_027   ${datatable_prefix_apk}_resume

case_053 直播进入回看_退出心跳
    [Documentation]    心跳事件
    回看呼出浮层
    按次数左移  2
    按次数下移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_053   ${datatable_prefix_apk}_hb

case_114 直播进入回看_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_114   ${datatable_prefix_apk}_stop

case_071 回看播放器进入直播_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_071   ${datatable_prefix_apk}_splay

case_070 回看播放器进入直播_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_070   ${datatable_prefix_apk}_play

case_059 回看播放器进入直播_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_059   ${datatable_prefix_apk}_hb

case_105 回看播放器进入直播_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_105   ${datatable_prefix_apk}_stop

case_056 直播全屏播放首页键退出_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_056   ${datatable_prefix_apk}_hb

case_109 直播全屏播放首页键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_109   ${datatable_prefix_apk}_stop

case_028 回看列表进入直播_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  直播
    直播频道进入回看列表
    按次数右移  2
    清除历史上报数据
    确认键  8
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_028   ${datatable_prefix_apk}_splay

case_028 回看列表进入直播_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_028   ${datatable_prefix_apk}_play

case_045 回看列表进入直播_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  直播
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_045   ${datatable_prefix_apk}_hb

case_029 回看列表进入直播_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_029   ${datatable_prefix_apk}_stop

case_049 直播小窗播放菜单键退出_退出心跳
    [Documentation]    心跳事件
    返回首页
    返回精选页
    切换频道  直播
    等待文本出现  正在直播
    等待  10
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_049   ${datatable_prefix_apk}_hb

case_108 直播小窗播放菜单键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_108   ${datatable_prefix_apk}_stop

case_034 九屏同看进入直播_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  直播
    清除历史上报数据
    点击内容描述  九屏同看
#    确认键  8
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_034   ${datatable_prefix_apk}_splay

case_034 九屏同看进入直播_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_034   ${datatable_prefix_apk}_play

case_041 九屏同看进入直播_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_041   ${datatable_prefix_apk}_hb

case_106 九屏同看进入直播_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_106   ${datatable_prefix_apk}_stop

case_032 直播试看频道播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    清除历史上报数据
    数字键进直播  005
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_032   ${datatable_prefix_apk}_splay

case_032 直播试看频道播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_032   ${datatable_prefix_apk}_play

case_047 直播试看频道播放_退出心跳
    [Documentation]    心跳事件
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_047   ${datatable_prefix_apk}_hb

case_100 直播试看频道播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_100   ${datatable_prefix_apk}_stop

case_057 直播全屏播放菜单键退出_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_057   ${datatable_prefix_apk}_hb

case_110 直播全屏播放菜单键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_110   ${datatable_prefix_apk}_stop

case_070 暂停进入时移播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    数字键进直播  001
    暂停键
    等待  180
    清除历史上报数据
    暂停恢复
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_070   ${datatable_prefix_apk}_splay

case_069 暂停进入时移播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_069   ${datatable_prefix_apk}_play

case_023 暂停进入时移播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  2
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_023   ${datatable_prefix_apk}_drag

case_027 暂停进入时移播放_快进拖拽
    [Documentation]    drag事件
    等待  3
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_027   ${datatable_prefix_apk}_drag

case_061 暂停进入时移播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_061   ${datatable_prefix_apk}_hb

case_033 暂停进入时移播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_033   ${datatable_prefix_apk}_stop

case_062 时移播放首页键退出_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_062   ${datatable_prefix_apk}_hb

case_111 时移播放首页键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_111   ${datatable_prefix_apk}_stop

case_063 时移播放菜单键退出_退出心跳
    [Documentation]    心跳事件
    返回首页
    返回精选页
    数字键进直播  001
    按秒快退  3
    菜单键
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_063   ${datatable_prefix_apk}_hb

case_112 时移播放菜单键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_112   ${datatable_prefix_apk}_stop

case_043 回看全屏播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  直播
    直播频道进入回看列表
    按次数右移  1
    按次数上移  1
    按次数右移  1
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_043   ${datatable_prefix_apk}_splay

case_040 回看列表进入回看_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_040   ${datatable_prefix_apk}_splay

case_040 回看列表进入回看_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_040   ${datatable_prefix_apk}_play

case_043 回看全屏播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_043   ${datatable_prefix_apk}_play

case_024 回看全屏播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_024   ${datatable_prefix_apk}_drag

case_087 回看列表进入回看_快进拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_087   ${datatable_prefix_apk}_drag

case_025 回看全屏播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_025   ${datatable_prefix_apk}_drag

case_088 回看列表进入回看_快退拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_088   ${datatable_prefix_apk}_drag

case_050 回看全屏播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_050   ${datatable_prefix_apk}_hb

case_055 回看全屏播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_055   ${datatable_prefix_apk}_hb

case_043 回看列表进入回看_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_043   ${datatable_prefix_apk}_hb

case_116 回看列表进入回看_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_116   ${datatable_prefix_apk}_stop

case_032 回看全屏播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_032   ${datatable_prefix_apk}_stop

case_064 回看播放首页键退出_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_064   ${datatable_prefix_apk}_hb

case_118 回看播放首页键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_118   ${datatable_prefix_apk}_stop

case_042 全局菜单进入回看_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    菜单键
    等待页面出现元素信息  ${全局菜单精选}
    按次数右移  2
    校验焦点是否在元素上  ${全局菜单回看}
    确认键  3
    按次数下移  1    3
    按次数右移  1
    按次数上移  1    3
    按次数右移  1    2
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_042   ${datatable_prefix_apk}_splay

case_042 全局菜单进入回看_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_042   ${datatable_prefix_apk}_play

case_046 回看播放不存在前贴片_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_046   ${datatable_prefix_apk}_splay

case_046 回看播放不存在前贴片_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_046   ${datatable_prefix_apk}_play

case_089 全局菜单进入回看_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_089   ${datatable_prefix_apk}_drag

case_081 回看播放不存在前贴片_快进拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_081   ${datatable_prefix_apk}_drag

case_090 全局菜单进入回看_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_090   ${datatable_prefix_apk}_drag

case_082 回看播放不存在前贴片_快退拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_082   ${datatable_prefix_apk}_drag

case_044 全局菜单进入回看_退出心跳
    [Documentation]    心跳事件
    回看呼出浮层
    按次数下移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_044   ${datatable_prefix_apk}_hb

case_117 全局菜单进入回看_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_117   ${datatable_prefix_apk}_stop

case_054 回看播放不存在前贴片_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_054   ${datatable_prefix_apk}_hb

case_113 回看播放不存在前贴片_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_113   ${datatable_prefix_apk}_stop

case_047 回看全屏手动切集_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_047   ${datatable_prefix_apk}_splay

case_047 回看全屏手动切集_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_047   ${datatable_prefix_apk}_play

case_026 回看全屏手动切集_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_026   ${datatable_prefix_apk}_drag

case_028 回看全屏手动切集_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_028   ${datatable_prefix_apk}_drag

case_052 回看全屏手动切集_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按秒快进  10
    等待  30
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_052   ${datatable_prefix_apk}_hb

case_031 回看全屏手动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_031   ${datatable_prefix_apk}_stop

case_048 回看全屏自动切集_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_048   ${datatable_prefix_apk}_splay

case_048 回看全屏自动切集_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_048   ${datatable_prefix_apk}_play

case_030 回看全屏自动切集_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_030   ${datatable_prefix_apk}_drag

case_029 回看全屏自动切集_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_029   ${datatable_prefix_apk}_drag

case_089 回看全屏自动切集_退出心跳
    [Documentation]    心跳事件
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_089   ${datatable_prefix_apk}_hb

case_035 回看全屏自动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_035   ${datatable_prefix_apk}_stop

case_065 回看播放菜单键退出_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_065   ${datatable_prefix_apk}_hb

case_119 回看播放菜单键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_119   ${datatable_prefix_apk}_stop

case_039 时移进入回看_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    数字键进直播  001
    按秒快退  3
    直播呼出浮层
    按次数右移  1    2
    按次数上移  1
    按次数右移  1
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_039   ${datatable_prefix_apk}_splay

case_039 时移进入回看_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_039   ${datatable_prefix_apk}_play

case_085 时移进入回看_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_085   ${datatable_prefix_apk}_drag

case_086 时移进入回看_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_086   ${datatable_prefix_apk}_drag

case_046 时移进入回看_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_046   ${datatable_prefix_apk}_hb

case_115 时移进入回看_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_115   ${datatable_prefix_apk}_stop

#case_045 回看播放存在前贴片_启播
#case_045 回看播放存在前贴片_VV
#case_079 回看播放存在前贴片_快进拖拽
#case_080 回看播放存在前贴片_快退拖拽
#case_051 回看播放存在前贴片_退出心跳
#case_030 回看播放存在前贴片_退出stop

