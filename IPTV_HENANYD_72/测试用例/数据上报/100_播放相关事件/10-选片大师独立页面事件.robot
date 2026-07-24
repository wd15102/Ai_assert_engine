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
case_129 选片大师独立页面正片播放_启播
    [Documentation]    启播事件
    到达选片大师独立页入口
    清除历史上报数据
    确认键  5
    按次数下移  1    10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_129   ${datatable_prefix_apk}_splay

case_124 选片大师独立页面正片播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_124   ${datatable_prefix_apk}_play

case_141 选片大师独立页面播放爆点媒资_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_141   ${datatable_prefix_apk}_splay

case_136 选片大师独立页面播放爆点媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_136   ${datatable_prefix_apk}_play

case_042 选片大师独立页面正片播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_042   ${datatable_prefix_apk}_pause

case_054 选片大师独立页面播放爆点媒资_暂停
    [Documentation]    pause事件
    获取校验结果      {'logtype': 'pause'}    test_054   ${datatable_prefix_apk}_pause

case_179 选片大师独立页面正片播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_179   ${datatable_prefix_apk}_hb

case_042 选片大师独立页面正片播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_042   ${datatable_prefix_apk}_resume

case_054 选片大师独立页面播放爆点媒资_暂停后恢复播放
    [Documentation]    resume事件
    获取校验结果      {'logtype': 'resume'}    test_054   ${datatable_prefix_apk}_resume

case_119 选片大师独立页面正片播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_119   ${datatable_prefix_apk}_drag

case_143 选片大师独立页面播放爆点媒资_快进拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_143   ${datatable_prefix_apk}_drag

case_120 选片大师独立页面正片播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_120   ${datatable_prefix_apk}_drag

case_144 选片大师独立页面播放爆点媒资_快退拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_144   ${datatable_prefix_apk}_drag

case_130 选片大师独立页面正片手动切集播放_启播
    [Documentation]    启播事件
    确认键
    按次数左移  2
    确认键
    按次数左移  3
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_130   ${datatable_prefix_apk}_splay

case_125 选片大师独立页面正片手动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_125   ${datatable_prefix_apk}_play

case_180 选片大师独立页面正片播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_180   ${datatable_prefix_apk}_hb

case_138 选片大师独立页面正片播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_138   ${datatable_prefix_apk}_stop

case_193 选片大师独立页面播放爆点媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_193   ${datatable_prefix_apk}_hb

case_150 选片大师独立页面播放爆点媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_150   ${datatable_prefix_apk}_stop

case_043 选片大师独立页面正片手动切集播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_043   ${datatable_prefix_apk}_pause

case_043 选片大师独立页面正片手动切集播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_043   ${datatable_prefix_apk}_resume

case_121 选片大师独立页面正片手动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_121   ${datatable_prefix_apk}_drag

case_122 选片大师独立页面正片手动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_122   ${datatable_prefix_apk}_drag

case_131 选片大师独立页面正片合集内自动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按秒快进  10
    等待  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_131   ${datatable_prefix_apk}_splay

case_126 选片大师独立页面正片合集内自动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_126   ${datatable_prefix_apk}_play

case_182 选片大师独立页面正片手动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_182   ${datatable_prefix_apk}_hb

case_139 选片大师独立页面正片手动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_139   ${datatable_prefix_apk}_stop

case_044 选片大师独立页面正片合集内自动切集播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_044   ${datatable_prefix_apk}_pause

case_044 选片大师独立页面正片合集内自动切集播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_044   ${datatable_prefix_apk}_resume

case_123 选片大师独立页面正片合集内自动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快进  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_123   ${datatable_prefix_apk}_drag

case_124 选片大师独立页面正片合集内自动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_124   ${datatable_prefix_apk}_drag

case_132 选片大师独立页面由爆点集数切其他集再切回爆点集数播放_启播
    [Documentation]    启播事件
    确认键
    按次数左移  1
    确认键
    按次数右移  2
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_132   ${datatable_prefix_apk}_splay

case_127 选片大师独立页面由爆点集数切其他集再切回爆点集数播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_127   ${datatable_prefix_apk}_play

case_183 选片大师独立页面正片合集内自动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_183   ${datatable_prefix_apk}_hb

case_140 选片大师独立页面正片合集内自动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_140   ${datatable_prefix_apk}_stop

case_045 选片大师独立页面由爆点集数切其他集再切回爆点集数播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_045   ${datatable_prefix_apk}_pause

case_045 选片大师独立页面由爆点集数切其他集再切回爆点集数播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_045   ${datatable_prefix_apk}_resume

case_125 选片大师独立页面由爆点集数切其他集再切回爆点集数播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_125   ${datatable_prefix_apk}_drag

case_126 选片大师独立页面由爆点集数切其他集再切回爆点集数播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_126   ${datatable_prefix_apk}_drag

case_133 选片大师独立页面正片合集间手动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    15
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_133   ${datatable_prefix_apk}_splay

case_128 选片大师独立页面正片合集间手动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_128   ${datatable_prefix_apk}_play

case_184 选片大师独立页面由爆点集数切其他集再切回爆点集数播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_184   ${datatable_prefix_apk}_hb

case_141 选片大师独立页面由爆点集数切其他集再切回爆点集数播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_141   ${datatable_prefix_apk}_stop

case_046 选片大师独立页面正片合集间手动切集播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_046   ${datatable_prefix_apk}_pause

case_046 选片大师独立页面正片合集间手动切集播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  6
    获取校验结果      {'logtype': 'resume'}    test_046   ${datatable_prefix_apk}_resume

case_128 选片大师独立页面正片合集间手动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_128   ${datatable_prefix_apk}_drag

case_127 选片大师独立页面正片合集间手动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_127   ${datatable_prefix_apk}_drag

case_134 选片大师独立页面正片合集间自动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按秒快进  5
    等待  13
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_134   ${datatable_prefix_apk}_splay

case_129 选片大师独立页面正片合集间自动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_129   ${datatable_prefix_apk}_play

case_185 选片大师独立页面正片合集间手动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_185   ${datatable_prefix_apk}_hb

case_142 选片大师独立页面正片合集间手动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_142   ${datatable_prefix_apk}_stop

case_047 选片大师独立页面正片合集间自动切集播放_暂停
    [Documentation]    pause事件
    等待  5
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_047   ${datatable_prefix_apk}_pause

case_047 选片大师独立页面正片合集间自动切集播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  6
    获取校验结果      {'logtype': 'resume'}    test_047   ${datatable_prefix_apk}_resume

case_129 选片大师独立页面正片合集间自动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_129   ${datatable_prefix_apk}_drag

case_130 选片大师独立页面正片合集间自动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_130   ${datatable_prefix_apk}_drag

case_142 选片大师独立页面播放试看媒资_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    15
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_142   ${datatable_prefix_apk}_splay

case_137 选片大师独立页面播放试看媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_137   ${datatable_prefix_apk}_play

case_186 选片大师独立页面正片合集间自动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_186   ${datatable_prefix_apk}_hb

case_143 选片大师独立页面正片合集间自动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_143   ${datatable_prefix_apk}_stop

case_055 选片大师独立页面播放试看媒资_暂停
    [Documentation]    pause事件
    等待页面不出现文本信息  蜘蛛侠：平行宇宙
    清除历史上报数据
    确认键  5
    获取校验结果      {'logtype': 'pause'}    test_055   ${datatable_prefix_apk}_pause

case_055 选片大师独立页面播放试看媒资_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  6
    获取校验结果      {'logtype': 'resume'}    test_055   ${datatable_prefix_apk}_resume

case_145 选片大师独立页面播放试看媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_145   ${datatable_prefix_apk}_drag

case_146 选片大师独立页面播放试看媒资_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_146   ${datatable_prefix_apk}_drag

case_196 选片大师独立页面播放媒资按首页键退出_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_196   ${datatable_prefix_apk}_hb

case_153 选片大师独立页面播放媒资按首页键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_153   ${datatable_prefix_apk}_stop

case_194 选片大师独立页面播放试看媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_194   ${datatable_prefix_apk}_hb

case_151 选片大师独立页面播放试看媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_151   ${datatable_prefix_apk}_stop

case_135 选片大师独立页面短视频播放_启播
    [Documentation]    启播事件
    到达选片大师独立页入口
    确认键  5
    按次数下移  4    3
    等待  10
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_135   ${datatable_prefix_apk}_splay

case_130 选片大师独立页面短视频播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_130   ${datatable_prefix_apk}_play

case_132 选片大师独立页面短视频播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_132   ${datatable_prefix_apk}_drag

case_131 选片大师独立页面短视频播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_131   ${datatable_prefix_apk}_drag

case_138 选片大师独立页面短视频跳转详情页播放_启播
    [Documentation]    启播事件
    等待文本出现  妻子的秘密_推荐正片  30
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_138   ${datatable_prefix_apk}_splay

case_133 选片大师独立页面短视频跳转详情页播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_133   ${datatable_prefix_apk}_play

case_187 选片大师独立页面短视频播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_187   ${datatable_prefix_apk}_hb

case_144 选片大师独立页面短视频播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_144   ${datatable_prefix_apk}_stop

case_137 选片大师独立页面短视频跳转详情页播放_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_137   ${datatable_prefix_apk}_drag

case_138 选片大师独立页面短视频跳转详情页播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_138   ${datatable_prefix_apk}_drag

case_190 选片大师独立页面短视频跳转详情页播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现元素  ${详情页收藏}
    详情页退出
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_190   ${datatable_prefix_apk}_hb

case_147 选片大师独立页面短视频跳转详情页播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_147   ${datatable_prefix_apk}_stop

case_139 选片大师独立页面播放推荐插入正片_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    5
    等待页面不出现文本信息  妻子的秘密_推荐正片  15
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_139   ${datatable_prefix_apk}_splay

case_134 选片大师独立页面播放推荐插入正片_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0','vid':'32021040808460813269912254489218'}    test_134   ${datatable_prefix_apk}_play

case_052 选片大师独立页面播放推荐插入正片_暂停
    [Documentation]    pause事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'pause'}    test_052   ${datatable_prefix_apk}_pause

case_052 选片大师独立页面播放推荐插入正片_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    等待页面不出现文本信息  妻子的秘密_推荐正片  20
    获取校验结果      {'logtype': 'resume'}    test_052   ${datatable_prefix_apk}_resume

case_139 选片大师独立页面播放推荐插入正片_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_139   ${datatable_prefix_apk}_drag

case_140 选片大师独立页面播放推荐插入正片_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    2
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_140   ${datatable_prefix_apk}_drag

case_136 选片大师独立页面短视频手动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_136   ${datatable_prefix_apk}_splay

case_131 选片大师独立页面短视频手动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_131   ${datatable_prefix_apk}_play

case_191 选片大师独立页面播放推荐插入正片_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_191   ${datatable_prefix_apk}_hb

case_148 选片大师独立页面播放推荐插入正片_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_148   ${datatable_prefix_apk}_stop

case_181 选片大师独立页面短视频播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_181   ${datatable_prefix_apk}_hb

#case_035 选片大师独立页面短视频手动切集播放_暂停
#    [Documentation]    pause事件
#    清除历史上报数据
#    暂停键
#    获取校验结果      {'logtype': 'pause'}    test_035   ${datatable_prefix_apk}_pause
#
#case_035 选片大师独立页面短视频手动切集播放_暂停后恢复播放
#    [Documentation]    resume事件
#    清除历史上报数据
#    暂停键
#    获取校验结果      {'logtype': 'resume'}    test_035   ${datatable_prefix_apk}_resume

case_133 选片大师独立页面短视频手动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_133   ${datatable_prefix_apk}_drag

case_134 选片大师独立页面短视频手动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_134   ${datatable_prefix_apk}_drag

case_137 选片大师独立页面短视频自动切集播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按秒快进  10
    等待  2
    等待页面不出现文本信息  短视频_活动标识   10
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_137   ${datatable_prefix_apk}_splay

case_132 选片大师独立页面短视频自动切集播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_132   ${datatable_prefix_apk}_play

case_188 选片大师独立页面短视频手动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_188   ${datatable_prefix_apk}_hb

case_145 选片大师独立页面短视频手动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_145   ${datatable_prefix_apk}_stop

#case_036 选片大师独立页面短视频自动切集播放_暂停
#    [Documentation]    pause事件
#    清除历史上报数据
#    暂停键
#    获取校验结果      {'logtype': 'pause'}    test_036   ${datatable_prefix_apk}_pause
#
#case_036 选片大师独立页面短视频自动切集播放_暂停后恢复播放
#    [Documentation]    resume事件
#    清除历史上报数据
#    暂停键
#    获取校验结果      {'logtype': 'resume'}    test_036   ${datatable_prefix_apk}_resume

case_136 选片大师独立页面短视频自动切集播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_136   ${datatable_prefix_apk}_drag

case_135 选片大师独立页面短视频自动切集播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_135   ${datatable_prefix_apk}_drag

case_140 选片大师独立页面播放推荐插入短视频_启播
    [Documentation]    启播事件
    等待文本出现  推荐短视频  15
    清除历史上报数据
    按次数下移  1    15
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_140   ${datatable_prefix_apk}_splay

case_135 选片大师独立页面播放推荐插入短视频_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_135   ${datatable_prefix_apk}_play

case_189 选片大师独立页面短视频自动切集播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_189   ${datatable_prefix_apk}_hb

case_146 选片大师独立页面短视频自动切集播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_146   ${datatable_prefix_apk}_stop

#case_039 选片大师独立页面播放推荐插入短视频_暂停
#    [Documentation]    pause事件
#    清除历史上报数据
#    确认键
#    获取校验结果      {'logtype': 'pause'}    test_028   ${datatable_prefix_apk}_pause
#
#case_039 选片大师独立页面播放推荐插入短视频_暂停后恢复播放
#    [Documentation]    resume事件
#    清除历史上报数据
#    确认键  10
#    获取校验结果      {'logtype': 'resume'}    test_028   ${datatable_prefix_apk}_resume

case_141 选片大师独立页面播放推荐插入短视频_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_141   ${datatable_prefix_apk}_drag

case_142 选片大师独立页面播放推荐插入短视频_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_142   ${datatable_prefix_apk}_drag

case_195 选片大师独立页面播放媒资按菜单键退出_退出心跳
    [Documentation]    心跳事件
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_195   ${datatable_prefix_apk}_hb

case_152 选片大师独立页面播放媒资按菜单键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_152   ${datatable_prefix_apk}_stop

case_192 选片大师独立页面播放推荐插入短视频_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_192   ${datatable_prefix_apk}_hb

case_149 选片大师独立页面播放推荐插入短视频_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_149   ${datatable_prefix_apk}_stop


#case_143 选片大师独立页面播放失败_启播