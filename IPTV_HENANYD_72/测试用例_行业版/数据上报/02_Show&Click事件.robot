*** Settings ***
Documentation    首页PV和STAY事件
Library           AppiumLibrary
Resource          ../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../IPTV_JX_72/对象库/详情页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_228 行业版用户中心点击已绑定机构切换
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数左移  4
    等待  3
    按次数下移  1
    确认键  5
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_228    ${datatable_prefix_apk}_click

case_229 行业版行业选择页点击切换年级
    [Documentation]  点击事件
    按次数左移  2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_229    ${datatable_prefix_apk}_click

case_199 行业版模块曝光公共字段检查
    [Documentation]  曝光事件
    返回首页
    返回精选页
    按次数左移  3
    等待  5
    清除历史上报数据
    按次数左移  1
    获取校验结果  {'logtype':'show','mpos':'1'}    test_199    ${datatable_prefix_apk}_show

case_200 行业频道第1模块曝光
    [Documentation]  曝光事件
    获取校验结果  {'logtype':'show','mpos':'1'}    test_200    ${datatable_prefix_apk}_show

case_201 行业频道第2模块曝光
    [Documentation]  曝光事件
    获取校验结果  {'logtype':'show','mpos':'2'}    test_201    ${datatable_prefix_apk}_show

case_202_1 行业频道第3模块不曝光
    [Documentation]  曝光事件
    获取校验结果_不上报  {'logtype':'show','mpos':'3'}    test_202    ${datatable_prefix_apk}_show

case_219 行业版点击事件公共字段检查
    [Documentation]  点击事件
    按次数下移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_219    ${datatable_prefix_apk}_click

case_220 行业频道第1模块点击
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_220    ${datatable_prefix_apk}_click

case_221 行业频道第2模块点击
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_221    ${datatable_prefix_apk}_click

case_202 行业频道第3模块曝光
    [Documentation]  曝光事件
    按次数返回  1
    等待  2
    清除历史上报数据
    向下  5
    获取校验结果  {'logtype':'show','mpos':'3'}    test_202    ${datatable_prefix_apk}_show

case_222 行业频道第3模块点击
    [Documentation]  点击事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_222    ${datatable_prefix_apk}_click

case_203 行业频道第4模块曝光
    [Documentation]  曝光事件
    按次数返回  1
    等待  2
    清除历史上报数据
    向下  5
    获取校验结果  {'logtype':'show','mpos':'4'}    test_203    ${datatable_prefix_apk}_show

case_223 行业频道第4模块点击
    [Documentation]  点击事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_223    ${datatable_prefix_apk}_click

case_204 行业频道第5模块曝光
    [Documentation]  曝光事件
    按次数返回  1
    等待  2
    清除历史上报数据
    向下  5
    获取校验结果  {'logtype':'show','mpos':'5'}    test_204    ${datatable_prefix_apk}_show

case_224 行业频道第5模块点击
    [Documentation]  点击事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_224    ${datatable_prefix_apk}_click

case_225 行业版用户中心点击新增机构
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数左移  4
    等待  3
    按次数下移  1
    确认键  5
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_225    ${datatable_prefix_apk}_click

case_226 行业版用户中心点击专注模式
    [Documentation]  点击事件
    按次数返回  1
    按次数右移  2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_226    ${datatable_prefix_apk}_click

case_227 行业版用户中心点击解除绑定
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  1
    确认键
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_227    ${datatable_prefix_apk}_click

case_230 行业版资讯列表点击资讯
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数左移  4
    等待  3
    按次数下移  3
    按次数右移  1
    确认键  8
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_230    ${datatable_prefix_apk}_click

case_231 行业版点击媒资播放
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数左移  4
    等待  3
    按次数下移  2
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_231    ${datatable_prefix_apk}_click

case_232 行业版片库点击资讯
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数左移  4
    等待  3
    按次数下移  3
    按次数右移  2
    确认键  5
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_232    ${datatable_prefix_apk}_click