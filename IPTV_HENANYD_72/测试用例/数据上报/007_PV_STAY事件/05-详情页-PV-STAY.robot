*** Settings ***
Documentation    详情页PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/我的.robot
Resource          ../../../../IPTV_JX_72/对象库/明星.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
#case_074 从电视剧频道进入详情页停留后返回
#    [Documentation]  STAY事件
#    返回首页
#    返回精选页
#    到达免费电视剧入口
#    确认键
#    等待详情页出现
#    清除历史上报数据
#    详情页退出
#    获取校验结果  {'logtype':'stay'}    test_074    ${datatable_prefix_apk}_stay
#
#case_071 点播详情页进入搜索页
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    到达免费电视剧入口
#    确认键
#    等待详情页出现
#    焦点移动到搜索
#    清除历史上报数据
#    确认键
#    等待搜索页出现
#    获取校验结果  {'logtype':'pv'}    test_071    ${datatable_prefix_apk}_pv
#
#case_072 搜索页返回点播详情页
#    [Documentation]  PV事件
#    清除历史上报数据
#    返回键
#    等待详情页出现
#    获取校验结果  {'logtype':'pv'}    test_072    ${datatable_prefix_apk}_pv
#
#case_075 从点播详情页进入搜索页停留后返回
#    [Documentation]  STAY事件
#    获取校验结果  {'logtype':'stay'}    test_075    ${datatable_prefix_apk}_stay
#
#case_073 点播详情页进入会员页
#    [Documentation]  PV事件
#    焦点移动到开通会员
#    清除历史上报数据
#    确认键
#    等待订购中心出现
##    获取校验结果  {'logtype':'pv'}    test_073    ${datatable_prefix_apk}_pv
#
#case_074 会员页返回点播详情页
#    [Documentation]  PV事件
#    清除历史上报数据
#    返回键
#    等待详情页出现
#    获取校验结果  {'logtype':'pv'}    test_074    ${datatable_prefix_apk}_pv
#
#case_076 从点播详情页进入会员页停留后返回
#    [Documentation]  STAY事件
#    log to console  WEB页面
##    获取校验结果  {'logtype':'stay'}    test_076    ${datatable_prefix_apk}_stay
#
#case_075 点播详情页进入我的页
#    [Documentation]  PV事件
#    焦点移动到我的
#    清除历史上报数据
#    确认键
#    等待我的页出现
#    获取校验结果  {'logtype':'pv'}    test_075    ${datatable_prefix_apk}_pv
#
#case_076 我的页返回点播详情页
#    [Documentation]  PV事件
#    清除历史上报数据
#    返回键
#    等待详情页出现
#    获取校验结果  {'logtype':'pv'}    test_076    ${datatable_prefix_apk}_pv
#
#case_077 从点播详情页进入我的页停留后返回
#    [Documentation]  STAY事件
#    获取校验结果  {'logtype':'stay'}    test_077    ${datatable_prefix_apk}_stay
#
#case_079 点播详情页试看结束进入订购提示页
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    到达试看电影入口
#    确认键
#    等待详情页出现
#    等待媒资播放
#    清除历史上报数据
#    等待试看结束
#    获取校验结果  {'logtype':'pv'}    test_079    ${datatable_prefix_apk}_pv
#
#case_079_1 进入点播详情页_无权益
#    [Documentation]  PV事件
#    获取校验结果  {'logtype':'pv'}    test_079    ${datatable_prefix_apk}_pv
#
#case_079 从点播详情页进入订购提示界面停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回键  5
#    获取校验结果  {'logtype':'stay'}    test_079    ${datatable_prefix_apk}_stay
#
#case_077 点播详情页进入订购页
#    [Documentation]  PV事件
#    确认键
#    等待详情页出现
#    按次数右移  1
#    清除历史上报数据
#    确认键
#    等待订购列表出现
##    获取校验结果  {'logtype':'pv'}    test_077    ${datatable_prefix_apk}_pv
#
#case_078 订购页返回点播详情页
#    [Documentation]  PV事件
#    清除历史上报数据
#    订购返回详情页
#    获取校验结果  {'logtype':'pv','cntp':'v_play'}    test_078    ${datatable_prefix_apk}_pv
#
#case_078 从点播详情页进入订购页停留后返回
#    [Documentation]  STAY事件
#    log to console  WEB页面
##    获取校验结果  {'logtype':'stay'}    test_078    ${datatable_prefix_apk}_stay
#
#case_080 从订购提示页进入订购页停留后返回
#    [Documentation]  STAY事件
#    log to console  WEB页面
##    返回首页
##    返回精选页
##    点击元素    ${试看电影}
##    等待页面出现元素信息  ${详情页收藏}    10
##    等待媒资播放
##    等待试看结束
##    点击元素    ${购买}
##    等待页面出现元素信息  ${订购中心}  10
##    清除历史上报数据
##    订购返回详情页
##    获取校验结果  {'logtype':'stay'}    test_080    ${datatable_prefix_apk}_stay
#
#case_080 点播详情页手动切集
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    到达免费电视剧入口
#    确认键
#    等待详情页出现
#    清除历史上报数据
#    切换集数  2
#    获取校验结果_不上报  {'logtype':'pv'}    test_080    ${datatable_prefix_apk}_pv
#
#case_081 从点播详情页手动切集停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_081    ${datatable_prefix_apk}_stay
#
#case_081 点播详情页自动切集
#    [Documentation]  PV事件
#    点击元素    ${免费电视剧}
#    等待详情页出现
#    等待媒资播放
#    点击全屏或购买
#    按秒快进  10
#    返回详情页
#    清除历史上报数据
#    等待  10
#    获取校验结果_不上报  {'logtype':'pv'}    test_081    ${datatable_prefix_apk}_pv
#
#case_082 从点播详情页自动切集停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    详情页退出
#    获取校验结果  {'logtype':'stay'}    test_082    ${datatable_prefix_apk}_stay
#
#case_082 点播详情页进相关明星页
#    [Documentation]  PV事件
#    点击元素    ${免费电视剧}
#    等待详情页出现
#    清除历史上报数据
#    点击内容描述  李溪芮
#    等待明星页出现
#    获取校验结果  {'logtype':'pv'}    test_082    ${datatable_prefix_apk}_pv
#
#case_083 相关明星页返回点播详情页
#    [Documentation]  PV事件
#    清除历史上报数据
#    返回键
#    等待页面出现内容描述信息  相关明星
#    获取校验结果  {'logtype':'pv'}    test_083    ${datatable_prefix_apk}_pv
#
#case_083 从点播详情页进相关明星页停留后返回
#    [Documentation]  STAY事件
#    获取校验结果  {'logtype':'stay'}    test_083    ${datatable_prefix_apk}_stay
#
#case_084 点播详情页进入花絮看点
#    [Documentation]   PV事件
#    按次数上移  4
#    按次数右移  1
#    按次数下移  1
#    清除历史上报数据
#    确认键
#    获取校验结果_不上报  {'logtype':'pv'}    test_084    ${datatable_prefix_apk}_pv
#
#case_084 从点播详情页进入花絮看点停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_084    ${datatable_prefix_apk}_stay
#
#case_085 点播详情页进入相关推荐
#    [Documentation]   PV事件
#    返回首页
#    返回精选页
#    到达免费电视剧入口
#    确认键
#    等待详情页出现
#    按次数下移  5
#    清除历史上报数据
#    进入媒资详情页  绯闻计划
#    获取校验结果  {'logtype':'pv'}    test_085    ${datatable_prefix_apk}_pv
#
#case_085 点播详情页进入点播详情页cid上报
#    [Documentation]  PV事件
#    获取校验结果  {'logtype':'pv'}    test_085    ${datatable_prefix_apk}_pv
#
#case_085 从点播详情页进入相关推荐停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_085    ${datatable_prefix_apk}_stay
#
#case_086 点播详情页进入看了还会看
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    到达免费电视剧入口
#    确认键
#    等待详情页出现
#    按次数下移  6
#    按次数左移  3
#    清除历史上报数据
#    确认键
#    等待详情页出现
#    获取校验结果  {'logtype':'pv'}    test_086    ${datatable_prefix_apk}_pv
#
#case_086 从点播详情页进入看了还会看停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_086    ${datatable_prefix_apk}_stay
#
#case_087 全屏播放页进入订购提示界面
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    到达试看电影入口
#    确认键
#    等待详情页出现
#    按次数左移  1
#    确认键
#    等待媒资播放
#    清除历史上报数据
#    等待试看结束
#    获取校验结果  {'logtype':'pv'}    test_087    ${datatable_prefix_apk}_pv
#
#case_087 从全屏播放页进入订购提示界面停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_087    ${datatable_prefix_apk}_stay
#
#case_088 全屏播放页进入订购页
#    [Documentation]   PV事件
#    返回首页
#    返回精选页
#    到达试看电影入口
#    确认键
#    等待详情页出现
#    等待媒资播放
#    按次数左移  1
#    确认键  5
#    等待元素出现  ${正在试看}
#    清除历史上报数据
#    确认键
#    等待订购列表出现
##    获取校验结果  {'logtype':'pv'}    test_088    ${datatable_prefix_apk}_pv
#
#case_088 从全屏播放页进入订购页停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    订购返回详情页
##    获取校验结果  {'logtype':'stay'}    test_088    ${datatable_prefix_apk}_stay
#
#case_089 从订购页停留后返回全屏播放页停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_089    ${datatable_prefix_apk}_stay
#
#case_090 从全屏订购提示页进入订购页停留后返回
#    [Documentation]  STAY事件
#    返回首页
#    返回精选页
#    到达试看电影入口
#    确认键
#    等待详情页出现
#    等待媒资播放
#    按次数左移  1
#    确认键  5
#    等待元素出现  ${正在试看}
##    等待试看结束
##    等待文本出现  试看结束
#    确认键
#    等待订购列表出现
#    清除历史上报数据
#    订购返回详情页
##    获取校验结果  {'logtype':'stay'}    test_090    ${datatable_prefix_apk}_stay
#
#case_091 从订购页返回全屏订购提示页停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_091    ${datatable_prefix_apk}_stay
#
#case_089 全屏播放手动切集
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    到达免费电视剧入口
#    确认键
#    等待详情页出现
#    等待媒资播放
#    全屏播放
#    等待  3
#    按次数上移  2
#    按次数右移  1
#    清除历史上报数据
#    确认键
#    获取校验结果_不上报  {'logtype':'pv'}    test_089    ${datatable_prefix_apk}_pv
#
#case_092 从全屏播放中手动切集停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_092    ${datatable_prefix_apk}_stay
#
#case_090 全屏播放自动切集
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    到达免费电视剧入口
#    确认键
#    等待详情页出现
#    等待媒资播放
#    全屏播放
#    按秒快进  12
#    清除历史上报数据
#    等待  10
#    获取校验结果_不上报  {'logtype':'pv'}    test_090    ${datatable_prefix_apk}_pv
#
#case_093 从全屏播放中自动切集停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_093    ${datatable_prefix_apk}_stay
#
#case_091 全屏播放进入花絮看点
#    [Documentation]  PV事件
#    返回首页
#    返回精选页
#    到达免费电视剧入口
#    确认键
#    等待详情页出现
#    等待媒资播放
#    全屏播放
#    呼出选集浮层
#    向上
#    清除历史上报数据
#    确认键
#    获取校验结果_不上报  {'logtype':'pv'}    test_091    ${datatable_prefix_apk}_pv
#
#case_094 从全屏播放进入花絮看点停留后返回
#    [Documentation]  STAY事件
#    清除历史上报数据
#    返回首页
#    获取校验结果  {'logtype':'stay'}    test_094    ${datatable_prefix_apk}_stay

case_103 搜索历史记录进入点播详情页
    [Documentation]  PV事件
    到达搜索入口
    确认键
    等待搜索页出现
    清除历史上报数据
    点击搜索历史媒资    2
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_103    ${datatable_prefix_apk}_pv

case_104 点播详情页返回搜索页
    [Documentation]  PV事件
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype':'pv'}    test_104    ${datatable_prefix_apk}_pv

case_105 搜索大家都在搜进入点播详情页
    [Documentation]  PV事件
    点击搜索推荐媒资    1
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_105    ${datatable_prefix_apk}_pv

case_105 从大家都在搜进入点播详情页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype':'stay'}    test_105    ${datatable_prefix_apk}_stay

case_106 从点播详情页返回搜索页停留后进入点播详情页
    [Documentation]  STAY事件
    校验焦点是否在内容描述上  绯闻计划
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'stay'}    test_106    ${datatable_prefix_apk}_stay

case_106 搜索结果进入点播详情页
    [Documentation]  PV事件
    详情页退出
    搜索-输入搜索词    JTP
    清除历史上报数据
    点击搜索结果媒资  1
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_106    ${datatable_prefix_apk}_pv

case_107 从搜索页结果进入点播详情页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype':'stay'}    test_107    ${datatable_prefix_apk}_stay

case_107 精选频道进入排行榜页
    [Documentation]  精选频道进入排行榜页
    log to console  暂无该场景

case_108 排行榜返回精选频道
    [Documentation]  排行榜返回精选频道
    log to console  暂无该场景

case_224 首页进入点播详情页
    [Documentation]  PV事件
    返回首页
    返回精选页
    到达免费电视剧入口
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_224    ${datatable_prefix_apk}_pv

case_229 首页进入非试看媒资详情页
    [Documentation]   PV事件
    获取校验结果  {'logtype':'pv'}    test_229    ${datatable_prefix_apk}_pv

case_185 首页进入点播详情页后返回
    [Documentation]  STAY事件
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype':'stay'}    test_185    ${datatable_prefix_apk}_stay

case_228 首页进入试看媒资详情页k
    [Documentation]  PV事件
    返回首页
    返回精选页
    到达试看电影入口
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_228    ${datatable_prefix_apk}_pv

case_244 历史记录进入点播详情页cid上报
    [Documentation]  PV事件
    到达首页观看记录入口
    确认键
    等待文本出现  观看历史
    按次数右移  3
    清除历史上报数据
    确认键  5
    等待媒资播放
#    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_244    ${datatable_prefix_apk}_pv

case_245 节目收藏进入点播详情页cid上报
    [Documentation]  PV事件
    播放退出
    详情页退出
    等待文本出现  观看历史
    按次数左移  4
    按次数下移  1
    清除历史上报数据
    点击进入内容描述  惊天破
    等待媒资播放
    获取校验结果  {'logtype':'pv'}    test_245    ${datatable_prefix_apk}_pv

case_246 我的进入点播详情页cid上报
    [Documentation]  PV事件
    到达我的页面入口
    确认键  5
    等待我的页出现
    按次数下移  3
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_246    ${datatable_prefix_apk}_pv

case_247 会员片库进入点播详情页
    [Documentation]  PV事件
    返回首页
    返回精选页
    切换频道  电视剧
    点击内容描述  会员片库
    等待文本出现  影视会员
    按次数下移  3
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_247    ${datatable_prefix_apk}_pv

case_248 点播详情页返回会员片库页
    [Documentation]  PV事件
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype':'pv'}    test_248    ${datatable_prefix_apk}_pv

case_249 首页进入点播详情页cid上报
    [Documentation]  PV事件
    返回首页
    返回精选页
    到达免费电影入口
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_249    ${datatable_prefix_apk}_pv

case_252 首页进入非试看付费媒资详情页
    [Documentation]  PV事件
    返回首页
    返回精选页
    到达试看电影入口
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype':'pv'}    test_252    ${datatable_prefix_apk}_pv