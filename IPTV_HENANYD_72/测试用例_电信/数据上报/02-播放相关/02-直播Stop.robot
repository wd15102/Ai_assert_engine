*** Settings ***
Documentation    直播Stop事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case023 直播分屏切换到精选分屏上报stop
    [Tags]  P2
    返回首页
    数字键进直播  001
    返回首页
    返回精选页
    按次数左移  1
    等待  3
    清除历史上报数据
    按次数右移  1
    等待  3
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_023   ${datatable_prefix_apk}_stop

case024 点击直播频道小视频窗上报stop
    [Tags]  P2
#    按次数左移  1
#    清除历史上报数据
#    点击元素  ${直播小窗播放器}
#    等待  5
#    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_024   ${datatable_prefix_apk}_stop
    log  基线场景不支持

case025 按上键切换频道上报stop
    [Tags]  P2
    返回首页
    返回精选页
    数字键进直播  002
    清除历史上报数据
    按次数上移  1
    等待  3
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_154   ${datatable_prefix_apk}_stop

case027 频道浮层切换频道上报stop
    [Tags]  P2
    返回首页
    返回精选页
    数字键进直播  002
    直播呼出浮层
    按次数上移   1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_156   ${datatable_prefix_apk}_stop

case026 全屏退出直播上报stop
    [Tags]  P2
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_155   ${datatable_prefix_apk}_stop

case028 退出时移直播上报stop
    [Tags]  P2
    返回首页
    返回精选页
    数字键进直播  001
    按秒快退  2
    按秒快进  3
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_157   ${datatable_prefix_apk}_stop

case029 回看列表进入直播，再退出直播上报stop
    [Tags]  P2
    返回首页
    返回精选页
    切换频道  直播
    直播频道进入回看列表
    按次数右移  1
    确认键
    清除历史上报数据
    返回首页
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_158   ${datatable_prefix_apk}_stop

case031 按下键切换回看内容上报stop
    [Tags]  P2
    直播频道进入回看列表
    按次数左移  1
    按次数下移  1
    按次数右移  1
    按次数上移  1
    按次数右移  1
    确认键  10
    清除历史上报数据
    按次数下移  2
    确认键  5
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_160   ${datatable_prefix_apk}_stop

case032 点击回看浮层节目上报stop
    [Tags]  P2
    按次数下移  2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_161   ${datatable_prefix_apk}_stop

case035 回看自动连播，上报stop
    [Tags]  P2
    清除历史上报数据
    按秒快进  5
    等待  30
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_164   ${datatable_prefix_apk}_stop

case030 退出回看上报stop
    [Tags]  P2
    清除历史上报数据
    返回首页
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_159   ${datatable_prefix_apk}_stop

case033 时移进入直播上报stop
    [Tags]  P2
    返回首页
    返回精选页
    数字键进直播  001
    按秒快退  2
    清除历史上报数据
    按秒快进  3
    等待  3
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_162   ${datatable_prefix_apk}_stop

case034 时移按返回键上报stop
    [Tags]  P2
    按秒快退  2
    清除历史上报数据
    返回首页
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_163   ${datatable_prefix_apk}_stop





