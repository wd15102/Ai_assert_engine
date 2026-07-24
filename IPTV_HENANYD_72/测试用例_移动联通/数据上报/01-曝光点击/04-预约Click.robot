*** Settings ***
Documentation    直播预约Click事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_048 点击非收藏非预约频道
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    返回首页
    返回精选页
    数字键进直播  001
    直播呼出浮层
    按次数下移  1    0
    清除历史上报数据
    点击内容描述  湖南经视高清
    获取校验结果  {'logtype':'click'}    test_048    ${datatable_prefix_apk}_click

case_049 点击非收藏非预约频道的回看节目
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    直播呼出浮层
    按次数右移  2
    清除历史上报数据
    按次数上移  1
    确认键
    获取校验结果  {'logtype':'click'}    test_049    ${datatable_prefix_apk}_click

case_050 点击非收藏非预约频道的订购
    [Documentation]  点击事件
    log to console  暂无直播订购
    数字键进直播  004
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_050    ${datatable_prefix_apk}_click

case_051 点击收藏频道
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    返回首页
    数字键进直播  001
    直播呼出浮层
    按次数左移  1
    按次数上移  1
    确认键
    清除历史上报数据
    点击内容描述  湖南娱乐高清
    获取校验结果  {'logtype':'click'}    test_051    ${datatable_prefix_apk}_click

case_052 点击收藏频道的回看
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    直播呼出浮层
    按次数右移  2
    按次数上移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_052    ${datatable_prefix_apk}_click

case_053 点击收藏频道的订购按钮
    [Documentation]  点击事件
    log to console  暂无直播订购功能
#    返回首页
#    数字键进直播  001
#    直播呼出浮层
#    点击内容描述  收藏
#    点击内容描述  湖南都市高清
#    等待  5
#    直播呼出浮层
#    按次数右移  1
#    清除历史上报数据
#    确认键
#    等待  5
#    获取校验结果  {'logtype':'click'}    test_053    ${datatable_prefix_apk}_click

case_054 点击预约分类的节目
    [Documentation]  点击事件
    log to console  暂无预约功能
#    返回首页
#    返回精选页
#    按次数左移  1
#    点击元素  ${回看}
#    按次数左移  1
#    按次数右移  2
#    按次数下移  1
#    点击直播预约  分段
#    等待  3
#    数字键进直播  002
#    直播呼出浮层
#    点击内容描述  预约
#    清除历史上报数据
#    点击内容描述  湖南卫视高清
#    等待  5
#    获取校验结果  {'logtype':'click'}    test_054    ${datatable_prefix_apk}_click

case_055 点击预约分类的节目取消按钮
    [Documentation]  点击事件
    log to console  暂无预约功能
#    直播呼出浮层
#    按次数左移  1
#    按次数上移  2
#    按次数右移  1
#    按次数下移  1
#    按次数右移  1
#    清除历史上报数据
#    确认键
#    等待  3
#    确认键
#    等待  5
#    获取校验结果  {'logtype':'click'}    test_055    ${datatable_prefix_apk}_click

case_056 点击直播收藏页的收藏
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    返回首页
    数字键进直播  001
    直播呼出浮层
    按次数左移  1
    按次数上移  1    2
    按次数右移  1
    确认键
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_056    ${datatable_prefix_apk}_click

case_057 点击直播收藏页的取消收藏
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_057    ${datatable_prefix_apk}_click

