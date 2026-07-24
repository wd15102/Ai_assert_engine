*** Settings ***
Documentation    全局菜单点击事件
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_070 点击菜单中的精选
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    返回首页
    菜单键
    清除历史上报数据
    点击元素  ${全局菜单精选}
    获取校验结果  {'logtype':'click'}    test_070    ${datatable_prefix_apk}_click

case_071 点击菜单中的直播
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    返回首页
    菜单键
    清除历史上报数据
    点击元素  ${全局菜单直播}
    确认键
    获取校验结果  {'logtype':'click'}    test_071    ${datatable_prefix_apk}_click

case_072 点击菜单中的回看
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    返回首页
    菜单键
    清除历史上报数据
    点击元素  ${全局菜单回看}
    确认键
    获取校验结果  {'logtype':'click'}    test_072    ${datatable_prefix_apk}_click

case_073 点击菜单中的搜索
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    返回首页
    菜单键
    清除历史上报数据
    点击元素  ${全局菜单搜索}
    确认键
    获取校验结果  {'logtype':'click'}    test_073    ${datatable_prefix_apk}_click

case_074 点击菜单中的历史记录
    [Documentation]  点击事件
    log to console  产品备注暂不修改
    返回首页
    菜单键
    清除历史上报数据
    点击元素  ${全局菜单历史记录}
    确认键  3
    获取校验结果  {'logtype':'click'}    test_074    ${datatable_prefix_apk}_click

case_075 点击片库页中的搜索
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数右移  1
    确认键
    等待片库内容出现
    按次数上移  2
    按次数右移  1
    校验焦点是否在内容描述上  搜索
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_075    ${datatable_prefix_apk}_click

case_076 点击片库页中的筛选
    [Documentation]  点击事件
    按次数返回  1
    等待片库内容出现
    校验焦点是否在元素上  ${片库搜索}
    按次数下移  1
    清除历史上报数据
    确认键  3
    获取校验结果_不上报  {'logtype':'click'}    test_076    ${datatable_prefix_apk}_click

case_077 点击片库页中的右侧媒资
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数右移  1
    确认键
    等待片库内容出现
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_077    ${datatable_prefix_apk}_click

case_078 点击明星页左侧频道
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数下移  15
    点击内容描述  张天爱
    等待明星页出现
    按次数左移  2
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'click'}    test_078    ${datatable_prefix_apk}_click

case_079 点击明星页右侧媒资
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_079    ${datatable_prefix_apk}_click

case_080 点击专题页的收藏
    [Documentation]  点击事件
    返回首页
    返回精选页
    切换频道  电视剧
    点击内容描述  APK专题
    等待专题出现
    按次数上移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_080    ${datatable_prefix_apk}_click

case_081 点击专题页的媒资
    [Documentation]  点击事件
    点击元素  ${专题收藏}
    清除历史上报数据
    点击内容描述  冰雪奇缘2 原声版
    确认键
    获取校验结果  {'logtype':'click'}    test_081    ${datatable_prefix_apk}_click

