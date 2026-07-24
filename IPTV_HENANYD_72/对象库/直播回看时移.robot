*** Settings ***
Documentation    直播回看时移方法
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot

*** Keywords ***
回看呼出浮层
    [Documentation]  回看播放器中呼出节目浮层
    等待  3
    FOR    ${i}   IN RANGE    3
        ${statusexit}     run keyword and return status    wait until page contains element    ${推荐图}  1
        run keyword if    ${statusexit}==True     按次数返回   1  ELSE   exit for loop
    END
    wait until page contains element  ${回看图标}    3
    FOR    ${i}   IN RANGE    2
        run keyword if  'HNDX' in '${project}'  确认键  0  ELSE  向下
        ${statusback}     run keyword and return status     wait until page contains element    ${回看浮层}     1
        run keyword if      ${statusback}==True     exit for loop
        ...     ELSE    向右
    END

直播呼出浮层
    [Documentation]  直播、时移播放器中呼出节目浮层
    wait until page contains element  ${直播播放器}    3
    等待  3
    FOR    ${i}   IN RANGE    3
        ${statusexit}     run keyword and return status    wait until page contains element    ${推荐图}  1
        run keyword if    ${statusexit}==True     按次数返回   1  ELSE   exit for loop
    END
    FOR    ${i}   IN RANGE    2
        确认键  1
        ${statusback}     run keyword and return status     wait until page contains element    ${全部}     1
        run keyword if      ${statusback}==True     exit for loop
    END

取消直播预约弹窗
    [Documentation]  取消直播预约弹窗
    FOR    ${i}   IN RANGE    2
        ${statuslive}     run keyword and return status     wait until page contains    直播预约     1
        run keyword if      ${statuslive}==True     Run Keywords    按次数右移  1    AND     确认键
    END
    等待  5

点击小窗播放器
    [Documentation]  点击直播频道中的小窗播放器
    点击元素  ${直播小窗播放器}
    wait until page contains element  ${直播播放器}

点击直播预约
    [Documentation]  点击预约直播节目
    [Arguments]  ${time}
    wait until page contains element    xpath=//*[@resource-id="com.hunantv.operator:id/play_back_playbill_item_content" and contains(@content-desc,'${time}')]  5
    click element   xpath=//*[@resource-id="com.hunantv.operator:id/play_back_playbill_item_content" and contains(@content-desc,'${time}')]
    wait until page contains element    com.hunantv.operator:id/positive_btn    10
    click element   com.hunantv.operator:id/positive_btn

直播播放进回看播放
    [Documentation]  直播播放进回看播放
    直播呼出浮层
    按次数右移  2    2
    按次数上移  1
    确认键
    等待  5

计算直播时移时间
    [Documentation]  计算直播时移时间(min)
    [Arguments]  ${time}    ${error}=2
    ${begintime}=   Wait Until Keyword Succeeds  20s  3s  获取直播时间  ${时移开始时间}
    ${endtime}=  Wait Until Keyword Succeeds  20s  3s  获取直播时间  ${时移结束时间}
    ${time_computing}     computing time  ${begintime}    ${endtime}  M
    ${new_num}    evaluate  abs(int(${time_computing})-int(${time}))
    run keyword if  ${new_num}<=${error}   log to console  时间相等
    ...     ELSE    fail

计算当前直播时间
    [Documentation]  计算当前直播时间(min)
    [Arguments]  ${time}    ${error}=2
    ${begintime}=   Wait Until Keyword Succeeds  20s  3s  获取直播时间  ${直播当前时间}
    ${endtime}=  Wait Until Keyword Succeeds  20s  3s  获取直播时间  ${时移结束时间}
    ${time_computing}     computing time  ${begintime}    ${endtime}  M
    ${new_num}    evaluate  abs(int(${time_computing})-int(${time}))
    run keyword if  ${new_num}<=${error}   log to console  时间相等
    ...     ELSE    fail

获取直播时间
    [Documentation]  获取直播时间
    [Arguments]  ${element}
    向左  1
    ${page}  get source
    ${time}=    Run Keyword And Continue On Failure  get xml locator  ${page}  ${element}   content\-desc
    run keyword if  '${time}'==''   fail  未获取到时间
    ...  ELSE   log  获取到时间<${time}>
    RETURN  ${time}

校验焦点是否在文本兄弟节点上
    [Arguments]  ${text}
    ${locator}  set variable  //*[@text='${text}']/preceding-sibling::*
    ${focused}     get element attribute  ${locator}    focused
    should be true      '${focused}'=='true'

校验焦点是否在文本父节点上
    [Arguments]  ${text}
    ${locator}  set variable  //*[@text='${text}']/parent::*
    ${focused}     get element attribute  ${locator}    focused
    should be true      '${focused}'=='true'

校验焦点是否在文本爷爷节点上
    [Arguments]  ${text}
    ${locator}  set variable  //*[@text='${text}']/../..
    ${focused}     get element attribute  ${locator}    focused
    should be true      '${focused}'=='true'

校验焦点是否在文本祖父节点上
    [Arguments]  ${text}
    ${locator}  set variable  //*[@text='${text}']/../../..
    ${focused}     get element attribute  ${locator}    focused
    should be true      '${focused}'=='true'

校验焦点的子节点是否包含文本
    [Arguments]  ${text}    ${timeout}=1
    ${locator}   set variable  //*[@focused="true" and @focusable="true"]//*[@text='${text}']
    wait until page contains element  ${locator}  ${timeout}

直播切台
    [Arguments]  ${name}    ${count}=1
    ${locator}=  run keyword if  '${name}'=='下'  set variable   ${直播频道向下切换}  ELSE   set variable    ${直播频道向上切换}
    run keyword if  '${locator}'== '上'    按次数上移  ${count}  ELSE   按次数下移  ${count}

短视频播放暂停
    [Documentation]  短视频播放暂停
    FOR    ${i}   IN RANGE    3
        ${status0}     run keyword and return status     wait until page contains    OK键     2
        run keyword if  '${status0}'== 'True'    按次数返回  1
        确认键
        ${status}     run keyword and return status     wait until page contains    继续播放     2
        run keyword if      ${status}==True   exit for loop
    END

暂停恢复
    [Documentation]  直播或点播暂停后恢复
    ${statuslive}     run keyword and return status     wait until page contains    继续播放     2
    run keyword if      ${statuslive}==True     确认键  ELSE   暂停键

进入直播回看页面
    [Documentation]  进入直播回看页面
    [Arguments]  ${channel_id}=001
    数字键进直播  ${channel_id}
    等待页面出现元素信息  ${直播播放器}
    确认键   1
    向右   1
    确认键
    等待页面出现元素信息  ${回看列表回看节目}

进入昨天的直播回看播放页面
    [Documentation]  进入昨天的直播回看播放页面
    [Arguments]  ${channel_id}=001
    数字键进直播  ${channel_id}
    直播呼出浮层
    向右  1
    确认键
    等待页面出现文本信息  分段
    向上
    向右
    确认键
    等待页面出现元素信息  ${回看图标}

直播预约取消
    [Documentation]  取消已预约的直播节目
    确认键
    ${result}  run keyword and return status  wait until page contains  确认取消  2
    run keyword if  ${result}  确认键
    ...  ELSE  run keywords  向右  AND  确认键

所有直播预约取消
    [Documentation]  取消所有已预约的直播节目
    直播呼出浮层
    向左
    校验焦点是否在内容描述上  全部
    按次数上移  2
    向右  1
    FOR  ${i}  IN RANGE  5
        ${result}  run keyword and return status  wait until page contains  尚未预约节目  1
        run keyword if  not ${result}  run keywords  向下  AND  向右  AND  确认键  AND  确认键
        exit for loop if  ${result}
    END

直播时移
    [Documentation]  直播时移
    [Arguments]    ${name}  ${count}=1
    FOR    ${i}    IN RANGE    3
        run keyword if   '${name}'=='右'  按次数右移  ${count}   ELSE    按次数左移  ${count}
        ${statusValue}     run keyword and return status    wait until page contains element  ${直播当前时间}    1
        run keyword if  ${statusValue}==True    exit for loop
    END

直播推荐焦点移动_上
    [Documentation]  直播推荐焦点向上一个移动
    [Arguments]    ${count}=1
    run keyword if  'HNDX' not in '${project}'  按次数上移  ${count}
    run keyword if  'HNDX' in '${project}'  按次数左移  ${count}

直播推荐焦点移动_下
    [Documentation]  直播推荐焦点向下一个移动
    [Arguments]    ${count}=1
    run keyword if  'HNDX' not in '${project}'  按次数下移  ${count}
    run keyword if  'HNDX' in '${project}'  按次数右移  ${count}