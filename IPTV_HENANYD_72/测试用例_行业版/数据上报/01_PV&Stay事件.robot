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
case_234 切换到行业频道页
    [Documentation]  PV事件
    行业版切换内容到行业1
    返回首页
    返回精选页
    按次数左移  3
    等待  5
    清除历史上报数据
    按次数左移  1
    获取校验结果  {'logtype':'pv'}    test_234    ${datatable_prefix_apk}_pv

case_235 切换到行业专注模式开关页
    [Documentation]  PV事件
    按次数下移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_235    ${datatable_prefix_apk}_pv

case_186 行业频道页stay事件
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_186    ${datatable_prefix_apk}_stay

case_236 切换到行业绑定页
    [Documentation]  PV事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_236    ${datatable_prefix_apk}_pv

case_187 行业专注模式开关页stay事件
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_187    ${datatable_prefix_apk}_stay

case_188 行业绑定页stay事件
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_188    ${datatable_prefix_apk}_stay

case_237 切换到行业选择页
    [Documentation]  PV事件
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_237    ${datatable_prefix_apk}_pv

case_189 行业选择页stay事件
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_189    ${datatable_prefix_apk}_stay

case_238 切换到行业专注模式开启页
    [Documentation]  PV事件
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_238    ${datatable_prefix_apk}_pv

case_190 行业专注模式开启页stay事件
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_190    ${datatable_prefix_apk}_stay

case_239 切换到行业资讯列表页
    [Documentation]  PV事件
    返回首页
    返回精选页
    按次数左移  4
    等待  5
    按次数下移  3
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_239    ${datatable_prefix_apk}_pv

case_240 切换到行业资讯详情页
    [Documentation]  PV事件
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_240    ${datatable_prefix_apk}_pv

case_191 行业资讯列表页stay事件
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_191    ${datatable_prefix_apk}_stay

case_192 行业资讯详情页stay事件
    [Documentation]  STAY事件
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'stay'}    test_192    ${datatable_prefix_apk}_stay

case_241 切换到行业点播播放页
    [Documentation]  PV事件
    返回首页
    返回精选页
    按次数左移  4
    等待  5
    按次数下移  2
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_241    ${datatable_prefix_apk}_pv

case_193 行业点播播放页stay事件
    [Documentation]  STAY事件
    清除历史上报数据
    返回键  0
    返回键  3
    获取校验结果  {'logtype':'stay'}    test_193    ${datatable_prefix_apk}_stay

case_242 切换到行业片库
    [Documentation]  PV事件
    返回首页
    返回精选页
    按次数左移  4
    等待  5
    按次数下移  3
    按次数右移  2
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'pv'}    test_242    ${datatable_prefix_apk}_pv

case_255 切换行业片库分类
    [Documentation]  PV事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'pv'}    test_255    ${datatable_prefix_apk}_pv

