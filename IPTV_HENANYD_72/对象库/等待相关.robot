*** Settings ***
Documentation    片库方法
Library  AppiumLibrary
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot
Resource   ../../IPTV_HENANYD_72/对象库/搜索.robot

*** Keywords ***
等待片库内容出现
    等待元素出现  ${片库列表}

等待详情页出现
    [Documentation]  进入媒资详情页
    Run Keyword And Ignore Error  等待元素出现  ${详情页收藏}
    Run Keyword And Ignore Error  等待元素出现  ${详情页选集区域}  20
    等待  5

等待订购列表出现
    [Documentation]  等待订购列表出现
    等待元素出现  ${订购列表}  40
    等待元素出现  ${订购包}  20
    等待  3

等待订购中心出现
    [Documentation]  等待订购列表出现
    等待元素出现  ${订购中心}  40
    等待  3

等待试看结束
    等待  310

等待消息页出现
    [Documentation]  进入消息页，等待全部消息出现
    等待元素出现  ${全部消息}
    等待  2

等待明星页出现
    [Documentation]  进入明星页，等待媒资内容出现
    等待元素出现  ${明星作品列表}
    等待  2

等待搜索页出现
    等待搜索出现      ${搜索推荐}     ${搜索为空}     ${搜索结果}  ${搜索全空}

等待我的页出现
    [Documentation]  进入我的页，等待版本信息出现
    等待元素出现  ${版本信息}
    等待  2

等待观看历史页出现
    [Documentation]  等待观看历史页出现
    等待元素出现  ${观看历史}

等待专题出现
    等待元素出现  ${专题内容区}

等待组合专题页出现
    等待元素出现  ${组合专题顶部搜索}
    等待  5

等待小窗播放专题出现
    等待文本出现  小窗播放专题标题
    等待  5

等待短视频模板专题出现
    等待文本出现  芒果热播影视
    等待  5

等待短视频主题页出现
    等待页面出现内容描述信息  大芒短视频测试b3    20
    等待  3

等待轮播主题页出现
    等待元素出现  ${轮播小窗}
    等待  5

等待选片大师主题页出现
    等待页面出现内容描述信息  独立页面a
    等待  5

等待即映主题页出现
    等待元素出现  ${即映独立页}
    等待  5

等待会员片库页出现
    等待文本出现  会员片库
    等待  3

等待体育赛事页出现
    等待文本出现  体育赛程分屏
    等待  3

等待少儿模式首页出现
    等待元素出现  ${少儿开通会员}
    等待  3

等待元素出现
    [Documentation]  等待元素加载出现
    [Arguments]  ${name}    ${time}=20
    wait until page contains element  ${name}   ${time}

等待文本出现
    [Documentation]  判断页面中文字是否出现
    [Arguments]  ${text}    ${time}=20
    wait until page contains  ${text}   ${time}

等待回看列表出现
    [Documentation]  等待订购列表出现
    等待元素出现  ${回看频道}
    等待  3
    run keyword if  'HNDX' in '${project}'  按次数左移  1

等待直播播放器出现
    [Documentation]  等待订购列表出现
    等待元素出现  ${直播播放器}
    等待  3

等待缓冲出现
    [Documentation]  等待缓冲出现
    [Arguments]  ${time}=120
    Run Keyword And Ignore Error  等待文本出现  加载中  ${time}
    等待  3

等待缓冲出现_feed
    [Documentation]  等待缓冲出现_feed
    [Arguments]  ${time}=180
    Run Keyword And Ignore Error  等待元素出现  ${feed缓冲加载}  ${time}
    等待  5

等待出现搜索结果页
    [Documentation]  等待出现搜索结果页
    等待元素出现  ${视频搜索结果列表}
    等待  3

等待焦点位于内容描述上
    [Documentation]  等待焦点位于内容描述上
    [Arguments]  ${name}    ${num}=30
    ${locator}  set variable  //*[@focused="true" and @focusable="true" and @content-desc='${name}']
    FOR    ${i}    IN RANGE   ${num}
       ${status}     run keyword and return status    wait until page contains element    ${locator}  3
       exit for loop if    ${status}
       等待  1
    END