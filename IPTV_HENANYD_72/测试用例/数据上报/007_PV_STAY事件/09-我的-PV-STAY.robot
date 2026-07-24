*** Settings ***
Documentation    我的PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_101 精选页进入我的页
    [Documentation]  PV事件
    到达我的页面入口
    清除历史上报数据
    确认键
    等待我的页出现
    获取校验结果  {'logtype':'pv'}    test_101    ${datatable_prefix_apk}_pv

case_102 我的页返回精选页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_102    ${datatable_prefix_apk}_pv

case_102 从精选频道进入我的页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_102    ${datatable_prefix_apk}_stay

case_109 个人中心页进入我的订购
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数右移  1
    清除历史上报数据
    确认键
#    获取校验结果  {'logtype':'pv'}    test_109    ${datatable_prefix_apk}_pv

case_109 从个人中心页进入我的订购停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
#    获取校验结果  {'logtype':'stay'}    test_109    ${datatable_prefix_apk}_stay

case_110 个人中心页进入消费记录
    [Documentation]  PV事件
    按次数左移  1
    清除历史上报数据
    确认键  5
#    获取校验结果  {'logtype':'pv'}    test_110    ${datatable_prefix_apk}_pv

case_251 个人中心进入绑定微信页面
    [Documentation]  PV事件
    返回键
    等待我的页出现
    按次数右移  2
    清除历史上报数据
    确认键
    等待文本出现  绑定微信
    获取校验结果  {'logtype':'pv'}    test_251    ${datatable_prefix_apk}_pv

case_111 个人中心页进入会员卡激活
    [Documentation]  PV事件
    返回键
    等待我的页出现
    按次数右移  1
    清除历史上报数据
    确认键
    等待文本出现  会员卡激活
    获取校验结果  {'logtype':'pv'}    test_111    ${datatable_prefix_apk}_pv

case_194 从个人中心页进入会员卡激活页面停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    等待我的页出现
    获取校验结果  {'logtype':'stay'}    test_194    ${datatable_prefix_apk}_stay

case_195 从会员卡激活页面返回个人中心停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_195    ${datatable_prefix_apk}_stay

case_112 个人中心页进入观看历史
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    到达观看历史全部记录入口
    清除历史上报数据
    确认键
    等待文本出现  观看历史
    获取校验结果  {'logtype':'pv'}    test_112    ${datatable_prefix_apk}_pv

case_113 观看历史返回个人中心页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    等待我的页出现
    获取校验结果  {'logtype':'pv'}    test_113    ${datatable_prefix_apk}_pv

case_115 从个人中心页进入观看历史停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_115    ${datatable_prefix_apk}_stay

case_126 个人中心进入我的收藏
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    到达我的收藏全部记录入口
    清除历史上报数据
    确认键
    等待文本出现  节目收藏
    获取校验结果  {'logtype':'pv'}    test_126    ${datatable_prefix_apk}_pv

case_127 我的收藏返回个人中心
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    等待我的页出现
    获取校验结果  {'logtype':'pv'}    test_127    ${datatable_prefix_apk}_pv

#case_128 个人中心进入我的预约
#    [Documentation]  PV事件
#    log to console  暂无节目预约功能
#    到达我的页面入口
#    确认键
#    到达我的预约全部记录入口
#    清除历史上报数据
#    确认键
#    等待文本出现  节目收藏
#    获取校验结果  {'logtype':'pv'}    test_128    ${datatable_prefix_apk}_pv

#case_129 我的预约返回个人中心
#    [Documentation]  PV事件
#    log to console  暂无节目预约功能
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'pv'}    test_129    ${datatable_prefix_apk}_pv

case_124 个人中心页进入设置
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    显示服务和帮助
    清除历史上报数据
    点击进入内容描述  设置
    等待文本出现  绑定微信
    获取校验结果  {'logtype':'pv'}    test_124    ${datatable_prefix_apk}_pv

case_125 设置返回个人中心页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_125    ${datatable_prefix_apk}_pv

case_138 个人中心进入问题反馈页
    [Documentation]  PV事件
    清除历史上报数据
    点击进入内容描述  客服反馈（保障反馈）
    等待文本出现  问题反馈
    获取校验结果  {'logtype':'pv'}    test_138    ${datatable_prefix_apk}_pv

case_140 问题反馈页进入反馈结果页
    [Documentation]  PV事件
    清除历史上报数据
    点击文本  手机遥控操作不方便
    确认键
    等待文本出现  反馈成功
    获取校验结果  {'logtype':'pv'}    test_140    ${datatable_prefix_apk}_pv

case_141 反馈结果页返回问题反馈页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_141    ${datatable_prefix_apk}_pv

case_139 问题反馈页返回个人中心
    [Documentation]  PV事件
    清除历史上报数据
    按次数返回  2
    获取校验结果  {'logtype':'pv'}    test_139    ${datatable_prefix_apk}_pv

case_116 个人中心页进入常见问题
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  4
    清除历史上报数据
    点击进入内容描述  常见问题
    等待文本出现  常见问题
    获取校验结果  {'logtype':'pv'}    test_116    ${datatable_prefix_apk}_pv

case_117 常见问题返回个人中心页
    [Documentation]   PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_117    ${datatable_prefix_apk}_pv

case_118 从个人中心页进入帮助反馈下常见问题停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_118    ${datatable_prefix_apk}_stay

case_119 从帮助反馈下常见问题返回个人中心停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_119    ${datatable_prefix_apk}_stay

case_122 个人中心页进入关于我们
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  4
    清除历史上报数据
    点击进入内容描述  关于我们
    等待文本出现  关于我们
    获取校验结果  {'logtype':'pv'}    test_122    ${datatable_prefix_apk}_pv

case_123 关于我们返回个人中心页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_123    ${datatable_prefix_apk}_pv

case_126 从个人中心页进入关于我们停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_126    ${datatable_prefix_apk}_stay

case_127 从关于我们返回个人中心停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_127    ${datatable_prefix_apk}_stay

case_114 个人中心页进入新手指引
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    显示服务和帮助
    清除历史上报数据
    点击进入内容描述  新手指引
    等待文本出现  继续看
    获取校验结果  {'logtype':'pv'}    test_114    ${datatable_prefix_apk}_pv

case_115 新手指引返回个人中心页
    [Documentation]  PV事件
    清除历史上报数据
    返回键
#    确认键
    获取校验结果  {'logtype':'pv'}    test_115    ${datatable_prefix_apk}_pv

case_116 从个人中心页进入新手指引停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_116    ${datatable_prefix_apk}_stay

case_117 从新手指引返回个人中心停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_117    ${datatable_prefix_apk}_stay

#case_130 个人中心页进入我的播单
#    [Documentation]  个人中心页进入我的播单
#    log to console  暂无我的播单功能
#    到达我的页面入口
#    确认键
#    到达我的播单入口
#    清除历史上报数据
#    确认键
#    等待文本出现  添加新的播单
#    获取校验结果  {'logtype':'pv'}    test_130    ${datatable_prefix_apk}_pv

#case_128 从个人中心页进入我的播单停留后返回
#    [Documentation]  从个人中心页进入我的播单停留后返回
#    log to console  暂无我的播单功能
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'stay'}    test_128    ${datatable_prefix_apk}_stay

#case_129 从我的播单返回个人中心停留后进入我的播单
#    [Documentation]  从我的播单返回个人中心停留后进入我的播单
#    log to console  暂无我的播单功能
#    清除历史上报数据
#    确认键
#    等待文本出现  添加新的播单
#    获取校验结果  {'logtype':'stay'}    test_129    ${datatable_prefix_apk}_stay

#case_132 我的播单进入添加播单
#    [Documentation]  我的播单进入添加播单
#    log to console  暂无我的播单功能
#    清除历史上报数据
#    点击文本  添加新的播单
#    获取校验结果  {'logtype':'pv'}    test_132    ${datatable_prefix_apk}_pv

#case_133 添加播放返回我的播单
#    [Documentation]  添加播放返回我的播单
#    log to console  暂无我的播单功能
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'pv'}    test_133    ${datatable_prefix_apk}_pv

#case_130 从我的播单进入添加播单停留后返回
#    [Documentation]  从我的播单进入添加播单停留后返回
#    log to console  暂无我的播单功能
#    获取校验结果  {'logtype':'stay'}    test_130    ${datatable_prefix_apk}_stay

#case_134 我的播单进入播单详情页
#    [Documentation]  我的播单进入播单详情页
#    log to console  暂无我的播单功能
#    清除历史上报数据
#    点击文本  爸妈爱看
#    获取校验结果  {'logtype':'pv'}    test_134    ${datatable_prefix_apk}_pv

#case_131 从添加播单返回我的播单停留后进入播单详情
#    [Documentation]  从添加播单返回我的播单停留后进入播单详情
#    log to console  暂无我的播单功能
#    获取校验结果  {'logtype':'stay'}    test_131    ${datatable_prefix_apk}_stay

#case_132 从我的播单进入播单详情页停留后返回
#    [Documentation]  从我的播单进入播单详情页停留后返回
#    log to console  暂无我的播单功能
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'stay'}    test_132    ${datatable_prefix_apk}_stay

#case_136 播单详情页进入播单播放
#    [Documentation]  播单详情页进入播单播放
#    log to console  暂无我的播单功能
#    点击文本  爸妈爱看
#    清除历史上报数据
#    点击文本  母亲 第1集
#    获取校验结果  {'logtype':'pv'}    test_136    ${datatable_prefix_apk}_pv

#case_137 播单播放返回播单详情页
#    [Documentation]  播单播放返回播单详情页
#    log to console  暂无我的播单功能
#    清除历史上报数据
#    播放退出
#    获取校验结果  {'logtype':'pv'}    test_137    ${datatable_prefix_apk}_pv

#case_133 从播单详情页进入播单播放停留后返回
#    [Documentation]  从播单详情页进入播单播放停留后返回
#    log to console  暂无我的播单功能
#    获取校验结果  {'logtype':'stay'}    test_133    ${datatable_prefix_apk}_stay

#case_134 从播单播放返回播单详情页进入播单播放
#    [Documentation]  从播单播放返回播单详情页进入播单播放
#    log to console  暂无我的播单功能
#    清除历史上报数据
#    点击文本  母亲 第1集
#    获取校验结果  {'logtype':'stay'}    test_134    ${datatable_prefix_apk}_stay

#case_135 播单详情页返回我的播单
#    [Documentation]  播单详情页返回我的播单
#    log to console  暂无我的播单功能
#    播放退出
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'pv'}    test_135    ${datatable_prefix_apk}_pv

#case_131 我的播单返回个人中心页
#    [Documentation]  我的播单返回个人中心页
#    log to console  暂无我的播单功能
#    清除历史上报数据
#    返回键
#    获取校验结果  {'logtype':'pv'}    test_131    ${datatable_prefix_apk}_pv

case_142 观看历史进入节目收藏
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    到达观看历史全部记录入口
    确认键
    等待文本出现  节目收藏
    清除历史上报数据
    向下
    获取校验结果  {'logtype':'pv'}    test_142    ${datatable_prefix_apk}_pv

#case_135 从观看历史进入使用记录
#    [Documentation]  从观看历史进入使用记录
#    log to console  暂无使用记录功能
#    获取校验结果  {'logtype':'stay'}    test_135    ${datatable_prefix_apk}_stay

#case_136 从使用记录返回观看历史
#    [Documentation]  从使用记录返回观看历史
#    log to console  暂无使用记录功能
#    清除历史上报数据
#    向上
#    获取校验结果  {'logtype':'stay'}    test_136    ${datatable_prefix_apk}_stay


#case_143 使用记录进入节目收藏
#    [Documentation]  使用记录进入节目收藏
#    log to console  暂无使用记录功能
#    向下
#    清除历史上报数据
#    向下
#    获取校验结果  {'logtype':'pv'}    test_143    ${datatable_prefix_apk}_pv

case_137 从我的页面进入观看历史停留后再进入节目收藏
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_137    ${datatable_prefix_apk}_stay

case_138 从节目收藏返回观看历史
    [Documentation]  STAY事件
    清除历史上报数据
    向上
    获取校验结果  {'logtype':'stay'}    test_138    ${datatable_prefix_apk}_stay

case_144 节目收藏进入专题收藏
    [Documentation]  PV事件
    向下
    清除历史上报数据
    向下
    获取校验结果  {'logtype':'pv'}    test_144    ${datatable_prefix_apk}_pv

case_139 从节目收藏进入专题收藏
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_139    ${datatable_prefix_apk}_stay

case_140 从专题收藏返回节目收藏
    [Documentation]  STAY事件
    清除历史上报数据
    向上
    获取校验结果  {'logtype':'stay'}    test_140    ${datatable_prefix_apk}_stay

#case_145 专题收藏进入节目预约
#    [Documentation]  专题收藏进入节目预约
#    log to console  暂无节目预约功能
#    向下
#    清除历史上报数据
#    向下
#    获取校验结果  {'logtype':'pv'}    test_145    ${datatable_prefix_apk}_pv

#case_141 从专题收藏进入节目预约
#    [Documentation]  STAY事件
#    log to console  暂无节目预约功能
#    获取校验结果  {'logtype':'stay'}    test_141    ${datatable_prefix_apk}_stay

#case_142 从节目预约返回专题收藏
#    [Documentation]  STAY事件
#    log to console  暂无节目预约功能
#    清除历史上报数据
#    向上
#    获取校验结果  {'logtype':'stay'}    test_142    ${datatable_prefix_apk}_stay

case_226 我的页面进入全屏播放
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    清除历史上报数据
    点击进入内容描述  我站在桥上看风景 DVD版
    等待媒资播放
    获取校验结果  {'logtype':'pv'}    test_226    ${datatable_prefix_apk}_pv

case_183 我的页面进入全屏播放后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    等待我的页出现
    获取校验结果  {'logtype':'stay'}    test_183    ${datatable_prefix_apk}_stay

case_227 观看历史进入全屏播放
    [Documentation]  PV事件
    到达我的页面入口
    确认键
    等待我的页出现
    到达观看历史全部记录入口
    确认键
    等待页面出现文本信息  观看历史
    清除历史上报数据
    点击内容描述  我站在桥上看风景 DVD版
    等待媒资播放
    获取校验结果  {'logtype':'pv'}    test_227    ${datatable_prefix_apk}_pv

case_184 观看历史进入全屏播放后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    等待页面出现文本信息  观看历史
    获取校验结果  {'logtype':'stay'}    test_184    ${datatable_prefix_apk}_stay

#case_230 播单播放试看结束
#    [Documentation]  播单播放试看结束
#    log to console  暂无播单
#    到达我的页面入口
#    确认键
#    到达我的播单全部记录入口
#    向左
#    确认键
#    点击文本  蜘蛛侠：平行宇宙
#    等待媒资播放
#    清除历史上报数据
#    按秒快进  5
#    等待页面出现文本信息  试看结束  10
#    获取校验结果  {'logtype':'pv'}    test_230    ${datatable_prefix_apk}_pv