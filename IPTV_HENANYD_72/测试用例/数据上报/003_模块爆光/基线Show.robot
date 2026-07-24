*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_194 点播花絮看点列表模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    到达免费电视剧入口
    确认键
#    点击元素  ${免费电视剧}
    等待详情页出现
    按次数下移  1
    等待  3
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype': 'show','mpos':'1002'}    test_194   ${datatable_prefix_apk}_show

case_194_1 所有事件改为lob上报格式修改
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1002'}    test_194   ${datatable_prefix_apk}_show

case_195 未输入字母时默认显示的大家都在搜曝光
    [Documentation]    模块曝光事件
    到达搜索入口
    清除历史上报数据
    确认键
    等待搜索页出现
    获取校验结果  {'logtype': 'show'}    test_195   ${datatable_prefix_apk}_show

case_195_1 搜索无结果时显示的大家都在搜
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_195   ${datatable_prefix_apk}_show

case_196 搜索无结果时显示的大家都在搜曝光
    [Documentation]    模块曝光事件
    搜索-输入搜索词  AAAA
    清除历史上报数据
    搜索-输入搜索词  A
    获取校验结果  {'logtype': 'show','bid':'26.1.16'}    test_196   ${datatable_prefix_apk}_show

case_197 组合专题顶部菜单曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  电视剧
    清除历史上报数据
    点击内容描述  APK组合专题
    等待组合专题页出现
    获取校验结果  {'logtype': 'show','mpos':'1000'}    test_197   ${datatable_prefix_apk}_show

case_198 组合专题页内模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','module_id':'common_immersionV2_template3'}    test_198   ${datatable_prefix_apk}_show

case_235 首页进入模块后返回曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    确认键
    校验焦点是否在内容描述上_模糊匹配  惊天破
    确认键
    等待详情页出现
    按次数左移  1
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_1_and_4h_template3'}    test_235   ${datatable_prefix_apk}_show

case_236 详情页进入模块后返回曝光
    [Documentation]    模块曝光事件
    校验焦点是否在元素上  ${免费电影}
    确认键
    等待详情页出现
    按次数下移  2    2
    确认键
    等待明星页出现
    等待  3
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype': 'show','mtitle':'相关明星'}    test_236   ${datatable_prefix_apk}_show

case_237 我的页面进入模块后返回曝光
    [Documentation]    模块曝光事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  3    2
    校验焦点是否在内容描述上  绯闻计划
    确认键
    等待详情页出现
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'show','mpos': '3','cntp':'user_ihome'}    test_237   ${datatable_prefix_apk}_show

case_238 片库页进入媒资后返回曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  电视剧
    确认键
    等待片库内容出现
    按次数右移  1
    确认键
    等待详情页出现
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'show','mpos': '2'}    test_238   ${datatable_prefix_apk}_show

case_239 组合专题页进入模块后返回曝光
    [Documentation]    模块曝光事件
    按返回直到焦点位于内容  电视剧
    点击内容描述  APK组合专题
    等待组合专题页出现
    按次数下移  3
    按次数右移  1
    确认键
    等待详情页出现
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_239   ${datatable_prefix_apk}_show

case_240 搜索页进入媒资后返回曝光
    [Documentation]    模块曝光事件
    到达搜索入口
    确认键
    等待搜索页出现
    点击搜索推荐媒资  1
    确认键
    等待详情页出现
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'show','cntp':'so_search'}    test_240   ${datatable_prefix_apk}_show

case_241 推荐1.0进入模块后返回曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  电竞
    按次数下移  1
    确认键
    等待详情页出现
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_4h_template3'}    test_241   ${datatable_prefix_apk}_show

case_242 推荐2.0进入模块后返回曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  精选
    按次数下移  3    2
    按键直到焦点位于内容描述上  天天向上1    下
    确认键
    等待详情页出现
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype': 'show','mpos': '3'}    test_242   ${datatable_prefix_apk}_show

case_288 首页通栏配有换一换但不展示按钮时曝光
    [Documentation]    模块曝光事件
    返回精选页
    切换频道  综艺
    等待  5
    清除历史上报数据
    切换频道  动漫
    获取校验结果  {'logtype': 'show','mpos': '1','module_id':'common_live_template3'}    test_288   ${datatable_prefix_apk}_show

case_289 首页通栏有换一换按钮时曝光
    [Documentation]    模块曝光事件
    等待页面出现内容描述信息  天天向上7  30
    等待  3
    清除历史上报数据
    按次数下移  2
    获取校验结果  {'logtype': 'show','mpos': '2'}    test_289   ${datatable_prefix_apk}_show

case_289_1 首页通栏点击换一换按钮刷新内容后曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    确认键  10
    获取校验结果  {'logtype': 'show','mpos': '2'}    test_289   ${datatable_prefix_apk}_show

case_391 点击首页模块换一换按钮
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_391    ${datatable_prefix_apk}_click

case_290 首页通栏没有换一换按钮时曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  2
    获取校验结果  {'logtype': 'show','mpos': '3'}    test_290   ${datatable_prefix_apk}_show



