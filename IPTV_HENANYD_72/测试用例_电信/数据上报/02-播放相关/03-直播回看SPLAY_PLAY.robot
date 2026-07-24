*** Settings ***
Documentation    直播回看时移splay事件测试
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case001 精选频道切换到直播频道
    [Tags]  P2
    返回首页
    数字键进直播  001
    返回首页
    返回精选页
    清除历史上报数据
    按次数左移  1
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_024   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_024   ${datatable_prefix_apk}_play

case002 从直播频道页进入直播播放页
    [Tags]  P2
    清除历史上报数据
    数字键进直播  002
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_144   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_138   ${datatable_prefix_apk}_play

case003 按上、下键切换直播频道
    [Tags]  P2
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_145   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_139   ${datatable_prefix_apk}_play

case004 按数字键进入直播
    [Tags]  P2
    返回首页
    清除历史上报数据
    数字键进直播  001
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_027   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_027   ${datatable_prefix_apk}_play

case005 从回看列表进入直播播放器
    [Tags]  P2
    返回首页
    返回精选页
    按次数左移  1
    点击元素  ${回看}
    等待  5
    按次数右移  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_028   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_028   ${datatable_prefix_apk}_play

case006 播放完整观看直播
    [Tags]  P2
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_146   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_140   ${datatable_prefix_apk}_play

case007 播放直播频道列表中的第一个直播
    [Tags]  P2
    清除历史上报数据
    数字键进直播  001
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_147   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_141   ${datatable_prefix_apk}_play

case008 播放直播频道列表中的第二个直播
    [Tags]  P2
    清除历史上报数据
    数字键进直播  002
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_148   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_142   ${datatable_prefix_apk}_play

case009 小窗播放直播
    [Tags]  P2
    返回首页
    返回精选页
    清除历史上报数据
    按次数左移  1
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_150   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_144   ${datatable_prefix_apk}_play

case010 全屏播放直播
    [Tags]  P2
    返回首页
    清除历史上报数据
    数字键进直播  001
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_149   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_143   ${datatable_prefix_apk}_play

case011 直播播放器进入时移播放器
    [Tags]  P2
    清除历史上报数据
    按秒快退  2
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_038   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_038   ${datatable_prefix_apk}_play

case012 时移播放直播频道列表中的第一个直播频道
    [Tags]  P2
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_151   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_145   ${datatable_prefix_apk}_play

case013 从时移播放器进入直播播放放器
    [Tags]  P2
    清除历史上报数据
    按秒快进  4
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_030   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_030   ${datatable_prefix_apk}_play

case014 时移播放直播频道列表中的第二个直播频道
    [Tags]  P2
    数字键进直播  002
    清除历史上报数据
    按秒快退  5
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_152   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_146   ${datatable_prefix_apk}_play

case015 时移播放直播seek触发
    [Tags]  P2
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_153   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_147   ${datatable_prefix_apk}_play

case016 时移播放暂停触发
    [Tags]  P2
    log to console  暂停不上报VV事件

case017 回看列表进入回看播放器
    [Tags]  P2
    返回首页
    返回精选页
    按次数左移  1
    按次数下移  2
    校验焦点是否在内容描述上  回看
    确认键
    等待页面出现文本信息  今日
    按次数上移  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_043   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_043   ${datatable_prefix_apk}_play

case018 回看播放存在前贴片
    [Tags]  P2
    log to console  无此功能

case019 回看播放不存在前贴片
    [Tags]  P2
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_154   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_148   ${datatable_prefix_apk}_play

case020 直播播放器进入回看
    [Tags]  P2
    返回首页
    数字键进直播  002
    直播呼出浮层
    按次数右移  1
    确认键
    等待页面出现元素信息  ${回看节目}
    按次数上移  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_155   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_149   ${datatable_prefix_apk}_play

case021 回看播放直播频道列表中的第一个直播频道
    [Tags]  P2
    返回首页
    数字键进直播  001
    等待  5
    确认键
    按次数右移  1
    确认键
    等待  5
    等待页面出现文本信息  今日
    按次数上移  1
    确认键
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_156   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_150   ${datatable_prefix_apk}_play

case022 回看播放直播频道列表中的第二个直播频道
    [Tags]  P2
    返回首页
    数字键进直播  002
    等待  5
    确认键
    按次数右移  1
    确认键
    等待  5
    等待页面出现文本信息  今日
    按次数上移  1
    确认键
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_157   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_151   ${datatable_prefix_apk}_play

case023 从回看播放器进入直播播放器
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    向上
    向右
    确认键
    回看呼出浮层
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_158   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_152   ${datatable_prefix_apk}_play

case024 播放试看直播
    [Tags]  P2
    返回首页
    清除历史上报数据
    数字键进直播  05
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_159   ${datatable_prefix_apk}_splay
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}   test_153   ${datatable_prefix_apk}_play