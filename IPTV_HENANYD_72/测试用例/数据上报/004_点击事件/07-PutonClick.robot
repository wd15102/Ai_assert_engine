*** Settings ***
Documentation    PutonClick事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_177 点击详情页顶部海报
    [Documentation]  点击事件
    返回首页
    返回精选页
    点击元素  ${免费电视剧}
    等待详情页出现
    焦点移动到顶部
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_177    ${datatable_prefix_apk}_click

case_180 点击直播浮层订购按钮
    [Documentation]  点击事件
    log to console  暂无直播订购功能
#    返回首页
#    数字键进直播  3
#    直播呼出浮层
#    向右
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'click'}    test_180    ${datatable_prefix_apk}_click

case_181 点击回看订购按钮
    [Documentation]  点击事件
    log to console  暂无直播订购功能
#    返回首页
#    切换频道    直播
#    直播频道进入回看列表
#    按次数下移  2
#    按次数右移  2
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'click'}    test_181    ${datatable_prefix_apk}_click

case_182 点击点播详情页开通会员按钮
    [Documentation]  点击事件
    返回精选页
    到达试看电影入口
    确认键
    等待详情页出现
    清除历史上报数据
    点击元素    ${购买}
    确认键
    获取校验结果  {'logtype':'click'}    test_182    ${datatable_prefix_apk}_click

case_183 点播详情页小窗试看结束后，点击小窗后再进入订购
    [Documentation]  点击事件
    返回精选页
    到达试看电影入口
    确认键
    等待试看结束
    按次数左移  1
    确认键  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_183    ${datatable_prefix_apk}_click

case_184 点播详情页小窗未付费无试看，点击小窗后再进入订购
    [Documentation]  点击事件
    返回精选页
    到达付费电影入口
    确认键
#    点击元素    ${付费电影}
    等待详情页出现
    按次数左移  1
    确认键  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_184    ${datatable_prefix_apk}_click

case_185 点播详情页分集按钮进入订购
    [Documentation]  点击事件
    返回精选页
    到达付费电视剧入口
    确认键
#    点击元素    ${付费电视剧}
    等待详情页出现
    按次数左移  1
    确认键  3
    呼出选集浮层
    按次数右移  4
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_185    ${datatable_prefix_apk}_click

case_186 点播全屏试看中按OK键
    [Documentation]  点击事件
    返回首页
    返回精选页
    到达试看电影入口
    确认键
#    点击元素  ${试看电影}
    等待详情页出现
    按次数左移  1
    确认键  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_186    ${datatable_prefix_apk}_click

case_187 点播全屏试看中切付费集数后的弹窗
    [Documentation]  点击事件
    log to console  6.3版本已无弹窗
#    返回首页
#    返回精选页
#    点击元素    ${付费电视剧}
#    等待  5
#    点击元素  ${小视频窗}
#    呼出选集浮层
#    切换集数    5
##    确认键
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'click'}    test_187    ${datatable_prefix_apk}_click

case_188 点播全屏试看结束后的订购按钮
    [Documentation]  点击事件
    返回首页
    返回精选页
    到达试看电影入口
    确认键
#    点击元素  ${试看电影}
    等待详情页出现
    按次数左移  1
    确认键
    等待试看结束
#    确认键
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_188    ${datatable_prefix_apk}_click

case_191 我的播单播放页切付费集数后的弹窗
    [Documentation]  点击事件
    log to console  暂无播单功能
#    到达我的页面入口
#    确认键
#    到达我的播单入口
#    确认键
#    点击文本  爸妈爱看
#    点击文本  爸妈爱看
#    点击文本  河山 第1集
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'click'}    test_191    ${datatable_prefix_apk}_click

case_192 观看历史点击后进入订购
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待元素出现  ${版本信息}
    到达观看历史全部记录入口
    确认键
    等待元素出现  ${观看历史}
    点击内容描述  蜘蛛侠：平行宇宙
    确认键
    等待文本出现  解锁剧集
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_192    ${datatable_prefix_apk}_click
