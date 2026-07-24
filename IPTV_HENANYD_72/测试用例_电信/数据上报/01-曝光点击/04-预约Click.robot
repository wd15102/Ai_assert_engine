*** Settings ***
Documentation    直播预约Click事件
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case001 点击非收藏非预约频道
    [Tags]  P2
    数字键进直播  001
    直播呼出浮层
    清除历史上报数据
    点击内容描述  湖南经视高清
    获取校验结果  {'logtype':'click'}    test_048    ${datatable_prefix_apk}_click

case002 点击非收藏非预约频道的回看
    [Tags]  P2
    直播呼出浮层
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_355    ${datatable_prefix_apk}_click

case003 点击非收藏非预约频道的订购
    [Tags]  P2
    数字键进直播  005
    直播呼出浮层
    按次数右移   1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_050    ${datatable_prefix_apk}_click

case004 直播中点击收藏频道
    [Tags]  P2
    返回首页
    数字键进直播  001
    直播呼出浮层
    点击内容描述  收藏
    清除历史上报数据
    点击内容描述  湖南娱乐高清
    获取校验结果  {'logtype':'click'}    test_051    ${datatable_prefix_apk}_click

case005 点击收藏频道的回看
    [Tags]  P2
    直播呼出浮层
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_356    ${datatable_prefix_apk}_click

case006 点击收藏频道的订购按钮
    [Tags]  P2
    返回首页
    数字键进直播  001
    直播呼出浮层
    按次数左移  1
    按次数上移  1
    按次数右移  1
    按次数下移  7  0
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_053    ${datatable_prefix_apk}_click

case007 点击预约分类的节目
    [Tags]  P2
    home键
    进入直播回看页面  2
    按次数下移  1
    按次数右移  1
    直播预约取消
    确认键
    点击文本  确认预约
    数字键进直播  1
    直播呼出浮层
    点击内容描述  预约
    清除历史上报数据
    点击内容描述  湖南经视高清
    获取校验结果  {'logtype':'click'}    test_054    ${datatable_prefix_apk}_click

case008 点击预约分类的节目取消按钮
    [Tags]  P2
    直播呼出浮层
    按次数左移  1
    按次数上移  2
    按次数右移  1
    按次数下移  1
    按次数右移  1
    清除历史上报数据
    确认键
    等待  3
    确认键
    获取校验结果  {'logtype':'click'}    test_055    ${datatable_prefix_apk}_click

case009 点击直播收藏页的收藏
    [Tags]  P2
    返回首页
    数字键进直播  1
    直播呼出浮层
    按次数左移  1
    按次数上移  1
    按次数右移  1
    确认键
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_056    ${datatable_prefix_apk}_click

case010 点击直播收藏页的取消收藏
    [Tags]  P2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_057    ${datatable_prefix_apk}_click

