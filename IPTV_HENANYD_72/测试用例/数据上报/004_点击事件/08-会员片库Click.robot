*** Settings ***
Documentation    会员片库Click事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_104 点击会员片库页的立即开通
    [Documentation]  点击事件
    返回首页
    返回精选页
    切换频道  电视剧
    点击内容描述  会员片库
    等待文本出现  会员片库
    按次数上移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_104    ${datatable_prefix_apk}_click

case_105 点击会员片库页的媒资
    [Documentation]  点击事件
    返回首页
    切换频道  电视剧
    点击内容描述  会员片库
    等待文本出现  会员片库
    按次数下移  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_105    ${datatable_prefix_apk}_click

