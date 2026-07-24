*** Settings ***
Documentation    订购PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_094 精选页进入会员页
    [Documentation]  PV事件
    log to console  订购暂不做修改
#    到达开通会员入口
#    清除历史上报数据
#    确认键
#    等待  10
#    获取校验结果  {'logtype':'pv'}    test_099    ${datatable_prefix_apk}_pv
#
#case HNYD63_stay test_101
#    [Documentation]  从精选频道进入会员页停留后返回
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'stay'}    test_101    ${datatable_prefix_apk}_stay
#
#
#case HNYD63_pv test_193
#    [Documentation]  会员开通进入所有会员页
#    向上
#    清除历史上报数据
#    确认键
#    等待  10
#    获取校验结果  {'logtype':'pv'}    test_193    ${datatable_prefix_apk}_pv
#
#case HNYD63_pv test_194
#    [Documentation]  所有会员页返回会员开通
#    清除历史上报数据
#    返回键
#    等待  10
#    获取校验结果  {'logtype':'pv'}    test_194    ${datatable_prefix_apk}_pv
#
#case HNYD63_pv test_100
#    [Documentation]  会员页返回精选页
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'pv'}    test_100    ${datatable_prefix_apk}_pv



