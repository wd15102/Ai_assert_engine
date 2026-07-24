*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/片库.robot
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_127 首页2横图-自动起播模块播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  电视剧
    按次数下移  10   2
    清除历史上报数据
    按次数下移  1    5
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_127   ${datatable_prefix_apk}_splay

case_122 首页2横图-自动起播模块播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_122   ${datatable_prefix_apk}_play

case_175 首页2横图-自动起播模块播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_175   ${datatable_prefix_apk}_hb

case_176 首页2横图-自动起播模块播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数右移  1    5
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_176   ${datatable_prefix_apk}_hb

case_136 首页2横图-自动起播模块播放_退出stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop','bid':'26.1.25'}    test_136   ${datatable_prefix_apk}_stop

case_128 首页2横图-自动起播模块播放短视频_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_128   ${datatable_prefix_apk}_splay

case_123 首页2横图-自动起播模块播放短视频_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_123   ${datatable_prefix_apk}_play

#case_177 首页2横图-自动起播模块播放短视频_5分钟心跳
#    [Documentation]    心跳事件

case_178 首页2横图-自动起播模块播放短视频_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数返回  1
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_178   ${datatable_prefix_apk}_hb

case_137 首页2横图-自动起播模块播放短视频_退出stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop','bid':'26.1.25'}    test_137   ${datatable_prefix_apk}_stop

case_061 闪图播放点播媒资
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  戏曲
    切换频道  测试
    确认键
    清除历史上报数据
    按次数右移  1
    等待  15
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_061   ${datatable_prefix_apk}_splay

case_060 闪图播放点播媒资
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_060   ${datatable_prefix_apk}_play

case_080 闪图媒资播放5分钟后上报心跳
    [Documentation]    心跳事件
    等待  100
    清除历史上报数据
    等待  200
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_080   ${datatable_prefix_apk}_hb

case_081 闪图媒资播放上报退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数右移  1
    等待  3
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_081   ${datatable_prefix_apk}_hb

case_036 闪图媒资播放上报stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop','bid':'26.1.25'}    test_036   ${datatable_prefix_apk}_stop

case_062 沉浸式闪图播放点播媒资
    [Documentation]    启播事件
    home键
    返回首页
    按次数返回  3
    切换频道  电影
    清除历史上报数据
    按次数下移  1
    等待  15
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_062   ${datatable_prefix_apk}_splay

case_061 沉浸式闪图播放点播媒资
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_061   ${datatable_prefix_apk}_play

case_082 沉浸式闪图播放点播媒资5分钟
    [Documentation]    心跳事件
    等待  100
    清除历史上报数据
    等待  200
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_082   ${datatable_prefix_apk}_hb

case_063 沉浸式闪图切换播放点播媒资
    [Documentation]    启播事件
    清除历史上报数据
    按次数右移  1
    等待  15
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_063   ${datatable_prefix_apk}_splay

case_062 沉浸式闪图切换播放点播媒资
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_062   ${datatable_prefix_apk}_play

case_037 沉浸式闪图播放点播媒资上报stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop','bid':'26.1.25'}    test_037   ${datatable_prefix_apk}_stop

case_083 沉浸式闪图播放点播媒资上报退出心跳
    [Documentation]    心跳事件
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_083   ${datatable_prefix_apk}_hb

case_084 沉浸式闪图切换播放点播媒资5分钟
    [Documentation]    心跳事件
    等待  100
    清除历史上报数据
    等待  200
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_084   ${datatable_prefix_apk}_hb

case_085 沉浸式闪图切换播放点播媒资上报退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按次数下移  1
    等待  2
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_085   ${datatable_prefix_apk}_hb

case_038 沉浸式闪图切换播放点播媒资上报stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop','bid':'26.1.25'}    test_038   ${datatable_prefix_apk}_stop

case_177 首页大IP自动起播模块播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  动漫
    清除历史上报数据
    切换频道  戏曲
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_177   ${datatable_prefix_apk}_splay

case_171 首页大IP自动起播模块播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_171   ${datatable_prefix_apk}_play

case_270 首页大IP自动起播模块播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_270   ${datatable_prefix_apk}_hb

case_271 首页大IP自动起播模块播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    切换频道  本地
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_271   ${datatable_prefix_apk}_hb

case_184 首页大IP自动起播模块播放_退出stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop','bid':'26.1.25'}    test_184   ${datatable_prefix_apk}_stop

case_178 首页大IP自动起播模块播放短视频_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_178   ${datatable_prefix_apk}_splay

case_172 首页大IP自动起播模块播放短视频_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_172   ${datatable_prefix_apk}_play

case_272 首页大IP自动起播模块播放短视频_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_272   ${datatable_prefix_apk}_hb

case_185 首页大IP自动起播模块播放短视频_退出stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop','bid':'26.1.25'}    test_185   ${datatable_prefix_apk}_stop

case_179 1+4自动播放模板播放直播媒资_启播
    [Documentation]    启播事件
    数字键进直播  001
    返回精选页
    清除历史上报数据
    切换频道  综艺
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_179   ${datatable_prefix_apk}_splay

case_173 1+4自动播放模板播放直播媒资_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_173   ${datatable_prefix_apk}_play

case_273 1+4自动播放模板播放直播媒资_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_273   ${datatable_prefix_apk}_hb

case_274 1+4自动播放模板播放直播媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    切换频道  纪实
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_274   ${datatable_prefix_apk}_hb

case_186 1+4自动播放模板播放直播媒资_stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop','bid':'26.1.25'}    test_186   ${datatable_prefix_apk}_stop

case_180 1+4自动播放模板播放点播媒资_启播
    [Documentation]    启播事件
    切换频道  4K
    清除历史上报数据
    切换频道  6.7模板
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_180   ${datatable_prefix_apk}_splay

case_174 1+4自动播放模板播放点播媒资_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_174   ${datatable_prefix_apk}_play

case_275 1+4自动播放模板播放点播媒资_5分钟心跳
    [Documentation]    心跳事件
    等待  205
    清除历史上报数据
    等待  100
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_275   ${datatable_prefix_apk}_hb

case_276 1+4自动播放模板播放点播媒资_退出心跳
    [Documentation]    心跳事件
    菜单键
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'hb','bid':'26.1.25'}    test_276   ${datatable_prefix_apk}_hb

case_187 1+4自动播放模板播放点播媒资_stop
    [Documentation]    stop事件
    获取校验结果      {'logtype': 'stop','bid':'26.1.25'}    test_187   ${datatable_prefix_apk}_stop

#case_039 组合专题沉浸式闪图退出上报stop
#case_040 组合专题进入媒资后退出上报stop