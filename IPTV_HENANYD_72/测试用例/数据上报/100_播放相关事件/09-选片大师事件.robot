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
case_112 选片大师正片播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  纪实
    清除历史上报数据
    切换频道  专题
    按次数下移  1
    按次数下移  1    10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_112   ${datatable_prefix_apk}_splay

case_108 选片大师正片播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_108   ${datatable_prefix_apk}_play

case_124 选片大师播放爆点媒资_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_124   ${datatable_prefix_apk}_splay

case_120 选片大师播放爆点媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_120   ${datatable_prefix_apk}_play

case_028 选片大师正片播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_028   ${datatable_prefix_apk}_pause

case_040 选片大师播放爆点媒资_暂停
    [Documentation]    pause事件
    获取校验结果      {'logtype': 'pause'}    test_040   ${datatable_prefix_apk}_pause

case_157 选片大师正片播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_157   ${datatable_prefix_apk}_hb

case_028 选片大师正片播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_028   ${datatable_prefix_apk}_resume

case_040 选片大师播放爆点媒资_暂停后恢复播放
    [Documentation]    resume事件
    获取校验结果      {'logtype': 'resume'}    test_040   ${datatable_prefix_apk}_resume

case_091 选片大师正片播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_091   ${datatable_prefix_apk}_drag

case_115 选片大师播放爆点媒资_快进拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_115   ${datatable_prefix_apk}_drag

case_092 选片大师正片播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_092   ${datatable_prefix_apk}_drag

case_116 选片大师播放爆点媒资_快退拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_116   ${datatable_prefix_apk}_drag

case_113 选片大师正片手动切集播放_启播
    [Documentation]    启播事件
    确认键
    按次数左移  2
    确认键
    按次数左移  3
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_113   ${datatable_prefix_apk}_splay

case_109 选片大师正片手动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_109   ${datatable_prefix_apk}_play

case_158 选片大师正片播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_158   ${datatable_prefix_apk}_hb

case_120 选片大师正片播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_120   ${datatable_prefix_apk}_stop

case_171 选片大师播放爆点媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_171   ${datatable_prefix_apk}_hb

case_132 选片大师播放爆点媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_132   ${datatable_prefix_apk}_stop

case_029 选片大师正片手动切集播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_029   ${datatable_prefix_apk}_pause

case_029 选片大师正片手动切集播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_029   ${datatable_prefix_apk}_resume

case_093 选片大师正片手动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_093   ${datatable_prefix_apk}_drag

case_094 选片大师正片手动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_094   ${datatable_prefix_apk}_drag

case_114 选片大师正片合集内自动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按秒快进  10
    等待  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_114   ${datatable_prefix_apk}_splay

case_110 选片大师正片合集内自动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_110   ${datatable_prefix_apk}_play

case_160 选片大师正片手动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_160   ${datatable_prefix_apk}_hb

case_121 选片大师正片手动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_121   ${datatable_prefix_apk}_stop

case_030 选片大师正片合集内自动切集播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_030   ${datatable_prefix_apk}_pause

case_030 选片大师正片合集内自动切集播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_030   ${datatable_prefix_apk}_resume

case_095 选片大师正片合集内自动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快进  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_095   ${datatable_prefix_apk}_drag

case_096 选片大师正片合集内自动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_096   ${datatable_prefix_apk}_drag

case_115 选片大师由爆点集数切其他集再切回爆点集数播放_启播
    [Documentation]    启播事件
    确认键
    按次数左移  1
    确认键
    按次数右移  2
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_115   ${datatable_prefix_apk}_splay

case_111 选片大师由爆点集数切其他集再切回爆点集数播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_111   ${datatable_prefix_apk}_play

case_161 选片大师正片合集内自动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_161   ${datatable_prefix_apk}_hb

case_122 选片大师正片合集内自动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_122   ${datatable_prefix_apk}_stop

case_031 选片大师由爆点集数切其他集再切回爆点集数播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_031   ${datatable_prefix_apk}_pause

case_031 选片大师由爆点集数切其他集再切回爆点集数播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_031   ${datatable_prefix_apk}_resume

case_097 选片大师由爆点集数切其他集再切回爆点集数播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_097   ${datatable_prefix_apk}_drag

case_098 选片大师由爆点集数切其他集再切回爆点集数播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_098   ${datatable_prefix_apk}_drag

case_116 选片大师正片合集间手动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    15
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_116   ${datatable_prefix_apk}_splay

case_112 选片大师正片合集间手动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_112   ${datatable_prefix_apk}_play

case_162 选片大师由爆点集数切其他集再切回爆点集数播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_162   ${datatable_prefix_apk}_hb

case_123 选片大师由爆点集数切其他集再切回爆点集数播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_123   ${datatable_prefix_apk}_stop

case_032 选片大师正片合集间手动切集播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_032   ${datatable_prefix_apk}_pause

case_032 选片大师正片合集间手动切集播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  6
    获取校验结果      {'logtype': 'resume'}    test_032   ${datatable_prefix_apk}_resume

case_100 选片大师正片合集间手动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_100   ${datatable_prefix_apk}_drag

case_099 选片大师正片合集间手动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_099   ${datatable_prefix_apk}_drag

case_117 选片大师正片合集间自动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按秒快进  5
    等待  13
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_117   ${datatable_prefix_apk}_splay

case_113 选片大师正片合集间自动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_113   ${datatable_prefix_apk}_play

case_163 选片大师正片合集间手动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_163   ${datatable_prefix_apk}_hb

case_124 选片大师正片合集间手动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_124   ${datatable_prefix_apk}_stop

case_033 选片大师正片合集间自动切集播放_暂停
    [Documentation]    pause事件
    等待  5
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_033   ${datatable_prefix_apk}_pause

case_033 选片大师正片合集间自动切集播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  6
    获取校验结果      {'logtype': 'resume'}    test_033   ${datatable_prefix_apk}_resume

case_101 选片大师正片合集间自动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_101   ${datatable_prefix_apk}_drag

case_102 选片大师正片合集间自动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_102   ${datatable_prefix_apk}_drag

case_125 选片大师播放试看媒资_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    15
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_125   ${datatable_prefix_apk}_splay

case_121 选片大师播放试看媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_121   ${datatable_prefix_apk}_play

case_164 选片大师正片合集间自动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_164   ${datatable_prefix_apk}_hb

case_125 选片大师正片合集间自动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_125   ${datatable_prefix_apk}_stop

case_041 选片大师播放试看媒资_暂停
    [Documentation]    pause事件
    等待页面不出现文本信息  蜘蛛侠：平行宇宙
    清除历史上报数据
    确认键  5
    获取校验结果      {'logtype': 'pause'}    test_041   ${datatable_prefix_apk}_pause

case_041 选片大师播放试看媒资_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  6
    获取校验结果      {'logtype': 'resume'}    test_041   ${datatable_prefix_apk}_resume

case_117 选片大师播放试看媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_117   ${datatable_prefix_apk}_drag

case_118 选片大师播放试看媒资_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_118   ${datatable_prefix_apk}_drag

case_174 选片大师播放媒资按首页键退出_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_174   ${datatable_prefix_apk}_hb

case_135 选片大师播放媒资按首页键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_135   ${datatable_prefix_apk}_stop

case_172 选片大师播放试看媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_172   ${datatable_prefix_apk}_hb

case_133 选片大师播放试看媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_133   ${datatable_prefix_apk}_stop

case_118 选片大师短视频播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  纪实
    切换频道  专题
    等待  5
    按次数下移  5
    等待  10
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_118   ${datatable_prefix_apk}_splay

case_114 选片大师短视频播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_114   ${datatable_prefix_apk}_play

case_104 选片大师短视频播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_104   ${datatable_prefix_apk}_drag

case_103 选片大师短视频播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_103   ${datatable_prefix_apk}_drag

case_121 选片大师短视频跳转详情页播放_启播
    [Documentation]    启播事件
    等待文本出现  妻子的秘密_推荐正片  30
    清除历史上报数据
    确认键  7
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_121   ${datatable_prefix_apk}_splay

case_117 选片大师短视频跳转详情页播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_117   ${datatable_prefix_apk}_play

case_165 选片大师短视频播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_165   ${datatable_prefix_apk}_hb

case_126 选片大师短视频播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_126   ${datatable_prefix_apk}_stop

case_109 选片大师短视频跳转详情页播放_快进拖拽
    [Documentation]    drag事件
    按次数左移  2    2
    确认键  5
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_109   ${datatable_prefix_apk}_drag

case_110 选片大师短视频跳转详情页播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_110   ${datatable_prefix_apk}_drag

case_168 选片大师短视频跳转详情页播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现元素  ${详情页收藏}
    详情页退出
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_168   ${datatable_prefix_apk}_hb

case_129 选片大师短视频跳转详情页播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_129   ${datatable_prefix_apk}_stop

case_122 选片大师播放推荐插入正片_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    5
    等待页面不出现文本信息  妻子的秘密_推荐正片  15
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_122   ${datatable_prefix_apk}_splay

case_118 选片大师播放推荐插入正片_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0','vid':'32021040808460813269912254489218'}    test_118   ${datatable_prefix_apk}_play

case_038 选片大师播放推荐插入正片_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_038   ${datatable_prefix_apk}_pause

case_038 选片大师播放推荐插入正片_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    等待页面不出现文本信息  妻子的秘密_推荐正片  20
    获取校验结果      {'logtype': 'resume'}    test_038   ${datatable_prefix_apk}_resume

case_111 选片大师播放推荐插入正片_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_111   ${datatable_prefix_apk}_drag

case_112 选片大师播放推荐插入正片_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    2
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_112   ${datatable_prefix_apk}_drag

case_119 选片大师短视频手动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_119   ${datatable_prefix_apk}_splay

case_115 选片大师短视频手动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_115   ${datatable_prefix_apk}_play

case_169 选片大师播放推荐插入正片_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_169   ${datatable_prefix_apk}_hb

case_130 选片大师播放推荐插入正片_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_130   ${datatable_prefix_apk}_stop

case_159 选片大师短视频播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_159   ${datatable_prefix_apk}_hb

#case_035 选片大师短视频手动切集播放_暂停
#    [Documentation]    pause事件
#    清除历史上报数据
#    暂停键
#    获取校验结果      {'logtype': 'pause'}    test_035   ${datatable_prefix_apk}_pause
#
#case_035 选片大师短视频手动切集播放_暂停后恢复播放
#    [Documentation]    resume事件
#    清除历史上报数据
#    暂停键
#    获取校验结果      {'logtype': 'resume'}    test_035   ${datatable_prefix_apk}_resume

case_105 选片大师短视频手动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_105   ${datatable_prefix_apk}_drag

case_106 选片大师短视频手动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_106   ${datatable_prefix_apk}_drag

case_120 选片大师短视频自动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按秒快进  10
    等待  2
    等待页面不出现文本信息  短视频_活动标识   10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_120   ${datatable_prefix_apk}_splay

case_116 选片大师短视频自动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_116   ${datatable_prefix_apk}_play

case_166 选片大师短视频手动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_166   ${datatable_prefix_apk}_hb

case_127 选片大师短视频手动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_127   ${datatable_prefix_apk}_stop

#case_036 选片大师短视频自动切集播放_暂停
#    [Documentation]    pause事件
#    清除历史上报数据
#    暂停键
#    获取校验结果      {'logtype': 'pause'}    test_036   ${datatable_prefix_apk}_pause
#
#case_036 选片大师短视频自动切集播放_暂停后恢复播放
#    [Documentation]    resume事件
#    清除历史上报数据
#    暂停键
#    获取校验结果      {'logtype': 'resume'}    test_036   ${datatable_prefix_apk}_resume

case_108 选片大师短视频自动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_108   ${datatable_prefix_apk}_drag

case_107 选片大师短视频自动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_107   ${datatable_prefix_apk}_drag

case_123 选片大师播放推荐插入短视频_启播
    [Documentation]    启播事件
    等待文本出现  推荐短视频  15
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_123   ${datatable_prefix_apk}_splay

case_119 选片大师播放推荐插入短视频_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_119   ${datatable_prefix_apk}_play

case_167 选片大师短视频自动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_167   ${datatable_prefix_apk}_hb

case_128 选片大师短视频自动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_128   ${datatable_prefix_apk}_stop

#case_039 选片大师播放推荐插入短视频_暂停
#    [Documentation]    pause事件
#    清除历史上报数据
#    确认键
#    获取校验结果      {'logtype': 'pause'}    test_028   ${datatable_prefix_apk}_pause
#
#case_039 选片大师播放推荐插入短视频_暂停后恢复播放
#    [Documentation]    resume事件
#    清除历史上报数据
#    确认键  10
#    获取校验结果      {'logtype': 'resume'}    test_028   ${datatable_prefix_apk}_resume

case_113 选片大师播放推荐插入短视频_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_113   ${datatable_prefix_apk}_drag

case_114 选片大师播放推荐插入短视频_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_114   ${datatable_prefix_apk}_drag

case_173 选片大师播放媒资按菜单键退出_退出心跳
    [Documentation]    心跳事件
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_173   ${datatable_prefix_apk}_hb

case_134 选片大师播放媒资按菜单键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_134   ${datatable_prefix_apk}_stop

case_170 选片大师播放推荐插入短视频_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_170   ${datatable_prefix_apk}_hb

case_131 选片大师播放推荐插入短视频_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_131   ${datatable_prefix_apk}_stop
