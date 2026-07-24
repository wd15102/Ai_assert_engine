*** Settings ***
Documentation    直播心跳
Resource          ../../../../IPTV_JX_72/对象库/直播回看时移.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case001 进入直播频道上报5分钟心跳
    [Tags]  P2
    返回首页
    数字键进直播  001
    等待  5
    返回首页
    返回精选页
    按次数左移  1
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_213   ${datatable_prefix_apk}_hb

case002 直播频道小视频窗上报5分钟心跳
    [Tags]  P2
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_216   ${datatable_prefix_apk}_hb

case003 直播分屏切换到精选分屏上报退出心跳
    [Tags]  P2
    清除历史上报数据
    按次数右移  1
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_214   ${datatable_prefix_apk}_hb

case004 小视频窗退出直播上报退出心跳
    [Tags]  P2
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_217   ${datatable_prefix_apk}_hb

case005 点击直播频道小视频窗上报退出心跳
    [Tags]  P2
    按次数左移  1
    等待  15
    清除历史上报数据
    点击元素  ${直播小窗播放器}
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_215   ${datatable_prefix_apk}_hb

case006 按上键切换频道上报退出心跳
    [Tags]  P2
    返回首页
    返回精选页
    数字键进直播  2
    等待  15
    清除历史上报数据
    按次数下移  1
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_218   ${datatable_prefix_apk}_hb

case007 按上键切换频道上报5分钟心跳
    [Tags]  P2
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_219   ${datatable_prefix_apk}_hb

case008 数字键进入直播上报5分钟心跳
    [Tags]  P2
    返回首页
    返回精选页
    数字键进直播  2
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_220   ${datatable_prefix_apk}_hb

case009 频道浮层切换频道上报退出心跳
    [Tags]  P2
    清除历史上报数据
    直播呼出浮层
    点击内容描述  湖南卫视高清
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_222   ${datatable_prefix_apk}_hb

case010 频道浮层切换频道上报5分钟心跳
    [Tags]  P2
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_223   ${datatable_prefix_apk}_hb

case011 全屏退出直播上报退出心跳
    [Tags]  P2
    清除历史上报数据
    直播退出
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_221   ${datatable_prefix_apk}_hb

case012 时移播放器进入直播上报5分钟心跳
    [Tags]  P2
    返回首页
    返回精选页
    数字键进直播  1
    按秒快退  2
    等待  5
    按秒快进  3
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_224   ${datatable_prefix_apk}_hb

case013 退出时移直播上报退出心跳
    [Tags]  P2
    清除历史上报数据
    直播退出
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_225   ${datatable_prefix_apk}_hb

case014 回看列表进入直播上报5分钟心跳
    [Tags]  P2
    返回首页
    返回精选页
    按次数左移  1
    点击元素  ${回看}
    等待  5
    按次数右移  3
    确认键
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_226   ${datatable_prefix_apk}_hb

case015 直播上报第2个5分钟心跳
    [Tags]  P2
    清除历史上报数据
    等待  300
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_227   ${datatable_prefix_apk}_hb

case016 退出回看直播上报退出心跳
    [Tags]  P2
    清除历史上报数据
    直播退出
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_228   ${datatable_prefix_apk}_hb

case017 回看列表进入回看上报5分钟心跳
    [Tags]  P2    
    返回首页
    返回精选页
    切换频道  直播
    直播频道进入回看列表
    按次数左移  1
    按次数下移  1
    按次数右移  1
    按次数上移  2
    按次数右移  1
    确认键
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_233   ${datatable_prefix_apk}_hb

case018 按下键切换回看内容上报退出心跳
    [Tags]  P2    
    清除历史上报数据
    按次数下移  1
    等待页面出现文本信息  确认
    确认键
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_235   ${datatable_prefix_apk}_hb

case019 按下键切换回看内容上报5分钟心跳
    [Tags]  P2    
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_236   ${datatable_prefix_apk}_hb

case020 点击回看浮层节目上报退出心跳
    [Tags]  P2    
    确认键
    按次数下移  1
    清除历史上报数据
    确认键
    等待  15
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_238   ${datatable_prefix_apk}_hb

case021 退出回看上报退出心跳
    [Tags]  P2    
    清除历史上报数据
    直播退出
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_234   ${datatable_prefix_apk}_hb

case022 直播进入时移上报5分钟心跳
    [Tags]  P2    
    返回首页
    数字键进直播  1
    等待  5
    按秒快退  2
    等待  200
    清除历史上报数据
    等待  120
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_241   ${datatable_prefix_apk}_hb

case023 时移进入直播上报退出心跳
    [Tags]  P2    
    清除历史上报数据
    按秒快进  3
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_242   ${datatable_prefix_apk}_hb

case024 时移按返回键上报退出心跳
    [Tags]  P2    
    按秒快退  2
    等待  5
    清除历史上报数据
    直播退出
    等待  5
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_243   ${datatable_prefix_apk}_hb

case025 直播暂停进入时移上报5分钟心跳
    [Tags]  P2    
    返回首页
    返回精选页
    数字键进直播  1
    等待  5
    暂停键
    等待  300
    确认键
    等待  210
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_244   ${datatable_prefix_apk}_hb

case026 付费直播上报退出心跳
    [Tags]  P2    
    返回首页
    数字键进直播  05
    清除历史上报数据
    返回首页
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_230   ${datatable_prefix_apk}_hb

case027 直播试看退出上报退出心跳
    [Tags]  P2    
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_230   ${datatable_prefix_apk}_hb

case028 自动切换回看内容上报退出心跳
    [Tags]  P2    
    返回首页
    切换频道  直播
    直播频道进入回看列表
    按次数上移  2
    按次数右移  1
    确认键
    按秒快进  15
    清除历史上报数据
    等待  15
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_237   ${datatable_prefix_apk}_hb
