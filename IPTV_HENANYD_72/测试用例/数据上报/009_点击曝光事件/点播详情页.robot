*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_294 详情页cms配置投放模块的曝光
    [Documentation]  模块曝光事件
    返回精选页
    点击元素  ${免费电视剧}
    等待详情页出现
    按键直到焦点位于内容描述上  李溪芮   下
    按次数下移  2
    等待  5
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'show','mpos':'3'}    test_294    ${datatable_prefix_apk}_show

case_403 点击详情页非算法推荐的通栏
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_403    ${datatable_prefix_apk}_click

case_403_01 点击详情页cms配置的通栏中的海报
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_403    ${datatable_prefix_apk}_click

case_296 详情页智能推荐2.0模块的曝光
    [Documentation]  模块曝光事件
    返回精选页
    点击元素  ${免费电视剧}
    等待详情页出现
    按键直到焦点位于内容描述上  胡一天张云龙爆笑探案！   下
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'show','module_id':'common_4h_template3'}    test_296    ${datatable_prefix_apk}_show

case_404 点击详情页智能推荐2.0通栏中的海报
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_404    ${datatable_prefix_apk}_click



