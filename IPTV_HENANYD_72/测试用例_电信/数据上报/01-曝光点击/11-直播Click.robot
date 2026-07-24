*** Settings ***
Documentation    直播Click事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case001 点击直播浮层中的频道
    [Tags]  P2
    返回首页
    点击内容描述  精选
    数字键进直播  001
    直播呼出浮层
    清除历史上报数据
    点击内容描述  湖南经视高清
    获取校验结果  {'logtype':'click'}    test_343    ${datatable_prefix_apk}_click

case002 点击回看列表中的直播节目
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    清除历史上报数据
    点击内容描述  分段1
    获取校验结果  {'logtype':'click'}    test_344    ${datatable_prefix_apk}_click

case003 点击回看列表中的预约
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数下移  1
    按次数右移  1
    直播预约取消
    清除历史上报数据
    确认键
    等待页面出现文本信息  确认预约
    确认键
    获取校验结果  {'logtype':'click'}    test_345    ${datatable_prefix_apk}_click

case004 点击回看列表中的取消预约
    [Tags]  P2
    清除历史上报数据
    确认键
    点击文本  确认取消
    获取校验结果  {'logtype':'click'}    test_346    ${datatable_prefix_apk}_click

case005 点击回看列表中的回看节目
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    向上
    清除历史上报数据
    点击内容描述  分段1
    获取校验结果  {'logtype':'click'}    test_347    ${datatable_prefix_apk}_click

case006 点击回看浮层中的直播节目
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数上移  1
    按次数右移  1
    校验焦点是否在内容描述上  分段1
    确认键
    等待页面出现元素信息  ${回看图标}  20
    确认键
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_348    ${datatable_prefix_apk}_click

case007 点击回看浮层中的预约
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数上移  1
    按次数右移  1
    校验焦点是否在内容描述上  分段1
    确认键
    等待页面出现元素信息  ${回看图标}  20
    确认键
    按次数下移  2
    清除历史上报数据
    确认键
    等待页面出现文本信息  确认预约
    确认键
    获取校验结果  {'logtype':'click'}    test_349    ${datatable_prefix_apk}_click

case008 点击回看浮层中的取消预约
    [Tags]  P2
    等待  6
    确认键
    按次数下移  2
    清除历史上报数据
    确认键
    等待页面出现文本信息  确认取消
    确认键
    获取校验结果  {'logtype':'click'}    test_350    ${datatable_prefix_apk}_click

case009 点击回看浮层中的回看节目
    [Tags]  P2
    返回首页
    进入昨天的直播回看播放页面  001
    回看呼出浮层
    按次数上移  1
    清除历史上报数据
    点击内容描述  分段1
    获取校验结果  {'logtype':'click'}    test_091    ${datatable_prefix_apk}_click

case010 点击直播放播推荐浮层的媒资
    [Tags]  P2
    返回首页
    数字键进直播  2
    直播呼出浮层
    按次数右移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','mod':'c_playrecpop'}    test_092    ${datatable_prefix_apk}_click

case011 点击直播推荐浮层的广告
    [Tags]  P2
    返回首页
    数字键进直播  2
    暂停键
    按次数上移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_094    ${datatable_prefix_apk}_click

case012 点击直播推荐浮层的继续播放
    [Tags]  P2
    返回首页
    数字键进直播  2
    暂停键
    清除历史上报数据
    点击文本  继续播放
    获取校验结果  {'logtype':'click'}    test_095    ${datatable_prefix_apk}_click

case013 点击直播推荐浮层的关闭广告
    [Tags]  P2
    返回首页
    数字键进直播  2
    暂停键
    清除历史上报数据
    向左
    点击文本  关闭广告
    获取校验结果  {'logtype':'click'}    test_096    ${datatable_prefix_apk}_click

case015 点击九屏同看页的频道
    [Tags]  P2
    返回首页
    切换频道  直播
    点击内容描述  九屏同看
    等待页面出现元素信息  ${九屏同看_频道}
    清除历史上报数据
    确认键
    等待页面出现元素信息  ${直播播放器}
    获取校验结果  {'logtype':'click'}    test_101    ${datatable_prefix_apk}_click

case016 点击直播暂停大图模式的海报
    [Tags]  P2
    返回首页
    数字键进直播  2
    暂停键
    按次数上移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_151    ${datatable_prefix_apk}_click

case018 点击时移暂停大图模式的海报
    [Tags]  P2
    返回首页
    数字键进直播  2
    按秒快退  5
    暂停键
    按次数上移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_157    ${datatable_prefix_apk}_click

case020 点击回看暂停大图模式的海报
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    向上
    点击内容描述  分段1
    等待媒资播放
    暂停键
    按次数上移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_164    ${datatable_prefix_apk}_click

case022 点击时移推荐浮层的继续播放
    [Tags]  P2
    返回首页
    数字键进直播  2
    按秒快退  1
    等待媒资播放
    暂停键
    清除历史上报数据
    点击文本  继续播放
    获取校验结果  {'logtype':'click'}    test_351    ${datatable_prefix_apk}_click

case023 点击时移推荐浮层的关闭广告
    [Tags]  P2
    暂停键
    清除历史上报数据
    点击文本  关闭广告
    确认键
    获取校验结果  {'logtype':'click'}    test_352    ${datatable_prefix_apk}_click

case025 点击回看推荐浮层的继续播放
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    向上
    点击内容描述  分段1
    等待媒资播放
    暂停键
    清除历史上报数据
    点击文本  继续播放
    获取校验结果  {'logtype':'click'}    test_353    ${datatable_prefix_apk}_click

case026 点击回看推荐浮层的关闭广告
    [Tags]  P2
    暂停键
    清除历史上报数据
    向左
    点击文本  关闭广告
    获取校验结果  {'logtype':'click'}    test_354    ${datatable_prefix_apk}_click
