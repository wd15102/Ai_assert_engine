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
case_285 进入小窗播放专题页
    [Documentation]  PV事件
    到达小窗播放专题入口
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_285    ${datatable_prefix_apk}_pv

case_278 小窗播放专题模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','cntp':'colum_play'}    test_278   ${datatable_prefix_apk}_show

case_181 小窗播放专题媒资播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_181   ${datatable_prefix_apk}_splay

case_175 小窗播放专题媒资播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_175   ${datatable_prefix_apk}_play

case_277 小窗播放专题媒资播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_277   ${datatable_prefix_apk}_hb

case_278 小窗播放专题媒资播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数右移  1    5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_278   ${datatable_prefix_apk}_hb

case_188 小窗播放专题媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_188   ${datatable_prefix_apk}_stop

case_182 小窗播放专题媒资切换媒资播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_182   ${datatable_prefix_apk}_splay

case_176 小窗播放专题媒资切换媒资播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_176   ${datatable_prefix_apk}_play

case_279 小窗播放专题媒资切换媒资播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数右移  1    5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_279   ${datatable_prefix_apk}_hb

case_189 小窗播放专题媒资切换媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_189   ${datatable_prefix_apk}_stop

case_279 小窗播放专题模块曝光_焦点移动
    [Documentation]    模块曝光事件
    按次数右移  1    3
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype': 'show'}    test_279   ${datatable_prefix_apk}_show

case_183 小窗播放专题试看媒资播放_启播
    [Documentation]    启播事件
    等待  3
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_183   ${datatable_prefix_apk}_splay

case_177 小窗播放专题试看媒资播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_177   ${datatable_prefix_apk}_play

case_184 小窗播放专题付费媒资播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_184   ${datatable_prefix_apk}_splay

case_280 小窗播放专题试看媒资播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_280   ${datatable_prefix_apk}_hb

case_190 小窗播放专题试看媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_190   ${datatable_prefix_apk}_stop

case_378 点击小窗播放专题推荐位内容
    [Documentation]  点击事件
    清除历史上报数据
    确认键     10
    获取校验结果  {'logtype':'click'}    test_378    ${datatable_prefix_apk}_click

case_218 进入小窗播放专题页后退出
    [Documentation]  STAY事件
    按返回直到焦点位于内容  催眠·裁决
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_218    ${datatable_prefix_apk}_stay

case_286 进入短视频模板专题页
    [Documentation]  PV事件
    到达短视频模板专题入口
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_286    ${datatable_prefix_apk}_pv

case_280 短视频模板专题曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','cntp':'colum_play'}    test_280   ${datatable_prefix_apk}_show

case_185 短视频模板专题媒资播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_185   ${datatable_prefix_apk}_splay

case_178 短视频模板专题媒资播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_178   ${datatable_prefix_apk}_play

case_281 短视频模板专题媒资播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_281   ${datatable_prefix_apk}_hb

case_282 短视频模板专题媒资播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_282   ${datatable_prefix_apk}_hb

case_191 短视频模板专题媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_191   ${datatable_prefix_apk}_stop

case_186 短视频模板专题切换媒资播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_186   ${datatable_prefix_apk}_splay

case_179 短视频模板专题切换媒资播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_179   ${datatable_prefix_apk}_play

case_283 短视频模板专题切换媒资播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_283   ${datatable_prefix_apk}_hb

case_192 短视频模板专题切换媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_192   ${datatable_prefix_apk}_stop

case_281 短视频模板专题曝光_焦点移动
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','cntp':'colum_play'}    test_281   ${datatable_prefix_apk}_show

case_187 短视频模板专题试看媒资播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_187   ${datatable_prefix_apk}_splay

case_180 短视频模板专题试看媒资播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_180   ${datatable_prefix_apk}_play

case_284 短视频模板专题试看媒资播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_284   ${datatable_prefix_apk}_hb

case_193 短视频模板专题试看媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_193   ${datatable_prefix_apk}_stop

case_188 短视频模板专题付费媒资播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_188   ${datatable_prefix_apk}_splay

case_379 点击短视频模板专题小窗内容
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    等待订购列表出现
    获取校验结果  {'logtype':'click'}    test_379    ${datatable_prefix_apk}_click

case_380 点击短视频模板专题列表内容
    [Documentation]  点击事件
    订购返回详情页
    按次数右移  1
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'click'}    test_380    ${datatable_prefix_apk}_click

case_219 进入短视频模板专题页后退出
    [Documentation]  STAY事件
    按次数返回  1    5
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_219    ${datatable_prefix_apk}_stay

