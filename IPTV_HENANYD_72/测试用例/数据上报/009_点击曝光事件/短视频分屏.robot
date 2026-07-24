*** Settings ***
Documentation    CV事件
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_210 进入短视频分屏模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  动漫
    切换频道  纪实
    切换频道  测试
    清除历史上报数据
    切换频道  短视频
    获取校验结果  {'logtype': 'show','mid':'26'}    test_210   ${datatable_prefix_apk}_show

case_046 短视频分屏播放菜单浮层
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themehomemenupop'}    test_046    ${datatable_prefix_apk}_cv

case_060 短视频分屏小窗播放菜单浮层中为视频推荐时曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themehomemenupop'}    test_060    ${datatable_prefix_apk}_cv

case_309 分屏进入主题全屏播放页，点击推荐浮层
    [Documentation]  点击事件
    等待  3
    按次数下移  2
    校验焦点是否在文本父节点上  全屏
    确认键
    按次数下移  1
    清除历史上报数据
    等待页面出现文本信息  OK键  20
    确认键  5
    获取校验结果  {'logtype':'click'}    test_309    ${datatable_prefix_apk}_click

case_050 分屏进入全屏播放推荐浮层
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themeplayrecpop'}    test_050    ${datatable_prefix_apk}_cv

case_295 短视频分屏，点赞
    [Documentation]  点击事件
    按键直到焦点位于文本父节点  全屏   返回
    按次数上移  1    5
    按次数右移  2
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_295    ${datatable_prefix_apk}_click

case_296 短视频分屏，取消点赞
    [Documentation]  点击事件
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_296    ${datatable_prefix_apk}_click

case_297 短视频分屏，点击关注
    [Documentation]  点击事件
    按次数右移  2
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_297    ${datatable_prefix_apk}_click

case_298 短视频分屏，取消关注
    [Documentation]  点击事件
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_298    ${datatable_prefix_apk}_click

case_299 短视频分屏，点击推荐按钮
    [Documentation]  点击事件
    按次数左移  3
    清除历史上报数据
    确认键  3
    获取校验结果  {'logtype':'click'}    test_299    ${datatable_prefix_apk}_click

case_300 短视频分屏，点击作者
    [Documentation]  点击事件
    按键直到出现文本信息  看正片
    按次数右移  2
    清除历史上报数据
    确认键  3
    获取校验结果  {'logtype':'click'}    test_300    ${datatable_prefix_apk}_click

case_212 分屏进入作者首页模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_212   ${datatable_prefix_apk}_show

case_301 分屏进入作者页面，点击关注
    [Documentation]  点击事件
    按次数上移  1
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_301    ${datatable_prefix_apk}_click

case_302 分屏进入作者页面，点击短视频媒资
    [Documentation]  点击事件
    按次数下移  1
    清除历史上报数据
    确认键  7
    获取校验结果  {'logtype':'click'}    test_302    ${datatable_prefix_apk}_click

case_215 进入短视频分屏关注子模块的模块曝光
    [Documentation]    模块曝光事件
    按返回直到焦点位于内容  子主题a
    清除历史上报数据
    向左  3
    获取校验结果  {'logtype': 'show'}    test_215   ${datatable_prefix_apk}_show

case_292 短视频分屏切换到我的关注子页面，点击关注
    [Documentation]  点击事件
    按次数下移  1
    向右  3
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_292    ${datatable_prefix_apk}_click

case_293 短视频分屏切换到我的关注子页面，点击取消关注
    [Documentation]  点击事件
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_293    ${datatable_prefix_apk}_click

case_294 短视频分屏切换到我的关注子页面，点击查看主页
    [Documentation]  点击事件
    按次数左移  1
    清除历史上报数据
    确认键  3
    获取校验结果  {'logtype':'click'}    test_294    ${datatable_prefix_apk}_click

case_047 分屏进入主题全屏播放页菜单浮层
    [Documentation]  CV事件
    按返回直到焦点位于内容  短视频
    按次数下移  1
    按次数右移  1    5
    按次数下移  1    3
    校验焦点是否在文本父节点上  全屏
    确认键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv','mod':'c_themeplaymenupop'}    test_047    ${datatable_prefix_apk}_cv

case_061 短视频分屏进入全屏播放页菜单浮层中为视频推荐时曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themeplaymenupop'}    test_061    ${datatable_prefix_apk}_cv

case_303 分屏进入主题全屏播放页，点击推荐按钮
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键  3
    获取校验结果  {'logtype':'click'}    test_303    ${datatable_prefix_apk}_click

case_304 分屏进入主题全屏播放页，点击点赞
    [Documentation]  点击事件
    按返回直到出现元素   ${详情页收藏}
    按次数返回  1
    按返回直到不出现元素   ${详情页收藏}
    确认键  1
    按次数右移  2
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_304    ${datatable_prefix_apk}_click

case_305 分屏进入主题全屏播放页，点击取消点赞
    [Documentation]  点击事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_305    ${datatable_prefix_apk}_click

case_306 分屏进入主题全屏播放页，点击视频列表
    [Documentation]  点击事件
    确认键  1
    按次数右移  5    0
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_306    ${datatable_prefix_apk}_click

case_211 分屏进入主题播放列表页模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_211   ${datatable_prefix_apk}_show

case_048 分屏进入主题全屏播放视频列表浮层
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themeplaylistpop'}    test_048    ${datatable_prefix_apk}_cv

case_307 分屏进入主题全屏播放页，点击作者
    [Documentation]  点击事件
    等待文本出现  视频列表
    按次数右移  3
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_307    ${datatable_prefix_apk}_click

case_218 分屏切换子主题模块曝光
    [Documentation]    模块曝光事件
    按返回直到焦点位于内容  短视频
    按次数下移  1    3
    校验焦点是否在内容描述上  子主题a
    清除历史上报数据
    向右  3
    获取校验结果  {'logtype': 'show'}    test_218   ${datatable_prefix_apk}_show

case_062 短视频分屏小窗播放菜单浮层中为带货推荐时曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_062    ${datatable_prefix_apk}_cv

case_063 短视频分屏带货推荐播放浮层，小窗进度条自动弹窗时曝光
    [Documentation]  CV事件
    校验焦点是否在内容描述上  子主题b
    等待  10
    获取校验结果  {'logtype':'cv','mod':'c_themeplaydhpop'}    test_063    ${datatable_prefix_apk}_cv

case_064 短视频分屏带货推荐播放浮层，小窗进度条上焦点弹窗时曝光
    [Documentation]  CV事件
    按次数下移  1
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype':'cv','mod':'c_themeplaydhpop'}    test_064    ${datatable_prefix_apk}_cv

case_065 短视频分屏带货推荐播放浮层，全屏弹窗时曝光
    [Documentation]  CV事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv','mod':'c_themeplaydhpop'}    test_065    ${datatable_prefix_apk}_cv

case_219 分屏插入播放推荐模块曝光
    [Documentation]    模块曝光事件
    确认键
    清除历史上报数据
    等待页面出现内容描述信息  大芒短视频b测试关联推荐  40
    获取校验结果  {'logtype': 'show'}    test_219   ${datatable_prefix_apk}_show

case_324 点击短视频分屏插入播放推荐内容
    [Documentation]  点击事件
    按次数右移  4    0
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_324    ${datatable_prefix_apk}_click

case_067 短视频分屏带货推荐播放浮层，全屏播放弹窗，且正常展示时曝光
    [Documentation]  CV事件
    确认键  5
    按次数上移  1
    清除历史上报数据
    等待页面出现元素信息  ${带货推荐标题}   25
    获取校验结果  {'logtype':'cv','mod':'c_themeplaydhpop'}    test_067    ${datatable_prefix_apk}_cv

case_066 短视频分屏进入全屏播放页菜单浮层中为带货推荐时曝光
    [Documentation]  CV事件
    等待  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv'}    test_066    ${datatable_prefix_apk}_cv

case_289 进入短视频时间线模板页_分屏
    [Documentation]  PV事件
    按键直到焦点位于内容描述上  子主题b
    清除历史上报数据
    按次数右移  1    3
    获取校验结果  {'logtype':'pv'}    test_289    ${datatable_prefix_apk}_pv

case_286 短视频时间线模板列表曝光_分屏
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_286   ${datatable_prefix_apk}_show

case_160 短视频时间线模板小窗菜单按钮曝光_分屏
    [Documentation]    CV事件
    获取校验结果  {'logtype': 'cv','mod':'c_themehomemenupop'}    test_160   ${datatable_prefix_apk}_cv

case_201 短视频时间线模板分屏页媒资播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_201   ${datatable_prefix_apk}_splay

case_193 短视频时间线模板分屏页媒资播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_193   ${datatable_prefix_apk}_play

case_186 短视频时间线模板分屏页媒资播放_快退拖拽
    [Documentation]    drag事件
    按次数下移  1
    确认键
    清除历史上报数据
    按次数左移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_186   ${datatable_prefix_apk}_drag

case_187 短视频时间线模板分屏页媒资播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_187   ${datatable_prefix_apk}_drag

case_071 短视频时间线模板分屏页媒资播放_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    短视频播放暂停
    获取校验结果      {'logtype': 'pause'}    test_071   ${datatable_prefix_apk}_pause

case_071 短视频时间线模板分屏页媒资播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_071   ${datatable_prefix_apk}_resume

case_287 短视频时间线模板列表曝光_焦点移动_分屏
    [Documentation]    模块曝光事件
    按键直到焦点位于文本父节点  全屏
    按次数右移  5
    清除历史上报数据
    按次数下移  2
    获取校验结果  {'logtype': 'show'}    test_287   ${datatable_prefix_apk}_show

case_389 点击短视频时间线模板媒资_分屏
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_389    ${datatable_prefix_apk}_click

case_297 短视频时间线模板分屏页媒资播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_297   ${datatable_prefix_apk}_hb

case_205 短视频时间线模板分屏页媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_205   ${datatable_prefix_apk}_stop

case_390 点击短视频时间线模板标签_分屏
    [Documentation]  点击事件
    按次数左移  1
    按次数右移  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_390    ${datatable_prefix_apk}_click

case_222 进入短视频时间线模板页后退出_分屏
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_222    ${datatable_prefix_apk}_stay

