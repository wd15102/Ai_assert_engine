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
case_080 短视频主题页小窗播放_启播
    [Documentation]    启播事件
    到达短视频轮播入口
    清除历史上报数据
    确认键
    等待短视频主题页出现
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_080   ${datatable_prefix_apk}_splay

case_078 短视频主题页小窗播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_078   ${datatable_prefix_apk}_play

case_136 短视频主题页小窗手动切集_退出心跳
    [Documentation]    心跳事件
    按次数左移  1    2
    按次数上移  1
    等待页面出现内容描述信息  大芒短视频测试a1  10
    按次数右移  1    2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_136   ${datatable_prefix_apk}_hb

case_055 短视频主题页小窗手动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_055   ${datatable_prefix_apk}_stop

case_081 短视频主题页小窗手动切集_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_081   ${datatable_prefix_apk}_splay

case_079 短视频主题页小窗手动切集_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_079   ${datatable_prefix_apk}_play

case_097 短视频主题页小窗播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_097   ${datatable_prefix_apk}_hb

case_105 短视频主题页大小屏切换_启播
    [Documentation]    启播事件
    清除历史上报数据
    确认键  5
    获取校验结果_不上报      {'logtype': 'splay','bid':'26.4.1'}    test_105   ${datatable_prefix_apk}_splay

case_101 短视频主题页大小屏切换_VV
    [Documentation]    VV事件
    获取校验结果_不上报      {'logtype': 'play','bid':'26.1.1.0'}    test_101   ${datatable_prefix_apk}_play

case_139 短视频主题页大小屏切换_退出心跳
    [Documentation]    心跳事件
    获取校验结果_不上报  {'logtype': 'hb','bid':'26.1.25'}    test_139   ${datatable_prefix_apk}_hb

case_085 短视频主题页大小屏切换_退出stop
    [Documentation]    stop事件
    获取校验结果_不上报  {'logtype': 'stop','bid':'26.1.25'}    test_085   ${datatable_prefix_apk}_stop

case_016 短视频模板媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    短视频播放暂停
    获取校验结果      {'logtype': 'pause'}    test_016   ${datatable_prefix_apk}_pause

case_016 短视频模板媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_016   ${datatable_prefix_apk}_resume

case_098 短视频主题页全屏播放_5分钟心跳
    [Documentation]    心跳事件
    等待  190
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_098   ${datatable_prefix_apk}_hb

case_137 短视频主题页全屏播放_10分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_137   ${datatable_prefix_apk}_hb

case_096 短视频主题页小窗播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  跳转UP主视频
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_096   ${datatable_prefix_apk}_hb

case_054 短视频主题页小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_054   ${datatable_prefix_apk}_stop

case_104 短视频主题页小窗自动切集_启播
    [Documentation]    启播事件
    确认键
    等待短视频主题页出现
    等待  10
    清除历史上报数据
    等待  50
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_104   ${datatable_prefix_apk}_splay

case_100 短视频主题页小窗自动切集_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_100   ${datatable_prefix_apk}_play

case_100 短视频主题页小窗自动切集_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_100   ${datatable_prefix_apk}_hb

case_056 短视频主题页小窗自动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_056   ${datatable_prefix_apk}_stop

case_079 短视频主题页全屏播放_启播
    [Documentation]    启播事件
    按次数右移  2
    校验焦点是否在内容描述上  跳转UP主视频
    清除历史上报数据
    确认键  5
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_079   ${datatable_prefix_apk}_splay

case_077 短视频主题页全屏播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_077   ${datatable_prefix_apk}_play

case_053 短视频主题页全屏播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_053   ${datatable_prefix_apk}_drag

case_054 短视频主题页全屏播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_054   ${datatable_prefix_apk}_drag

case_099 短视频主题页全屏播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  跳转UP主视频
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_099   ${datatable_prefix_apk}_hb

case_084 短视频主题页全屏播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_084   ${datatable_prefix_apk}_stop

case_082 短视频主题页全屏手动切集_启播
    [Documentation]    启播事件
    校验焦点是否在内容描述上  跳转UP主视频
    按次数左移  2
    确认键
    等待短视频主题页出现
    确认键  5
    清除历史上报数据
    按次数下移  1
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_082   ${datatable_prefix_apk}_splay

case_080 短视频主题页全屏手动切集_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_080   ${datatable_prefix_apk}_play

case_138 短视频主题页全屏手动切集_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    等待  50
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_138   ${datatable_prefix_apk}_hb

case_058 短视频主题页全屏手动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_058   ${datatable_prefix_apk}_stop

case_083 短视频主题页全屏自动切集_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_083   ${datatable_prefix_apk}_splay

case_081 短视频主题页全屏自动切集_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_081   ${datatable_prefix_apk}_play

case_102 短视频主题页全屏自动切集_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_102   ${datatable_prefix_apk}_hb

case_141 短视频主题页媒资播放，按首页键退出，上报退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_141   ${datatable_prefix_apk}_hb

case_059 短视频主题页媒资播放，按首页键退出，上报退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_059   ${datatable_prefix_apk}_stop

case_057 短视频主题页全屏自动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_057   ${datatable_prefix_apk}_stop

case_084 短视频主题页进入作者主页点播媒资播放_启播
    [Documentation]    启播事件
    到达短视频轮播入口
    按次数右移  1
    校验焦点是否在内容描述上  跳转UP主
    确认键  5
    清除历史上报数据
    确认键  5
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_084   ${datatable_prefix_apk}_splay

case_082 短视频主题页进入作者主页点播媒资播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_082   ${datatable_prefix_apk}_play

case_055 短视频主题页进入作者主页点播媒资播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_055   ${datatable_prefix_apk}_drag

case_056 短视频主题页进入作者主页点播媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_056   ${datatable_prefix_apk}_drag

case_104 短视频主题页进入作者主页点播媒资播放_5分钟心跳
    [Documentation]    心跳事件
    等待  195
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_104   ${datatable_prefix_apk}_hb

case_105 短视频主题页进入作者主页点播媒资播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_105   ${datatable_prefix_apk}_hb

case_060 短视频主题页进入作者主页点播媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_060   ${datatable_prefix_apk}_stop

case_085 进入个人中心_我赞过短视频点播媒资_启播
    [Documentation]    启播事件
    按返回直到出现内容  跳转UP主
    按次数左移  2
    确认键  5
    按次数右移  3
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_085   ${datatable_prefix_apk}_splay

case_083 进入个人中心_我赞过短视频点播媒资_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_083   ${datatable_prefix_apk}_play

case_057 进入个人中心_我赞过短视频点播媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_057   ${datatable_prefix_apk}_drag

case_058 进入个人中心_我赞过短视频点播媒资_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_058   ${datatable_prefix_apk}_drag

case_101 进入个人中心_我赞过短视频点播媒资_5分钟心跳
    [Documentation]    心跳事件
    等待  195
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_101   ${datatable_prefix_apk}_hb

case_103 进入个人中心_我赞过短视频点播媒资_退出心跳
    [Documentation]    心跳事件
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_103   ${datatable_prefix_apk}_hb

case_061 进入个人中心_我赞过短视频点播媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_061   ${datatable_prefix_apk}_stop

case_140 短视频主题页媒资播放，按菜单键退出，上报退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_140   ${datatable_prefix_apk}_hb

case_086 短视频主题页媒资播放，按菜单键退出，上报退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_086   ${datatable_prefix_apk}_stop

case_092 短视频主题页进入播放失败媒资启播
    [Documentation]    启播事件
    到达短视频轮播入口
    确认键
    等待短视频主题页出现
    按次数左移  1    2
    按次数下移  1    3
    按次数右移  1
    确认键
    按次数右移  1
    确认键
    清除历史上报数据
    按次数下移  1    2
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_092   ${datatable_prefix_apk}_splay

case_086 短视频分屏小窗播放_启播
    [Documentation]    启播事件
    退出应用
    启动应用
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  纪实
    切换频道  测试
    清除历史上报数据
    切换频道  短视频
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_086   ${datatable_prefix_apk}_splay

case_084 短视频分屏小窗播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_084   ${datatable_prefix_apk}_play

case_106 短视频分屏小窗播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_106   ${datatable_prefix_apk}_hb

case_107 短视频分屏大小屏切换_启播
    [Documentation]    启播事件
    按次数下移  2
    清除历史上报数据
    确认键  10
    获取校验结果_不上报  {'logtype': 'splay','bid':'26.4.1'}    test_107   ${datatable_prefix_apk}_splay

case_103 短视频分屏大小屏切换_VV
    [Documentation]    VV事件
    获取校验结果_不上报  {'logtype': 'play','bid':'26.1.1.0'}    test_103   ${datatable_prefix_apk}_play

case_019 短视频分屏媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    短视频播放暂停
    获取校验结果      {'logtype': 'pause'}    test_019   ${datatable_prefix_apk}_pause

case_019 短视频分屏媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_019   ${datatable_prefix_apk}_resume

case_111 短视频分屏进入全屏播放_5分钟心跳
    [Documentation]    心跳事件
    等待  190
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_111   ${datatable_prefix_apk}_hb

case_145 短视频分屏大小屏切换_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数返回  1
    获取校验结果_不上报  {'logtype': 'hb','bid':'26.1.25'}    test_145   ${datatable_prefix_apk}_hb

case_089 短视频分屏大小屏切换_退出stop
    [Documentation]    stop事件
    获取校验结果_不上报  {'logtype': 'stop','bid':'26.1.25'}    test_089   ${datatable_prefix_apk}_stop

case_107 短视频分屏小窗播放_退出心跳
    [Documentation]    心跳事件
    按次数上移  1
    清除历史上报数据
    按次数右移  1    3
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_107   ${datatable_prefix_apk}_hb

case_062 短视频分屏小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_062   ${datatable_prefix_apk}_stop

case_087 短视频分屏小窗手动切集_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_087   ${datatable_prefix_apk}_splay

case_085 短视频分屏小窗手动切集_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_085   ${datatable_prefix_apk}_play

case_108 短视频分屏小窗手动切集_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    等待  50
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_108   ${datatable_prefix_apk}_hb

case_063 短视频分屏小窗手动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_063   ${datatable_prefix_apk}_stop

case_088 短视频分屏小窗自动切集_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_088   ${datatable_prefix_apk}_splay

case_086 短视频分屏小窗自动切集_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_086   ${datatable_prefix_apk}_play

case_109 短视频分屏小窗自动切集_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    切换频道  测试
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_109   ${datatable_prefix_apk}_hb

case_064 短视频分屏小窗自动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_064   ${datatable_prefix_apk}_stop

case_106 短视频分屏进入全屏播放_启播
    [Documentation]    启播事件
    切换频道  短视频
    等待  5
    按次数下移  1
    按次数右移  1    5
    按次数下移  1
    确认键
    清除历史上报数据
    按次数下移  1
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_106   ${datatable_prefix_apk}_splay

case_089 短视频分屏进入全屏手动切集_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_089   ${datatable_prefix_apk}_splay

case_087 短视频分屏进入全屏手动切集_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_087   ${datatable_prefix_apk}_play

case_102 短视频分屏进入全屏播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_102   ${datatable_prefix_apk}_play

case_059 短视频分屏进入全屏播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_059   ${datatable_prefix_apk}_drag

case_060 短视频分屏进入全屏播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_060   ${datatable_prefix_apk}_drag

case_142 短视频分屏进入全屏播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    等待  50
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_142   ${datatable_prefix_apk}_hb

case_110 短视频分屏进入全屏手动切集_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_110   ${datatable_prefix_apk}_hb

case_087 短视频分屏进入全屏播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_087   ${datatable_prefix_apk}_stop

case_065 短视频分屏进入全屏手动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_065   ${datatable_prefix_apk}_stop

case_090 短视频分屏进入全屏自动切集_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_090   ${datatable_prefix_apk}_splay

case_088 短视频分屏进入全屏自动切集_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_088   ${datatable_prefix_apk}_play

case_112 短视频分屏进入全屏自动切集_退出心跳
    [Documentation]    心跳事件
    确认键
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_112   ${datatable_prefix_apk}_hb

case_113 短视频分屏进入全屏暂停后，按首页键退出，上报退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_113   ${datatable_prefix_apk}_hb

case_067 短视频分屏进入全屏暂停后，按首页键退出，上报stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_067   ${datatable_prefix_apk}_stop

case_066 短视频分屏进入全屏自动切集_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_066   ${datatable_prefix_apk}_stop

case_091 短视频分屏点击推荐按钮进入点播媒资_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  纪实
    切换频道  测试
    切换频道  短视频
    等待  5
    按次数下移  2
    确认键
    等待媒资播放
    确认键
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_091   ${datatable_prefix_apk}_splay

case_089 短视频分屏点击推荐按钮进入点播媒资_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_089   ${datatable_prefix_apk}_play

case_143 短视频分屏点击推荐按钮进入点播媒资_退出心跳
    [Documentation]    心跳事件
    按返回直到出现元素  ${详情页收藏}
    清除历史上报数据
    详情页退出
    按返回直到不出现元素  ${详情页收藏}
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_143   ${datatable_prefix_apk}_hb

case_068 短视频分屏点击推荐按钮进入点播媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_068   ${datatable_prefix_apk}_stop

case_093 短视频分屏进入播放失败媒资启播
    [Documentation]    启播事件
    按返回直到焦点位于内容  短视频
    校验焦点是否在内容描述上  短视频
    按次数下移  1
    按次数右移  2
    等待  5
    按次数下移  1
    确认键  5
    清除历史上报数据
    按次数下移  1
    等待媒资播放
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_093   ${datatable_prefix_apk}_splay

case_144 短视频分屏进入全屏暂停后，按菜单键退出，上报退出心跳
    [Documentation]    心跳事件
    按次数上移  1    5
    确认键  1
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_144   ${datatable_prefix_apk}_hb

case_088 短视频分屏进入全屏暂停后，按菜单键退出，上报stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_088   ${datatable_prefix_apk}_stop
