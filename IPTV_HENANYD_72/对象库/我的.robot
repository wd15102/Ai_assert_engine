*** Settings ***
Documentation    我的页方法
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot



*** Keywords ***
到达观看历史全部记录入口
    [Documentation]  焦点移动到全部记录
    等待我的页出现
    按方向移动  下    2
    按方向移动  右    5

到达我的收藏全部记录入口
    [Documentation]  焦点移动到全部记录
    等待我的页出现
    按方向移动  下    1
    按方向移动  右    1
    按方向移动  下    1
    按方向移动  右    5

到达我的预约全部记录入口
    [Documentation]  焦点移动到全部记录
    等待我的页出现
    按方向移动  下    1
    按方向移动  右    2
    按方向移动  下    1
    按方向移动  右    5

到达我的播单入口
    [Documentation]  到达播单的全部播单
    等待我的页出现
    向下移动到元素  ${播单位置1}

显示服务和帮助
    [Documentation]  向下滑动显示服务和帮助通栏
#    按方向滑动  下    ${设置}
    按次数下移  4
    等待页面出现元素信息  ${设置}

返回到我的页
    [Documentation]  返回到我的页
    [Arguments]  ${element}=${版本信息}
    FOR    ${i}    IN RANGE   20
       ${status}     run keyword and return status    wait until page contains element    ${element}  3
       exit for loop if    ${status}
       Press keycode   4
       Press keycode   4
       ${status}     run keyword and return status    wait until page contains element    ${element}  3
       exit for loop if    ${status}
       返回键
    END

清空观看历史
    ${status}     run keyword and return status    wait until page contains element    ${全部删除}  3
    run keyword if  ${status}==True     Run Keywords    点击文本   全部删除
    ...     AND     点击文本  确定
    ...     ELSE    等待  2

会员卡激活输入
    [Documentation]  输入激活卡(0-F)
    [Arguments]  ${num}
    @{keycode_list}     evaluate  list('${num}')
    ${num_old}   evaluate    0
    FOR    ${keycode}  IN  @{keycode_list}
        ${keycode}  evaluate    int('${keycode}',16)
        ${row}  evaluate  ${keycode}%6-${num_old}%6
        ${column}  evaluate  ${keycode}//6-${num_old}//6
        ${column_old}   evaluate  ${num_old}//6
        run keyword if   ${row}>=0 and ${column_old}<2     按次数右移  ${row}
        ...  ELSE IF    ${row}<0 and ${column_old}<2    按次数左移  abs(${row})
        ...  ELSE   等待  1
        run keyword if   ${column}>=0 and ${column_old}<2   按次数下移  ${column}
        ...  ELSE IF    ${column}<0 and ${column_old}<2    按次数上移  abs(${column})
        ...  ELSE   等待  1
        run keyword if   ${column}>=0 and ${column_old}>=2   按次数下移  ${column}
        ...  ELSE IF    ${column}<0 and ${column_old}>=2    按次数上移  abs(${column})
        ...  ELSE   等待  1
        run keyword if   ${row}>=0 and ${column_old}>=2   按次数右移  ${row}
        ...  ELSE IF    ${row}<0 and ${column_old}>=2    按次数左移  abs(${row})
        ...  ELSE   等待  1
        确认键  1
        ${num_old}  evaluate    '${keycode}'
    END
    等待  5

到达设置页面内容
    [Documentation]  到达设置页面内容
    [Arguments]  ${text}
    FOR    ${i}    IN RANGE   15
        ${status}     run keyword and return status    wait until page contains  ${text}  1
        run keyword if  '${status}'=='True'   exit for loop
        ...     ELSE    按次数下移  1    0
    END
    FOR    ${i}    IN RANGE   15
        ${status}     run keyword and return status    wait until page contains  ${text}  1
        run keyword if  '${status}'=='True'   exit for loop
        ...     ELSE    按次数上移  1    0
    END
    FOR    ${i}    IN RANGE   10
       ${locator}  set variable  //*[@text='${text}']/parent::*
       ${focused}     get element attribute  ${locator}    focused
       run keyword if  '${focused}'=='true'   exit for loop
       ...     ELSE    按次数下移  1  0
    END
    FOR    ${i}    IN RANGE   10
       ${locator}  set variable  //*[@text='${text}']/parent::*
       ${focused}     get element attribute  ${locator}    focused
       run keyword if  '${focused}'=='true'   exit for loop
       ...     ELSE    按次数上移  1  0
    END
    ${locator}  set variable  //*[@text='${text}']/parent::*
    ${focused}     get element attribute  ${locator}    focused
    run keyword if  '${focused}'=='true'    log to console  到达设置页面内容
    ...     ELSE    log to console  无此内容

删除全部播单
    [Documentation]  清除全部记录信息
    ${status1}  run keyword and return status  wait until page contains  我的播单
    ${status2}  run keyword and return status  wait until page contains  您还没有添加过播单
    run keyword if  ${status1} and not ${status2}  点击文本  删除
    FOR  ${i}  IN RANGE  10
        exit for loop if  not ${status1} and ${status2}
        ${status3}     run keyword and return status    wait until page contains element    ${播单删除标识}  2
        run keyword if  ${status3}  run keywords  点击元素  ${播单删除标识}  AND  确认键  ELSE  exit for loop
    END

屏保设置
    [Documentation]  屏保设置为1分钟
    [Arguments]  ${num}=1
    ${text}  set variable   ${num}分钟
    到达我的页面入口
    确认键
    等待我的页出现
    按键直到焦点位于内容描述上  设置   下
    确认键
    等待文本出现  设置
    到达设置页面内容    屏幕保护
    按键直到出现文本信息  ${text}  左