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
case_142 短视频主题页小窗菜单按钮曝光_不含标签
    [Documentation]  CV事件
    到达短视频轮播入口
    清除历史上报数据
    确认键
    等待短视频主题页出现
    获取校验结果  {'logtype':'cv'}    test_142    ${datatable_prefix_apk}_cv

case_143 短视频主题页小窗菜单按钮曝光_含标签
    [Documentation]  CV事件
    按次数下移  3    2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'cv','mod':'c_themehomemenupop'}    test_143    ${datatable_prefix_apk}_cv

case_144 短视频主题页全屏播放菜单浮层曝光_不含标签
    [Documentation]  CV事件
    按次数右移  1
    确认键  5
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv'}    test_144    ${datatable_prefix_apk}_cv

case_362 短视频主题页小窗点击标签按钮
    [Documentation]  点击事件
    按次数返回  1
    按返回直到不出现元素  ${短视频全屏操作菜单区}
    按次数右移  3
    清除历史上报数据
    确认键   15
    获取校验结果  {'logtype':'click'}    test_362    ${datatable_prefix_apk}_click

case_278 从短视频主题页进入标签聚合页
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_278    ${datatable_prefix_apk}_pv

case_278_1 进入短视频标签最热页面
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_278    ${datatable_prefix_apk}_pv

case_270 标签聚合页模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_270   ${datatable_prefix_apk}_show

case_270_1 进入短视频标签最热页模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_270   ${datatable_prefix_apk}_show

case_145 短视频标签聚合页小窗播放页菜单浮层曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themehomemenupop'}    test_145    ${datatable_prefix_apk}_cv

case_146 主题带货推荐播放浮层，标签聚合页小窗进度条自动弹窗时曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_themeplaydhpop'}    test_146    ${datatable_prefix_apk}_cv

case_166 标签聚合页媒资播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_166   ${datatable_prefix_apk}_splay

case_160 标签聚合页媒资播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_160   ${datatable_prefix_apk}_play

case_147 主题带货推荐播放浮层，标签聚合页小窗进度条上焦点弹窗时曝光
    [Documentation]  CV事件
    等待  5
    按次数右移  1
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype':'cv'}    test_147    ${datatable_prefix_apk}_cv

case_148 主题带货推荐播放浮层，标签聚合页全屏弹窗时曝光
    [Documentation]  CV事件
    按次数左移  1
    确认键
    清除历史上报数据
    按次数下移  1
    等待文本出现  扫码了解详情   20
    获取校验结果  {'logtype':'cv'}    test_148    ${datatable_prefix_apk}_cv

case_167 标签聚合页媒资全屏播放_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_167   ${datatable_prefix_apk}_splay

case_168 标签聚合页全屏手动切换媒资_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_168   ${datatable_prefix_apk}_splay

case_168_1 进入短视频标签最热页播放媒资_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_168   ${datatable_prefix_apk}_splay

case_161 标签聚合页媒资全屏播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_161   ${datatable_prefix_apk}_play

case_162 标签聚合页全屏手动切换媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_162   ${datatable_prefix_apk}_play

case_162_1 进入短视频标签最热页播放媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_162   ${datatable_prefix_apk}_play

case_158 标签聚合页全屏播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_158   ${datatable_prefix_apk}_drag

case_160 标签聚合页全屏手动切换媒资_快进拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_160   ${datatable_prefix_apk}_drag

case_160_1 进入短视频标签最热页播放媒资_快进拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_160   ${datatable_prefix_apk}_drag

case_161 标签聚合页全屏手动切换媒资_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_161   ${datatable_prefix_apk}_drag

case_159 标签聚合页全屏播放_快退拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_159   ${datatable_prefix_apk}_drag

case_161_1 进入短视频标签最热页播放媒资_快退拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_161   ${datatable_prefix_apk}_drag

case_056 标签聚合页全屏播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    短视频播放暂停
    获取校验结果      {'logtype': 'pause'}    test_056   ${datatable_prefix_apk}_pause

case_057 标签聚合页全屏手动切换媒资播放暂停
    [Documentation]    pause事件
    获取校验结果      {'logtype': 'pause'}    test_057   ${datatable_prefix_apk}_pause

case_057_1 进入短视频标签最热页播放媒资_播放暂停
    [Documentation]    pause事件
    获取校验结果      {'logtype': 'pause'}    test_057   ${datatable_prefix_apk}_pause

case_057 标签聚合页全屏手动切换媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_057   ${datatable_prefix_apk}_resume

case_056 标签聚合页全屏播放暂停后恢复播放
    [Documentation]    resume事件
    获取校验结果      {'logtype': 'resume'}    test_056   ${datatable_prefix_apk}_resume

case_057_1 进入短视频标签最热页播放媒资_暂停后恢复播放
    [Documentation]    resume事件
    获取校验结果      {'logtype': 'resume'}    test_057   ${datatable_prefix_apk}_resume

case_254 标签聚合页媒资全屏播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数下移  1    10
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_254   ${datatable_prefix_apk}_hb

case_255 标签聚合页全屏手动切换媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_255   ${datatable_prefix_apk}_hb

case_255_1 进入短视频标签最热页播放媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_255   ${datatable_prefix_apk}_hb

case_171 标签聚合页媒资全屏播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_171   ${datatable_prefix_apk}_stop

case_172 标签聚合页全屏手动切换媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_172   ${datatable_prefix_apk}_stop

case_172_1 进入短视频标签最热页播放媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_172   ${datatable_prefix_apk}_stop

case_256 标签聚合页媒资播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_256   ${datatable_prefix_apk}_hb

case_257 标签聚合页媒资播放_退出心跳
    [Documentation]    心跳事件
    按次数返回  1    3
    清除历史上报数据
    按次数上移  1    5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_257   ${datatable_prefix_apk}_hb

case_258 标签聚合页手动切换媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_258   ${datatable_prefix_apk}_hb

case_173 标签聚合页媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_173   ${datatable_prefix_apk}_stop

case_174 标签聚合页手动切换媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_174   ${datatable_prefix_apk}_stop

case_169 标签聚合页手动切换媒资_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_169   ${datatable_prefix_apk}_splay

case_163 标签聚合页手动切换媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_163   ${datatable_prefix_apk}_play

case_170 标签聚合页自动切换媒资_启播
    [Documentation]    启播事件
    等待  30
    清除历史上报数据
    等待  25
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_170   ${datatable_prefix_apk}_splay

case_164 标签聚合页自动切换媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_164   ${datatable_prefix_apk}_play

case_259 标签聚合页自动切换媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数上移  1    2
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_259   ${datatable_prefix_apk}_hb

case_175 标签聚合页自动切换媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_175   ${datatable_prefix_apk}_stop

case_363 标签_聚合播放页，点击收藏
    [Documentation]  点击事件
    按次数上移  3    2
    校验焦点是否在文本上  收藏
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_363    ${datatable_prefix_apk}_click

case_363_1 点击标签最热页收藏按钮
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_363    ${datatable_prefix_apk}_click

case_364 标签_聚合播放页，点击取消收藏
    [Documentation]  点击事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_364    ${datatable_prefix_apk}_click

case_364_1 点击标签最热页取消收藏
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_364    ${datatable_prefix_apk}_click

case_271 标签聚合页移动模块曝光
    [Documentation]    模块曝光事件
    按次数下移  1    2
    按次数左移  1    2
    按次数下移  2
    等待  5
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show'}    test_271   ${datatable_prefix_apk}_show

case_271_1 进入短视频标签最热页模块曝光_焦点移动
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_271   ${datatable_prefix_apk}_show

case_365 标签聚合页点击列表视频
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_365    ${datatable_prefix_apk}_click

case_365_1 点击标签最热页列表媒资
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_365    ${datatable_prefix_apk}_click

case_212 从短视频主题页进入标签聚合页后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_212    ${datatable_prefix_apk}_stay

case_212_1 进入短视频标签最热页面后退出
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_212    ${datatable_prefix_apk}_stay

case_149 短视频分屏小窗菜单按钮曝光_不含标签
    [Documentation]  CV事件
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  纪实
    切换频道  测试
    清除历史上报数据
    切换频道  短视频
    获取校验结果  {'logtype':'cv','mod':'c_themehomemenupop'}    test_149    ${datatable_prefix_apk}_cv

case_150 短视频分屏小窗菜单按钮曝光_含标签
    [Documentation]  CV事件
    按次数下移  1
    按次数右移  1    5
    按次数下移  1
    按次数右移  5
    按次数下移  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv'}    test_150    ${datatable_prefix_apk}_cv

case_151 短视频分屏全屏播放菜单浮层曝光_不含标签
    [Documentation]  CV事件
    按次数左移  1
    确认键  5
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'cv'}    test_151    ${datatable_prefix_apk}_cv

case_366 短视频分屏小窗点击标签按钮
    [Documentation]  点击事件
    按键直到焦点位于文本父节点  全屏   返回
    按次数右移  3
    校验焦点是否在文本父节点上  王者荣耀
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_366    ${datatable_prefix_apk}_click

case_279 从短视频分屏进入标签聚合页
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_279    ${datatable_prefix_apk}_pv

case_171 标签聚合页全屏自动切换媒资_启播
    [Documentation]    启播事件
    确认键
    按次数下移  1    30
    清除历史上报数据
    等待  25
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_171   ${datatable_prefix_apk}_splay

case_165 标签聚合页全屏自动切换媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_165   ${datatable_prefix_apk}_play

case_162 标签聚合页全屏自动切换媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_162   ${datatable_prefix_apk}_drag

case_163 标签聚合页全屏自动切换媒资_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_163   ${datatable_prefix_apk}_drag

case_058 标签聚合页全屏自动切换媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    短视频播放暂停
    获取校验结果      {'logtype': 'pause'}    test_058   ${datatable_prefix_apk}_pause

case_058 标签聚合页全屏自动切换媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_058   ${datatable_prefix_apk}_resume

case_260 标签聚合页全屏自动切换媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_260   ${datatable_prefix_apk}_hb

case_176 标签聚合页全屏自动切换媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_176   ${datatable_prefix_apk}_stop

case_213 从短视频分屏进入标签聚合页后退出
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay','cntp':'tag_play'}    test_213    ${datatable_prefix_apk}_stay

case_272 个人中心标签模块曝光
    [Documentation]    模块曝光事件
    到达我的页面入口
    确认键
    等待我的页出现
    按键直到焦点位于内容描述上  短视频跳专题测试   下
    校验焦点是否在内容描述上  短视频跳专题测试
    清除历史上报数据
    按次数下移  2
    获取校验结果  {'logtype': 'show','mtitle':'短视频标签'}    test_272   ${datatable_prefix_apk}_show

case_367 个人中心点击标签内容
    [Documentation]  点击事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_367    ${datatable_prefix_apk}_click

case_368 个人中心点击标签全部收藏
    [Documentation]  点击事件
    按次数返回  1    2
    按次数右移  3
    校验焦点是否在元素上  ${短视频标签_全部收藏}
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_368    ${datatable_prefix_apk}_click

case_280 进入标签_收藏页
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_280    ${datatable_prefix_apk}_pv

case_369 标签_收藏页，点击内容
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_369    ${datatable_prefix_apk}_click

case_370 点击标签收藏页第1页第1个媒资
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_370    ${datatable_prefix_apk}_click

case_371 点击标签收藏页第1页第2个媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_371    ${datatable_prefix_apk}_click

case_372 点击标签收藏页第2页第1个媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    按次数左移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_372    ${datatable_prefix_apk}_click

case_373 标签_收藏页，点击删除
    [Documentation]  点击事件
    按次数返回  1    2
    按次数上移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_373    ${datatable_prefix_apk}_click

case_214 进入标签_收藏页后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  2
    获取校验结果  {'logtype':'stay'}    test_214    ${datatable_prefix_apk}_stay

case_157 标签最热页菜单控件曝光
    [Documentation]  CV事件
    到达短视频轮播入口
    按次数右移  3
    校验焦点是否在内容描述上  跳转标签
    清除历史上报数据
    确认键  5
    等待文本出现  热门推荐
    获取校验结果  {'logtype':'cv'}    test_157    ${datatable_prefix_apk}_cv

case_287 进入短视频标签最新页面
    [Documentation]  PV事件
    按次数左移  1    2
    校验焦点是否在文本爷爷节点上  热门推荐
    清除历史上报数据
    按次数下移  1    3
    校验焦点是否在文本爷爷节点上  最新上线
    获取校验结果_不上报  {'logtype':'pv'}    test_287    ${datatable_prefix_apk}_pv

case_282 进入短视频标签最新页模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_282   ${datatable_prefix_apk}_show

case_382 点击标签最新页列表媒资
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_382    ${datatable_prefix_apk}_click

case_158 标签最新页菜单控件曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_158    ${datatable_prefix_apk}_cv

case_199 进入短视频标签最新页播放媒资_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_199   ${datatable_prefix_apk}_splay

case_191 进入短视频标签最新页播放媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_191   ${datatable_prefix_apk}_play

case_383 点击标签最新页收藏按钮
    [Documentation]  点击事件
    按次数上移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_383    ${datatable_prefix_apk}_click

case_384 点击标签最新页取消收藏
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_384    ${datatable_prefix_apk}_click

case_182 进入短视频标签最新页播放媒资_快进拖拽
    [Documentation]    drag事件
    按次数下移  1
    确认键  5
    清除历史上报数据
    按次数右移  1
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_182   ${datatable_prefix_apk}_drag

case_183 进入短视频标签最新页播放媒资_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    按次数左移  1    3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_183   ${datatable_prefix_apk}_drag

case_069 进入短视频标签最新页播放媒资_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    短视频播放暂停
    获取校验结果      {'logtype': 'pause'}    test_069   ${datatable_prefix_apk}_pause

case_069 进入短视频标签最新页播放媒资_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键  10
    获取校验结果      {'logtype': 'resume'}    test_069   ${datatable_prefix_apk}_resume

case_283 进入短视频标签最新页模块曝光_焦点移动
    [Documentation]    模块曝光事件
    按次数返回  1    3
    按次数左移  1
    校验焦点是否在内容描述上  大芒短视频测试b4
    按次数下移  2
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show'}    test_283   ${datatable_prefix_apk}_show

case_295 进入短视频标签最新页播放媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_295   ${datatable_prefix_apk}_hb

case_203 进入短视频标签最新页播放媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_203   ${datatable_prefix_apk}_stop

case_220 进入短视频标签最新页面后退出
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay','cntp':'tag_play'}    test_220    ${datatable_prefix_apk}_stay
