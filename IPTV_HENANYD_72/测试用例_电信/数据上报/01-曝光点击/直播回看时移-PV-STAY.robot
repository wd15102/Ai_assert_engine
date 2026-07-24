*** Settings ***
Documentation    直播回看时移PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case001 从直播频道进入到回看列表页
    [Tags]  P2
    返回首页
    切换频道  直播
    清除历史上报数据
    直播频道进入回看列表
    获取校验结果  {'logtype':'pv'}    test_041    ${datatable_prefix_apk}_pv

case002 回看列表页切换频道
    [Tags]  P2
    按次数左移  1
    向下
    清除历史上报数据
    向下
    获取校验结果  {'logtype':'pv'}    test_043    ${datatable_prefix_apk}_pv

case003 从回看列表页中切换直播频道停留后返回
    [Tags]  P2
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_051    ${datatable_prefix_apk}_stay

case004 回看列表进入直播播放器
    [Tags]  P2
    直播频道进入回看列表
    清除历史上报数据
    点击内容描述  分段1
    获取校验结果  {'logtype':'pv'}    test_044    ${datatable_prefix_apk}_pv

case005 直播播放器返回回看列表
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'pv'}    test_045    ${datatable_prefix_apk}_pv

case006 从回看列表进入直播播放器停留后返回
    [Tags]  P2
    获取校验结果  {'logtype':'stay'}    test_052    ${datatable_prefix_apk}_stay

case007 从直播播放器返回回看列表停留后再次进入直播播放器
    [Tags]  P2
    清除历史上报数据
    点击内容描述  分段1
    获取校验结果  {'logtype':'stay'}    test_053    ${datatable_prefix_apk}_stay

case008 回看列表页进入回看播放器
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数左移  1
    向下
    向右
    向上
    向右
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_046    ${datatable_prefix_apk}_pv

case009 回看播放器返回回看列表页
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'pv'}    test_047    ${datatable_prefix_apk}_pv

case010 从回看列表页进入回看播放器停留后返回
    [Tags]  P2
    获取校验结果  {'logtype':'stay'}    test_054    ${datatable_prefix_apk}_stay

case011 回看播放器频道节目单浮层进入其它回看节目
    [Tags]  P2
    确认键
    回看呼出浮层
    向下
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_048    ${datatable_prefix_apk}_pv

case012 回看播放器频道节目单浮层进入其它回看节目
    [Tags]  P2
    获取校验结果  {'logtype':'pv'}    test_048    ${datatable_prefix_apk}_pv

case013 从回看播放器频道节目单浮层进入其它回看节目停留后返回
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'stay'}    test_056    ${datatable_prefix_apk}_stay

case014 回看节目播放完毕自动切换回看节目内容
    [Tags]  P2
    确认键
    回看呼出浮层
    向下
    确认键
    清除历史上报数据
    按秒快进  30
    等待  15
    获取校验结果  {'logtype':'pv'}    test_050    ${datatable_prefix_apk}_pv

case015 回看节目播放完毕自动切换回看节目内容停留后返回
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'stay'}    test_058    ${datatable_prefix_apk}_stay

case016 从回看列表页返回直播频道页
    [Tags]  P2
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_042    ${datatable_prefix_apk}_pv

case017 从回看播放器返回回看列表页停留后返回
    [Tags]  P2
    获取校验结果  {'logtype':'stay'}    test_055    ${datatable_prefix_apk}_stay

case018 回看播放器频道节目单浮层进入直播频道
    [Tags]  P2
    直播频道进入回看列表
    按次数上移  1
    按次数右移  1
    校验焦点是否在内容描述上  分段1
    确认键
    回看呼出浮层
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_049    ${datatable_prefix_apk}_pv

case019 回看节目浮层跳转到直播
    [Tags]  P2
    获取校验结果  {'logtype':'pv'}    test_049    ${datatable_prefix_apk}_pv

case020 从回看播放器频道节目单浮层进入直播频道停留后返回
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'stay'}    test_057    ${datatable_prefix_apk}_stay

case021 遥控器按键进入直播
    [Tags]  P2
    返回首页
    切换频道  直播
    清除历史上报数据
    数字键进直播  2
    获取校验结果  {'logtype':'pv'}    test_051    ${datatable_prefix_apk}_pv

case022 从直播返回首页
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'pv'}    test_052    ${datatable_prefix_apk}_pv

case023 从遥控器按键进入直播停留后返回
    [Tags]  P2
    获取校验结果  {'logtype':'stay'}    test_059    ${datatable_prefix_apk}_stay

case024 直播频道进入直播播放器
    [Tags]  P2
    切换频道  直播
    清除历史上报数据
    点击小窗播放器
    获取校验结果  {'logtype':'pv'}    test_053    ${datatable_prefix_apk}_pv

case025 直播播放器返回直播频道
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'pv'}    test_054    ${datatable_prefix_apk}_pv

case026 从直播频道进入直播播放器停留后返回
    [Tags]  P2
    获取校验结果  {'logtype':'stay'}    test_060    ${datatable_prefix_apk}_stay

case027 直播播放器按上下键切换频道
    [Tags]  P2
    点击小窗播放器
    按次数右移  1
    清除历史上报数据
    向上
    获取校验结果  {'logtype':'pv'}    test_055    ${datatable_prefix_apk}_pv

case028 从直播播放器按上下键切换频道停留后返回
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'stay'}    test_061    ${datatable_prefix_apk}_stay

case029 直播播放器频道节目单浮层切换直播频道
    [Tags]  P2
    数字键进直播  1
    直播呼出浮层
    清除历史上报数据
    点击内容描述  湖南经视高清
    获取校验结果  {'logtype':'pv'}    test_056    ${datatable_prefix_apk}_pv

case030 直播频道浮层跳转到其它直播
    [Tags]  P2
    获取校验结果  {'logtype':'pv'}    test_274    ${datatable_prefix_apk}_pv

case031 从直播播放器频道节目单浮层切换直播频道停留后返回
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'stay'}    test_062    ${datatable_prefix_apk}_stay

case032 直播播放器频道节目单浮层进入回看列表
    [Tags]  P2
    切换频道  直播
    点击小窗播放器
    直播呼出浮层
    清除历史上报数据
    向右
    确认键
    获取校验结果  {'logtype':'pv'}    test_057    ${datatable_prefix_apk}_pv

case033 从直播播放器频道节目单浮层进入回看列表停留后返回
    [Tags]  P2
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_063    ${datatable_prefix_apk}_stay

case034 直播播放器进入时移播放器
    [Tags]  P2
    返回首页
    数字键进直播  2
    清除历史上报数据
    按秒快退  3
    获取校验结果  {'logtype':'pv'}    test_058    ${datatable_prefix_apk}_pv

case035 从直播播放器进入时移播放器停留后返回
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'stay'}    test_064    ${datatable_prefix_apk}_stay

case036 从时移播放器进入直播播放器停留后返回
    [Tags]  P2
    返回首页
    切换频道  直播
    数字键进直播  2
    按秒快退  4
    按秒快进  10
    清除历史上报数据
    返回首页
    获取校验结果  {'logtype':'stay'}    test_065    ${datatable_prefix_apk}_stay

case037 时移播放器按上下键切换频道
    [Tags]  P2
    数字键进直播  2
    按秒快退  2
    清除历史上报数据
    向上
    获取校验结果  {'logtype':'pv'}    test_059    ${datatable_prefix_apk}_pv

case038 时移播放器按上下键切换频道停留后返回
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'stay'}    test_066    ${datatable_prefix_apk}_stay

case039 时移播放器频道节目单浮层切换直播频道
    [Tags]  P2
    数字键进直播  2
    按秒快退  2
    直播呼出浮层
    清除历史上报数据
    点击内容描述  湖南都市高清
    获取校验结果  {'logtype':'pv'}    test_060    ${datatable_prefix_apk}_pv

case040 时移频道浮层跳转到其它直播
    [Tags]  P2
    获取校验结果  {'logtype':'pv'}    test_060    ${datatable_prefix_apk}_pv

case041 时移播放器频道节目单浮层切换直播频道停留后返回
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'stay'}    test_067    ${datatable_prefix_apk}_stay

case042 时移播放器频道节目单浮层进入回看列表
    [Tags]  P2
    返回精选页
    数字键进直播  2
    按秒快退  2
    直播呼出浮层
    向右
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_061    ${datatable_prefix_apk}_pv

case043 时移播放器频道节目单浮层进入回看列表停留后返回
    [Tags]  P2
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_068    ${datatable_prefix_apk}_stay

case044 时移播放器进入直播播放器
    [Tags]  P2
    数字键进直播  2
    按秒快退  3
    清除历史上报数据
    按秒快进  10
    获取校验结果  {'logtype':'pv'}    test_062    ${datatable_prefix_apk}_pv

case045 从直播频道进入九屏同看
    [Tags]  P2
    返回首页
    切换频道  直播
    清除历史上报数据
    点击内容描述  九屏同看
    等待  5
    获取校验结果  {'logtype':'pv'}    test_177    ${datatable_prefix_apk}_pv

case046 从九屏同看返回直播频道
    [Tags]  P2
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_178    ${datatable_prefix_apk}_pv

case047 从直播频道进入九屏同看停留后返回
    [Tags]  P2
    获取校验结果  {'logtype':'stay'}    test_163    ${datatable_prefix_apk}_stay

case048 从九屏同看返回直播频道停留后返回
    [Tags]  P2
    清除历史上报数据
    切换频道  精选
    获取校验结果  {'logtype':'stay'}    test_164    ${datatable_prefix_apk}_stay

case049 从九屏同看进入直播播放器
    [Tags]  P2
    切换频道  直播
    点击内容描述  九屏同看
    等待  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_179    ${datatable_prefix_apk}_pv

case050 从九屏同看进入直播频道频道停留后返回
    [Tags]  P2
    清除历史上报数据
    直播退出
    获取校验结果  {'logtype':'stay'}    test_179    ${datatable_prefix_apk}_stay

case051 按键进入直播试看
    [Tags]  P2
    返回首页
    切换频道  直播
    数字键进直播  5
    清除历史上报数据
    等待页面出现文本信息  立即订购   70
    获取校验结果  {'logtype':'pv'}    test_180    ${datatable_prefix_apk}_pv

case051 直播试看完毕订购提示页
    [Tags]  P2
    log  测试结果与“按键进入直播试看”一致

case052 从按键进入直播试看停留后返回
    [Tags]  P2
    清除历史上报数据
    返回首页
    获取校验结果  {'logtype':'stay'}    test_165    ${datatable_prefix_apk}_stay

case052 直播试看完毕订购提示页后退出
    [Tags]  P2
    log  测试结果与“从按键进入直播试看停留后返回”一致

case053 从直播试看返回直播频道停留后返回
    [Tags]  P2
    清除历史上报数据
    切换频道  精选
    获取校验结果  {'logtype':'stay'}    test_166    ${datatable_prefix_apk}_stay

case054 回看列表切换分类
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数左移  1
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'pv'}    test_275    ${datatable_prefix_apk}_pv