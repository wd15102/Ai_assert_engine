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
case_222 第1次进入选片大师feed浮层_模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  纪实
    清除历史上报数据
    切换频道  专题
    等待  10
    获取校验结果  {'logtype': 'show','flag':'138'}    test_222   ${datatable_prefix_apk}_show

case_068 第1次进入选片大师feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_068    ${datatable_prefix_apk}_cv

case_069 第1次进入选片大师feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_069    ${datatable_prefix_apk}_cv

case_070 第1次进入选片大师feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_070    ${datatable_prefix_apk}_cv

case_315 点击选片大师开通会员按钮
    [Documentation]  点击事件
    按次数下移  2
    按次数右移  2
    清除历史上报数据
    确认键
    等待订购列表出现
    获取校验结果  {'logtype':'click'}    test_315    ${datatable_prefix_apk}_click

case_223 进入开通会员后返回feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    订购返回详情页
    等待  10
    获取校验结果  {'logtype': 'show','flag':'138'}    test_223   ${datatable_prefix_apk}_show

case_071 进入开通会员后返回feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_071    ${datatable_prefix_apk}_cv

case_072 进入开通会员后返回feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_072    ${datatable_prefix_apk}_cv

case_073 进入开通会员后返回feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_073    ${datatable_prefix_apk}_cv

case_224 按确认键呼出feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_224   ${datatable_prefix_apk}_show

case_074 按确认键呼出feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_074    ${datatable_prefix_apk}_cv

case_075 按确认键呼出feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_075    ${datatable_prefix_apk}_cv

case_077_1 按确认键呼出feed浮层_暂停按钮不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playpausepop'}    test_077    ${datatable_prefix_apk}_cv

case_076 按确认键呼出feed浮层_恢复播放按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playrestorepop'}    test_076    ${datatable_prefix_apk}_cv

case_316 点击选片大师恢复播放按钮
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_316    ${datatable_prefix_apk}_click

case_077 按确认键呼出feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_077    ${datatable_prefix_apk}_cv

case_076_1 按确认键呼出feed浮层_恢复播放按钮不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playrestorepop'}    test_076    ${datatable_prefix_apk}_cv

case_317 点击选片大师暂停按钮
    [Documentation]  点击事件
    等待页面不出现元素信息  ${选片大师内容}  15
    确认键
    确认键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_317    ${datatable_prefix_apk}_click

case_077_1 按确认键呼出feed浮层_暂停按钮不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playpausepop'}    test_077    ${datatable_prefix_apk}_cv

case_076 按确认键呼出feed浮层_恢复播放按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playrestorepop'}    test_076    ${datatable_prefix_apk}_cv

case_318 点击选片大师选集按钮
    [Documentation]  点击事件
    按次数左移  2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_318    ${datatable_prefix_apk}_click

case_078 选集列表控件曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjilistpop'}    test_078    ${datatable_prefix_apk}_cv

case_319 点击选片大师具体集数
    [Documentation]  点击事件
    确认键
    按次数左移  2
    确认键
    按次数左移  2
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype':'click'}    test_319    ${datatable_prefix_apk}_click

case_225 合集内切集出现feed浮层_模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','flag':'138'}    test_225   ${datatable_prefix_apk}_show

case_079 合集内切集出现feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_079    ${datatable_prefix_apk}_cv

case_080 合集内切集出现feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playpausepop'}    test_080    ${datatable_prefix_apk}_cv

case_226 按返回键呼出feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数返回  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_226   ${datatable_prefix_apk}_show

case_081 按返回键呼出feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_081    ${datatable_prefix_apk}_cv

case_082 按返回键呼出feed浮层_开通会员不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playopenvippop'}    test_082    ${datatable_prefix_apk}_cv

case_083 按返回键呼出feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_083    ${datatable_prefix_apk}_cv

case_227 按下键切换合集feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_227   ${datatable_prefix_apk}_show

case_084 按下键切换合集feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_084    ${datatable_prefix_apk}_cv

case_085 按下键切换合集feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_085    ${datatable_prefix_apk}_cv

case_228 按上键切换合集feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数上移  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_228   ${datatable_prefix_apk}_show

case_086 按上键切换合集feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_086    ${datatable_prefix_apk}_cv

case_087 按上键切换合集feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playopenvippop'}    test_087    ${datatable_prefix_apk}_cv

case_088 按上键切换合集feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_088    ${datatable_prefix_apk}_cv

case_098 观看历史记录浮层曝光
    [Documentation]  CV事件
    清除历史上报数据
    按次数下移  3
    等待文本出现  按【OK】键跳转
    确认键
    获取校验结果  {'logtype':'cv','mod':'c_playhistorypop'}    test_098    ${datatable_prefix_apk}_cv

case_322 点击选片大师观看历史记录
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_322    ${datatable_prefix_apk}_click

case_229 短视频feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_229   ${datatable_prefix_apk}_show

case_089 短视频feed浮层_短视频功能推荐位曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_shortvideorecpop'}    test_089    ${datatable_prefix_apk}_cv

case_089_1 短视频feed浮层_选集按钮不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_089    ${datatable_prefix_apk}_cv

case_089_2 短视频feed浮层_开通会员不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playopenvippop'}    test_089    ${datatable_prefix_apk}_cv

case_089_3 短视频feed浮层_暂停按钮不曝光
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv','mod':'c_playpausepop'}    test_089    ${datatable_prefix_apk}_cv

case_320 点击选片大师短视频功能推荐位按钮
    [Documentation]  点击事件
    等待文本出现  妻子的秘密_推荐正片
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_320    ${datatable_prefix_apk}_click

case_230 短视频跳转后返回feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数返回  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_230   ${datatable_prefix_apk}_show

case_090 短视频跳转后返回feed浮层_短视频功能推荐位曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_shortvideorecpop'}    test_090    ${datatable_prefix_apk}_cv

case_231 推荐正片feed浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    10
    获取校验结果  {'logtype': 'show','flag':'138'}    test_231   ${datatable_prefix_apk}_show

case_091 推荐正片feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_091    ${datatable_prefix_apk}_cv

case_092 推荐正片feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_092    ${datatable_prefix_apk}_cv

case_093 推荐正片feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_093    ${datatable_prefix_apk}_cv

case_321 点击选片大师推荐正片开通会员按钮
    [Documentation]  点击事件
    等待页面不出现文本信息  妻子的秘密_推荐正片  10
    确认键
    按次数左移  1
    清除历史上报数据
    确认键
    等待订购列表出现
    获取校验结果  {'logtype':'click'}    test_321    ${datatable_prefix_apk}_click

case_232 推荐短视频feed浮层_模块曝光
    [Documentation]    模块曝光事件
    订购返回详情页
    按次数下移  2    5
    等待文本出现  推荐短视频
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','flag':'138'}    test_232   ${datatable_prefix_apk}_show

case_234 进入试看结束开通会员后返回feed浮层_模块曝光
    [Documentation]    模块曝光事件
    按次数下移  1    10
    等待订购列表出现
    清除历史上报数据
    订购返回详情页
    等待  2
    获取校验结果  {'logtype': 'show','flag':'138'}    test_234   ${datatable_prefix_apk}_show

case_095 进入试看结束开通会员后返回feed浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_095    ${datatable_prefix_apk}_cv

case_096 进入试看结束开通会员后返回feed浮层_开通会员曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playopenvippop'}    test_096    ${datatable_prefix_apk}_cv

case_097 进入试看结束开通会员后返回feed浮层_暂停按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playpausepop'}    test_097    ${datatable_prefix_apk}_cv

case_233 试看结束浮层_模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    等待  15
    获取校验结果  {'logtype': 'show','flag':'138'}    test_233   ${datatable_prefix_apk}_show

case_094 试看结束浮层_选集按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_094    ${datatable_prefix_apk}_cv

case_100 试看结束浮层_订购按钮曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_trylookendpop'}    test_100    ${datatable_prefix_apk}_cv

case_099 问题反馈浮层曝光
    [Documentation]  CV事件
    清除历史上报数据
    按次数下移  1    3
    等待文本出现  问题反馈
    确认键
    获取校验结果  {'logtype':'cv','mod':'c_feedbackpop'}    test_099    ${datatable_prefix_apk}_cv

case_101 播放报错页面选集浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_xuanjifuceng'}    test_101    ${datatable_prefix_apk}_cv   2

case_323 点击选片大师问题反馈浮层
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_323    ${datatable_prefix_apk}_click

选片大师播放失败_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_126   ${datatable_prefix_apk}_splay

选片大师播放失败
    [Documentation]    错误上报
    获取校验结果  {'logtype': 'error','bid':'26.13.20','vid':'errorid'}    test_005   ${datatable_prefix_apk}_error

case_385 选片大师分屏点击feed浮层全屏按钮
    [Documentation]  点击事件
    按次数返回  1    3
    按次数下移  1    2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_385    ${datatable_prefix_apk}_click

