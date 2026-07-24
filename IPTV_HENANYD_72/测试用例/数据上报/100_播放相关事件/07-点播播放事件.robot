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
case_001 电影类媒资小窗播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    确认键
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_001   ${datatable_prefix_apk}_splay

case_000 公共字段检查_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_001   ${datatable_prefix_apk}_splay

case_015 无广告媒资小窗播放_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_015   ${datatable_prefix_apk}_splay

case_001_01 启播事件公共字段新增开机参数
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_001   ${datatable_prefix_apk}_splay

case_001 电影类媒资小窗播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_001   ${datatable_prefix_apk}_play

case_001_01 VV事件公共字段新增开机参数
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_001   ${datatable_prefix_apk}_play

case_000 公共字段检查_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_001   ${datatable_prefix_apk}_play

case_015 无广告类媒资小窗播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_015   ${datatable_prefix_apk}_play

case_019 各入口进入播放媒资_首页进入_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_019   ${datatable_prefix_apk}_splay

case_019 各入口进入播放媒资_首页进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_019   ${datatable_prefix_apk}_play

case_011 电影类媒资小窗播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_011   ${datatable_prefix_apk}_hb

case_014 电影类媒资小窗播放_10分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_014   ${datatable_prefix_apk}_hb

case_067 详情页点播媒资大小屏切换_启播
    [Documentation]    启播事件
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果_不上报  {'logtype': 'splay','bid':'26.4.1'}    test_067   ${datatable_prefix_apk}_splay

case_068 详情页点播媒资大小屏切换_VV
    [Documentation]    VV事件
    获取校验结果_不上报  {'logtype': 'play','bid':'26.1.1.0'}    test_068   ${datatable_prefix_apk}_play

case_019 详情页点播媒资大小屏切换_退出心跳
    [Documentation]    心跳事件
    获取校验结果_不上报  {'logtype': 'hb','bid':'26.1.25'}    test_019   ${datatable_prefix_apk}_hb

case_019_01 心跳事件公共字段新增开机参数
    [Documentation]    心跳事件
    获取校验结果_不上报  {'logtype': 'hb','bid':'26.1.25'}    test_019   ${datatable_prefix_apk}_hb

case_094 详情页点播媒资大小屏切换_退出stop
    [Documentation]    stop事件
    获取校验结果_不上报  {'logtype': 'stop','bid':'26.1.25'}    test_094   ${datatable_prefix_apk}_stop

case_094_01 STOP事件公共字段新增开机参数
    [Documentation]    stop事件
    获取校验结果_不上报  {'logtype': 'stop','bid':'26.1.25'}    test_094   ${datatable_prefix_apk}_stop

case_002 电影类媒资播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_002   ${datatable_prefix_apk}_drag

case_065 各入口进入播放媒资_首页进入_快进拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_065   ${datatable_prefix_apk}_drag

case_065_01 Drag事件公共字段新增开机参数
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_065   ${datatable_prefix_apk}_drag

case_003 电影类媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_003   ${datatable_prefix_apk}_drag

case_066 各入口进入播放媒资_首页进入_快退拖拽
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_066   ${datatable_prefix_apk}_drag

case_001 公共字段检查_drag
    [Documentation]    drag事件
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_001   ${datatable_prefix_apk}_drag

case_001 pause事件公共字段检查
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_001   ${datatable_prefix_apk}_pause

case_002 电影类媒资播放暂停
    [Documentation]    pause事件
    获取校验结果      {'logtype': 'pause'}    test_002   ${datatable_prefix_apk}_pause

case_003 首页进入媒资播放暂停
    [Documentation]    pause事件
    获取校验结果      {'logtype': 'pause'}    test_003   ${datatable_prefix_apk}_pause

case_003_01 pause事件公共字段新增开机参数
    [Documentation]    pause事件
    获取校验结果      {'logtype': 'pause'}    test_003   ${datatable_prefix_apk}_pause

case_001 resume事件公共字段检查
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_001   ${datatable_prefix_apk}_resume

case_002 电影类媒资播放暂停后恢复播放
    [Documentation]    resume事件
    获取校验结果      {'logtype': 'resume'}    test_002   ${datatable_prefix_apk}_resume

case_003 首页进入媒资播放暂停后恢复播放
    [Documentation]    resume事件
    获取校验结果      {'logtype': 'resume'}    test_003   ${datatable_prefix_apk}_resume

case_003_01 resume事件公共字段新增开机参数
    [Documentation]    resume事件
    获取校验结果      {'logtype': 'resume'}    test_003   ${datatable_prefix_apk}_resume

case_025 电影类媒资播放多次暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_025   ${datatable_prefix_apk}_pause

case_025 电影类媒资播放多次暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_025   ${datatable_prefix_apk}_resume

case_002 电影类媒资小窗播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_002   ${datatable_prefix_apk}_hb

case_001 公共字段检查_心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_001   ${datatable_prefix_apk}_hb

case_013 无广告类媒资小窗播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_013   ${datatable_prefix_apk}_hb

case_025 各入口进入播放媒资_首页进入_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_025   ${datatable_prefix_apk}_hb

case_002 各入口进入播放媒资_首页进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_002   ${datatable_prefix_apk}_stop

case_010 电影类媒资小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_010   ${datatable_prefix_apk}_stop

case_001 公共字段检查_stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_001   ${datatable_prefix_apk}_stop

case_011 无广告类媒资小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_011   ${datatable_prefix_apk}_stop

case_014 有广告媒资小窗播放_启播
    [Documentation]    启播事件
    log to console  暂无前贴广告

case_014 有广告类媒资小窗播放_VV
    [Documentation]    VV事件
    log to console  暂无前贴广告

case_015 有广告类媒资小窗播放_退出心跳
    [Documentation]    心跳事件
    log to console  暂无前贴广告

case_092 有广告类媒资小窗播放_退出stop
    [Documentation]    stop事件
    log to console  暂无前贴广告

case_012 电视剧类媒资小窗播放_启播
    [Documentation]    启播事件
    返回精选页
    到达免费电视剧入口
    清除历史上报数据
    确认键
    等待详情页出现
    点播播放选集  1
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_012   ${datatable_prefix_apk}_splay

case_012 电视剧类媒资小窗播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_012   ${datatable_prefix_apk}_play

case_004 电视剧类媒资播放_快进拖拽
    [Documentation]    drag事件
    按次数上移  1    5
    清除历史上报数据
    点播时移    右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_004   ${datatable_prefix_apk}_drag

case_005 电视剧类媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移    左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_005   ${datatable_prefix_apk}_drag

case_004 电视剧类媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_004   ${datatable_prefix_apk}_pause

case_004 电视剧类媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_004   ${datatable_prefix_apk}_resume

case_013 花絮媒资小窗播放_启播
    [Documentation]    启播事件
    等待  5
    按次数返回  1    2
    按键直到焦点位于内容描述上  选集   下
    按次数右移  1
    校验焦点是否在文本父节点上  片花
    按次数下移  1
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_013   ${datatable_prefix_apk}_splay

case_013 花絮媒资小窗播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_013   ${datatable_prefix_apk}_play

case_012 电视剧类媒资小窗播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_012   ${datatable_prefix_apk}_hb

case_013 电视剧类媒资小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_013   ${datatable_prefix_apk}_stop

case_006 花絮媒资播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_006   ${datatable_prefix_apk}_drag

case_007 花絮媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_007   ${datatable_prefix_apk}_drag

case_018 花絮媒资小窗播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_018   ${datatable_prefix_apk}_hb

case_014 花絮媒资小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_014   ${datatable_prefix_apk}_stop

case_010 综艺类媒资小窗播放_启播
    [Documentation]    启播事件
    返回精选页
    到达免费综艺入口
    清除历史上报数据
    确认键
    等待详情页出现
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_010   ${datatable_prefix_apk}_splay

case_010 综艺类媒资小窗播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_010   ${datatable_prefix_apk}_play

case_008 综艺类媒资播放_快进拖拽
    [Documentation]    drag事件
    按次数左移  1
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_008   ${datatable_prefix_apk}_drag

case_009 综艺类媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_009   ${datatable_prefix_apk}_drag

case_005 综艺类媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_005   ${datatable_prefix_apk}_pause

case_005 综艺类媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    确认键
    获取校验结果      {'logtype': 'resume'}    test_005   ${datatable_prefix_apk}_resume

case_017 综艺类媒资小窗播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_017   ${datatable_prefix_apk}_hb

case_021 综艺类媒资小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_021   ${datatable_prefix_apk}_stop

case_011 试看电影媒资小窗播放_启播
    [Documentation]    启播事件
    返回精选页
    到达试看电影入口
    清除历史上报数据
    确认键
    等待详情页出现
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_011   ${datatable_prefix_apk}_splay

case_011 试看电影媒资小窗播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_011   ${datatable_prefix_apk}_play

case_010 试看电影媒资播放_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_010   ${datatable_prefix_apk}_drag

case_011 试看电影媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_011   ${datatable_prefix_apk}_drag

case_035 试看电影快进拖拽到试看结束
    [Documentation]    drag事件
    清除历史上报数据
    按秒快进  3
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_035   ${datatable_prefix_apk}_drag

case_016 试看电影媒资小窗播放_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_016   ${datatable_prefix_apk}_hb

case_012 试看电影媒资小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_012   ${datatable_prefix_apk}_stop

case_036 试看结束显示后再进行快进快退
    [Documentation]    drag事件
    清除历史上报数据
    按秒快退  1
    获取校验结果_不上报      {'logtype': 'drag','bid':'26.1.25'}    test_036   ${datatable_prefix_apk}_drag

case_018 试看电视剧媒资小窗播放_启播
    [Documentation]    启播事件
    返回精选页
    到达付费电视剧入口
    清除历史上报数据
    确认键
    等待详情页出现
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_018   ${datatable_prefix_apk}_splay

case_018 试看电视剧媒资小窗播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_018   ${datatable_prefix_apk}_play

case_012 试看电视剧媒资播放_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_012   ${datatable_prefix_apk}_drag

case_013 试看电视剧媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_013   ${datatable_prefix_apk}_drag

case_010 试看电视剧媒资小窗播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_010   ${datatable_prefix_apk}_hb

case_093 试看电视剧媒资小窗播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_093   ${datatable_prefix_apk}_stop

case_021 点播媒资小窗自动连播媒资_启播
    [Documentation]    启播事件
    返回精选页
    到达免费电视剧入口
    确认键
#    点击元素  ${免费电视剧}
    等待详情页出现
    等待媒资播放
    按次数左移  1
    确认键
    清除历史上报数据
    按秒快进  10
    按次数右移  1
    按返回直到焦点位于元素  ${全屏}
    等待  20
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_021   ${datatable_prefix_apk}_splay

case_021 点播媒资小窗自动连播媒资_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_021   ${datatable_prefix_apk}_play

case_017 点播媒资全屏手动连播媒资_启播
    [Documentation]    启播事件
    校验焦点是否在元素上  ${全屏}
    确认键
    按次数右移  1
    按次数上移  1    2
    按次数左移  1
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_017   ${datatable_prefix_apk}_splay

case_017 点播媒资全屏手动连播媒资_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_017   ${datatable_prefix_apk}_play

case_022 点播媒资小窗自动连播媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_022   ${datatable_prefix_apk}_hb

case_017 点播媒资小窗自动连播媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_017   ${datatable_prefix_apk}_stop

case_066 点播媒资全屏自动连播媒资_启播
    [Documentation]    启播事件
    清除历史上报数据
    按秒快进  10
    等待  20
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_066   ${datatable_prefix_apk}_splay

case_065 点播媒资全屏自动连播媒资_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_065   ${datatable_prefix_apk}_play

case_021 点播媒资全屏手动连播媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_021   ${datatable_prefix_apk}_hb

case_016 点播媒资全屏手动连播媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_016   ${datatable_prefix_apk}_stop

case_088 点播媒资全屏自动连播媒资_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_088   ${datatable_prefix_apk}_hb

case_020 点播媒资全屏自动连播媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_020   ${datatable_prefix_apk}_hb

case_155 详情页按首页键退出_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_155   ${datatable_prefix_apk}_hb

case_098 详情页按首页键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_098   ${datatable_prefix_apk}_stop

case_015 点播媒资全屏自动连播媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_015   ${datatable_prefix_apk}_stop

case_018 点播详情页点击购买上报stop
    [Documentation]    stop事件
    返回精选页
    到达试看电影入口
    确认键
#    点击元素  ${试看电影}
    等待详情页出现
    等待媒资播放
    清除历史上报数据
    确认键
    等待订购列表出现
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_018   ${datatable_prefix_apk}_stop

case_023 点播详情页点击购买上报心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_023   ${datatable_prefix_apk}_hb

case_019 点播详情页点击搜索上报stop
    [Documentation]    stop事件
    订购返回详情页
    按次数上移  5    2
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_019   ${datatable_prefix_apk}_stop

case_024 点播详情页点击搜索上报心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_024   ${datatable_prefix_apk}_hb

case_020 点播详情页点击其它视频上报stop
    按次数返回  1    3
    按键直到焦点位于内容描述上  陈赫   下
    按次数下移  2
    清除历史上报数据
    确认键
    等待详情页出现
    等待媒资播放
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_020   ${datatable_prefix_apk}_stop

case_026 点播详情页点击其它视频上报心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_026   ${datatable_prefix_apk}_hb

case_065 推荐1.0媒资媒资播放_启播
    [Documentation]    启播事件
    获取校验结果      {'logtype': 'splay','bid':'26.4.1'}    test_065   ${datatable_prefix_apk}_splay

case_064 推荐1.0媒资媒资播放_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_064   ${datatable_prefix_apk}_play

case_031 推荐1.0媒资媒资播放_快进拖拽
    [Documentation]    drag事件
    按次数左移  1
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_031   ${datatable_prefix_apk}_drag

case_032 推荐1.0媒资媒资播放_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_032   ${datatable_prefix_apk}_drag

case_028 推荐1.0媒资媒资播放_退出心跳
    [Documentation]    心跳事件
    菜单键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_028   ${datatable_prefix_apk}_hb

case_022 推荐1.0媒资媒资播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_022   ${datatable_prefix_apk}_stop

case_156 详情页按菜单键退出_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_156   ${datatable_prefix_apk}_hb

case_099 详情页按菜单键退出_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_099   ${datatable_prefix_apk}_stop

case_003 各入口进入播放媒资_专题页进入_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    切换频道  电视剧
    点击内容描述  APK专题
    等待专题出现
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_003   ${datatable_prefix_apk}_splay

case_003 各入口进入播放媒资_专题页进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_003   ${datatable_prefix_apk}_play

case_014 各入口进入播放媒资_专题页进入_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_014   ${datatable_prefix_apk}_drag

case_015 各入口进入播放媒资_专题页进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_015   ${datatable_prefix_apk}_drag

case_007 专题进入媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_007   ${datatable_prefix_apk}_pause

case_007 专题进入媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_007   ${datatable_prefix_apk}_resume

case_005 各入口进入播放媒资_专题页进入_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  电视剧
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_005   ${datatable_prefix_apk}_hb

case_005 各入口进入播放媒资_专题页进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_005   ${datatable_prefix_apk}_stop

case_008 各入口进入播放媒资_会员片库进入_启播
    [Documentation]    启播事件
    点击内容描述  会员片库
    等待文本出现  会员片库
    等待  5
    按次数下移  3
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_008   ${datatable_prefix_apk}_splay

case_008 各入口进入播放媒资_会员片库进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_008   ${datatable_prefix_apk}_play

case_075 各入口进入播放媒资_会员片库进入_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_075   ${datatable_prefix_apk}_drag

case_076 各入口进入播放媒资_会员片库进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_076   ${datatable_prefix_apk}_drag

case_011 会员片库进入媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_011   ${datatable_prefix_apk}_pause

case_011 会员片库进入媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_011   ${datatable_prefix_apk}_resume

case_009 各入口进入播放媒资_会员片库进入_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  电视剧
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_009   ${datatable_prefix_apk}_hb

case_009 各入口进入播放媒资_会员片库进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_009   ${datatable_prefix_apk}_stop

case_022 各入口进入播放媒资_组合专题页进入_启播
    [Documentation]    启播事件
    点击内容描述  APK组合专题
    等待组合专题页出现
    按次数下移  3    2
    按次数右移  1    5
    清除历史上报数据
    确认键
    等待详情页出现
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1','lastp':'colum_list'}    test_022   ${datatable_prefix_apk}_splay

case_022 各入口进入播放媒资_组合专题页进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0','lastp':'colum_list'}    test_022   ${datatable_prefix_apk}_play

case_037 各入口进入播放媒资_组合专题页进入_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_037   ${datatable_prefix_apk}_drag

case_038 各入口进入播放媒资_组合专题页进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_038   ${datatable_prefix_apk}_drag

case_027 各入口进入播放媒资_组合专题页进入_退出心跳
    [Documentation]    心跳事件
    等待  5
    按次数返回  1
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_027   ${datatable_prefix_apk}_hb

case_095 各入口进入播放媒资_组合专题页进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_095   ${datatable_prefix_apk}_stop

case_002 各入口进入播放媒资_列表页进入_启播
    [Documentation]    启播事件
    按返回直到焦点位于内容  电视剧
    确认键
    等待片库内容出现
    按次数右移  1
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_002   ${datatable_prefix_apk}_splay

case_002 各入口进入播放媒资_列表页进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_002   ${datatable_prefix_apk}_play

case_067 各入口进入播放媒资_列表页进入_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_067   ${datatable_prefix_apk}_drag

case_068 各入口进入播放媒资_列表页进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_068   ${datatable_prefix_apk}_drag

case_003 各入口进入播放媒资_列表页进入_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  电视剧
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_003   ${datatable_prefix_apk}_hb

case_003 各入口进入播放媒资_列表页进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_003   ${datatable_prefix_apk}_stop

case_007 各入口进入播放媒资_搜索页进入_启播
    [Documentation]    启播事件
    到达搜索入口
    确认键
    等待搜索页出现
    点击搜索推荐媒资  1
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_007   ${datatable_prefix_apk}_splay

case_007 各入口进入播放媒资_搜索页进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_007   ${datatable_prefix_apk}_play

case_016 各入口进入播放媒资_搜索页进入_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_016   ${datatable_prefix_apk}_drag

case_017 各入口进入播放媒资_搜索页进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_017   ${datatable_prefix_apk}_drag

case_006 搜索进入媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_006   ${datatable_prefix_apk}_pause

case_006 搜索进入媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_006   ${datatable_prefix_apk}_resume

case_004 各入口进入播放媒资_搜索页进入_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  精选
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_004   ${datatable_prefix_apk}_hb

case_004 各入口进入播放媒资_搜索页进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_004   ${datatable_prefix_apk}_stop

case_004 各入口进入播放媒资_我的页进入_启播
    [Documentation]    启播事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移   2
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_004   ${datatable_prefix_apk}_splay

case_004 各入口进入播放媒资_我的页进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_004   ${datatable_prefix_apk}_play

case_069 各入口进入播放媒资_我的页进入_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_069   ${datatable_prefix_apk}_drag

case_070 各入口进入播放媒资_我的页进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_070   ${datatable_prefix_apk}_drag

case_006 各入口进入播放媒资_我的页进入_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现文本  我的账号
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_006   ${datatable_prefix_apk}_hb

case_006 各入口进入播放媒资_我的页进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_006   ${datatable_prefix_apk}_stop

case_005 各入口进入播放媒资_历史记录进入_启播
    [Documentation]    启播事件
    按次数右移  5
    确认键
    等待文本出现  观看历史
    按次数右移  1
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_005   ${datatable_prefix_apk}_splay

case_005 各入口进入播放媒资_历史记录进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_005   ${datatable_prefix_apk}_play

case_018 各入口进入播放媒资_历史记录进入_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_018   ${datatable_prefix_apk}_drag

case_019 各入口进入播放媒资_历史记录进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_019   ${datatable_prefix_apk}_drag

case_008 观看记录进入媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键  5
    获取校验结果      {'logtype': 'pause'}    test_008   ${datatable_prefix_apk}_pause

case_008 观看记录进入媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_008   ${datatable_prefix_apk}_resume

case_007 各入口进入播放媒资_历史记录进入_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  我站在桥上看风景 DVD版
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_007   ${datatable_prefix_apk}_hb

case_007 各入口进入播放媒资_历史记录进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_007   ${datatable_prefix_apk}_stop

case_016 各入口进入播放媒资_播放记录历史推荐进入_启播
    [Documentation]    启播事件
    清空观看历史
    等待页面出现文本信息  热门推荐
    按次数左移  1
    按次数右移  1
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_016   ${datatable_prefix_apk}_splay

case_016 各入口进入播放媒资_播放记录历史推荐进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_016   ${datatable_prefix_apk}_play

case_071 各入口进入播放媒资_播放记录历史推荐进入_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_071   ${datatable_prefix_apk}_drag

case_072 各入口进入播放媒资_播放记录历史推荐进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_072   ${datatable_prefix_apk}_drag

case_029 各入口进入播放媒资_播放记录历史推荐进入_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到出现文本   观看历史
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_029   ${datatable_prefix_apk}_hb

case_096 各入口进入播放媒资_播放记录历史推荐进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_096   ${datatable_prefix_apk}_stop

case_006 各入口进入播放媒资_节目收藏页进入_启播
    [Documentation]    启播事件
    按次数左移  1
    按次数下移  1    3
    按次数右移  1
    清除历史上报数据
    确认键
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_006   ${datatable_prefix_apk}_splay

case_006 各入口进入播放媒资_节目收藏页进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_006   ${datatable_prefix_apk}_play

case_073 各入口进入播放媒资_节目收藏页进入_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键  5
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_073   ${datatable_prefix_apk}_drag

case_074 各入口进入播放媒资_节目收藏页进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_074   ${datatable_prefix_apk}_drag

case_009 收藏记录进入媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键  5
    获取校验结果      {'logtype': 'pause'}    test_009   ${datatable_prefix_apk}_pause

case_009 收藏记录进入媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_009   ${datatable_prefix_apk}_resume

case_008 各入口进入播放媒资_节目收藏页进入_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_008   ${datatable_prefix_apk}_hb

case_008 各入口进入播放媒资_节目收藏页进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_008   ${datatable_prefix_apk}_stop

case_069 各入口进入播放媒资_明星页进入_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    点击元素  ${免费电视剧}
    等待详情页出现
    按键直到焦点位于内容描述上  李溪芮  下
    按次数左移  1
    点击进入内容描述  姜潮
    等待页面出现元素信息  ${明星头像}
    按键直到焦点位于内容描述上  婆婆和妈妈    右
    清除历史上报数据
    确认键
    等待详情页出现
    等待媒资播放
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_069   ${datatable_prefix_apk}_splay

case_067 各入口进入播放媒资_明星页进入_VV
    [Documentation]    VV事件
    获取校验结果      {'logtype': 'play','bid':'26.1.1.0'}    test_067   ${datatable_prefix_apk}_play

case_077 各入口进入播放媒资_明星页进入_快进拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键  5
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_077   ${datatable_prefix_apk}_drag

case_078 各入口进入播放媒资_明星页进入_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_078   ${datatable_prefix_apk}_drag

case_012 明星页进入媒资播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_012   ${datatable_prefix_apk}_pause

case_012 明星页进入媒资播放暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_012   ${datatable_prefix_apk}_resume

case_154 各入口进入播放媒资_明星页进入_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    home键
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_154   ${datatable_prefix_apk}_hb

case_097 各入口进入播放媒资_明星页进入_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_097   ${datatable_prefix_apk}_stop

播放免费短片媒资
    [Documentation]    启播事件
    log to console  暂无短片

播放免费预告媒资
    [Documentation]    启播事件
    log to console  暂无预告