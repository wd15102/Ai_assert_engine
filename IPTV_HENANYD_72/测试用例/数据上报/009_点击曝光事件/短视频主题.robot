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
case_207 进入主题首页模块曝光
    [Documentation]    模块曝光事件
    到达短视频轮播入口
    清除历史上报数据
    确认键
    等待短视频主题页出现
    获取校验结果  {'logtype': 'show','cntp':'theme_home'}    test_207   ${datatable_prefix_apk}_show

case_043 主题首页播放菜单浮层
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_043    ${datatable_prefix_apk}_cv

case_051 主题首页播放菜单浮层中为带货推荐时曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_051    ${datatable_prefix_apk}_cv

case_053 主题带货推荐播放浮层，小窗进度条自动弹窗时曝光
    [Documentation]  CV事件
    清除历史上报数据
    等待  10
    获取校验结果  {'logtype':'cv','mod':'c_themeplaydhpop'}    test_053    ${datatable_prefix_apk}_cv

case_054 主题带货推荐播放浮层，小窗进度条上焦点弹窗时曝光
    [Documentation]  CV事件
    等待  5
    清除历史上报数据
    按次数右移  2
    获取校验结果  {'logtype':'cv','mod':'c_themeplaydhpop'}    test_054    ${datatable_prefix_apk}_cv

case_055 主题带货推荐播放浮层，全屏弹窗时曝光
    [Documentation]  CV事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv','mod':'c_themeplaydhpop'}    test_055    ${datatable_prefix_apk}_cv

case_410 点击主题首页播放菜单浮层中带货推荐
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_410    ${datatable_prefix_apk}_click

case_217 插入播放推荐模块曝光
    [Documentation]    模块曝光事件
    返回键
    清除历史上报数据
    等待页面出现内容描述信息  大芒短视频b测试关联推荐  30
    获取校验结果  {'logtype': 'show'}    test_217   ${datatable_prefix_apk}_show

case_216 切换子主题模块曝光
    [Documentation]    模块曝光事件
    按次数左移  4
    清除历史上报数据
    向上  5
    获取校验结果  {'logtype': 'show'}    test_216   ${datatable_prefix_apk}_show

case_274 进入主题首页，手动切换视频
    [Documentation]  点击事件
    按次数右移  1    3
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_274    ${datatable_prefix_apk}_click

case_058 主题首页播放菜单浮层中为视频推荐时曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themehomemenupop'}    test_058    ${datatable_prefix_apk}_cv

case_280 进入主题首页，点击推荐按钮
    [Documentation]  点击事件
    按次数右移  2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_280    ${datatable_prefix_apk}_click

case_280_1 点击主题首页播放菜单浮层中视频推荐
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_280    ${datatable_prefix_apk}_click

case_280_2 点击全屏播放页菜单浮层中视频推荐
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_280    ${datatable_prefix_apk}_click

case_275 进入主题首页，点赞
    [Documentation]  点击事件
    按返回直到出现文本  移动ott主题
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_275    ${datatable_prefix_apk}_click

case_276 进入主题首页，取消点赞
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_276    ${datatable_prefix_apk}_click

case_277 进入主题首页，点击关注
    [Documentation]  点击事件
    按次数右移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_277    ${datatable_prefix_apk}_click

case_278 进入主题首页，点击取消关注
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_278    ${datatable_prefix_apk}_click

case_279 进入主题首页，点击作者
    [Documentation]  点击事件
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_279    ${datatable_prefix_apk}_click

case_209 进入作者首页模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_209   ${datatable_prefix_apk}_show

case_286 进入作者页面，点击关注
    [Documentation]  点击事件
    按次数上移  1
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_286    ${datatable_prefix_apk}_click

case_287 进入作者页面，点击短视频媒资
    [Documentation]  点击事件
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_287    ${datatable_prefix_apk}_click

case_281 进入主题全屏播放页，点赞
    [Documentation]  点击事件
    到达短视频轮播入口
    确认键
    等待短视频主题页出现
    按次数右移  1    3
    确认键  3
    确认键  1
    按次数右移  2
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_281    ${datatable_prefix_apk}_click

case_282 进入主题全屏播放页，取消点赞
    [Documentation]  点击事件
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_282    ${datatable_prefix_apk}_click

case_283 进入主题全屏播放页，点击视频列表
    [Documentation]  点击事件
    按次数右移  3
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype':'click'}    test_283    ${datatable_prefix_apk}_click

case_284 进入主题全屏播放页，点击推荐按钮
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_284    ${datatable_prefix_apk}_click

点击全屏播放页菜单浮层中带货推荐
    [Documentation]  点击事件
#    按次数右移  1
#    清除历史上报数据
#    确认键  1
    获取校验结果  {'logtype':'click'}    test_412    ${datatable_prefix_apk}_click

case_285 进入主题全屏播放页，点击作者
    [Documentation]  点击事件
    按次数返回  1    5
    确认键  1
    按次数右移  3
    清除历史上报数据
    确认键  3
    获取校验结果  {'logtype':'click'}    test_285    ${datatable_prefix_apk}_click

case_208 进入主题播放列表页模块曝光
    [Documentation]    模块曝光事件
    按次数返回  1    7
    确认键  1
    按次数右移  4
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'show'}    test_208   ${datatable_prefix_apk}_show

case_045 主题全屏播放视频列表浮层
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themeplaylistpop'}    test_045    ${datatable_prefix_apk}_cv

case_044 主题全屏播放页菜单浮层
    [Documentation]  CV事件
#    清除历史上报数据
#    确认键  5
    获取校验结果  {'logtype':'cv','mod':'c_themeplaymenupop'}    test_044    ${datatable_prefix_apk}_cv

case_052 全屏播放页菜单浮层中为带货推荐时曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themeplaymenupop'}    test_052    ${datatable_prefix_apk}_cv

case_056 主题带货推荐播放浮层，全屏播放弹窗，且正常展示时曝光
    [Documentation]  CV事件
    确认键
    按次数下移  2
    清除历史上报数据
    等待页面出现元素信息  ${带货推荐标题}   20
    获取校验结果  {'logtype':'cv'}    test_056    ${datatable_prefix_apk}_cv

case_057 主题带货推荐播放浮层，全屏播放弹窗，且被其他功能浮层隐藏后重现时曝光
    [Documentation]  CV事件
    log to console  后期功能去掉了

case_059 全屏播放页菜单浮层中为视频推荐时曝光
    [Documentation]  CV事件
    到达短视频轮播入口
    确认键
    等待短视频主题页出现
    按键直到焦点位于文本爷爷节点  子主题b    左
    按次数上移  1
    等待页面出现内容描述信息  大芒短视频测试a1  10
    按次数右移  1    3
    确认键  5
    确认键  5
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv','mod':'c_themeplaymenupop'}    test_059    ${datatable_prefix_apk}_cv

case_049 主题全屏播放推荐浮层
    [Documentation]  CV事件
    按次数下移  1
    清除历史上报数据
    等待页面出现文本信息  OK键  20
    获取校验结果  {'logtype':'cv','mod':'c_themeplayrecpop'}    test_049    ${datatable_prefix_apk}_cv

case_314 进入主题全屏播放页，点击推荐浮层
    [Documentation]  点击事件
    清除历史上报数据
    确认键  2
    获取校验结果  {'logtype':'click'}    test_314    ${datatable_prefix_apk}_click

case_288 进入短视频时间线模板页_主题
    [Documentation]  PV事件
    详情页退出
    按次数返回  1
    按次数左移  1    3
    按次数下移  1    5
    清除历史上报数据
    按次数下移  1
    等待页面出现内容描述信息  大芒短视频测试c1
    获取校验结果_不上报  {'logtype':'pv'}    test_288    ${datatable_prefix_apk}_pv

case_284 短视频时间线模板列表曝光_主题
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_284   ${datatable_prefix_apk}_show

case_159 短视频时间线模板小窗菜单按钮曝光_主题
    [Documentation]    CV事件
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'cv'}    test_159   ${datatable_prefix_apk}_cv

case_200 短视频时间线模板主题页媒资播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_200   ${datatable_prefix_apk}_splay

case_192 短视频时间线模板主题页媒资播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_192   ${datatable_prefix_apk}_play

case_184 短视频时间线模板主题页媒资播放_快退拖拽
    [Documentation]    drag事件
    确认键
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_184   ${datatable_prefix_apk}_drag

case_185 短视频时间线模板主题页媒资播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_185   ${datatable_prefix_apk}_drag

case_070 短视频时间线模板主题页媒资播放_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    短视频播放暂停
    获取校验结果      {'logtype': 'pause'}    test_070   ${datatable_prefix_apk}_pause

case_070 短视频时间线模板主题页媒资播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_070   ${datatable_prefix_apk}_resume

case_285 短视频时间线模板列表曝光_焦点移动_主题
    [Documentation]    模块曝光事件
#    按键直到出现文本信息  子主题a
    按键直到焦点位于内容描述上  大芒短视频测试c1
    按次数下移  1
    清除历史上报数据
    按次数下移  1    3
    获取校验结果  {'logtype': 'show'}    test_285   ${datatable_prefix_apk}_show

case_285_1 短视频广告推荐模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_285   ${datatable_prefix_apk}_show

case_387 点击短视频时间线模板媒资_主题
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_387    ${datatable_prefix_apk}_click

case_296 短视频时间线模板主题页媒资播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_296   ${datatable_prefix_apk}_hb

case_204 短视频时间线模板主题页媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_204   ${datatable_prefix_apk}_stop

case_388 点击短视频时间线模板标签_主题
    [Documentation]  点击事件
    按键直到焦点位于文本父节点  王者荣耀  右
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_388    ${datatable_prefix_apk}_click

case_221 进入短视频时间线模板页后退出_主题
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_221    ${datatable_prefix_apk}_stay

case_411 点击短视频广告推荐模块
    [Documentation]  点击事件
    按键直到出现文本信息  子主题a
    按次数左移  4
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_411    ${datatable_prefix_apk}_click

case_194 短视频广告推荐媒资播放
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_194   ${datatable_prefix_apk}_play

case_301 广告推荐播放，上报退出
    [Documentation]    心跳事件
    清除历史上报数据
    按次数返回  1    5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_301   ${datatable_prefix_apk}_hb

case_288 进入个人中心_我赞过页面，点击删除
    [Documentation]  点击事件
    返回精选页
    切换频道  全部
    切换频道  精选
    切换频道  电视剧
    按次数下移  1
    确认键  5
    按次数右移  1
    按次数上移  1
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_288    ${datatable_prefix_apk}_click

case_289 进入个人中心_我赞过页面，点击媒资
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_289    ${datatable_prefix_apk}_click

case_290 进入个人中心_我的关注页面，点击删除
    [Documentation]  点击事件
    按返回直到出现元素  ${我赞过的}
    按次数左移  3
    向下  3
    校验焦点是否在内容描述上  我的关注
    按次数右移  1
    按次数上移  1
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_290    ${datatable_prefix_apk}_click

case_291 进入个人中心_我的关注页面，点击作者
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_291    ${datatable_prefix_apk}_click

case_310 进入我的页面，点击我赞过的媒资
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  5
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_310    ${datatable_prefix_apk}_click

case_311 进入我的页面，点击我赞过的全部赞过
    [Documentation]  点击事件
    按次数返回  1
    按次数右移  3
    清除历史上报数据
    确认键  3
    获取校验结果  {'logtype':'click'}    test_311    ${datatable_prefix_apk}_click

case_312 进入我的页面，点击我关注的up主
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键  3
    获取校验结果  {'logtype':'click'}    test_312    ${datatable_prefix_apk}_click

case_313 进入我的页面，点击我关注的全部关注
    [Documentation]  点击事件
    按次数返回  1
    按次数右移  4
    清除历史上报数据
    确认键  1
    获取校验结果  {'logtype':'click'}    test_313    ${datatable_prefix_apk}_click