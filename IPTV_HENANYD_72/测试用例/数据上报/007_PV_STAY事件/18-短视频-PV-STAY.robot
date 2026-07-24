*** Settings ***
Documentation    详情页PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/等待相关.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_258 进入主题首页
    [Documentation]  PV事件
    返回首页
    返回精选页
    切换频道  电视剧
    按次数下移  1
    按次数右移  1
    清除历史上报数据
    确认键
    等待短视频主题页出现
    获取校验结果  {'logtype':'pv'}    test_258    ${datatable_prefix_apk}_pv

case_260 进入主题全屏播放页
    [Documentation]  PV事件
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_260    ${datatable_prefix_apk}_pv

case_197 进入主题首页后退出
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_197    ${datatable_prefix_apk}_stay

case_261 进入作者主页
    [Documentation]  PV事件
    确认键  1
    按次数右移  3    0
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_261    ${datatable_prefix_apk}_pv

case_198 进入主题全屏播放页后退出
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_198    ${datatable_prefix_apk}_stay

case_199 进入作者主页后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1    7
    获取校验结果  {'logtype':'stay'}    test_199    ${datatable_prefix_apk}_stay

case_264 进入主题播放失败页面
    [Documentation]  PV事件
    按次数返回  1
    按次数左移  2
    向下  3
    按次数右移  1
    按次数下移  1
    确认键  3
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_264    ${datatable_prefix_apk}_pv

case_204 进入主题播放失败页面后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_204    ${datatable_prefix_apk}_stay

case_262 进入个人中心_我赞过的
    [Documentation]  PV事件
    到达短视频轮播入口
    按次数左移  1
    清除历史上报数据
    确认键
    等待页面出现文本信息  我赞过的
    获取校验结果  {'logtype':'pv'}    test_262    ${datatable_prefix_apk}_pv

case_263 进入个人中心_我的关注
    [Documentation]  PV事件
    清除历史上报数据
    向下
    获取校验结果  {'logtype':'pv'}    test_263    ${datatable_prefix_apk}_pv

case_200 进入个人中心_我赞过后退出
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_200    ${datatable_prefix_apk}_stay

case_201 进入个人中心_我的关注后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_201    ${datatable_prefix_apk}_stay

case_265 进入短视频分屏
    [Documentation]  PV事件
    返回首页
    返回精选页
    切换频道  少儿频道
    切换频道  纪实
    切换频道  测试
    清除历史上报数据
    切换频道  短视频
    获取校验结果  {'logtype':'pv'}    test_265    ${datatable_prefix_apk}_pv

case_266 分屏进入主题全屏播放页
    [Documentation]  PV事件
    按次数下移  1
    按次数右移  1    5
    按次数下移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_266    ${datatable_prefix_apk}_pv

case_202 进入短视频分屏后退出
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_202    ${datatable_prefix_apk}_stay

case_203 分屏进入主题全屏播放页后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_203    ${datatable_prefix_apk}_stay

case_268 分屏进入作者主页
    [Documentation]  PV事件
    按次数右移  3
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_268    ${datatable_prefix_apk}_pv

case_205 分屏进入作者主页后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_205    ${datatable_prefix_apk}_stay

case_267 分屏进入主题全屏播放失败页面
    [Documentation]  PV事件
    按次数上移  1
    向右  3
    按次数下移  2
    等待  3
    清除历史上报数据
    确认键  3
    获取校验结果  {'logtype':'pv'}    test_267    ${datatable_prefix_apk}_pv

case_206 分屏进入主题全屏播放失败页面后退出
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_206    ${datatable_prefix_apk}_stay