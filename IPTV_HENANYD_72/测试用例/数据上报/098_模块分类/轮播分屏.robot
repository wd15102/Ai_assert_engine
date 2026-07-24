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
case_283 进入轮播分屏页面
    [Documentation]  PV事件
    返回首页
    返回精选页
    确认键
    切换频道  少儿频道
    切换频道  纪实
    切换频道  测试
    清除历史上报数据
    切换频道  轮播分屏
    获取校验结果  {'logtype':'pv'}    test_283    ${datatable_prefix_apk}_pv

case_274 轮播分屏模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype':'show','module_id':'common_turnplay'}    test_274   ${datatable_prefix_apk}_show

case_172 轮播分屏小窗播放_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_172   ${datatable_prefix_apk}_splay

case_166 轮播分屏小窗播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_166   ${datatable_prefix_apk}_play

case_261 轮播分屏小窗播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_261   ${datatable_prefix_apk}_hb

case_262 轮播分屏小窗播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    切换频道  测试
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_262   ${datatable_prefix_apk}_hb

case_177 轮播分屏小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_177   ${datatable_prefix_apk}_stop

case_275 轮播分屏小窗列表移动过程中模块曝光
    [Documentation]    模块曝光事件
    切换频道  轮播分屏
    按次数下移  3
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype':'show'}    test_275   ${datatable_prefix_apk}_show

case_374 点击轮播分屏小窗列表频道
    [Documentation]  点击事件
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype':'click'}    test_374    ${datatable_prefix_apk}_click

case_173 轮播分屏小窗切频道_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_173   ${datatable_prefix_apk}_splay

case_167 轮播分屏小窗切频道_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_167   ${datatable_prefix_apk}_play

case_263 轮播分屏小窗切频道_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_263   ${datatable_prefix_apk}_hb

case_178 轮播分屏小窗切频道_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_178   ${datatable_prefix_apk}_stop

case_375 点击轮播分屏小窗
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_375    ${datatable_prefix_apk}_click

case_284 进入轮播分屏小窗，大小屏切换
    [Documentation]  PV事件
    获取校验结果_不上报  {'logtype':'pv'}    test_284    ${datatable_prefix_apk}_pv

case_174 轮播分屏，大小屏切换，检查启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_174   ${datatable_prefix_apk}_splay

case_168 轮播分屏，大小屏切换，检查VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_168   ${datatable_prefix_apk}_play

case_264 轮播分屏，大小屏切换，检查心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_264   ${datatable_prefix_apk}_hb

case_179 轮播分屏，大小屏切换，检查stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_179   ${datatable_prefix_apk}_stop

case_276 轮播分屏进入全屏列表模块曝光
    [Documentation]    模块曝光事件
    等待  5
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'show'}    test_276   ${datatable_prefix_apk}_show

case_152 轮播分屏进入全屏列表浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_152    ${datatable_prefix_apk}_cv

case_277 轮播分屏进入全屏在轮播列表移动过程中模块曝光
    [Documentation]    模块曝光事件
    等待  5
    确认键
    清除历史上报数据
    按次数下移  1    2
    确认键
    获取校验结果  {'logtype':'show','lob':'00000001000000001002000000000010'}    test_277   ${datatable_prefix_apk}_show

case_376 轮播分屏进入全屏呼出列表浮层，点击轮播频道
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_376    ${datatable_prefix_apk}_click

case_175 轮播分屏全屏播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_175   ${datatable_prefix_apk}_splay

case_176 轮播分屏全屏切频道_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_176   ${datatable_prefix_apk}_splay

case_169 轮播分屏全屏播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_169   ${datatable_prefix_apk}_play

case_170 轮播分屏全屏切频道_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_170   ${datatable_prefix_apk}_play

case_265 轮播分屏全屏切频道_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_265   ${datatable_prefix_apk}_hb

case_266 轮播分屏全屏播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_266   ${datatable_prefix_apk}_hb

case_180 轮播分屏全屏播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_180   ${datatable_prefix_apk}_stop

case_181 轮播分屏全屏切频道_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_181   ${datatable_prefix_apk}_stop

case_059 轮播分屏进入全屏播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_059   ${datatable_prefix_apk}_pause

case_059 轮播分屏进入全屏播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'resume'}    test_059   ${datatable_prefix_apk}_resume

case_267 轮播分屏全屏播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_267   ${datatable_prefix_apk}_hb

case_217 进入轮播分屏页面后退出
    [Documentation]  STAY事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype':'stay','lob':'1'}    test_217    ${datatable_prefix_apk}_stay

case_268 轮播分屏，通过首页键离开，检查退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_268   ${datatable_prefix_apk}_hb

case_183 轮播分屏，通过首页键离开，检查退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_183   ${datatable_prefix_apk}_stop

case_269 轮播分屏，通过菜单键离开，检查退出心跳
    [Documentation]    心跳事件
    切换频道  少儿频道
    切换频道  纪实
    切换频道  测试
    切换频道  轮播分屏
    等待  10
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_269   ${datatable_prefix_apk}_hb

case_182 轮播分屏，通过菜单键离开，检查退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_182   ${datatable_prefix_apk}_stop

