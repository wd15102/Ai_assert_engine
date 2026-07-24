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
case_269 进入轮播小窗页面
    [Documentation]  PV事件
    到达轮播主题小窗入口
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_269    ${datatable_prefix_apk}_pv

case_207 进入轮播小窗后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_207    ${datatable_prefix_apk}_stay

case_243 轮播小窗列表模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'show'}    test_243   ${datatable_prefix_apk}_show

case_102 轮播小窗列表浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_102    ${datatable_prefix_apk}_cv

case_244 轮播小窗列表移动过程中模块曝光
    [Documentation]    模块曝光事件
    按次数左移  1
    清除历史上报数据
    按次数上移  1
    获取校验结果  {'logtype': 'show'}    test_244   ${datatable_prefix_apk}_show

case_325 轮播小窗点击轮播列表
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_325    ${datatable_prefix_apk}_click

case_326 轮播小窗点击全屏
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_326    ${datatable_prefix_apk}_click

case_270 进入轮播小窗，大小屏切换
    [Documentation]  PV事件
    获取校验结果_不上报  {'logtype':'pv'}    test_270    ${datatable_prefix_apk}_pv

case_208 进入轮播小窗，大小屏切换后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按返回直到焦点位于内容  跳轮播主题-指定频道
    获取校验结果  {'logtype':'stay'}    test_208    ${datatable_prefix_apk}_stay

case_210 进入轮播小窗，在轮播列表切换频道后退出
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_210    ${datatable_prefix_apk}_stay

case_271 主题进入轮播全屏页面
    [Documentation]  PV事件
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_271    ${datatable_prefix_apk}_pv

case_209 主题进入轮播全屏后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按返回直到焦点位于内容  跳轮播主题全屏-指定频道
    获取校验结果  {'logtype':'stay'}    test_209    ${datatable_prefix_apk}_stay

case_245 主题进入全屏列表模块曝光
    [Documentation]    模块曝光事件
    等待  5
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'show'}    test_245   ${datatable_prefix_apk}_show

case_103 主题进入全屏列表浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_103    ${datatable_prefix_apk}_cv

case_246 主题进入全屏在轮播列表移动过程中模块曝光
    [Documentation]    模块曝光事件
    确认键
    清除历史上报数据
    按次数上移  1    2
    确认键
    获取校验结果  {'logtype':'show','lob':'00000001000000001008000000154081'}    test_246   ${datatable_prefix_apk}_show

case_327 主题进入全屏呼出列表浮层，点击轮播频道
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_327    ${datatable_prefix_apk}_click

case_272 进入轮播模块分屏页面
    [Documentation]  PV事件
    home键
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  纪实
    清除历史上报数据
    切换频道  VIP
    获取校验结果  {'logtype':'pv'}    test_272    ${datatable_prefix_apk}_pv

case_247 轮播模块模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype':'show','module_id':'common_turnplay_flow'}    test_247   ${datatable_prefix_apk}_show

case_248 轮播模块小窗列表移动过程中模块曝光
    [Documentation]    模块曝光事件
    按次数下移  1
    按次数右移  1
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype':'show'}    test_248   ${datatable_prefix_apk}_show

case_328 点击轮播模块小窗列表频道
    [Documentation]  点击事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_328    ${datatable_prefix_apk}_click

case_329 点击轮播模块小窗
    [Documentation]  点击事件
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_329    ${datatable_prefix_apk}_click

case_273 进入轮播模块小窗，大小屏切换
    [Documentation]  PV事件
    获取校验结果_不上报  {'logtype':'pv'}    test_273    ${datatable_prefix_apk}_pv

case_249 轮播模块进入全屏列表模块曝光
    [Documentation]    模块曝光事件
    等待  5
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'show'}    test_249   ${datatable_prefix_apk}_show

case_104 轮播模块进入全屏列表浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_104    ${datatable_prefix_apk}_cv

case_250 轮播模块进入进入全屏在轮播列表移动过程中模块曝光
    [Documentation]    模块曝光事件
    等待  5
    确认键
    清除历史上报数据
    按次数下移  1    2
    确认键
    获取校验结果  {'logtype':'show','lob':'00000001000000001025000000196968'}    test_250   ${datatable_prefix_apk}_show

case_330 轮播模块进入进入全屏呼出列表浮层，点击轮播频道
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_330    ${datatable_prefix_apk}_click

case_211 进入轮播模块分屏页面后退出
    [Documentation]  STAY事件
    按返回直到焦点位于内容  VIP
    清除历史上报数据
    按次数左移  1
    获取校验结果  {'logtype':'stay'}    test_211    ${datatable_prefix_apk}_stay
