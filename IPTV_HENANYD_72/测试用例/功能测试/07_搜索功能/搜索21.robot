*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../系统方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
case_001 非suggest词搜索即全部结果-标题
    [Documentation]    非suggest词搜索即全部结果-标题
    [Tags]  smoke
    到达搜索入口
    确认键
    等待搜索页出现
    搜索-输入搜索词  A
    等待页面出现内容描述信息  全部
    等待页面出现内容描述信息  延安爱情

case_002 搜索长视频正片
    [Documentation]    搜索长视频正片
    等待页面出现内容描述信息  延安爱情

case_003 搜索结果样式-标题
    [Documentation]    搜索结果样式-标题
    等待页面出现内容描述信息  延安爱情
    点击搜索结果媒资  1

case_004 搜索结果数量超过12个
    [Documentation]    搜索结果数量超过12个
    按次数下移  3
    等待文本出现  查看更多

case_005 搜索结果页焦点移动
    [Documentation]    搜索结果页焦点移动
    校验焦点是否在内容描述上  亲爱的恩东啊
    按次数下移  1
    校验焦点是否在文本上  查看更多

case_006 搜索短视频
    [Documentation]    搜索短视频
    等待页面出现内容描述信息  测试-橙子短视频验证0504

case_007 视频搜索结果tab页有短视频
    [Documentation]    视频搜索结果tab页有短视频
    等待页面出现内容描述信息  测试-橙子短视频验证0504

case_008 短视频搜索内容标题
    [Documentation]    短视频搜索内容标题
    等待页面出现内容描述信息  测试-橙子短视频验证0504

case_009 搜索结果点击更多
    [Documentation]    搜索结果点击更多
    校验内容描述出现次数  可可小爱爱国系列    0
    确认键
    校验内容描述出现次数  可可小爱爱国系列    1

case_010 搜索结果页焦点移动后按返回回到搜索导航
    [Documentation]    搜索结果页焦点移动后按返回回到搜索导航
    按键直到焦点位于文本上  查看更多   下
    按次数返回  1
    校验焦点是否在内容描述上  全部

case_011 视频搜索结果每个tab都有内容
    [Documentation]    视频搜索结果每个tab都有内容
    FOR    ${i}    IN RANGE   10
        按次数右移  1
        等待元素出现  xpath=//*[@resource-id="${appPackage1}:id/search_media_recycler_view"]/android.view.View[@index=\'0\']   15
    END

case_012 视频搜索结果tab页没有短视频
    [Documentation]    视频搜索结果没有长视频内容
    到达搜索入口
    确认键
    等待搜索页出现
    搜索-输入搜索词  SSSSSLTH
    搜索结果海报是否存在指定媒资  三生三世十里桃花
    搜索-校验搜索结果媒资数量   2

case_013 搜索结果数量不足12个
    [Documentation]    搜索结果数量不足12个
    搜索-校验搜索结果媒资数量   2

case_014 视频搜索结果有视频内容时明星tab页展示
    [Documentation]    视频搜索结果有视频内容时明星tab页展示
    等待页面出现内容描述信息  明星

case_015 视频搜索结果点击长视频跳转
    [Documentation]    视频搜索结果点击长视频跳转
    点击搜索结果媒资  1
    确认键
    等待详情页出现

case_016 点击搜索结果长视频媒资后返回
    [Documentation]    点击搜索结果长视频媒资后返回
    详情页退出
    校验焦点是否在内容描述上  三生三世十里桃花

case_017 视频搜索结果没有长视频内容
    [Documentation]    视频搜索结果没有长视频内容
    清空搜索结果
    搜索-输入搜索词  YJXFNG
    校验内容描述出现次数_模糊匹配  御姐驯服奶狗实录    1
    搜索-校验搜索结果媒资数量   1

case_018 视频搜索结果点击短视频内容跳转
    [Documentation]    视频搜索结果点击短视频内容跳转
    点击内容描述_模糊匹配  御姐驯服奶狗实录
    等待出现搜索结果页

case_019 点击搜索结果短视频媒资后返回
    [Documentation]    点击搜索结果短视频媒资后返回
    按次数下移  1
    按次数返回  1
    等待搜索页出现

case_020 视频搜索结果没有视频内容但有明星内容
    [Documentation]    视频搜索结果没有视频内容但有明星内容
    清空搜索结果
    搜索-输入搜索词  OYNN
    校验内容描述出现次数  全部   0
    校验内容描述出现次数  明星   1

case_021 视频搜索结果没有长视频也没有短视频内容
    [Documentation]    视频搜索结果没有长视频也没有短视频内容
    校验内容描述出现次数  全部   0
    校验内容描述出现次数  明星   1

case_022 视频搜索结果没有视频内容且没有明星等其他内容
    [Documentation]    视频搜索结果没有视频内容且没有明星等其他内容
    清空搜索结果
    搜索-输入搜索词  AAAAAA
    等待页面出现元素信息  ${搜索为空}

case_023 视频搜索结果没有视频内容且没有明星内容
    [Documentation]    视频搜索结果没有视频内容且没有明星内容
    等待页面出现元素信息  ${搜索为空}

#少儿模式不支持短视频搜索
#搜索历史增加短视频搜索历史
#搜索结果数量等于12个
#明星搜索名称修改