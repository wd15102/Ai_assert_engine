*** Settings ***
Documentation    详情页PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/等待相关.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_257 首页进入点播详情页
    [Documentation]  PV事件
    返回首页
    返回精选页
    按次数下移  4
    清除历史上报数据
    点击内容描述  默片解说员
#    等待元素出现  ${欢喜全屏}
#    获取校验结果  {'logtype':'pv'}    test_257    ${datatable_prefix_apk}_pv

case_196 首页进入点播详情页后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
#    获取校验结果  {'logtype':'stay'}    test_196    ${datatable_prefix_apk}_stay

