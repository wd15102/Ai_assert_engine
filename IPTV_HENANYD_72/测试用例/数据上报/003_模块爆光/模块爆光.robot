*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 模块爆光公共字段检查
    [Documentation]    模块曝光事件
    清除历史上报数据
    重新启动
    获取校验结果  {'logtype': 'show','mpos':'1000'}    test_001   ${datatable_prefix_apk}_show

case_002 启动进入顶部菜单曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1000'}    test_002   ${datatable_prefix_apk}_show

case_002_01 模块曝光事件公共字段新增开机参数
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1000'}    test_002   ${datatable_prefix_apk}_show

case_273 顶部通栏图片模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'-999'}    test_273   ${datatable_prefix_apk}_show

case_003 启动进入导航栏曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_003   ${datatable_prefix_apk}_show

case_004 启动进入精选频道页第一个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_1_and_4h_template3'}    test_004   ${datatable_prefix_apk}_show

case_005 启动进入精选频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_005   ${datatable_prefix_apk}_show

case_006 启动进入精选频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_006   ${datatable_prefix_apk}_show

case_011 启动进入直播频道页第一个模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    清除历史上报数据
    按次数左移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1'}    test_011   ${datatable_prefix_apk}_show

case_012 启动进入直播频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_012   ${datatable_prefix_apk}_show

case_013 启动进入直播频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_013   ${datatable_prefix_apk}_show

case_014 启动进入全部频道页第一个模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数左移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1'}    test_014   ${datatable_prefix_apk}_show

case_015 启动进入全部频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_015   ${datatable_prefix_apk}_show

case_016 启动进入全部频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_016   ${datatable_prefix_apk}_show

case_017 启动进入电视剧频道页第一个模块曝光
    [Documentation]    模块曝光事件
    按次数右移  2
    等待  4
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','offset_menta_data':'我赞过的'}    test_017   ${datatable_prefix_apk}_show

case_018 启动进入电视剧频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_018   ${datatable_prefix_apk}_show

case_019 启动进入电视剧频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_019   ${datatable_prefix_apk}_show

case_020 启动进入电视剧频道页第四个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'4'}    test_020   ${datatable_prefix_apk}_show

case_021 启动进入电影频道页第一个模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','module_id':'common_immersionV2_template3'}    test_021   ${datatable_prefix_apk}_show

case_021_1 由电视剧切换到电影过程中导航栏戏曲曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_300   ${datatable_prefix_apk}_show

case_022 启动进入电影频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'2'}    test_022   ${datatable_prefix_apk}_show

case_023 启动进入电影频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_023   ${datatable_prefix_apk}_show

case_024 进入少儿频道页第一个模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','module_id':'common_shouping_3h_template3'}    test_024   ${datatable_prefix_apk}_show

case_025 进入少儿频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_025   ${datatable_prefix_apk}_show

case_026 进入少儿频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'3'}    test_026   ${datatable_prefix_apk}_show

case_027 进入少儿频道页第四个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'4'}    test_027   ${datatable_prefix_apk}_show

case_028 由少儿切换到综艺过程中导航栏专题曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_028   ${datatable_prefix_apk}_show

case_029 进入综艺频道页第一个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_1_and_4h_template3'}    test_029   ${datatable_prefix_apk}_show

case_030 进入综艺频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_030   ${datatable_prefix_apk}_show

case_031 进入综艺频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_031   ${datatable_prefix_apk}_show

case_032 由综艺切换到动漫过程中导航栏4K曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_032   ${datatable_prefix_apk}_show

case_033 进入动漫频道页第一个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_live_template3'}    test_033   ${datatable_prefix_apk}_show

case_034 进入动漫频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'2'}    test_034   ${datatable_prefix_apk}_show

case_035 进入动漫频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_035   ${datatable_prefix_apk}_show

case_036 由动漫切换到电竞过程中导航栏本地曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_036   ${datatable_prefix_apk}_show

case_037 进入电竞频道页第一个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_4h_template3'}    test_037   ${datatable_prefix_apk}_show

case_038 进入电竞频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_038   ${datatable_prefix_apk}_show

case_039 进入电竞频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_039   ${datatable_prefix_apk}_show

case_040 由电竞切换到纪实过程中导航栏测试分屏曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_040   ${datatable_prefix_apk}_show

case_041 进入纪实频道页第一个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_immersionV2_template3'}    test_041   ${datatable_prefix_apk}_show

case_042 进入纪实频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'2'}    test_042   ${datatable_prefix_apk}_show

case_043 进入纪实频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_043   ${datatable_prefix_apk}_show

case_044 进入纪实频道页第四个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'4'}    test_044   ${datatable_prefix_apk}_show

case_045 进入戏曲频道页第一个模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_emphasis_cp_template3'}    test_045   ${datatable_prefix_apk}_show

case_046 进入戏曲频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'2'}    test_046   ${datatable_prefix_apk}_show

case_047 进入戏曲频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_047   ${datatable_prefix_apk}_show

case_048 进入VIP频道页第一个模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_turnplay_flow'}    test_048   ${datatable_prefix_apk}_show

case_049 进入VIP频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'2'}    test_049   ${datatable_prefix_apk}_show

case_050 进入VIP频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_050   ${datatable_prefix_apk}_show

case_051 进入专题频道页第一个模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    10
    获取校验结果  {'logtype': 'show','mpos':'1','flag':'138'}    test_051   ${datatable_prefix_apk}_show

case_052 进入专题频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'2'}    test_052   ${datatable_prefix_apk}_show

case_053 进入专题频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_053   ${datatable_prefix_apk}_show

case_054 进入4K频道页第一个模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_vip_template3'}    test_054   ${datatable_prefix_apk}_show

case_055 进入4K频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'2'}    test_055   ${datatable_prefix_apk}_show

case_056 进入4K频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_056   ${datatable_prefix_apk}_show

case_057 进入本地频道页第一个模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1','module_id':'common_emphasis_cp_template3'}    test_057   ${datatable_prefix_apk}_show

case_058 进入本地频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'2'}    test_058   ${datatable_prefix_apk}_show

case_059 进入本地频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_059   ${datatable_prefix_apk}_show

case_060 进入测试频道页第一个模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show','module_id':'common_jingxuan_template3'}    test_060   ${datatable_prefix_apk}_show

case_206 精选频道页精准投放投放模块的曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','module_id': 'common_jingxuan_template3'}    test_206   ${datatable_prefix_apk}_show

case_061 进入测试频道页第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'2'}    test_061   ${datatable_prefix_apk}_show

case_062 进入测试频道页第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos':'3'}    test_062   ${datatable_prefix_apk}_show

case_063 由电竞切换到动漫过程中导航栏精选曝光
    [Documentation]    模块曝光事件
    退出应用
    启动应用
    返回首页
    返回精选页
    切换频道  电竞
    等待  2
    清除历史上报数据
    按次数左移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_063   ${datatable_prefix_apk}_show

case_064 由动漫切换到综艺过程中导航栏直播曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数左移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_064   ${datatable_prefix_apk}_show

case_065 由综艺切换到少儿过程中导航栏全部曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数左移  1    2
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_065   ${datatable_prefix_apk}_show

case_066 点播详情页剧集列表模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    到达免费电视剧入口
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'show','mpos':'1002'}    test_066   ${datatable_prefix_apk}_show

case_067 点播详情页面顶部模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1000'}    test_067   ${datatable_prefix_apk}_show

case_068 点播详情页功能区域模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos':'1001'}    test_068   ${datatable_prefix_apk}_show

点播页顶部会员投放位曝光
    [Documentation]    控件曝光
    获取校验结果  {'logtype': 'cv','mod':'c_playdetailtoprecpop'}    test_163   ${datatable_prefix_apk}_cv

详情页付费推广位入口曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'cv','mod':'c_detrecposvippop'}    test_164   ${datatable_prefix_apk}_cv

case_069 点播详情页明星列表模块曝光
    [Documentation]    模块曝光事件
    按次数下移  3
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show','mtitle':'相关明星'}    test_069   ${datatable_prefix_apk}_show

case_070 点播详情页相关推荐模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show','mtitle':'相关推荐'}    test_070   ${datatable_prefix_apk}_show

case_071 点播详情页看了还会看模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show','mtitle':'看了还会看'}    test_071   ${datatable_prefix_apk}_show

case_071_1 详情页算法推荐投放模块的曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mtitle':'看了还会看'}    test_071   ${datatable_prefix_apk}_show

case_072 会员片库影视会员模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  电视剧
    等待  5
    清除历史上报数据
    点击内容描述  会员片库
    等待文本出现  会员片库
    获取校验结果  {'logtype': 'show','mdata':'唐人街探案'}    test_072   ${datatable_prefix_apk}_show

case_073 会员片库少儿会员模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show'}    test_073   ${datatable_prefix_apk}_show

case_074 会员片库动漫会员模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show'}    test_074   ${datatable_prefix_apk}_show

case_075 会员片库电竞会员模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show'}    test_075   ${datatable_prefix_apk}_show

case_076 会员片库纪录片会员模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show'}    test_076   ${datatable_prefix_apk}_show

case_077 会员片库教育会员模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数右移  1    2
    获取校验结果  {'logtype': 'show'}    test_077   ${datatable_prefix_apk}_show

case_079 电视剧片库页免费专区模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    按次数右移  1    2
    清除历史上报数据
    确认键
    等待片库内容出现
    获取校验结果  {'logtype': 'show','cntp':'list_index','mpos':'2'}    test_079   ${datatable_prefix_apk}_show

case_080 电视剧片库页同步剧场模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_080   ${datatable_prefix_apk}_show

case_081 电视剧片库页高清剧场模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_081   ${datatable_prefix_apk}_show

case_082 电视剧片库页亚洲剧场模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_082   ${datatable_prefix_apk}_show

case_083 电视剧片库页鼎级剧场模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_083   ${datatable_prefix_apk}_show

case_084 电视剧片库页专题模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_084   ${datatable_prefix_apk}_show

case_085 电视剧片库页内地剧场模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_085   ${datatable_prefix_apk}_show

case_086 电视剧片库页港台剧场模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_086   ${datatable_prefix_apk}_show

case_087 电视剧片库页古装历史模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_087   ${datatable_prefix_apk}_show

case_088 电视剧片库页警匪战争模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_088   ${datatable_prefix_apk}_show

case_089 电视剧片库页爱情偶像模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_089   ${datatable_prefix_apk}_show

case_090 电视剧片库页都市家庭模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_090   ${datatable_prefix_apk}_show

case_078 电视剧片库页最新上线模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
#    获取校验结果  {'logtype': 'show'}    test_078   ${datatable_prefix_apk}_show

case_092 电影片库页免费专区模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    按次数右移  2
    等待  10
    清除历史上报数据
    确认键
    等待片库内容出现
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_092   ${datatable_prefix_apk}_show

case_093 电影片库页会员独享模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_093   ${datatable_prefix_apk}_show

case_094 电影片库页高清影院模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_094   ${datatable_prefix_apk}_show

case_095 电影片库页好莱坞模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_095   ${datatable_prefix_apk}_show

case_096 电影片库页午夜惊彩模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_096   ${datatable_prefix_apk}_show

case_097 电影片库页专题模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_097   ${datatable_prefix_apk}_show

case_098 电影片库页华语电影模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_098   ${datatable_prefix_apk}_show

case_099 电影片库页欧美电影模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_099   ${datatable_prefix_apk}_show

case_100 电影片库页亚洲电影模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_100   ${datatable_prefix_apk}_show

case_101 电影片库动作冒险模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_101   ${datatable_prefix_apk}_show

case_102 电影片库页爱情喜剧模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_102   ${datatable_prefix_apk}_show

case_103 电影片库页恐怖悬疑模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_103   ${datatable_prefix_apk}_show

case_104 电影片库页动漫电影模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_104   ${datatable_prefix_apk}_show

case_105 电影片库页伦理剧情模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_105   ${datatable_prefix_apk}_show

case_091 电影片库页最新上线模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_091   ${datatable_prefix_apk}_show

case_107 少儿片库页免费专区模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    切换频道  少儿频道
    等待  5
    清除历史上报数据
    确认键
    等待片库内容出现
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_107   ${datatable_prefix_apk}_show

case_108 少儿片库页首映模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_108   ${datatable_prefix_apk}_show

case_109 少儿片库页动画明星模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_109   ${datatable_prefix_apk}_show

case_110 少儿片库页高清动画模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_110   ${datatable_prefix_apk}_show

case_111 少儿片库页成长乐园模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_111   ${datatable_prefix_apk}_show

case_112 少儿片库页玩具总动员模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_112   ${datatable_prefix_apk}_show

case_113 少儿片库页迪士尼模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_113   ${datatable_prefix_apk}_show

case_114 少儿片库页动画剧场模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_114   ${datatable_prefix_apk}_show

case_115 少儿片库页麦咭TV模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_115   ${datatable_prefix_apk}_show

case_116 少儿片库页儿童歌谣模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_116   ${datatable_prefix_apk}_show

case_117 少儿片库页亲子综艺模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_117   ${datatable_prefix_apk}_show

case_118 少儿片库页国产动画模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_118   ${datatable_prefix_apk}_show

case_119 少儿片库页亚洲动画模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_119   ${datatable_prefix_apk}_show

case_120 少儿片库页欧美动画模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_120   ${datatable_prefix_apk}_show

case_121 少儿片库页专题模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_121   ${datatable_prefix_apk}_show

case_122 综艺片库页王牌综艺模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    按次数右移  4
    等待  10
    清除历史上报数据
    确认键
    等待片库内容出现
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_122   ${datatable_prefix_apk}_show

case_123 综艺片库页专题模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_123   ${datatable_prefix_apk}_show

case_124 综艺片库页真人秀模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_124   ${datatable_prefix_apk}_show

case_125 综艺片库页音乐节目模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_125   ${datatable_prefix_apk}_show

case_126 综艺片库页爆笑娱乐模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_126   ${datatable_prefix_apk}_show

case_127 综艺片库页娱乐星闻模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_127   ${datatable_prefix_apk}_show

case_128 综艺片库页情感访谈模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_128   ${datatable_prefix_apk}_show

case_129 综艺片库页全部综艺模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_129   ${datatable_prefix_apk}_show

case_130 综艺片库页本周热播模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_130   ${datatable_prefix_apk}_show

case_131 动漫片库页免费专区模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    按次数右移  5
    等待  10
    清除历史上报数据
    确认键
    等待片库内容出现
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_131   ${datatable_prefix_apk}_show

case_132 动漫片库页热血动漫模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_132   ${datatable_prefix_apk}_show

case_133 动漫片库页国产动漫模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_133   ${datatable_prefix_apk}_show

case_134 动漫片库页亚洲动漫模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_134   ${datatable_prefix_apk}_show

case_135 动漫片库页欧美动漫模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_135   ${datatable_prefix_apk}_show

case_136 动漫片库页最新上线模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_136   ${datatable_prefix_apk}_show

case_137 电竞片库页最新上线模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    按次数右移  6
    等待  10
    清除历史上报数据
    确认键
    等待片库内容出现
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_137   ${datatable_prefix_apk}_show

case_138 电竞片库页电竞赛事模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_138   ${datatable_prefix_apk}_show

case_139 电竞片库页免费专区模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_139   ${datatable_prefix_apk}_show

case_140 电竞片库页电竞战队模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_140   ${datatable_prefix_apk}_show

case_141 电竞片库页英雄联盟模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_141   ${datatable_prefix_apk}_show

case_142 电竞片库页DOTA2模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_142   ${datatable_prefix_apk}_show

case_143 电竞片库页星际争霸2模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_143   ${datatable_prefix_apk}_show

case_144 电竞片库页魔兽争霸3模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_144   ${datatable_prefix_apk}_show

case_145 电竞片库页CS模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_145   ${datatable_prefix_apk}_show

case_146 电竞片库页炉石传说模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_146   ${datatable_prefix_apk}_show

case_147 电竞片库页英魂之刃模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_147   ${datatable_prefix_apk}_show

case_148 电竞片库页王者荣耀模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_148   ${datatable_prefix_apk}_show

case_149 纪实片库页免费专区模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    按次数右移  7
    等待  10
    清除历史上报数据
    确认键
    等待片库内容出现
    获取校验结果  {'logtype': 'show','mpos':'2'}    test_149   ${datatable_prefix_apk}_show

case_150 纪实片库页先锋纪录模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_150   ${datatable_prefix_apk}_show

case_151 纪实片库页会员独享模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_151   ${datatable_prefix_apk}_show

case_152 纪实片库页经典纪录模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_152   ${datatable_prefix_apk}_show

case_153 纪实片库页Discovery模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_153   ${datatable_prefix_apk}_show

case_154 纪实片库页电视节目模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_154   ${datatable_prefix_apk}_show

case_155 纪实片库页体育赛事模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_155   ${datatable_prefix_apk}_show

case_156 纪实片库页自然探秘模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_156   ${datatable_prefix_apk}_show

case_157 纪实片库页历史人文模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_157   ${datatable_prefix_apk}_show

case_158 纪实片库页铁血军事模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_158   ${datatable_prefix_apk}_show

case_159 纪实片库页科技前沿模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_159   ${datatable_prefix_apk}_show

case_160 纪实片库页公开课模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_160   ${datatable_prefix_apk}_show

case_161 纪实片库页专题模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_161   ${datatable_prefix_apk}_show

case_162 纪实片库页时代纪录模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_162   ${datatable_prefix_apk}_show

case_163 纪实片库页最新上线模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果_不上报  {'logtype': 'show'}    test_163   ${datatable_prefix_apk}_show

case_164 搜索页进入明星页曝光
    [Documentation]    模块曝光事件
    退出应用
    启动应用
    到达搜索入口
    确认键
    搜索-输入搜索词  A
    点击搜索结果媒资  2
    按次数上移  1
    按次数右移  11
    等待  5
    按键直到出现内容描述  李安  右
    确认键
    清除历史上报数据
    点击搜索推荐媒资    1
    确认键
    等待明星页出现
    获取校验结果  {'logtype': 'show'}    test_164   ${datatable_prefix_apk}_show

case_165 点播详情页进入明星页曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    到达试看电影入口
    确认键
    等待详情页出现
    按次数下移  1
    等待  5
    清除历史上报数据
    点击内容描述  陈赫
    等待明星页出现
    获取校验结果  {'logtype': 'show'}    test_165   ${datatable_prefix_apk}_show

case_166 首页进入明星页曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    按次数下移  14
    按键直到焦点位于内容描述上  艾伦·阿金    下
    等待  5
    按次数右移  3
    校验焦点是否在内容描述上  张天爱
    清除历史上报数据
    确认键
    等待明星页出现
    获取校验结果  {'logtype': 'show'}    test_166   ${datatable_prefix_apk}_show

case_166_1 明星全部曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show'}    test_166   ${datatable_prefix_apk}_show

case_174 明星页左侧由全部切换到电视剧栏目模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_174   ${datatable_prefix_apk}_show

case_175 明星页左侧由电视剧切换到电影栏目模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_175   ${datatable_prefix_apk}_show

case_176 明星页左侧由电影切换到综艺栏目模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_176   ${datatable_prefix_apk}_show

case_177 明星页左侧由综艺切换到少儿栏目模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show'}    test_177   ${datatable_prefix_apk}_show

case_167 首页进入专题页曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    按次数右移  1    2
    清除历史上报数据
    点击内容描述  APK专题
    等待专题出现
    获取校验结果  {'logtype': 'show','cntp':'colum_list'}    test_167   ${datatable_prefix_apk}_show

case_168 列表片库页进入专题页曝光
    [Documentation]    模块曝光事件
    log to console  暂无列表片库专题

case_169 我的页面第一个模块曝光
    [Documentation]    模块曝光事件
    到达我的页面入口
    清除历史上报数据
    确认键
    等待我的页出现
    获取校验结果  {'logtype': 'show','mpos': '1'}    test_169   ${datatable_prefix_apk}_show

case_170 我的页面第二个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos': '2'}    test_170   ${datatable_prefix_apk}_show

case_171 我的页面第三个模块曝光
    [Documentation]    模块曝光事件
    获取校验结果_不上报  {'logtype': 'show','mpos': '3'}    test_171   ${datatable_prefix_apk}_show

case_172 点播全屏呼出浮层花絮看点模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    按次数左移  1
    确认键  5
    按次数上移  2
    清除历史上报数据
    按次数右移  1
    获取校验结果  {'logtype': 'show'}    test_172   ${datatable_prefix_apk}_show

case_173 点播全屏呼出浮层剧集列表模块曝光
    [Documentation]    模块曝光事件
    等待  5
    清除历史上报数据
    按次数上移  1
    获取校验结果  {'logtype': 'show','mpos':'1002'}    test_173   ${datatable_prefix_apk}_show

case_214 点播全屏播放，播放反馈模块曝光
    [Documentation]    模块曝光事件
    等待  5
    按次数上移  3
    按次数右移  1
#    run keyword if  'HNDX' in '${project}'  按次数右移  1
    清除历史上报数据
    确认键
#    按次数右移  1
    获取校验结果  {'logtype': 'show','mid':'singlecycle'}    test_214   ${datatable_prefix_apk}_show

case_178 首页2+2模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    按次数下移  1    2
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show','mpos': '3'}    test_178   ${datatable_prefix_apk}_show

case_179 首页少儿模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按键直到出现内容描述  夺冠   下
    获取校验结果  {'logtype': 'show','mpos': '4'}    test_179   ${datatable_prefix_apk}_show

case_180 首页分类3通栏模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1    2
    获取校验结果  {'logtype': 'show','mpos': '5'}    test_180   ${datatable_prefix_apk}_show

case_180_1 精选频道页cms配置投放模块的曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos': '5'}    test_180   ${datatable_prefix_apk}_show

case_181 首页6竖图模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  3
    获取校验结果  {'logtype': 'show','mpos': '6'}    test_181   ${datatable_prefix_apk}_show

case_182 首页6竖图排行榜模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '7'}    test_182   ${datatable_prefix_apk}_show

case_183 首页6竖图即将上映模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '8'}    test_183   ${datatable_prefix_apk}_show

case_184 首页4横图模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '9'}    test_184   ${datatable_prefix_apk}_show

case_185 首页3横图模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '10'}    test_185   ${datatable_prefix_apk}_show

case_186 首页2横图模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '11'}    test_186   ${datatable_prefix_apk}_show

case_187 首页1横图模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '12'}    test_187   ${datatable_prefix_apk}_show

case_188 首页6横图模块曝光
    [Documentation]    模块曝光事件
    获取校验结果  {'logtype': 'show','mpos': '13'}    test_188   ${datatable_prefix_apk}_show

case_189 首页6圆图模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '14'}    test_189   ${datatable_prefix_apk}_show

case_190 首页6方图模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  2
    获取校验结果  {'logtype': 'show','mpos': '15'}    test_190   ${datatable_prefix_apk}_show

case_205 精选频道页算法推荐投放模块的曝光
    [Documentation]    模块曝光事件
    按次数下移  4
    等待  3
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '20'}    test_205   ${datatable_prefix_apk}_show

case_191 首页抽屉模块曝光
    [Documentation]    模块曝光事件
    按次数返回  1
    返回首页
    返回精选页
    切换频道  电视剧
    按次数下移  3
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '4'}    test_191   ${datatable_prefix_apk}_show

case_192 首页二维码通栏模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  2
    获取校验结果  {'logtype': 'show','mpos': '5'}    test_192     ${datatable_prefix_apk}_show

case_220 首页我赞过的模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  2
    获取校验结果  {'logtype': 'show','mpos': '7'}    test_220     ${datatable_prefix_apk}_show

case_221 首页我的关注模块曝光
    [Documentation]    模块曝光事件
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype': 'show','mpos': '8'}    test_221     ${datatable_prefix_apk}_show

case_193 首页沉浸式闪图模块曝光
    [Documentation]    模块曝光事件
    返回首页
    返回精选页
    清除历史上报数据
    切换频道  电影
    获取校验结果  {'logtype': 'show','module_id': 'common_immersionV2_template3'}    test_193   ${datatable_prefix_apk}_show
