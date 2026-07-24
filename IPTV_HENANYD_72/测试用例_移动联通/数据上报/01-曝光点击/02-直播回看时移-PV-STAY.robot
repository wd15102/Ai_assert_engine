*** Settings ***
Documentation    直播回看时移PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_041 从直播频道进入到回看列表页
    [Documentation]  PV事件
    返回首页
    切换频道  直播
    清除历史上报数据
    直播频道进入回看列表
    获取校验结果  {'logtype':'pv'}    test_041    ${datatable_prefix_apk}_pv

case_043 回看列表页切换频道
    [Documentation]  PV事件
    向下  5
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'pv'}    test_043    ${datatable_prefix_apk}_pv

case_051 从回看列表页中切换直播频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_051    ${datatable_prefix_apk}_stay

case_044 回看列表进入直播播放器
    [Documentation]  PV事件
    直播频道进入回看列表
    按次数右移  2
    清除历史上报数据
    点击内容描述  分段1
    等待  8
    获取校验结果  {'logtype':'pv'}    test_044    ${datatable_prefix_apk}_pv

case_045 直播播放器返回回看列表
    [Documentation]  PV事件
    log to console  产品确认暂不修改
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'pv'}    test_045    ${datatable_prefix_apk}_pv

case_052 从回看列表进入直播播放器停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_052    ${datatable_prefix_apk}_stay

case_053 从直播播放器返回回看列表停留后再次进入直播播放器
    [Documentation]  STAY事件
    log to console  产品确认暂不修改
    清除历史上报数据
    点击内容描述  分段1
    获取校验结果  {'logtype':'stay'}    test_053    ${datatable_prefix_apk}_stay

case_046 回看列表页进入回看播放器
    [Documentation]  PV事件
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数下移  1
    按次数右移  1
    按次数上移  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_046    ${datatable_prefix_apk}_pv

case_047 回看播放器返回回看列表页
    [Documentation]  PV事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'pv'}    test_047    ${datatable_prefix_apk}_pv

case_054 从回看列表页进入回看播放器停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_054    ${datatable_prefix_apk}_stay

case_048 回看播放器频道节目单浮层进入其它回看节目
    [Documentation]  PV事件
    确认键
    回看呼出浮层
    向下
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_048    ${datatable_prefix_apk}_pv

case_056 从回看播放器频道节目单浮层进入其它回看节目停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_056    ${datatable_prefix_apk}_stay

case_050 回看节目播放完毕自动切换回看节目内容
    [Documentation]  PV事件
    确认键
    回看呼出浮层
    按次数下移  1
    确认键
    清除历史上报数据
    按秒快进  10
    等待  30
    获取校验结果  {'logtype':'pv'}    test_050    ${datatable_prefix_apk}_pv

case_058 回看节目播放完毕自动切换回看节目内容停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_058    ${datatable_prefix_apk}_stay

case_042 从回看列表页返回直播频道页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_042    ${datatable_prefix_apk}_pv

case_055 从回看播放器返回回看列表页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_055    ${datatable_prefix_apk}_stay

case_049 回看播放器频道节目单浮层进入直播频道
    [Documentation]  PV事件
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数右移  2
    按次数上移  1
    点击内容描述  分段1
    确认键
    回看呼出浮层
    按次数左移  1
    按次数下移  1
    按次数右移  1
    清除历史上报数据
    点击内容描述  分段1
    等待  8
    获取校验结果  {'logtype':'pv'}    test_049    ${datatable_prefix_apk}_pv

case_049 回看节目浮层跳转到直播
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_049    ${datatable_prefix_apk}_pv

case_057 从回看播放器频道节目单浮层进入直播频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_057    ${datatable_prefix_apk}_stay

case_051 遥控器按键进入直播
    [Documentation]  PV事件
    返回首页
    切换频道  直播
    等待  5
    清除历史上报数据
    数字键进直播  002
    获取校验结果  {'logtype':'pv'}    test_051    ${datatable_prefix_apk}_pv

case_052 从直播返回首页
    [Documentation]  PV事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'pv'}    test_052    ${datatable_prefix_apk}_pv

case_059 从遥控器按键进入直播停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_059    ${datatable_prefix_apk}_stay

case_053 直播频道进入直播播放器
    [Documentation]  PV事件
    切换频道  直播
    清除历史上报数据
    点击小窗播放器
    等待  8
    获取校验结果  {'logtype':'pv'}    test_053    ${datatable_prefix_apk}_pv

case_054 直播播放器返回直播频道
    [Documentation]  PV事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'pv'}    test_054    ${datatable_prefix_apk}_pv

case_060 从直播频道进入直播播放器停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_060    ${datatable_prefix_apk}_stay

case_055 直播播放器按上下键切换频道
    [Documentation]  PV事件
    点击小窗播放器
    等待  10
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'pv'}    test_055    ${datatable_prefix_apk}_pv

case_061 从直播播放器按上下键切换频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_061    ${datatable_prefix_apk}_stay

case_056 直播播放器频道节目单浮层切换直播频道
    [Documentation]  PV事件
    数字键进直播  003
    直播呼出浮层
    按次数上移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_056    ${datatable_prefix_apk}_pv

case_062 从直播播放器频道节目单浮层切换直播频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_062    ${datatable_prefix_apk}_stay

#case_057 直播播放器频道节目单浮层进入回看列表
#    [Documentation]  PV事件
#    log to console  暂无法从直播进入回看列表
#    点击小窗播放器
#    直播呼出浮层
#    清除历史上报数据
#    向右
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_057    ${datatable_prefix_apk}_pv

#case_063 从直播播放器频道节目单浮层进入回看列表停留后返回
#    [Documentation]  STAY事件
#    log to console  暂无法从直播进入回看列表
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'stay'}    test_063    ${datatable_prefix_apk}_stay

case_058 直播播放器进入时移播放器
    [Documentation]  PV事件
    返回首页
    切换频道  直播
    点击小窗播放器
    数字键进直播  2
    清除历史上报数据
    按秒快退  3
    获取校验结果  {'logtype':'pv'}    test_058    ${datatable_prefix_apk}_pv

case_064 从直播播放器进入时移播放器停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_064    ${datatable_prefix_apk}_stay

case_065 从时移播放器进入直播播放器停留后返回
    [Documentation]  STAY事件
    返回首页
    切换频道  直播
    数字键进直播  2
    按秒快退  4
    按秒快进  6
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_065    ${datatable_prefix_apk}_stay

case_059 时移播放器按上下键切换频道
    [Documentation]  PV事件
    数字键进直播  002
    按秒快退  2
    等待  5
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'pv'}    test_059    ${datatable_prefix_apk}_pv

case_059 时移频道浮层跳转到其它直播
    [Documentation]  PV事件
    获取校验结果  {'logtype':'pv'}    test_059    ${datatable_prefix_apk}_pv

case_066 时移播放器按上下键切换频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_066    ${datatable_prefix_apk}_stay

case_060 时移播放器频道节目单浮层切换直播频道
    [Documentation]  PV事件
    数字键进直播  002
    按秒快退  2
    直播呼出浮层
    清除历史上报数据
    点击内容描述  湖南都市高清
    获取校验结果  {'logtype':'pv'}    test_060    ${datatable_prefix_apk}_pv

case_067 时移播放器频道节目单浮层切换直播频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_067    ${datatable_prefix_apk}_stay

#case_061 时移播放器频道节目单浮层进入回看列表
#    [Documentation]  PV事件
#    log to console  暂无法从时移进入回看列表
#    数字键进直播  2
#    按秒快退  2
#    直播呼出浮层
#    向右
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'pv'}    test_061    ${datatable_prefix_apk}_pv

#case_068 时移播放器频道节目单浮层进入回看列表停留后返回
#    [Documentation]  STAY事件
#    log to console  暂无法从时移进入回看列表
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'stay'}    test_068    ${datatable_prefix_apk}_stay

case_062 时移播放器进入直播播放器
    [Documentation]  PV事件
    数字键进直播  2
    按秒快退  3
    等待  5
    清除历史上报数据
    按秒快进  5
    获取校验结果  {'logtype':'pv'}    test_062    ${datatable_prefix_apk}_pv

case_177 从直播频道进入九屏同看
    [Documentation]  PV事件
    返回首页
    切换频道  直播
    清除历史上报数据
    点击内容描述  九屏同看
    获取校验结果  {'logtype':'pv'}    test_177    ${datatable_prefix_apk}_pv

case_178 从九屏同看返回直播频道
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_178    ${datatable_prefix_apk}_pv

case_163 从直播频道进入九屏同看停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_163    ${datatable_prefix_apk}_stay

case_164 从九屏同看返回直播频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道  精选
    获取校验结果  {'logtype':'stay'}    test_164    ${datatable_prefix_apk}_stay

case_179 从九屏同看进入直播播放器
    [Documentation]  PV事件
    切换频道  直播
    点击内容描述  九屏同看
    等待  3
    清除历史上报数据
    确认键  8
    获取校验结果  {'logtype':'pv'}    test_179    ${datatable_prefix_apk}_pv

case_179 从九屏同看进入直播频道频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_179    ${datatable_prefix_apk}_stay

case_180 直播试看完毕订购提示页
    [Documentation]  PV事件
    返回首页
    数字键进直播  005
    等待  30
    清除历史上报数据
    等待  30
    获取校验结果  {'logtype':'pv'}    test_180    ${datatable_prefix_apk}_pv

case_165 直播试看完毕订购提示页后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_165    ${datatable_prefix_apk}_stay

case_166 从直播试看返回直播频道停留后返回
    [Documentation]  STAY事件
    log to console  暂无直播试看功能
#    清除历史上报数据
#    切换频道  精选
#    获取校验结果  {'logtype':'stay'}    test_166    ${datatable_prefix_apk}_stay

case_195 从直播频道进入四屏同看
    [Documentation]  PV事件
    返回首页
    切换频道  直播
    清除历史上报数据
    点击内容描述  四屏同看
    获取校验结果  {'logtype':'pv'}    test_195    ${datatable_prefix_apk}_pv

case_196 从四屏同看返回直播频道
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_196    ${datatable_prefix_apk}_pv

case_180 从直播频道进入四屏同看停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_180    ${datatable_prefix_apk}_stay

case_181 从四屏同看返回直播频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道  精选
    获取校验结果  {'logtype':'stay'}    test_181    ${datatable_prefix_apk}_stay

case_197 从四屏同看进入直播播放器
    [Documentation]  PV事件
    切换频道  直播
    点击内容描述  四屏同看
    等待  3
    清除历史上报数据
    确认键  8
    获取校验结果  {'logtype':'pv'}    test_197    ${datatable_prefix_apk}_pv

case_182 从四屏同看进入直播频道频道停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'stay'}    test_182    ${datatable_prefix_apk}_stay