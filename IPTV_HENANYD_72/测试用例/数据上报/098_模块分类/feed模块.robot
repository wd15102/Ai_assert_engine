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
case_264 单feed模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  电竞
    切换频道  戏曲
    按次数下移  4
    等待  5
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','mpos':'4'}    test_264   ${datatable_prefix_apk}_show

case_160 单feed模块自动播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_160   ${datatable_prefix_apk}_splay

case_154 单feed模块自动播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_154   ${datatable_prefix_apk}_play

case_247 单feed模块自动播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_247   ${datatable_prefix_apk}_hb

case_265 单feed模块焦点移动曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','mpos':'4'}    test_265   ${datatable_prefix_apk}_show

case_248 单feed模块自动播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_248   ${datatable_prefix_apk}_hb

case_165 单feed模块自动播放_stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop'}    test_165   ${datatable_prefix_apk}_stop

case_161 单feed模块切换卡片播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_161   ${datatable_prefix_apk}_splay

case_155 单feed模块切换卡片播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_155   ${datatable_prefix_apk}_play

case_249 单feed模块切换卡片播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数下移  1    3
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_249   ${datatable_prefix_apk}_hb

case_166 单feed模块切换卡片播放_stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop'}    test_166   ${datatable_prefix_apk}_stop

case_357 点击单feed模块正在播放的卡片
    [Documentation]  点击事件
    按次数下移  1    10
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_357    ${datatable_prefix_apk}_click

case_276 从单feed模块卡片进入详情页
    [Documentation]  PV事件
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_276    ${datatable_prefix_apk}_pv

case_266 单feed模块跳转返回曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'show','mpos':'4'}    test_266   ${datatable_prefix_apk}_show

case_162 单feed模块点击卡片跳转后返回播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_162   ${datatable_prefix_apk}_splay

case_156 单feed模块点击卡片跳转后返回播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_156   ${datatable_prefix_apk}_play

case_250 单feed模块点击卡片跳转后返回播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数上移  1    5
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_250   ${datatable_prefix_apk}_hb

case_167 单feed模块点击卡片跳转后返回播放_stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop'}    test_167   ${datatable_prefix_apk}_stop

case_358 点击单feed模块未开始播放的卡片
    [Documentation]  点击事件
    清除历史上报数据
    按次数下移  1    0
    确认键
    获取校验结果  {'logtype':'click'}    test_358    ${datatable_prefix_apk}_click

case_267 双feed模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  综艺
    按次数下移  5
    等待  5
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','mpos':'6'}    test_267   ${datatable_prefix_apk}_show

case_163 双feed模块自动播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_163   ${datatable_prefix_apk}_splay

case_157 双feed模块自动播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_157   ${datatable_prefix_apk}_play

case_268 双feed模块焦点移动曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'show','mpos':'6'}    test_268   ${datatable_prefix_apk}_show

case_251 双feed模块自动播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_251   ${datatable_prefix_apk}_hb

case_168 双feed模块自动播放_stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop'}    test_168   ${datatable_prefix_apk}_stop

case_164 双feed模块切换卡片播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_164   ${datatable_prefix_apk}_splay

case_158 双feed模块切换卡片播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_158   ${datatable_prefix_apk}_play

case_252 双feed模块切换卡片播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数右移  1
    等待  5
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_252   ${datatable_prefix_apk}_hb

case_169 双feed模块切换卡片播放_stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop'}    test_169   ${datatable_prefix_apk}_stop

case_359 点击双feed模块正在播放的卡片
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_359    ${datatable_prefix_apk}_click

case_277 从双feed模块卡片进入详情页
    [Documentation]  PV事件
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_277    ${datatable_prefix_apk}_pv

case_269 双feed模块跳转返回曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'show','mpos':'6'}    test_269   ${datatable_prefix_apk}_show

case_165 双feed模块点击卡片跳转后返回播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_165   ${datatable_prefix_apk}_splay

case_159 双feed模块点击卡片跳转后返回播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_159   ${datatable_prefix_apk}_play

case_253 双feed模块点击卡片跳转后返回播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数左移  1    5
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_253   ${datatable_prefix_apk}_hb

case_170 双feed模块点击卡片跳转后返回播放_stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop'}    test_170   ${datatable_prefix_apk}_stop

case_360 点击双feed模块未开始播放的卡片
    [Documentation]  点击事件
    清除历史上报数据
    按次数右移  1    0
    确认键
    获取校验结果  {'logtype':'click'}    test_360    ${datatable_prefix_apk}_click

case_361 点击双feed模块播放结束的卡片
    [Documentation]  点击事件
    等待详情页出现
    详情页退出
    按次数下移  2
    清除历史上报数据
    等待  15
    确认键
    获取校验结果  {'logtype':'click'}    test_361    ${datatable_prefix_apk}_click