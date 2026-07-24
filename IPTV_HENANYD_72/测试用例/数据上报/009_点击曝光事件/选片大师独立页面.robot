*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_251 选片大师独立页面_第1次进入选片大师feed浮层_模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    到达选片大师独立页入口
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_251   ${datatable_prefix_apk}_show

case_281 进入选片大师独立页面-有多个子主题
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_281    ${datatable_prefix_apk}_pv

case_108 选片大师独立页面_第1次进入feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_108    ${datatable_prefix_apk}_cv

case_109 选片大师独立页面_第1次进入feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_109    ${datatable_prefix_apk}_cv

case_110 选片大师独立页面_第1次进入feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_110    ${datatable_prefix_apk}_cv

case_334 选片大师独立页面_点击开通会员按钮
    [Documentation]  点击事件
    按次数下移  1
    按次数右移  2
    清除历史上报数据
    确认键
    等待订购列表出现
    获取校验结果  {'logtype':'click'}    test_334    ${datatable_prefix_apk}_click

case_252 选片大师独立页面_进入开通会员后返回feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    订购返回详情页
    等待  10
    获取校验结果  {'logtype': 'show','flag':'138'}    test_252   ${datatable_prefix_apk}_show

case_111 选片大师独立页面_进入开通会员后返回feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_111    ${datatable_prefix_apk}_cv

case_112 选片大师独立页面_进入开通会员后返回feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_112    ${datatable_prefix_apk}_cv

case_113 选片大师独立页面_进入开通会员后返回feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_113    ${datatable_prefix_apk}_cv

case_253 选片大师独立页面_按确认键呼出feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_253   ${datatable_prefix_apk}_show

case_114 选片大师独立页面_按确认键呼出feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_114    ${datatable_prefix_apk}_cv

case_115 选片大师独立页面_按确认键呼出feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_115    ${datatable_prefix_apk}_cv

case_116 选片大师独立页面_按确认键呼出feed浮层_恢复播放按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playrestorepop'}    test_116    ${datatable_prefix_apk}_cv

case_335 选片大师独立页面_点击恢复播放按钮
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_335    ${datatable_prefix_apk}_click

case_117 选片大师独立页面_按确认键呼出feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_117    ${datatable_prefix_apk}_cv

case_116_1 选片大师独立页面_按确认键呼出feed浮层_恢复播放按钮不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playrestorepop'}    test_116    ${datatable_prefix_apk}_cv

case_336 选片大师独立页面_点击暂停按钮
    [Documentation]  点击事件
    等待页面不出现元素信息  ${选片大师内容}  10
    确认键
    确认键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_336    ${datatable_prefix_apk}_click

case_117_1 选片大师独立页面_按确认键呼出feed浮层_暂停按钮不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playpausepop'}    test_117    ${datatable_prefix_apk}_cv

case_337 选片大师独立页面_点击选集按钮
    [Documentation]  点击事件
    按次数左移  2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_337    ${datatable_prefix_apk}_click

case_118 选片大师独立页面_选集列表控件曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjilistpop'}    test_118    ${datatable_prefix_apk}_cv

case_338 选片大师独立页面_点击具体集数
    [Documentation]  点击事件
    确认键
    按次数左移  2
    确认键
    按次数左移  2
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype':'click'}    test_338    ${datatable_prefix_apk}_click

case_254 选片大师独立页面_合集内切集出现feed浮层_模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','flag':'138'}    test_254   ${datatable_prefix_apk}_show

case_119 选片大师独立页面_合集内切集出现feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_119    ${datatable_prefix_apk}_cv

case_120 选片大师独立页面_合集内切集出现feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playpausepop'}    test_120    ${datatable_prefix_apk}_cv

case_255 选片大师独立页面_按返回键呼出feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数返回  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_255   ${datatable_prefix_apk}_show

case_121 选片大师独立页面_按返回键呼出feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_121    ${datatable_prefix_apk}_cv

case_122 选片大师独立页面_按返回键呼出feed浮层_开通会员不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playopenvippop'}    test_122    ${datatable_prefix_apk}_cv

case_123 选片大师独立页面_按返回键呼出feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_123    ${datatable_prefix_apk}_cv

case_256 选片大师独立页面_按下键切换合集feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_256   ${datatable_prefix_apk}_show

case_124 选片大师独立页面_按下键切换合集feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_124    ${datatable_prefix_apk}_cv

case_125 选片大师独立页面_按下键切换合集feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_125    ${datatable_prefix_apk}_cv

case_257 选片大师独立页面_按上键切换合集feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数上移  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_257   ${datatable_prefix_apk}_show

case_126 选片大师独立页面_按上键切换合集feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_126    ${datatable_prefix_apk}_cv

case_127 选片大师独立页面_按上键切换合集feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playopenvippop'}    test_127    ${datatable_prefix_apk}_cv

case_128 选片大师独立页面_按上键切换合集feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_128    ${datatable_prefix_apk}_cv

case_138 选片大师独立页面_观看历史记录浮层曝光
    [Documentation]  CV事件
    清除历史上报数据
    按次数下移  3
    等待文本出现  按【OK】键跳转
    确认键
    获取校验结果  {'logtype':'cv','mod':'c_playhistorypop'}    test_138    ${datatable_prefix_apk}_cv

case_341 选片大师独立页面_点击观看历史记录
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_341    ${datatable_prefix_apk}_click

case_258 选片大师独立页面_短视频feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_258   ${datatable_prefix_apk}_show

case_129 选片大师独立页面_短视频feed浮层_短视频功能推荐位曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_shortvideorecpop'}    test_129    ${datatable_prefix_apk}_cv

case_129_1 选片大师独立页面_短视频feed浮层_选集按钮不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_129    ${datatable_prefix_apk}_cv

case_129_2 选片大师独立页面_短视频feed浮层_开通会员不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playopenvippop'}    test_129    ${datatable_prefix_apk}_cv

case_129_3 选片大师独立页面_短视频feed浮层_暂停按钮不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playpausepop'}    test_129    ${datatable_prefix_apk}_cv

case_339 选片大师独立页面_点击短视频功能推荐位按钮
    [Documentation]  点击事件
    等待文本出现  妻子的秘密_推荐正片
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_339    ${datatable_prefix_apk}_click

case_259 选片大师独立页面_短视频跳转后返回feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数返回  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_259   ${datatable_prefix_apk}_show

case_130 选片大师独立页面_短视频跳转后返回feed浮层_短视频功能推荐位曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_shortvideorecpop'}    test_130    ${datatable_prefix_apk}_cv

case_260 选片大师独立页面_推荐正片feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    10
    获取校验结果  {'logtype': 'show','flag':'138'}    test_260   ${datatable_prefix_apk}_show

case_131 选片大师独立页面_推荐正片feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_131    ${datatable_prefix_apk}_cv

case_132 选片大师独立页面_推荐正片feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_132    ${datatable_prefix_apk}_cv

case_133 选片大师独立页面_推荐正片feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_133    ${datatable_prefix_apk}_cv

case_340 选片大师独立页面_点击推荐正片开通会员按钮
    [Documentation]  点击事件
    等待页面不出现文本信息  妻子的秘密_推荐正片  10
    确认键
    按次数左移  1
    清除历史上报数据
    确认键  15
    获取校验结果  {'logtype':'click'}    test_340    ${datatable_prefix_apk}_click

case_261 选片大师独立页面_推荐短视频feed浮层_模块曝光
    [Documentation]    模块曝光事件
    订购返回详情页
    按次数下移  2    5
    等待文本出现  推荐短视频
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_261   ${datatable_prefix_apk}_show

case_263 选片大师独立页面_进入试看结束开通会员后返回feed浮层_模块曝光
    [Documentation]    模块曝光事件
    按次数下移  1    10
    等待订购列表出现
    清除历史上报数据
    订购返回详情页
    等待  2
    获取校验结果  {'logtype': 'show','flag':'138'}    test_263   ${datatable_prefix_apk}_show

case_135 选片大师独立页面_进入试看结束开通会员后返回feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_135    ${datatable_prefix_apk}_cv

case_136 选片大师独立页面_进入试看结束开通会员后返回feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_136    ${datatable_prefix_apk}_cv

case_137 选片大师独立页面_进入试看结束开通会员后返回feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_137    ${datatable_prefix_apk}_cv

case_262 选片大师独立页面_试看结束浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    等待  15
    获取校验结果  {'logtype': 'show','flag':'138'}    test_262   ${datatable_prefix_apk}_show

case_134 选片大师独立页面_试看结束浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_134    ${datatable_prefix_apk}_cv

case_140 选片大师独立页面_试看结束浮层_订购按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_trylookendpop'}    test_140    ${datatable_prefix_apk}_cv

case_139 选片大师独立页面_问题反馈浮层曝光
    [Documentation]  CV事件
    清除历史上报数据
    按次数下移  1    3
    等待文本出现  问题反馈
    确认键
    获取校验结果  {'logtype':'cv','mod':'c_feedbackpop'}    test_139    ${datatable_prefix_apk}_cv

case_141 选片大师独立页面_播放报错页面选集浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_141    ${datatable_prefix_apk}_cv   2

case_342 选片大师独立页面_点击问题反馈浮层
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_342    ${datatable_prefix_apk}_click

case_386 选片大师独立页面点击feed浮层全屏按钮
    [Documentation]  点击事件
    按次数返回  1    3
    按次数下移  1    2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_386    ${datatable_prefix_apk}_click

case_215 进入选片大师独立页面后退出-有多个子主题
    [Documentation]  STAY事件
    清除历史上报数据
    按返回直到出现内容  选片大师独立页面
    获取校验结果  {'logtype':'stay','cntp':'xpds_play'}    test_215    ${datatable_prefix_apk}_stay

case_282 进入选片大师独立页面切换子主题
    [Documentation]  PV事件
    校验焦点是否在内容描述上  选片大师独立页面
    确认键  10
    清除历史上报数据
    按次数右移  1    5
    获取校验结果  {'logtype':'pv'}    test_282    ${datatable_prefix_apk}_pv

case_216 进入选片大师独立页面切换子主题后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1    5
    获取校验结果  {'logtype':'stay'}    test_216    ${datatable_prefix_apk}_stay