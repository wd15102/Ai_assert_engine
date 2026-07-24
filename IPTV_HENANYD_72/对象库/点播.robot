*** Settings ***
Library           AppiumLibrary
Resource          ../../IPTV_HENANYD_72/对象库/公共方法.robot

*** Keywords ***
移动到看了还会看
    [Documentation]  点播详情页移动到看了还会看
    wait until page contains element  xpath=//android.widget.TextView[@text='芒果首页']     20
    :FOR    ${i}   IN RANGE    5
    \    ${statusValue}     run keyword and return status    wait until page contains element    android=new UiSelector().text("看了还会看")  2
    \   run keyword if    ${statusValue}   exit for loop
    \   向下

点击简介按钮
    [Documentation]  点击简介按钮
    ${locator}  set variable    id=com.mgtv.tv:id/dynamic_detail_img
    wait until page contains element  ${locator}   20
    click element  ${locator}

等待媒资播放
    [Documentation]  判断媒资是否处于加载中或播放广告
    等待  5
    FOR    ${i}    IN RANGE    5
        ${statusValue}     run keyword and return status    wait until page contains element  ${加载}    1
        ${statusValue1}     run keyword and return status    等待页面出现文本信息  开通会员免广告    2
        run keyword if  ${statusValue}==True   Run Keywords     sleep  2     AND     log to console      加载未完成，等待2秒
        ...     ELSE IF  ${statusValue1}==True   Run Keywords    sleep  5   AND     log to console      广告未播放完，等待5秒
        ...     ELSE IF     ${statusValue}==False and ${statusValue1}==False    Run Keywords   log to console  播放正常    AND    exit for loop
    END

详情页进入收银台
    [Documentation]  详情页进入收银台
    ${locator}  set variable    id=com.mgtv.tv:id/vod_dynamic_vip_text
    wait until page contains element  ${locator}   20
    click element  ${locator}

等待自动续播消失并返回
    [Documentation]  媒资全屏播放时，如果出现自动续播提示，等待8S，并返回
    ${statusValue}     run keyword and return status    wait until page contains element  id=com.mgtv.tv:id/com.mgtv.tv:id/continue_play_tip_text    2
    run keyword if  ${statusValue}   sleep  8
    返回键

点击片尾
    [Documentation]  呼出播放进度条，并点击片尾，进入下一集播放
    按次数右移  1
    click element  id=com.mgtv.tv:id/sdkplayer_playback_tail

点播播放选集
    [Documentation]  点播播放选集
    [Arguments]    ${num}
    ${locator}  set variable    ${全部剧集}
    ${new_num}    evaluate  int(${num})-1
    wait until page contains element  ${locator}   20
    click element  ${locator}
    wait until page contains element    xpath=//*[@resource-id='${app_package1}:id/vod_all_series_dialog_rlv']/android.view.View[@index='${num}']  10
    click element   xpath=//*[@resource-id='${app_package1}:id/vod_all_series_dialog_rlv']/android.view.View[@index='${new_num}']
    等待  5

点播全屏播放浮层选集
    [Documentation]  点播全屏播放浮层选集
    [Arguments]    ${num}
#    ${series}   evaluate  "${剧集列表}".format('${num}')
#    ${new_num}    evaluate  int(${num})-1
    按次数下移  1    2
    ${name}  get element attribute  ${当前焦点}  contentDescription
#    ${name}  获取元素属性  ${当前焦点}  contentDescription
    ${num0}  evaluate    int(${num})
    ${num1}  evaluate    int(${name})
    ${num2}  evaluate   abs(${num0}-${num1})
    run keyword if  ${num0}>${num1}   Run Keywords     sleep  5     AND     按次数下移  1    2     AND     按次数右移  ${num2}     AND     确认键    0
    ...  ELSE IF  ${num0} < ${num1}   Run Keywords     sleep  5     AND     按次数下移  1    2     AND     按次数左移  ${num2}     AND     确认键    0
    ...  ELSE    log to console  当前已在对应集数
#    点击元素  ${series}

点播播放时间
    [Documentation]  点播播放时间
    [Arguments]    ${time}    ${error}=20
    ${local_time}  Wait Until Keyword Succeeds  20s  3s    获取直播时间  ${点播当前播放时间}
    ${begintime}    set variable    00:00:00
    ${time_computing}     computing time  ${begintime}    ${local_time}  S
    ${new_num}    evaluate  abs(int(${time_computing})-int(${time}))
    run keyword if  ${new_num}<=${error}   log to console  时间相等
    ...     ELSE    fail    起播时间错误

点播时移
    [Documentation]  点播时移
    [Arguments]    ${name}  ${count}=1
    FOR    ${i}    IN RANGE    3
        run keyword if   '${name}'=='右'  按次数右移  ${count}   ELSE    按次数左移  ${count}
        ${statusValue}     run keyword and return status    wait until page contains element  ${时移开始时间}    2
        run keyword if  ${statusValue}==True    exit for loop
    END
    等待  4

检查清晰度选中位置
    [Documentation]  点播全屏清晰度选中位置
    [Arguments]    ${name}
    ${locator}  set variable  xpath=//*[@resource-id='${app_package1}:id/vodplayer_dynamic_setting_radio_item_radio_icon_view']/parent::*
    校验元素内容描述是否为指定值  ${locator}  ${name}  1

全屏关闭自动联播功能
    [Documentation]  全屏关闭自动联播功能
    按次数上移  4
    按次数右移  1
    按次数下移  1
    按次数右移  1
    确认键  5

等待点播暂停出现
    [Documentation]  等待点播暂停出现，出现暂停广告或暂停图标
    ${statusValue}     run keyword and return status    wait until page contains element  ${点播暂停图标}    2
    ${statusValue1}     run keyword and return status    等待页面出现文本信息  关闭广告    2
    Run Keyword If  '${statusValue}'=='True' or '${statusValue1}'=='True'   log to console  出现点播暂停
    ...     ELSE    fail  未出现点播暂停

关闭暂停广告
    [Documentation]  关闭暂停广告，如有则关闭，如无则不处理
    ${statusValue}     run keyword and return status    等待页面出现文本信息  关闭广告    1
    run keyword if  ${statusValue}==True    Run Keywords    按次数左移  1    AND     确认键
    ...  ELSE   log to console  无广告