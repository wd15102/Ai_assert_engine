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
case_425 点击搜索“查看更多”按钮
    [Documentation]  点击事件
    返回首页
    到达搜索入口
    确认键
    等待搜索页出现
    搜索-输入搜索词    A
    点击搜索结果媒资    1
    按键直到焦点位于文本上  查看更多   下
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_425    ${datatable_prefix_apk}_click

case_290 视频搜索结果播放页
    [Documentation]  PV事件
    按键直到焦点位于文本上  查看更多   下
    按次数下移  1
    清除历史上报数据
    确认键
    等待出现搜索结果页
    获取校验结果  {'logtype':'pv'}    test_290    ${datatable_prefix_apk}_pv

case_165 视频搜索结果免费媒资播放页菜单浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_165    ${datatable_prefix_apk}_cv

case_166 视频搜索结果播放页菜单浮层曝光_带货推荐
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_166    ${datatable_prefix_apk}_cv

case_298 视频搜索结果页左则视频列表曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_298   ${datatable_prefix_apk}_show

case_203 视频搜索结果页小窗播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_203   ${datatable_prefix_apk}_splay

case_196 视频搜索结果页小窗播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_196   ${datatable_prefix_apk}_play

case_302 视频搜索结果页小窗播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_302   ${datatable_prefix_apk}_hb

case_413 视频搜索结果页点击搜索媒资推荐按钮
    [Documentation]  点击事件
    按次数右移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_413    ${datatable_prefix_apk}_click

case_414 视频搜索结果页点击推荐媒资推荐按钮
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_414    ${datatable_prefix_apk}_click

case_416 视频搜索结果页点击取消点赞
    [Documentation]  点击事件
    按次数返回  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_416    ${datatable_prefix_apk}_click

case_415 视频搜索结果页点击点赞
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_415    ${datatable_prefix_apk}_click

case_417 视频搜索结果页点击作者
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_417    ${datatable_prefix_apk}_click

case_303 视频搜索结果页小窗播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_303   ${datatable_prefix_apk}_hb

case_208 视频搜索结果页小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_208   ${datatable_prefix_apk}_stop

case_167 视频搜索结果试看媒资播放页菜单浮层曝光
    [Documentation]  CV事件
    按次数返回  1    3
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'cv'}    test_167    ${datatable_prefix_apk}_cv

case_168 视频搜索结果页推荐媒资播放页菜单浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_168    ${datatable_prefix_apk}_cv

case_169 视频搜索结果页带标签媒资播放页菜单浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_169    ${datatable_prefix_apk}_cv

case_170 视频搜索结果播放页菜单浮层曝光_视频推荐
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_170    ${datatable_prefix_apk}_cv

case_418 视频搜索结果页点击开通会员
    [Documentation]  点击事件
    按次数右移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_418    ${datatable_prefix_apk}_click

case_419 视频搜索结果页点击标签
    [Documentation]  点击事件
    等待订购列表出现
    按次数返回  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_419    ${datatable_prefix_apk}_click

case_291 视频搜索结果全屏播放页
    [Documentation]  PV事件
    按键直到出现文本信息  更多关于“A“的相关视频  返回
    确认键  5
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_291    ${datatable_prefix_apk}_pv

case_190 视频搜索结果页全屏播放_拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_190   ${datatable_prefix_apk}_drag

case_171 视频搜索结果免费媒资全屏播放页菜单浮层曝光
    [Documentation]  CV事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv'}    test_171    ${datatable_prefix_apk}_cv

case_172 视频搜索结果页推荐媒资全屏播放页菜单浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_172    ${datatable_prefix_apk}_cv

case_074 视频搜索结果页全屏播放_暂停
    [Documentation]    pause事件
    清除历史上报数据
    短视频播放暂停
    获取校验结果      {'logtype': 'pause'}    test_074   ${datatable_prefix_apk}_pause

case_074 视频搜索结果页全屏播放_暂停的恢复
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_074   ${datatable_prefix_apk}_resume

case_204 视频搜索结果页全屏播放_启播
    [Documentation]    启播事件
    清除历史上报数据
    按次数下移  1    5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_204   ${datatable_prefix_apk}_splay

case_197 视频搜索结果页全屏播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_197   ${datatable_prefix_apk}_play

case_304 视频搜索结果页全屏播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_304   ${datatable_prefix_apk}_hb

case_209 视频搜索结果页全屏播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_209   ${datatable_prefix_apk}_stop

case_173 视频搜索结果试看媒资全屏播放页菜单浮层曝光
    [Documentation]  CV事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv'}    test_173    ${datatable_prefix_apk}_cv

case_420 视频搜索结果页全屏播放点击开通会员
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_420    ${datatable_prefix_apk}_click

case_421 视频搜索结果页全屏播放点击搜索媒资推荐按钮
    [Documentation]  点击事件
    等待订购列表出现
    按次数返回  1    7
    确认键
    按次数右移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_421    ${datatable_prefix_apk}_click

case_422 视频搜索结果页全屏播放点击推荐媒资推荐按钮
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_422    ${datatable_prefix_apk}_click

case_299 视频搜索结果页左则视频列表曝光_焦点移动
    [Documentation]    模块曝光事件
    按键直到出现文本信息  更多关于“A“的相关视频
    确认键  5
    按次数下移  2
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show'}    test_299   ${datatable_prefix_apk}_show

case_423 视频搜索结果页点击关注
    [Documentation]  点击事件
    确认键  5
    按次数右移  5
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_423    ${datatable_prefix_apk}_click

case_424 视频搜索结果页点击取消关注
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_424    ${datatable_prefix_apk}_click



#视频搜索结果页小窗播放_缓冲
#视频搜索结果页全屏播放_缓冲