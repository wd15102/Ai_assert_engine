*** Settings ***
Documentation    首页点击事件
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../IPTV_JX_72/对象库/消息.robot

Suite Setup     run keywords  启动应用  AND  激活接口  ${广告}    ${广告_前贴_空},${广告_直播退出_非空},${广告_直播暂停_非空},${广告_点播角标_非空},${广告_点播推荐位_非空},${广告_点播暂停_非空}
Suite Teardown      退出应用

*** Test Cases ***
case_001 消息接收事件_系统公告
    [Documentation]  messrec事件||公告消息_右下_弹窗_图文_15秒_首页
    返回首页
    清除历史上报数据
    发送消息    公告1  1   ${uuid}
    等待文本出现  消息标题公告  30
    获取校验结果  {'logtype':'messrec'}    test_001    ${datatable_prefix_apk}_messrec

case_001_01 所有消息事件改为post上报
    [Documentation]  messrec事件
    获取校验结果  {'logtype':'messrec'}    test_001    ${datatable_prefix_apk}_messrec

case_001_02 消息接收事件公共字段检查
    [Documentation]  messrec事件
    获取校验结果  {'logtype':'messrec'}    test_001    ${datatable_prefix_apk}_messrec

case_001 消息阅读事件_系统公告
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_001    ${datatable_prefix_apk}_messrd

case_105 消息弹窗控件上报_系统公告
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_105    ${datatable_prefix_apk}_cv

系统消息
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_105    ${datatable_prefix_apk}_cv

消息弹窗曝光
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_105    ${datatable_prefix_apk}_cv

case_001 消息点击事件_系统公告
    [Documentation]  messclick事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messclick'}    test_001    ${datatable_prefix_apk}_messclick

case_331 点击消息弹窗_系统公告
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','bid':'26.5.5.5'}    test_331    ${datatable_prefix_apk}_click

case_001 系统公告_居中_图片与文字
    [Documentation]  messrec事件||公告消息_居中_弹窗_图文_30秒_详情页
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    公告图文  1   ${uuid}  site_1  30    style_2  7
    等待文本出现  消息标题公告图文  30
    获取校验结果  {'logtype':'messrec'}    test_001    ${datatable_prefix_apk}_messrec

case_005 系统公告_居中_图片与文字_消息阅读事件
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_005    ${datatable_prefix_apk}_messrd

case_005 自动弹出居中消息
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_005    ${datatable_prefix_apk}_messrd

case_162 屏幕正中间消息
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_162    ${datatable_prefix_apk}_cv

case_005 自动弹出居中消息点击
    [Documentation]  messclick事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messclick'}    test_005    ${datatable_prefix_apk}_messclick

case_001 系统公告_霸屏_图片
    [Documentation]  messrec事件||公告消息_全屏_弹窗_图片_60秒_WEB
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    公告全图  1   ${uuid}  site_3  60    style_3  9
    等待文本出现  查看  30
    等待页面不出现文本信息  消息标题公告全图  30
    获取校验结果  {'logtype':'messrec'}    test_001    ${datatable_prefix_apk}_messrec

case_006 系统公告_霸屏_图片_消息阅读事件
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_006    ${datatable_prefix_apk}_messrd

case_006 自动弹出图片消息
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_006    ${datatable_prefix_apk}_messrd

case_006 自动弹出全屏消息
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_006    ${datatable_prefix_apk}_messrd

case_006 自动弹出图片消息点击
    [Documentation]  messclick事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messclick'}    test_006    ${datatable_prefix_apk}_messclick

case_006 自动弹出全屏消息点击
    [Documentation]  messclick事件
    获取校验结果  {'logtype':'messclick'}    test_006    ${datatable_prefix_apk}_messclick

case_001 系统公告_右下_不弹窗
    [Documentation]  messrec事件||公告消息_右下_不弹窗_图文_明星
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    公告不弹  1   ${uuid}  site_4  60    style_2  10
    等待页面不出现文本信息  消息标题公告不弹  30
    获取校验结果  {'logtype':'messrec'}    test_001    ${datatable_prefix_apk}_messrec

case_007 系统公告_右下_不弹窗_消息阅读事件
    [Documentation]  messrd事件
    获取校验结果_不上报  {'logtype':'messrd'}    test_007    ${datatable_prefix_apk}_messrd

case_001 系统公告_弹窗_不入消息盒子
    [Documentation]  messrec事件||公告消息_右下_弹窗_图文_60秒_我的
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    公告5  1   ${uuid}  site_2  60    style_2  11  2
    等待文本出现  消息标题公告5  30
    获取校验结果  {'logtype':'messrec'}    test_001    ${datatable_prefix_apk}_messrec

case_008 系统公告_弹窗_不入消息盒子_消息阅读事件
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_008    ${datatable_prefix_apk}_messrd

case_001 系统公告_可变宽高图片
    [Documentation]  messrec事件||公告消息_全屏_弹窗_图片_60秒_回看
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    公告异图  1   ${uuid}  site_3  60    style_4  12
    等待文本出现  查看  30
    等待页面不出现文本信息  消息标题公告异图
    获取校验结果  {'logtype':'messrec'}    test_001    ${datatable_prefix_apk}_messrec

case_013 系统公告_可变宽高图片_消息阅读事件
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_013    ${datatable_prefix_apk}_messrd

case_013 自动弹出异型消息
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_013    ${datatable_prefix_apk}_messrd

case_007 自动弹出异型消息点击
    [Documentation]  messclick事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messclick'}    test_007    ${datatable_prefix_apk}_messclick

case_002 消息接收事件_系统其他消息
    [Documentation]  messrec事件
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    其他消息  6   ${uuid}  site_2  15    style_1  8
    等待文本出现  消息标题其他消息  30
    获取校验结果  {'logtype':'messrec'}    test_002    ${datatable_prefix_apk}_messrec

case_002 消息阅读事件_系统其他消息
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_002    ${datatable_prefix_apk}_messrd

case_106 消息弹窗控件上报_系统其他消息
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_106    ${datatable_prefix_apk}_cv

系统其他消息
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_106    ${datatable_prefix_apk}_cv

非强制弹窗消息
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_106    ${datatable_prefix_apk}_cv

case_002 消息点击事件_系统其他消息
    [Documentation]  messclick事件
    确认键
    获取校验结果  {'logtype':'messclick'}    test_002    ${datatable_prefix_apk}_messclick

case_332 点击消息弹窗_系统其他消息
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','bid':'26.5.5.5'}    test_332    ${datatable_prefix_apk}_click

case_002 系统其他消息_居中_图片与文字
    [Documentation]  messrec事件
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    其他居中  6   ${uuid}  site_1  30    style_2  7
    等待文本出现  消息标题其他居中  30
    获取校验结果  {'logtype':'messrec'}    test_002    ${datatable_prefix_apk}_messrec

case_009 系统其他消息_居中_图片与文字_消息阅读事件
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_009    ${datatable_prefix_apk}_messrd

case_002 系统其他消息_霸屏_图片
    [Documentation]  messrec事件
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    其他全图  6   ${uuid}  site_3  60    style_3  9
    等待文本出现  查看  30
    等待页面不出现文本信息  消息标题其他全图  30
    获取校验结果  {'logtype':'messrec'}    test_002    ${datatable_prefix_apk}_messrec

case_010 系统其他消息_霸屏_图片_消息阅读事件
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_010    ${datatable_prefix_apk}_messrd

case_002 系统其他消息_右下_不弹窗
    [Documentation]  messrec事件
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    其他不弹窗  6   ${uuid}  site_4  60    style_1  10
    等待页面不出现文本信息  消息标题其他不弹窗  30
    获取校验结果  {'logtype':'messrec'}    test_002    ${datatable_prefix_apk}_messrec

case_011 系统其他消息_右下_不弹窗_消息阅读事件
    [Documentation]  messrd事件
    获取校验结果_不上报  {'logtype':'messrd'}    test_011    ${datatable_prefix_apk}_messrd

case_002 系统其他消息_弹窗_不入消息盒子
    [Documentation]  messrec事件
    按键直到焦点位于内容描述上  精选
    清除历史上报数据
    发送消息    其他消息5  6   ${uuid}  site_2  60    style_2  11  2
    等待文本出现  消息标题其他消息5  30
    获取校验结果  {'logtype':'messrec'}    test_002    ${datatable_prefix_apk}_messrec

case_012 系统其他消息_弹窗_不入消息盒子_消息阅读事件
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_012    ${datatable_prefix_apk}_messrd

case_003 消息接收事件_营销消息
    [Documentation]  messrec事件
    返回首页
    清除历史上报数据
    发送消息  营销  60  ${uuid}  site_5   15  style_2  7
    检查消息是否接收到   消息标题营销
    获取校验结果  {'logtype':'messrec'}    test_003    ${datatable_prefix_apk}_messrec

case_003 消息阅读事件_营销消息
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_003    ${datatable_prefix_apk}_messrd

case_107 消息弹窗控件上报_营销消息
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_107    ${datatable_prefix_apk}_cv

case_003 消息点击事件_营销消息
    [Documentation]  messclick事件
    确认键
    获取校验结果  {'logtype':'messclick'}    test_003    ${datatable_prefix_apk}_messclick

case_333 点击消息弹窗_营销消息
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','bid':'26.5.5.5'}    test_333    ${datatable_prefix_apk}_click

case_004 消息接收事件_任务消息
    [Documentation]  messrec事件
    返回精选页
    等待  10
    清除历史上报数据
    发送消息  任务  70  ${uuid}  site_5   15  style_2  2
    检查消息是否接收到   消息标题任务
    获取校验结果  {'logtype':'messrec'}    test_004    ${datatable_prefix_apk}_messrec

case_004 消息阅读事件_任务消息
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_004    ${datatable_prefix_apk}_messrd

case_153 消息弹窗控件上报_任务消息
    [Documentation]  CV事件
    获取校验结果  {'logtype':'cv'}    test_153    ${datatable_prefix_apk}_cv

case_004 消息点击事件_任务消息
    [Documentation]  messclick事件
    确认键
    获取校验结果  {'logtype':'messclick'}    test_004    ${datatable_prefix_apk}_messclick

case_377 点击消息弹窗_任务消息
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','bid':'26.5.5.5'}    test_377    ${datatable_prefix_apk}_click

case_004 消息接收事件_未读消息
    [Documentation]  messrec事件
    返回精选页
    数字键进直播  001
    清除历史上报数据
    发送消息  其他消息6  6  ${uuid}  site_1  15
    等待  10
    发送消息  其他消息7  6  ${uuid}  site_1  15
    获取校验结果  {'logtype':'messrec'}    test_002    ${datatable_prefix_apk}_messrec    2

case_005 从全部消息页切换到未读消息
    [Documentation]  messscan事件
    到达消息页面入口
    确认键
    等待消息页出现
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messscan'}    test_005    ${datatable_prefix_apk}_messscan

case_405 点击未读消息中的消息
    [Documentation]  点击事件
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_405    ${datatable_prefix_apk}_click

case_014 未读消息列表消息点击
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_014    ${datatable_prefix_apk}_messrd

case_014_1 手动将消息状态置为已读
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_014    ${datatable_prefix_apk}_messrd

case_006 从未读消息页返回到首页
    [Documentation]  messscan事件
    按次数返回  1
    清除历史上报数据
    按次数返回  1
    获取校验结果  {'logtype':'messscan'}    test_006    ${datatable_prefix_apk}_messscan

case_015 打开消息盒子，浏览业务提醒消息
    [Documentation]  messrd事件
    确认键
    等待消息页出现
    按次数右移  1
    按次数下移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messrd'}    test_015    ${datatable_prefix_apk}_messrd

case_016 打开消息盒子，浏览推荐提醒消息
    [Documentation]  messrd事件
    按次数下移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messrd'}    test_016    ${datatable_prefix_apk}_messrd

case_406 点击某一条消息
    [Documentation]  点击事件
    按次数下移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_406    ${datatable_prefix_apk}_click

case_406_1 点击全部消息中的消息
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_406    ${datatable_prefix_apk}_click

case_406_2 全部消息列表消息点击
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_406    ${datatable_prefix_apk}_click

case_017 消息列表中打开文字消息
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_017    ${datatable_prefix_apk}_messrd

case_008 消息列表中点击文字消息
    [Documentation]  messclick事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messclick'}    test_008    ${datatable_prefix_apk}_messclick

case_018 消息列表中打开图片消息
    [Documentation]  messrd事件
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messrd'}    test_018    ${datatable_prefix_apk}_messrd

case_018_1 消息列表中打开全屏消息
    [Documentation]  messrd事件
    获取校验结果  {'logtype':'messrd'}    test_018    ${datatable_prefix_apk}_messrd

case_009 消息列表中点击图片消息
    [Documentation]  messclick事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messclick'}    test_009    ${datatable_prefix_apk}_messclick

case_009_1 消息列表中点击全屏消息
    [Documentation]  messclick事件
    获取校验结果  {'logtype':'messclick'}    test_009    ${datatable_prefix_apk}_messclick

case_019 消息列表中打开居中消息
    [Documentation]  messrd事件
    等待订购中心出现
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messrd'}    test_019    ${datatable_prefix_apk}_messrd

case_010 消息列表中点击居中消息
    [Documentation]  messclick事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messclick'}    test_010    ${datatable_prefix_apk}_messclick

case_020 消息列表中打开右下角消息
    [Documentation]  messrd事件
    等待详情页出现
    详情页退出
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messrd'}    test_020    ${datatable_prefix_apk}_messrd

case_011 消息列表中点击右下角消息
    [Documentation]  messclick事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messclick'}    test_011    ${datatable_prefix_apk}_messclick

case_021 消息列表中打开异型消息
    [Documentation]  messrd事件
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messrd'}    test_021    ${datatable_prefix_apk}_messrd

case_012 消息列表中点击异型消息
    [Documentation]  messclick事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'messclick'}    test_012    ${datatable_prefix_apk}_messclick

case_407 点击删除某一条消息
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_407    ${datatable_prefix_apk}_click

case_408 点击消息全部标记已读
    [Documentation]  点击事件
    按键直到焦点位于文本上  全部删除  上
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_408    ${datatable_prefix_apk}_click

case_409 点击消息全部删除
    [Documentation]  点击事件
    按次数返回  1
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_409    ${datatable_prefix_apk}_click

#从未读消息进入搜索页停留后返回

case_005 消息接收事件_营销消息_后端发送
    [Documentation]  messrec事件
    返回首页
    清除历史上报数据
    发送营销消息  营销  ${uuid}  30
    检查消息是否接收到   继续观看
    获取校验结果  {'logtype':'messrec'}    test_005    ${datatable_prefix_apk}_messrec

case_006 消息接收事件_任务消息_后端发送
    [Documentation]  messrec事件
    返回首页
    等待  60
    清除历史上报数据
    发送任务消息  ${uuid}
    检查消息是否接收到   观看任务
    获取校验结果  {'logtype':'messrec'}    test_006    ${datatable_prefix_apk}_messrec