*** Settings ***
Documentation    首页点击事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 点击事件公共字段检查
    [Documentation]  点击事件
    到达切换模式入口
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_001    ${datatable_prefix_apk}_click

case_002 点击APK首页顶部海报
    [Documentation]  点击事件
    log to console  暂无海报

case_003 点击切换模式按钮
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_003    ${datatable_prefix_apk}_click

case_003_01 点击事件公共字段新增开机参数
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_003    ${datatable_prefix_apk}_click

case_004 点击搜索按钮
    [Documentation]  点击事件
    返回键
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_004    ${datatable_prefix_apk}_click

case_005 点击开通会员按钮
    [Documentation]  点击事件
    返回键
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_005    ${datatable_prefix_apk}_click

case_006 点击我的按钮
    [Documentation]  点击事件
    返回键
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_006    ${datatable_prefix_apk}_click

case_007 点击消息按钮
    [Documentation]  点击事件
    返回键
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_007    ${datatable_prefix_apk}_click

case_008 点击服务按钮
    [Documentation]  点击事件
    返回键
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_008    ${datatable_prefix_apk}_click

case_009 点击家庭云按钮
    [Documentation]  点击事件
    返回键
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_009    ${datatable_prefix_apk}_click

case_010 点击电视剧频道导航栏
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_010    ${datatable_prefix_apk}_click

case_011 点击精选频道第1个模块的第1个位置
    [Documentation]  点击事件
    返回首页
    返回精选页
    清除历史上报数据
    点击元素  ${免费电影}
    获取校验结果  {'logtype':'click'}    test_011    ${datatable_prefix_apk}_click

case_011_01 点击频道页非算法推荐的通栏
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_011    ${datatable_prefix_apk}_click

case_012 点击精选频道第1个模块的第2个位置
    [Documentation]  点击事件
    返回精选页
    清除历史上报数据
    点击元素  ${试看电影}
    获取校验结果  {'logtype':'click'}    test_012    ${datatable_prefix_apk}_click

case_013 点击精选频道第2个模块的第1个位置
    [Documentation]  点击事件
    返回精选页
    清除历史上报数据
    点击元素  ${精选直播}
    获取校验结果  {'logtype':'click'}    test_013    ${datatable_prefix_apk}_click

case_014 点击精选频道的点播媒资
    [Documentation]  点击事件
    返回精选页
    清除历史上报数据
    点击元素  ${免费电影}
    获取校验结果  {'logtype':'click'}    test_014    ${datatable_prefix_apk}_click

case_015 点击直播频道的直播频道
    [Documentation]  点击事件
    返回精选页
    按次数左移  1
    清除历史上报数据
    点击元素  ${直播小窗播放器}
    获取校验结果  {'logtype':'click'}    test_015    ${datatable_prefix_apk}_click

case_015_1 点击首页频道页内模块进入直播fpa上报
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_015    ${datatable_prefix_apk}_click

case_016 点击直播频道的回看
    [Documentation]  点击事件
    返回首页
    清除历史上报数据
    点击元素  ${回看}
    获取校验结果  {'logtype':'click'}    test_016    ${datatable_prefix_apk}_click

case_016_1 点击首页频道页内模块进入回看列表fpa上报
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_016    ${datatable_prefix_apk}_click

case_017 点击精选频道推荐方式配置为cms配置的通栏中的海报
    [Documentation]  点击事件
    返回精选页
    清除历史上报数据
    点击元素  ${免费电影}
    获取校验结果  {'logtype':'click'}    test_017    ${datatable_prefix_apk}_click

case_017_1 点击首页频道页内模块进入详情页fpa上报
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_017    ${datatable_prefix_apk}_click

case_262 点击首页频道页内模块进入历史记录fpa上报
    [Documentation]  点击事件
    到达首页观看记录入口
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_262    ${datatable_prefix_apk}_click

case_263 点击首页导航进入片库页fpa上报
    [Documentation]  点击事件
    返回精选页
    切换频道  电视剧
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_263    ${datatable_prefix_apk}_click

case_264 点击首页频道页内模块进入片库fpa上报
    [Documentation]  点击事件
    返回精选页
    按次数右移  1
    按次数下移  3
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_264    ${datatable_prefix_apk}_click

case_265 点击首页频道页内模块进入原生专题播放fpa上报
    [Documentation]  点击事件
    到达专题入口
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_265    ${datatable_prefix_apk}_click

case_266 点击首页频道页内模块进入组合专题播放fpa上报
    [Documentation]  点击事件
    到达组合专题入口
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_266    ${datatable_prefix_apk}_click

case_271 点击首页频道页内模块进入会员片库fpa上报
    [Documentation]  点击事件
    按次数返回  1
    等待页面出现内容描述信息  会员片库
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_271    ${datatable_prefix_apk}_click