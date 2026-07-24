*** Settings ***
Documentation    直播Click事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_083 点击直播浮层中的频道
    [Documentation]  点击事件
    数字键进直播  2
    直播呼出浮层
    清除历史上报数据
    点击内容描述  湖南经视高清
    获取校验结果  {'logtype':'click'}    test_083    ${datatable_prefix_apk}_click

case_240 直播点击节目浮层的直播节目
    [Documentation]  点击事件
    直播呼出浮层
    按次数右移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_240    ${datatable_prefix_apk}_click

case_241 直播点击节目浮层的未开始节目
    [Documentation]  点击事件
    直播呼出浮层
    按次数右移  2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_241    ${datatable_prefix_apk}_click

case_242 直播点击节目浮层的已过期节目
    [Documentation]  点击事件
    取消直播预约弹窗
    直播呼出浮层
    按次数右移  1
    按次数上移  5
    按次数右移  1
    清除历史上报数据
    确认键  6
    获取校验结果  {'logtype':'click'}    test_242    ${datatable_prefix_apk}_click

case_243 直播点击节目浮层的回看节目
    [Documentation]  点击事件
    直播呼出浮层
    按次数右移  2
    按次数上移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_243    ${datatable_prefix_apk}_click

case_244 时移点击节目浮层的直播节目
    [Documentation]  点击事件
    返回首页
    数字键进直播  002
    按秒快退  3
    直播呼出浮层
    按次数右移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_244    ${datatable_prefix_apk}_click

case_245 时移点击节目浮层的未开始节目
    [Documentation]  点击事件
    直播呼出浮层
    按次数右移  2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_245    ${datatable_prefix_apk}_click

case_246 时移点击节目浮层的已过期节目
    [Documentation]  点击事件
    取消直播预约弹窗
    直播呼出浮层
    按次数右移  1
    按次数上移  5
    按次数右移  1
    清除历史上报数据
    确认键  8
    获取校验结果  {'logtype':'click'}    test_246    ${datatable_prefix_apk}_click

case_247 时移点击节目浮层的回看节目
    [Documentation]  点击事件
    直播呼出浮层
    按次数右移  2
    按次数上移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_247    ${datatable_prefix_apk}_click

case_248 回看点击节目浮层的回看节目
    [Documentation]  点击事件
    回看呼出浮层
    按次数上移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_248    ${datatable_prefix_apk}_click

case_249 回看点击节目浮层的未开始节目
    [Documentation]  点击事件
    回看呼出浮层
    按次数下移  5
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_249    ${datatable_prefix_apk}_click

case_250 回看点击节目浮层的已过期节目
    [Documentation]  点击事件
    取消直播预约弹窗
    回看呼出浮层
    按次数左移  1
    按次数上移  6
    按次数右移  1
    清除历史上报数据
    确认键  8
    获取校验结果  {'logtype':'click'}    test_250    ${datatable_prefix_apk}_click

case_251 回看点击节目浮层的直播节目
    [Documentation]  点击事件
    回看呼出浮层
    按次数下移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_251    ${datatable_prefix_apk}_click

case_084 点击回看列表中的直播节目
    [Documentation]  点击事件
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数右移  2
    清除历史上报数据
    点击内容描述  分段1
    获取校验结果  {'logtype':'click'}    test_084    ${datatable_prefix_apk}_click

case_088 点击回看浮层中的直播节目
    [Documentation]  点击事件
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数右移  1
    按次数上移  1
    按次数右移  1
    点击内容描述  分段1
    等待  5
    回看呼出浮层
    按次数左移  1
    按次数下移  1
    按次数右移  1
    清除历史上报数据
    点击内容描述  分段1
    获取校验结果  {'logtype':'click'}    test_088    ${datatable_prefix_apk}_click

case_091 点击回看浮层中的回看节目
    [Documentation]  点击事件
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数右移  1
    按次数上移  1
    按次数右移  1
    点击内容描述  分段1
    回看呼出浮层
    向左
    向上
    清除历史上报数据
    点击内容描述  分段1
    获取校验结果  {'logtype':'click'}    test_091    ${datatable_prefix_apk}_click

case_092 点击直播放播推荐浮层的媒资
    [Documentation]  点击事件
    返回首页
    返回精选页
    数字键进直播  002
    直播呼出浮层
    按次数右移  2    2
    按次数右移  1
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'click','mod':'c_playrecpop'}    test_092    ${datatable_prefix_apk}_click

case_095 点击直播推荐浮层的继续播放
    [Documentation]  点击事件
    返回首页
    数字键进直播  2
    暂停键
    清除历史上报数据
    点击文本  继续播放
    获取校验结果  {'logtype':'click'}    test_095    ${datatable_prefix_apk}_click

case_096 点击直播推荐浮层的关闭广告
    [Documentation]  点击事件
    log to console  6.4取消退出广告
#    返回首页
#    数字键进直播  2
#    按返回直到出现元素   ${退出}
#    清除历史上报数据
#    按次数左移  1
#    点击文本  取消
#    获取校验结果  {'logtype':'click'}    test_096    ${datatable_prefix_apk}_click

case_097 点击直播推荐浮层的退出播放
    [Documentation]  点击事件
    log to console  6.4取消退出广告
#    返回首页
#    数字键进直播  2
#    按返回直到出现元素   ${退出}
#    清除历史上报数据
#    点击文本  退出播放
#    获取校验结果  {'logtype':'click'}    test_097    ${datatable_prefix_apk}_click

case_101 点击九屏同看页的频道
    [Documentation]  点击事件
    返回首页
    返回精选页
    切换频道  直播
    点击内容描述  九屏同看
    等待元素出现  ${九屏同看}
    确认键  5
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_101    ${datatable_prefix_apk}_click

case_252 点击时移放播推荐浮层的媒资
    [Documentation]  点击事件
    返回首页
    返回精选页
    数字键进直播  2
    按秒快退  2
    直播呼出浮层
    按次数右移  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','mod':'c_playrecpop'}    test_252    ${datatable_prefix_apk}_click

case_253 点击回看放播推荐浮层的媒资
    [Documentation]  点击事件
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数下移  1
    按次数右移  1
    按次数上移  1
    按次数右移  1
    确认键  5
    回看呼出浮层
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','mod':'c_playrecpop'}    test_253    ${datatable_prefix_apk}_click