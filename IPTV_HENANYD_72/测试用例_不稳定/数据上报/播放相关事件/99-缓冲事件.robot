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
case_000 Buffer事件公共字段检查
    [Documentation]  buffer事件
    返回首页
    返回精选页
    确认键
    清除历史上报数据
    网络限速配置
    点击元素  ${试看电影}
    等待详情页出现
    等待缓冲出现
    解除网络限速
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_001    ${datatable_prefix_apk}_buffer

case_001 点播媒资播放过程中，出现缓冲
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_001    ${datatable_prefix_apk}_buffer

case_001_01 buffer事件公共字段新增开机参数
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_001    ${datatable_prefix_apk}_buffer

case_080 点播媒资快进后播放
    [Documentation]  buffer事件
    按次数左移  2
    确认键
    网络限速配置
    清除历史上报数据
    按秒快进  3
    等待缓冲出现
    解除网络限速
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_080    ${datatable_prefix_apk}_buffer

case_081 点播媒资快退后播放
    [Documentation]  buffer事件
    清除历史上报数据
    按秒快退  1
    等待缓冲出现
    解除网络限速
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_081    ${datatable_prefix_apk}_buffer

case_002 推荐2.0媒资播放，出现缓冲
    [Documentation]  buffer事件
    返回精选页
    按次数下移  3
    校验焦点是否在内容描述上  天天向上1
    清除历史上报数据
    网络限速配置
    确认键
    等待详情页出现
    等待缓冲出现
    解除网络限速
    获取校验结果  {'logtype':'buffer'}    test_002    ${datatable_prefix_apk}_buffer

case_003 组合专题媒资沉浸式闪图播放，出现缓冲
    [Documentation]  buffer事件
    到达组合专题入口
    清除历史上报数据
    网络限速配置
    确认键
    等待组合专题页出现
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_003    ${datatable_prefix_apk}_buffer

case_004 沉浸式闪图媒资播放过程中，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    返回精选页
    切换频道  电影
    清除历史上报数据
    网络限速配置
    按次数下移  2
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_004    ${datatable_prefix_apk}_buffer

case_004_01 沉浸式闪图播放点播媒资
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_004    ${datatable_prefix_apk}_buffer

case_082 沉浸式闪图切换播放点播媒资
    [Documentation]  buffer事件
    网络限速配置
    按次数右移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_082    ${datatable_prefix_apk}_buffer

case_005 首页2横图-自动起播模块播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    返回精选页
    切换频道  动漫
    等待页面出现内容描述信息  天天向上1  30
    按次数下移  2
    清除历史上报数据
    网络限速配置
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_005    ${datatable_prefix_apk}_buffer

case_006 首页2横图-自动起播模块播放短视频_缓冲
    [Documentation]  buffer事件
    解除网络限速
    网络限速配置  5
    清除历史上报数据
    按次数右移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_006    ${datatable_prefix_apk}_buffer

case_007 首页大IP自动起播模块播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    返回精选页
    网络限速配置
    清除历史上报数据
    切换频道  戏曲
    等待出现校验结果_不校验数量    {'logtype':'buffer'}    test_007    ${datatable_prefix_apk}_buffer

case_008 首页大IP自动起播模块播放短视频_缓冲
    [Documentation]  buffer事件
    清除历史上报数据
    切换频道  本地
    等待出现校验结果_不校验数量    {'logtype':'buffer'}    test_008    ${datatable_prefix_apk}_buffer

case_009 闪图媒资播放过程中，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    切换频道  测试
    按次数下移  1
    清除历史上报数据
    网络限速配置
    按次数右移  1
    等待出现校验结果_不校验数量    {'logtype':'buffer'}    test_009    ${datatable_prefix_apk}_buffer

case_009_01 闪图播放点播媒资
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_009    ${datatable_prefix_apk}_buffer

case_010 直播播放过程中，出现缓冲
    [Documentation]  buffer事件
    返回精选页
    网络限速配置  5
    清除历史上报数据
    数字键进直播  002
    等待缓冲出现
    解除网络限速
    获取校验结果  {'logtype':'buffer'}    test_010    ${datatable_prefix_apk}_buffer

case_011 时移播放过程中，出现缓冲
    [Documentation]  buffer事件
    返回精选页
    数字键进直播  002
    清除历史上报数据
    网络限速配置  5
    按秒快退  3
    等待  8
    等待缓冲出现
    解除网络限速
    获取校验结果  {'logtype':'buffer'}    test_011    ${datatable_prefix_apk}_buffer

case_012 回看播放过程中，出现缓冲
    [Documentation]  buffer事件
    返回精选页
    切换频道  直播
    直播频道进入回看列表
    按次数下移  1    3
    按次数右移  1
    校验焦点是否在内容描述上  今日
    按次数上移  1
    按次数右移  1
    清除历史上报数据
    网络限速配置  5
    确认键  5
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_012    ${datatable_prefix_apk}_buffer

case_083 回看过程中快进播放
    [Documentation]  buffer事件
    清除历史上报数据
    按秒快进  3
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_083    ${datatable_prefix_apk}_buffer

case_084 回看过程中快退播放
    [Documentation]  buffer事件
    清除历史上报数据
    按秒快退  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_084    ${datatable_prefix_apk}_buffer

case_013 单feed模块自动播放_缓冲
    [Documentation]  buffer事件
    返回精选页
    切换频道  戏曲
    按次数下移  4
    清除历史上报数据
    网络限速配置  6
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_013    ${datatable_prefix_apk}_buffer

case_014 单feed模块切换卡片播放_缓冲
    [Documentation]  buffer事件
    清除历史上报数据
    按次数下移  2
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_014    ${datatable_prefix_apk}_buffer

case_015 单feed模块点击卡片跳转后返回播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按次数下移  1
    确认键  5
    网络限速配置
    清除历史上报数据
    按次数返回  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_015    ${datatable_prefix_apk}_buffer

case_016 双feed模块自动播放_缓冲
    [Documentation]  buffer事件
    返回精选页
    切换频道  综艺
    按次数下移  5
    清除历史上报数据
    网络限速配置  6
    按次数下移  1    5
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_016    ${datatable_prefix_apk}_buffer

case_017 双feed模块切换卡片播放_缓冲
    [Documentation]  buffer事件
    清除历史上报数据
    按次数下移  1    5
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_017    ${datatable_prefix_apk}_buffer

case_018 双feed模块点击卡片跳转后返回播放_缓冲
    [Documentation]  buffer事件
    按次数右移  1
    确认键  5
    清除历史上报数据
    网络限速配置
    按次数返回  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_018    ${datatable_prefix_apk}_buffer

case_019 选片大师独立页面自动起播播放_缓冲
    [Documentation]  buffer事件
    到达选片大师独立页入口
    网络限速配置  7
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_019    ${datatable_prefix_apk}_buffer

case_020 选片大师独立页面正片手动切集播放出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    按次数下移  1
    网络限速配置
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_020    ${datatable_prefix_apk}_buffer

case_021 选片大师独立页面自动切集播放出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待页面不出现文本信息  大家都爱看的小欢喜啊啊啊啊啊啊啊啊啊啊啊啊啊yyds  20
    等待文本出现  大家都爱看的小欢喜啊啊啊啊啊啊啊啊啊啊啊啊啊yyds  120
    等待  10
    清除历史上报数据
    网络限速配置   15
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_021    ${datatable_prefix_apk}_buffer

case_022 选片大师独立页面短视频播放出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    按次数下移  1    5
    清除历史上报数据
    网络限速配置  7
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_022    ${datatable_prefix_apk}_buffer

case_023 选片大师独立页面播放推荐插入正片出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待文本出现  妻子的秘密_推荐正片  30
    清除历史上报数据
    网络限速配置
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_023    ${datatable_prefix_apk}_buffer

case_024 选片大师独立页面播放推荐插入短视频出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    按次数下移  2
    等待文本出现  推荐短视频   30
    清除历史上报数据
    网络限速配置
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_024    ${datatable_prefix_apk}_buffer

case_025 选片大师正片播放出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    返回精选页
    切换频道  戏曲
    清除历史上报数据
    网络限速配置   7
    切换频道  专题
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_025    ${datatable_prefix_apk}_buffer

case_026 选片大师播放爆点媒资出现缓冲
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_026    ${datatable_prefix_apk}_buffer

case_026_01 选片大师播放同一媒资展示不同爆点出现缓冲
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_026    ${datatable_prefix_apk}_buffer

case_027 选片大师正片播放拖拽出现缓冲
    [Documentation]  buffer事件
    按次数下移  2
    清除历史上报数据
    按秒快进  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_027    ${datatable_prefix_apk}_buffer

case_028 选片大师正片手动切集播放出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    网络限速配置
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_028    ${datatable_prefix_apk}_buffer

case_029 选片大师正片自动切集播放出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待页面不出现文本信息  大家都爱看的小欢喜啊啊啊啊啊啊啊啊啊啊啊啊啊yyds  20
    等待文本出现  大家都爱看的小欢喜啊啊啊啊啊啊啊啊啊啊啊啊啊yyds  120
    等待  10
    清除历史上报数据
    网络限速配置  12
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_029    ${datatable_prefix_apk}_buffer

case_030 选片大师播放试看媒资出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待  5
    网络限速配置   15
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_030    ${datatable_prefix_apk}_buffer

case_031 选片大师短视频播放出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待  5
    网络限速配置  7
    清除历史上报数据
    按次数下移  1
    等待缓冲出现
    解除网络限速
    获取校验结果  {'logtype':'buffer'}    test_031    ${datatable_prefix_apk}_buffer

case_032 选片大师播放推荐插入正片出现缓冲
    [Documentation]  buffer事件
    等待文本出现  妻子的秘密_推荐正片  30
    网络限速配置
    清除历史上报数据
    按次数下移  1    2
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_032    ${datatable_prefix_apk}_buffer

case_033 选片大师短视频活动标识播放出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    网络限速配置   6
    清除历史上报数据
    按次数下移  1    2
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_033    ${datatable_prefix_apk}_buffer

case_034 选片大师短视频播放拖拽出现缓冲
    [Documentation]  buffer事件
    清除历史上报数据
    按秒快进  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_034    ${datatable_prefix_apk}_buffer

case_035 选片大师短视频手动切集播放出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    网络限速配置
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_035    ${datatable_prefix_apk}_buffer

case_036 选片大师短视频直播标识播放出现缓冲
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_036    ${datatable_prefix_apk}_buffer

case_037 选片大师播放推荐插入短视频出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待文本出现  推荐短视频   30
    清除历史上报数据
    等待文本出现  一起来看流星雨   300
    网络限速配置
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_037    ${datatable_prefix_apk}_buffer

case_038 选片大师短视频自动切集播放出现缓冲
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_038    ${datatable_prefix_apk}_buffer

case_039 选片大师短视频广告标识播放出现缓冲
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_039    ${datatable_prefix_apk}_buffer

case_040 小窗播放专题媒资播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    到达小窗播放专题入口
    网络限速配置  7
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_040    ${datatable_prefix_apk}_buffer

case_041 小窗播放专题媒资切换媒资播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待  5
    网络限速配置
    清除历史上报数据
    按次数右移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_041    ${datatable_prefix_apk}_buffer

case_042 小窗播放专题试看媒资播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按次数右移  2
    网络限速配置  15
    清除历史上报数据
    按次数右移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_042    ${datatable_prefix_apk}_buffer

case_043 短视频模板专题媒资播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    到达短视频模板专题入口
    网络限速配置  7
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_043    ${datatable_prefix_apk}_buffer

case_044 短视频模板专题切换媒资播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待  5
    网络限速配置  7
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_044    ${datatable_prefix_apk}_buffer

case_045 短视频模板专题试看媒资播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按次数下移  1
    网络限速配置  15
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_045    ${datatable_prefix_apk}_buffer

case_046 进入主题首页小窗播放，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    到达短视频轮播入口
    网络限速配置  7
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_046    ${datatable_prefix_apk}_buffer

case_047 进入主题首页小窗续播下一个媒资，出现缓冲
    [Documentation]  buffer事件
    等待焦点位于内容描述上  大芒短视频b测试关联推荐   300
    清除历史上报数据
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_047    ${datatable_prefix_apk}_buffer

case_048 进入主题首页全屏播放，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    确认键
    网络限速配置  7
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_048    ${datatable_prefix_apk}_buffer

case_049 进入主题首页全屏续播下一个媒资，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待文本出现  大芒短视频测试b3   60
    清除历史上报数据
    网络限速配置  7
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_049    ${datatable_prefix_apk}_buffer

case_050 进入作者主页点播媒资，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    确认键
    按次数右移  3
    确认键
    等待文本出现  大家好，欢迎来到我的个人空间
    网络限速配置  7
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_050    ${datatable_prefix_apk}_buffer

case_051 分屏进入主题首页小窗播放，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    返回精选页
    切换频道  戏曲
    切换频道  测试
    网络限速配置  7
    清除历史上报数据
    切换频道  短视频
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_051    ${datatable_prefix_apk}_buffer

case_052 分屏进入主题首页小窗续播下一个媒资，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    按次数下移  1
    按次数右移  1    3
    等待  48
    清除历史上报数据
    网络限速配置  7
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_052    ${datatable_prefix_apk}_buffer

case_053 分屏进入主题首页全屏播放，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    按次数下移  1
    确认键
    网络限速配置  7
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_053    ${datatable_prefix_apk}_buffer

case_054 分屏进入主题首页全屏续播下一个媒资，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待  60
    清除历史上报数据
    网络限速配置  7
    按秒快进  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_054    ${datatable_prefix_apk}_buffer

case_055 分屏进入作者主页点播媒资，出现缓冲
    [Documentation]  buffer事件
    解除网络限速
    确认键
    按次数右移  3
    确认键
    等待文本出现  大家好，欢迎来到我的个人空间
    网络限速配置  7
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_055    ${datatable_prefix_apk}_buffer

case_056 进入短视频标签最热页播放媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    到达短视频标签入口
    网络限速配置  7
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_056    ${datatable_prefix_apk}_buffer

case_057 标签聚合页媒资播放_缓冲
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_057    ${datatable_prefix_apk}_buffer

case_058 标签聚合页手动切换媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待  5
    网络限速配置  7
    按次数下移  1
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_058    ${datatable_prefix_apk}_buffer

case_059 标签聚合页自动切换媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待  40
    清除历史上报数据
    网络限速配置  7
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_059    ${datatable_prefix_apk}_buffer

case_060 进入短视频标签最新页播放媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按次数左移  1
    按次数下移  1    3
    按次数右移  1
    网络限速配置  7
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_060    ${datatable_prefix_apk}_buffer

case_061 标签聚合页媒资全屏播放_缓冲
    [Documentation]  buffer事件
    解除网络限速
    确认键
    网络限速配置  7
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_061    ${datatable_prefix_apk}_buffer

case_062 标签聚合页全屏手动切换媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待  5
    网络限速配置  7
    清除历史上报数据
    按次数下移  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_062    ${datatable_prefix_apk}_buffer

case_063 标签聚合页全屏自动切换媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    等待  60
    清除历史上报数据
    网络限速配置  7
    按秒快进  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_063    ${datatable_prefix_apk}_buffer

case_064 点播播放流畅媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    返回精选页
    切换频道  电影
    按键直到焦点位于内容描述上  指定流畅  下
    网络限速配置  15
    清除历史上报数据
    确认键
    等待详情页出现
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_064    ${datatable_prefix_apk}_buffer

case_065 点播播放标清媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按返回直到焦点位于内容  指定流畅
    按次数右移  1
    网络限速配置  15
    清除历史上报数据
    确认键
    等待详情页出现
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_065    ${datatable_prefix_apk}_buffer

case_066 点播播放高清媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按返回直到焦点位于内容  指定标清
    按次数右移  1
    网络限速配置  15
    清除历史上报数据
    确认键
    等待详情页出现
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_066    ${datatable_prefix_apk}_buffer

case_067 点播播放超清媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按返回直到焦点位于内容  指定高清
    按次数右移  1
    网络限速配置  15
    清除历史上报数据
    确认键
    等待详情页出现
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_067    ${datatable_prefix_apk}_buffer

case_068 点播播放蓝光媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按返回直到焦点位于内容  指定超清
    按次数右移  1
    网络限速配置  15
    清除历史上报数据
    确认键
    等待详情页出现
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_068    ${datatable_prefix_apk}_buffer

case_069 点播播放4K媒资_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按返回直到焦点位于内容  指定蓝光
    按次数右移  1
    网络限速配置  15
    清除历史上报数据
    确认键
    等待详情页出现
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_069    ${datatable_prefix_apk}_buffer

case_070 点播播放过程中切换清晰度_缓冲
    [Documentation]  buffer事件
    解除网络限速
    按返回直到焦点位于内容  指定4K
    按键直到焦点位于内容描述上  多清晰度不指定  上
    确认键
    等待详情页出现
    按次数左移  1
    确认键  10
    按次数下移  1    5
    按次数下移  2    2
    按次数左移  1
    确认键
    网络限速配置  12
    清除历史上报数据
    按秒快进  1
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_070    ${datatable_prefix_apk}_buffer

case_161 缓冲切换浮层曝光
    [Documentation]  CV事件
    清除历史上报数据
    等待文本出现  当前网络卡顿，您可以尝试切换到其他清晰度观看  300
    解除网络限速
    获取校验结果  {'logtype': 'cv'}    test_161   ${datatable_prefix_apk}_cv

case_070_1 点播全屏点击点击缓冲清晰度切换
    [Documentation]  点击事件
    log to console  需求变更，无法点击

case_070_2 系统播放器播放_缓冲事件
    [Documentation]  buffer事件
    log to console  需求变更，暂时无系统播放器，不区分自研播放器

case_070_3 自研播放器播放_缓冲事件
    [Documentation]  buffer事件
    log to console  需求变更，暂时无系统播放器，不区分自研播放器

case_071 轮播小窗播放出现1次缓冲
    [Documentation]  buffer事件
    到达轮播主题小窗入口
    网络限速配置  5
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_071    ${datatable_prefix_apk}_buffer

case_072 轮播小窗播放出现多次缓冲
    [Documentation]  buffer事件
    清除历史上报数据
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_072    ${datatable_prefix_apk}_buffer

case_073 轮播全屏播放出现1次缓冲
    [Documentation]  buffer事件
    解除网络限速
    按返回直到焦点位于内容  跳轮播主题-指定频道
    按次数右移  1
    网络限速配置  15
    清除历史上报数据
    确认键
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_073    ${datatable_prefix_apk}_buffer

case_074 轮播全屏播放出现多次缓冲
    [Documentation]  buffer事件
    清除历史上报数据
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_074    ${datatable_prefix_apk}_buffer

case_075 轮播通栏播放出现1次缓冲
    [Documentation]  buffer事件
    解除网络限速
    按返回直到焦点位于内容  综艺
    网络限速配置  8
    清除历史上报数据
    切换频道  VIP
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_075    ${datatable_prefix_apk}_buffer

case_076 轮播通栏播放出现多次缓冲
    [Documentation]  buffer事件
    清除历史上报数据
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_076    ${datatable_prefix_apk}_buffer

case_077 轮播播放过程中，出现缓冲
    [Documentation]  buffer事件
    获取校验结果  {'logtype':'buffer'}    test_077    ${datatable_prefix_apk}_buffer

case_078 轮播分屏播放出现1次缓冲
    [Documentation]  buffer事件
    解除网络限速
    切换频道  智能推荐2
    网络限速配置  15
    清除历史上报数据
    切换频道  轮播分屏
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_078    ${datatable_prefix_apk}_buffer

case_079 轮播分屏播放出现多次缓冲
    [Documentation]  buffer事件
    清除历史上报数据
    等待出现校验结果_不校验数量  {'logtype':'buffer'}    test_079    ${datatable_prefix_apk}_buffer

case_080 轮播时移播放过程中，出现缓冲
    [Documentation]  buffer事件
    log to console  轮播不能时移

#微博短视频自动起播播放_缓冲
#进入个人中心_我赞过点播媒资，出现缓冲
#简约版媒资快进播放，出现缓冲
#简约版媒资快退播放，出现缓冲
