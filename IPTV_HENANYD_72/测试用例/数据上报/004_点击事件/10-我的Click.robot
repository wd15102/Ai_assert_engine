*** Settings ***
Documentation    我的Click事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/我的.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_109 点击我的页顶部账号
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_109    ${datatable_prefix_apk}_click

case_109_1 点击我的页顶部消费记录
    [Documentation]  点击事件
    按返回直到出现元素  ${版本信息}
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_109    ${datatable_prefix_apk}_click

case_109_2 点击我的页第1个模块
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_109    ${datatable_prefix_apk}_click

case_110 点击我的页顶部我的订购
    [Documentation]  点击事件
    按返回直到出现元素  ${版本信息}
    向右
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_110    ${datatable_prefix_apk}_click

case_112 点击我的页顶部会员卡激活
    [Documentation]  点击事件
    按返回直到出现元素  ${版本信息}
    按次数右移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_112    ${datatable_prefix_apk}_click

case_111 点击我的页顶部绑定微信
    [Documentation]  点击事件
    按返回直到出现元素  ${版本信息}
    向左
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_111    ${datatable_prefix_apk}_click

case_113 我的页从历史切换到收藏tab
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  1
    清除历史上报数据
    向右
    获取校验结果  {'logtype':'click'}    test_113    ${datatable_prefix_apk}_click

case_115 我的页从收藏切换到预约tab
    [Documentation]  点击事件
    清除历史上报数据
    向右
    获取校验结果  {'logtype':'click'}    test_115    ${datatable_prefix_apk}_click

case_114 我的页从收藏切换到历史tab
    [Documentation]  点击事件
    向左
    清除历史上报数据
    向左
    获取校验结果  {'logtype':'click'}    test_114    ${datatable_prefix_apk}_click

case_116 点击我的页历史tab媒资
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  1
    清除历史上报数据
    点击进入内容描述  我站在桥上看风景 DVD版
    获取校验结果  {'logtype':'click'}    test_116    ${datatable_prefix_apk}_click

case_116_1 点击我的页第2个模块
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_116    ${datatable_prefix_apk}_click

case_117 点击我的页收藏tab媒资
    [Documentation]  点击事件
    返回键
    向上
    向下
    向右
    清除历史上报数据
    点击进入内容描述  惊天破
    获取校验结果  {'logtype':'click'}    test_117    ${datatable_prefix_apk}_click

case_118 点击我的页预约tab媒资
    [Documentation]  点击事件
    返回键
    向上
    向下
    按次数右移  2
    清除历史上报数据
    点击内容描述  锦衣之下
    获取校验结果  {'logtype':'click'}    test_118    ${datatable_prefix_apk}_click

case_119 点击我的页历史tab全部记录
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    到达观看历史全部记录入口
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_119    ${datatable_prefix_apk}_click

case_393 点击观看历史页第1个媒资
    [Documentation]  点击事件
    等待观看历史页出现
    按次数右移  1
    校验焦点是否在内容描述上  我站在桥上看风景 DVD版
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_393    ${datatable_prefix_apk}_click

case_394 点击观看历史页第7个媒资
    [Documentation]  点击事件
    按键直到焦点位于内容描述上  我站在桥上看风景 DVD版
    按次数右移  1
    按次数下移  1
    校验焦点是否在内容描述上  绯闻计划
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_394    ${datatable_prefix_apk}_click

case_120 点击我的页收藏tab全部记录
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    到达我的收藏全部记录入口
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_120    ${datatable_prefix_apk}_click

case_395 点击节目收藏页第4个媒资
    [Documentation]  点击事件
    等待观看历史页出现
    校验焦点是否在文本上  节目收藏
    按次数右移  4
    校验焦点是否在内容描述上  惊天破
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_395    ${datatable_prefix_apk}_click

case_396 点击专题收藏页第2个媒资
    [Documentation]  点击事件
    按键直到出现文本信息  节目收藏
    按次数左移  4
    校验焦点是否在文本上  节目收藏
    按键直到焦点位于文本上  专题收藏  下
    按次数右移  2
    校验焦点是否在内容描述上  专题收藏第二个
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_396    ${datatable_prefix_apk}_click

case_397 点击我赞过的页第10个媒资
    [Documentation]  点击事件
    按键直到出现文本信息  专题收藏
    按次数左移  2
    校验焦点是否在文本上  专题收藏
    按键直到焦点位于文本上  我赞过的  下
    按次数右移  3
    校验焦点是否在内容描述上  跳片库测试
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_397    ${datatable_prefix_apk}_click

case_398 点击我的关注页第3个媒资
    [Documentation]  点击事件
    按键直到出现文本信息  我赞过的
    按次数左移  3
    校验焦点是否在文本上  我赞过的
    按键直到焦点位于文本上  我的关注  下
    按次数右移  1
    按次数下移  1
    校验焦点是否在内容描述上  我是谁呢能写多少字呢我要试试试试就试试
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_398    ${datatable_prefix_apk}_click

case_399 点击家庭片库页第3个媒资
    [Documentation]  点击事件
    按键直到出现文本信息  我的关注
    按次数左移  2
    校验焦点是否在文本上  我的关注
    按键直到焦点位于文本上  家庭片库  下
    按次数右移  3
    校验焦点是否在内容描述上  向往的生活 第六季
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_399    ${datatable_prefix_apk}_click

case_121 点击我的页预约tab全部记录
    [Documentation]  点击事件
    log to console  暂无预约功能
#    到达我的页面入口
#    确认键
#    到达我的预约全部记录入口
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'click'}    test_121    ${datatable_prefix_apk}_click

case_122 点击播单
    [Documentation]  点击事件
    log to console  暂无播单功能
#    到达我的页面入口
#    确认键
#    到达我的播单入口
#    按次数左移  5
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'click'}    test_122    ${datatable_prefix_apk}_click

case_123 点击全部播单
    [Documentation]  点击事件
    log to console  暂无播单功能
#    到达我的页面入口
#    确认键
#    到达我的播单入口
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'click'}    test_123    ${datatable_prefix_apk}_click

case_124 点击猜你喜欢
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  3
    校验焦点是否在内容描述上  绯闻计划
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lob':'moduleid'}    test_124    ${datatable_prefix_apk}_click

case_124_1 点击我的页算法推荐的通栏中的海报
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','lob':'moduleid'}    test_124    ${datatable_prefix_apk}_click

case_125 点击设置
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    显示服务和帮助
    校验焦点是否在内容描述上    设置
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_125    ${datatable_prefix_apk}_click

case_392 在设置页面点击主动升级
    [Documentation]  点击事件
    到达设置页面内容  点击检测版本
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_392    ${datatable_prefix_apk}_click

case_040 在设置页面点击主动升级后用户下载
    [Documentation]    应用安装事件
    获取校验结果  {'logtype':'downup','uact':'rqi'}    test_040   ${datatable_prefix_apk}_downup

case_129 点击常见问题
    [Documentation]  点击事件
    返回键
    清除历史上报数据
    点击进入内容描述  常见问题
    获取校验结果  {'logtype':'click'}    test_129    ${datatable_prefix_apk}_click

case_130 点击客服反馈
    [Documentation]  点击事件
    返回键
    清除历史上报数据
    点击进入内容描述  客服反馈（保障反馈）
    获取校验结果  {'logtype':'click'}    test_130    ${datatable_prefix_apk}_click

case_127 点击消费密码设置
    [Documentation]  点击事件
    log to console  暂无消费密码功能
#    返回键
#    清除历史上报数据
#    点击文本  消费密码设置
#    获取校验结果  {'logtype':'click'}    test_127    ${datatable_prefix_apk}_click

case_126 点击的手机遥控
    [Documentation]  点击事件
    log to console  暂无手机遥控功能
#    返回到我的页  ${常见问题}
#    清除历史上报数据
#    点击文本  手机遥控
#    获取校验结果  {'logtype':'click'}    test_126    ${datatable_prefix_apk}_click

case_131 点击关于我们
    [Documentation]  点击事件
    按返回直到出现元素  ${常见问题}
    清除历史上报数据
    点击进入内容描述  关于我们
    获取校验结果  {'logtype':'click'}    test_131    ${datatable_prefix_apk}_click

case_128 点击新手指引
    [Documentation]  点击事件
    返回键
    清除历史上报数据
    点击进入内容描述  新手指引
    获取校验结果  {'logtype':'click'}    test_128    ${datatable_prefix_apk}_click

case_140 点击清除系统缓存
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    显示服务和帮助
    校验焦点是否在内容描述上    设置
    确认键
    到达设置页面内容  清除缓存
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_140    ${datatable_prefix_apk}_click

case_258 点击跳过片头片尾（从关到开）
    [Documentation]  点击事件
    按次数下移  1
    到达设置页面内容    跳过片头片尾
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype':'click'}    test_258    ${datatable_prefix_apk}_click

case_259 点击跳过片头片尾（从开到关）
    [Documentation]  点击事件
    清除历史上报数据
    按次数左移  1
    获取校验结果  {'logtype':'click'}    test_259    ${datatable_prefix_apk}_click

case_141 点击屏保设置
    [Documentation]  点击事件
    log to console  暂无屏保功能
#    按次数下移  4
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'click'}    test_141    ${datatable_prefix_apk}_click

case_143 点击“添加新播单”
    [Documentation]  点击事件
    log to console  暂无播单功能
#    到达我的页面入口
#    确认键
#    到达我的播单入口
#    确认键
#    清除历史上报数据
#    点击文本  添加新的播单
#    获取校验结果  {'logtype':'click'}    test_143    ${datatable_prefix_apk}_click

case_146 非删除状态下点击进入播单
    [Documentation]  点击事件
    log to console  暂无播单功能
#    返回键
#    清除历史上报数据
#    点击文本  爸妈爱看
#    获取校验结果  {'logtype':'click'}    test_146    ${datatable_prefix_apk}_click

case_144 点击“顶部删除”
    [Documentation]  点击事件
    log to console  暂无播单功能
#    返回键
#    清除历史上报数据
#    点击文本  删除
#    获取校验结果  {'logtype':'click'}    test_144    ${datatable_prefix_apk}_click

case_145 点击“某一个播单删除”
    [Documentation]  点击事件
    log to console  暂无播单功能
#    向下
#    清除历史上报数据
#    确认键
#    获取校验结果  {'logtype':'click'}    test_145    ${datatable_prefix_apk}_click

case_147 点击“过滤短视频”
    [Documentation]  点击事件
    log to console  6.5版本删除
    到达我的页面入口
    确认键
    等待我的页出现
    到达观看历史全部记录入口
    确认键
#    清除历史上报数据
#    点击文本  过滤短视频
#    获取校验结果  {'logtype':'click'}    test_147    ${datatable_prefix_apk}_click

case_148 点击“删除”
    [Documentation]  点击事件
    清除历史上报数据
    点击文本  删 除
    获取校验结果  {'logtype':'click'}    test_148    ${datatable_prefix_apk}_click

case_149 点击“全部删除”
    [Documentation]  点击事件
    清除历史上报数据
    点击文本  全部删除
    获取校验结果  {'logtype':'click'}    test_149    ${datatable_prefix_apk}_click

case_291 我的页算法推荐投放模块的曝光
    [Documentation]  模块曝光事件
    到达我的页面入口
    确认键
    等待我的页出现
    按键直到焦点位于内容描述上   我站在桥上看风景 DVD版   下
    等待  5
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'show','mpos':'3'}    test_291    ${datatable_prefix_apk}_show

case_291_01 我的页移动算法数据接入模块的曝光
    [Documentation]  模块曝光事件
    获取校验结果  {'logtype':'show','mpos':'3'}    test_291    ${datatable_prefix_apk}_show

case_400 点击我的页移动算法数据接入通栏中的海报
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lob':'mpos'}    test_400    ${datatable_prefix_apk}_click

case_292 我的页cms配置投放模块的曝光
    [Documentation]  模块曝光事件
    按键直到焦点位于内容描述上  绯闻计划  返回
    按键直到焦点位于内容描述上  产品测试账号  下
    run keyword if  'HNDX' in '${project}'  按次数下移  2
    按次数下移  1    5
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'show','module_id':'common_6v_rank_template3'}    test_292    ${datatable_prefix_apk}_show

case_239 点击我的页cms配置的通栏中的海报
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lob':'mpos'}    test_239    ${datatable_prefix_apk}_click

case_293 我的页智能推荐2.0模块的曝光
    [Documentation]  模块曝光事件
    按键直到焦点位于内容描述上  胡一天张云龙爆笑探案！  返回
    按键直到焦点位于内容描述上  叮铃学习模式  下
    等待  5
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'show','module_id':'common_3h_template3'}    test_293    ${datatable_prefix_apk}_show

case_401 点击我的页智能推荐2.0通栏中的海报
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lob':'mpos'}    test_401    ${datatable_prefix_apk}_click