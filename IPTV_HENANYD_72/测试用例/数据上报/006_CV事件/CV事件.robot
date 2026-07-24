*** Settings ***
Documentation    CV事件
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 公共字段检查
    [Documentation]  CV事件
    数字键进直播  002
    清除历史上报数据
    直播呼出浮层
    获取校验结果  {'logtype':'cv','mod':'c_channelpop'}    test_001    ${datatable_prefix_apk}_cv

case_002 直播呼出频道浮层
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_channelpop'}    test_002    ${datatable_prefix_apk}_cv

case_002_01 所有CV事件改为post上报
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_channelpop'}    test_002    ${datatable_prefix_apk}_cv

case_002_02 CV事件公共字段新增开机参数
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_channelpop'}    test_002    ${datatable_prefix_apk}_cv

case_010 直播呼出节目浮层
    [Documentation]  CV事件
    清除历史上报数据
    直播呼出浮层
    按次数右移  1
    run keyword if  'HNDX' not in '${project}'  获取校验结果  {'logtype':'cv','mod':'c_channelitempop'}    test_010    ${datatable_prefix_apk}_cv

case_032 直播推荐浮层
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playrecpop'}    test_032    ${datatable_prefix_apk}_cv

case_004 直播浮层切换到收藏
    [Documentation]  CV事件
    按次数左移  2
    清除历史上报数据
    按次数上移  1
    获取校验结果  {'logtype':'cv'}    test_004    ${datatable_prefix_apk}_cv

#case_003 直播浮层切换到预约
#    [Documentation]  CV事件
#    log to console  暂无直播预约
#    等待  3
#    直播呼出浮层
#    向左
#    向上
#    清除历史上报数据
#    向上
#    获取校验结果  {'logtype':'cv'}    test_003    ${datatable_prefix_apk}_cv

case_017 直播暂停大图推荐浮层
    [Documentation]  CV事件
    清除历史上报数据
    暂停键
    等待文本出现  继续播放
    获取校验结果  {'logtype':'cv'}    test_017    ${datatable_prefix_apk}_cv

case_042 快捷指令浮层
    [Documentation]  CV事件
    返回首页
    清除历史上报数据
    数字键进直播  002
    获取校验结果  {'logtype':'cv','mod':'c_quickpop'}    test_042    ${datatable_prefix_apk}_cv

case_005 时移呼出频道浮层
    [Documentation]  CV事件
    按秒快退  2
    清除历史上报数据
    直播呼出浮层
    获取校验结果  {'logtype':'cv','mod':'c_channelpop'}    test_005    ${datatable_prefix_apk}_cv

case_011 时移呼出节目浮层
    [Documentation]  CV事件
    run keyword if  'HNDX' not in '${project}'  清除历史上报数据
    按次数右移  1
    run keyword if  'HNDX' not in '${project}'  获取校验结果  {'logtype':'cv','mod':'c_channelitempop'}    test_011    ${datatable_prefix_apk}_cv

case_033 时移推荐浮层
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playrecpop'}    test_033    ${datatable_prefix_apk}_cv

case_007 时移浮层切换到收藏
    [Documentation]  CV事件
    按次数左移  2
    清除历史上报数据
    按次数上移  1
    获取校验结果  {'logtype':'cv'}    test_007    ${datatable_prefix_apk}_cv

#case_006 时移浮层切换到预约
#    [Documentation]  CV事件
#    log to console  暂无预约
#    等待  3
#    直播呼出浮层
#    向左
#    向上
#    清除历史上报数据
#    向上
#    获取校验结果  {'logtype':'cv'}    test_006    ${datatable_prefix_apk}_cv

case_021 时移暂停大图推荐浮层
    [Documentation]  CV事件
    清除历史上报数据
    暂停键
    等待文本出现  继续播放
    获取校验结果  {'logtype':'cv'}    test_021    ${datatable_prefix_apk}_cv

case_008 回看呼出节目浮层
    [Documentation]  CV事件
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数下移  1    2
    按次数右移  1
    按次数上移  1    2
    按次数右移  1
    确认键  5
    清除历史上报数据
    回看呼出浮层
    获取校验结果  {'logtype':'cv','mod':'c_channelitempop'}    test_008    ${datatable_prefix_apk}_cv

case_034 回看推荐浮层
    [Documentation]  CV事件
    等待  2
    run keyword if  'HNDX' not in '${project}'  获取校验结果  {'logtype':'cv','mod':'c_playrecpop'}    test_034    ${datatable_prefix_apk}_cv

case_012 回看呼出频道浮层
    [Documentation]  CV事件
    回看呼出浮层
    清除历史上报数据
    按次数左移  2
    run keyword if  'HNDX' not in '${project}'  获取校验结果  {'logtype':'cv','mod':'c_channelpop'}    test_012    ${datatable_prefix_apk}_cv

case_025 回看暂停大图推荐浮层
    [Documentation]  CV事件
    清除历史上报数据
    暂停键
    等待文本出现  继续播放
    获取校验结果  {'logtype':'cv'}    test_025    ${datatable_prefix_apk}_cv

case_009 回看浮层切换到收藏
    [Documentation]  CV事件
    home键
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数下移  1    2
    按次数右移  1
    按次数上移  1    2
    按次数右移  1
    确认键  7
    回看呼出浮层
    按次数左移  3
    按次数左移  1    2
    清除历史上报数据
    向上
    run keyword if  'HNDX' not in '${project}'  获取校验结果  {'logtype':'cv'}    test_009    ${datatable_prefix_apk}_cv

case_013 点播暂停大图推荐浮层
    [Documentation]  CV事件
    返回首页
    返回精选页
    点击元素  ${免费电视剧}
    等待详情页出现
    等待媒资播放
    全屏播放
    按次数上移  1
    清除历史上报数据
    暂停键
    等待文本出现  继续播放
    获取校验结果  {'logtype':'cv'}    test_013    ${datatable_prefix_apk}_cv

case_154 播放详情选集推荐曝光
    [Documentation]  CV事件
    返回首页
    返回精选页
    到达免费电视剧入口
    清除历史上报数据
    确认键
    等待详情页出现
    等待媒资播放
    获取校验结果  {'logtype':'cv','mod':'c_playselectionrecpop'}    test_154    ${datatable_prefix_apk}_cv

case_035 点播页呼出选集浮层
    [Documentation]  CV事件
    按次数左移  1    3
    确认键  5
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'cv','mod':'c_playoperpop'}    test_035    ${datatable_prefix_apk}_cv

case_155 全屏播放详情选集推荐曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv','mod':'c_playselectionrecpop'}    test_155    ${datatable_prefix_apk}_cv

case_036 点播页呼出花絮浮层
    [Documentation]  CV事件
    等待  5
    按次数上移  2    2
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype':'cv'}    test_036    ${datatable_prefix_apk}_cv

case_041 点播页呼出跳过片头片尾浮层
    [Documentation]  CV事件
    等待  5
    按次数上移  3
    按次数右移  1
#    run keyword if  'HNDX' in '${project}'  按次数右移  1
    清除历史上报数据
    确认键  1
#    按次数右移  1
    获取校验结果_不上报  {'logtype':'cv','lob':'jumpslicepop'}    test_041    ${datatable_prefix_apk}_cv

点播页呼出其他类型浮层
    [Documentation]  show事件
    获取校验结果  {'logtype': 'show','mid':'singlecycle'}    test_297   ${datatable_prefix_apk}_show

case_037 点播页呼出看点浮层
    [Documentation]  CV事件
    返回首页
    返回精选页
    到达免费综艺入口
    确认键
    等待详情页出现
    等待媒资播放
    按次数左移  1
    确认键  5
    按次数上移  2
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype':'cv','lob':'32019111113390672856317549459489'}    test_037    ${datatable_prefix_apk}_cv

case_038 跳过片头浮层
    [Documentation]  CV事件
    返回首页
    返回精选页
    点击元素  ${免费电视剧}
    等待详情页出现
    等待媒资播放
    全屏播放
    等待  5
    按键直到焦点位于内容描述上  跳过片头片尾   下
    清除历史上报数据
    确认键
    获取校验结果_不上报  {'logtype':'cv'}    test_038    ${datatable_prefix_apk}_cv

case_039 跳过片头浮层
    [Documentation]  CV事件
    获取校验结果_不上报  {'logtype':'cv'}    test_039    ${datatable_prefix_apk}_cv
