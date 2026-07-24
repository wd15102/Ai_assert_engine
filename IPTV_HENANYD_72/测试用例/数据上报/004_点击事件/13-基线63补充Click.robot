*** Settings ***
Documentation    直播Click事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_213 直播中点击非收藏非预约频道
    [Documentation]  点击事件
    返回首页
    返回精选页
    数字键进直播  001
    直播呼出浮层
    清除历史上报数据
    点击内容描述  湖南经视高清
    获取校验结果  {'logtype':'click'}    test_213    ${datatable_prefix_apk}_click

case_214 直播中点击收藏频道
    [Documentation]  点击事件
    直播呼出浮层
    点击内容描述  收藏
    清除历史上报数据
    点击内容描述  时尚频道高清
    获取校验结果  {'logtype':'click'}    test_214    ${datatable_prefix_apk}_click

case_215 回看中点击非收藏非预约频道
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数左移  1
    直播频道进入回看列表
    按次数右移  1
    按次数上移  1    2
    按次数右移  1
    确认键  5
    回看呼出浮层
    按次数左移  2
    清除历史上报数据
    点击内容描述  湖南经视高清
    获取校验结果  {'logtype':'click'}    test_215    ${datatable_prefix_apk}_click

case_216 回看中点击收藏频道
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数左移  1
    直播频道进入回看列表
    按次数右移  1
    按次数上移  1    2
    按次数右移  1
    确认键  5
    回看呼出浮层
    按次数左移  4
    点击内容描述  收藏
    清除历史上报数据
    点击内容描述  时尚频道高清
    获取校验结果  {'logtype':'click'}    test_216    ${datatable_prefix_apk}_click

case_217 时移中点击非收藏非预约频道
    [Documentation]  点击事件
    返回首页
    返回精选页
    数字键进直播  001
    按秒快退  2
    直播呼出浮层
    清除历史上报数据
    点击内容描述  湖南经视高清
    获取校验结果  {'logtype':'click'}    test_217    ${datatable_prefix_apk}_click

case_218 时移中点击收藏频道
    [Documentation]  点击事件
    按秒快退  2
    直播呼出浮层
    点击内容描述  收藏
    清除历史上报数据
    点击内容描述  时尚频道高清
    获取校验结果  {'logtype':'click'}    test_218    ${datatable_prefix_apk}_click
