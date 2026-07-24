*** Settings ***
Documentation    首页方法
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot
Resource   ../../系统方法.robot

*** Keywords ***
启动叮铃小屏浏览器
    [Documentation]    小屏端启用应用程序
    Open Application    http://${appium_server}/wd/hub    deviceName=${device_id}    platformName=Android    platformVersion=${platform_version}
        ...    appPackage=${appPackage}    appActivity=${appActivity}   automationName=${automationName}  unicodeKeyboard=true  noReset=true
    等待元素出现  ${浏览器窗口}

点击解除绑定答案
    [Arguments]  ${error}=0
    等待元素出现  ${叮铃数字一}
    ${num1}  get text  ${叮铃数字一}
    ${num2}  get text  ${叮铃数字二}
    ${symbol}   get text  ${叮铃计算符}
    ${symbol}  set variable if  '${symbol}'=='+'   +    ${symbol}
    ${symbol}  set variable if  '${symbol}'=='－'   -    ${symbol}
    ${symbol}  set variable if  '${symbol}'=='×'   *    ${symbol}
    ${symbol}  set variable if  '${symbol}'=='÷'   /    ${symbol}
    ${result}   evaluate  str(int(${num1}${symbol}${num2}))
#    log to console  ${num1}${symbol}${num2}=${result}
    @{result_list}  evaluate  list('${result}')
    FOR  ${i}  IN  @{result_list}
        run keyword if  '${error}'=='0'  点击计算正确答案  ${i}  ELSE   点击计算错误答案    ${i}
    END

点击计算正确答案
    [Arguments]  ${num}
    按次数左移  4
    FOR  ${i}   IN RANGE    4
        ${text}  get element attribute  ${当前焦点}  text
        run keyword if  '${text}'=='${num}'   exit for loop
        ...     ELSE    按次数右移  1
    END
    ${text}  get element attribute  ${当前焦点}  text
    run keyword if  '${text}'=='${num}'     确认键
    ...     ELSE    log to console  无此答案

点击计算错误答案
    [Arguments]  ${num}
    FOR  ${i}   IN RANGE    4
        ${text}  get element attribute  ${当前焦点}  text
        run keyword if  '${text}'!='${num}'   exit for loop
        ...     ELSE    按次数右移  1
    END
    ${text}  get element attribute  ${当前焦点}  text
    run keyword if  '${text}'!='${num}'     Run Keywords    确认键     AND     exit for loop
    ...     ELSE    log to console  无此答案

登录MGTV账号
    [Documentation]  登录MGTV账号
    点击文本  家长守护
    ${statusValue}     run keyword and return status    wait until page contains    账号密码登录  5
    run keyword if    ${statusValue}==True      Run Keywords   点击文本  账号密码登录
    ...  AND    input text  ${叮铃账号输入框}  19873060034
    ...  AND    input text  ${叮铃密码输入框}  mgtv_iptv
    ...  AND    点击文本  同意
    ...  AND    点击文本  登录
    ...  AND    等待  5
    ...  ELSE   log to console  已登录账号
#    点击文本  首页

按次数向下滑动
    [Documentation]  按次数向下滑动
    [Arguments]  ${num}
    FOR    ${i}   IN RANGE    ${num}
           Swipe By Percent     50     50    50     40     1000
    END

按次数向上滑动
    [Documentation]  按次数向下滑动
    [Arguments]  ${num}
    FOR    ${i}   IN RANGE    ${num}
           Swipe By Percent     50     50    50     60     1000
    END

向下滚动
    [Documentation]  向下滚动
    [Arguments]  ${startlocator}  ${endlocator}
    scroll  ${startlocator}  ${endlocator}