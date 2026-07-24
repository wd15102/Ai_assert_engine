*** Settings ***
Documentation    直播回看Drag事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case020 直播频道页进入全屏，快退拖拽进入时移
    [Tags]  P2
    返回首页
    数字键进直播  001
    返回首页
    返回精选页
    切换频道  直播
    点击元素  ${直播小窗播放器}
    等待元素出现  ${直播播放器}
    等待页面不出现内容描述信息  湖南卫视高清   10
    清除历史上报数据
    按秒快退  2
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_147   ${datatable_prefix_apk}_drag

case021 直播全屏，第二次时移快退拖拽，继续时移
    [Tags]  P2
    清除历史上报数据
    等待  2
    向右
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_148   ${datatable_prefix_apk}_drag

case027 直播全屏，第三次时移快进拖拽，继续时移
    [Tags]  P2
    清除历史上报数据
    向右
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_154   ${datatable_prefix_apk}_drag

case022 时移快进拖拽，进入直播
    [Tags]  P2
    清除历史上报数据
    按秒快进  4
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_149   ${datatable_prefix_apk}_drag

case023 数字键进入直播全屏，快退拖拽，进入时移
    [Tags]  P2
    返回首页
    数字键进直播  001
    等待页面不出现内容描述信息  湖南卫视高清
    清除历史上报数据
    按秒快退  2
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_150   ${datatable_prefix_apk}_drag

case024 数字键进入直播全屏，快进拖拽，进入直播
    [Tags]  P2
    清除历史上报数据
    按秒快进  3
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_151   ${datatable_prefix_apk}_drag

case025 精选功能键进入直播全屏，快退拖拽，进入时移
    [Tags]  P2
    返回首页
    返回精选页
    点击元素  ${精选直播}
    等待元素出现  ${直播播放器}
    等待页面不出现内容描述信息  湖南卫视高清   10
    清除历史上报数据
    按秒快退  2
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_152   ${datatable_prefix_apk}_drag

case026 精选功能键进入直播全屏，快进拖拽，进入直播
    [Tags]  P2
    清除历史上报数据
    按秒快进  3
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_153   ${datatable_prefix_apk}_drag

case028 回看全屏，快进拖拽
    [Tags]  P2
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数左移  1
    按次数下移  1
    按次数右移  1
    按次数上移  1
    按次数右移  1
    确认键  5
    清除历史上报数据
    按秒快进  1
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_155   ${datatable_prefix_apk}_drag

case029 回看全屏，快退拖拽
    [Tags]  P2
    清除历史上报数据
    按秒快退  1
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_156   ${datatable_prefix_apk}_drag

case030 回看全屏，第三次拖拽
    [Tags]  P2
    清除历史上报数据
    按秒快进  1
    获取校验结果  {'logtype': 'drag','bid':'26.1.25'}    test_157   ${datatable_prefix_apk}_drag