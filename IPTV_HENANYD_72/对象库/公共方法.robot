*** Settings ***
Documentation    公共方法
Library     AppiumLibrary
Library     TestLibrary
Library     Collections
Library     ../../../DP_AutoTest/TestLibrary/android_common.py
Library    ../../../DP_AutoTest/TestLibrary/GetLogcat.py
Variables  ../../IPTV_HENANYD_72/config.py
Variables  ../../IPTV_HENANYD_72/element.py
Variables  ../../IPTV_HENANYD_72/mock.py
Resource   ../../IPTV_HENANYD_72/遥控按键.robot
Resource   ../../IPTV_HENANYD_72/系统方法.robot
Resource   ../../IPTV_HENANYD_72/对象库/等待相关.robot
Resource   ../../IPTV_HENANYD_72/对象库/首页.robot
Resource   ../../IPTV_HENANYD_72/对象库/直播回看时移.robot
Resource   ../../IPTV_HENANYD_72/对象库/专项测试.robot
Resource   ../../IPTV_HENANYD_72/对象库/我的.robot

*** Keywords ***
启动应用
    [Documentation]    盒端启用应用程序
    register keyword to run on failure  Nothing
    run keyword if  ${reconnet}==1  重新连接设备
    解除网络限速
    FOR    ${i}   IN RANGE    3
        清除历史上报数据
        清除设备缓存
        等待   15
        Open Application    http://${appium_server}/wd/hub    deviceName=${device_id}    platformName=Android    platformVersion=${platform_version}
        ...    appPackage=${appPackage}   noReset=true appActivity=${appActivity} appWaitActivity=${appActivity}  newCommandTimeout=1200  automationName=${automationName}  unicodeKeyboard=false  resetKeyboard=false  noReset=${noReset}
        run keyword if  ${zhengqi_apk}!=0    home键
        Home键
        等待   15
        Home键
        run keyword if  ${zhengqi_apk}!=0    从政企进入首页
        检查是否进入首页并关闭广告
        ${statusValue1}  run keyword and return status   等待页面出现内容描述信息  少儿频道   1
        ${statusValue2}  run keyword and return status   等待页面出现内容描述信息  电竞   1
        ${statusValue3}  run keyword and return status   等待页面出现内容描述信息  二级菜单   1
        run keyword if  ${statusValue1}==True and ${statusValue2}==True and ${statusValue3}==True  exit for loop
        ...  ELSE   Run Keywords    log to console  启动异常，重新启动   AND  设置本地映射  enable  AND    退出应用
    END

启动现网环境
    [Documentation]    盒端启用应用程序
    register keyword to run on failure  Nothing
    run keyword if  ${reconnet}==1  重新连接设备
    解除网络限速
    FOR    ${i}   IN RANGE    3
        清除历史上报数据
        清除设备缓存
        Open Application    http://${appium_server}/wd/hub    deviceName=${device_id}    platformName=Android    platformVersion=${platform_version}
        ...    appPackage=${appPackage}    appActivity=${appActivity}   newCommandTimeout=1200  automationName=UiAutomator1  unicodeKeyboard=true   noReset=${noReset}
        run keyword if  ${zhengqi_apk}!=0    从政企进入首页
        检查是否进入首页并关闭广告
        按次数返回  1
        ${statusValue1}  run keyword and return status   等待页面出现内容描述信息_模糊匹配  看电视   1
        ${statusValue2}  run keyword and return status   等待页面出现内容描述信息_模糊匹配  刷一刷   1
        ${statusValue3}  run keyword and return status   等待页面出现内容描述信息_模糊匹配  免费专区   1
        ${statusValue4}  run keyword and return status   等待元素出现  ${直播播放器}   1
        run keyword if  ${statusValue4}==True   exit for loop
        run keyword if  ${statusValue1}==True and ${statusValue2}==True and ${statusValue3}==True  exit for loop
        ...  ELSE   Run Keywords    log to console  启动异常，重新启动  AND    退出应用
    END

从政企进入首页
    FOR    ${i}   IN RANGE    20
            ${statusValue}  run keyword and return status   wait until page contains element    ${咪咕政企}    2
            exit for loop if  ${statusValue}
            go back
    END
    菜单键
    确认键

检查是否进入首页并关闭广告
    Run Keyword And Ignore Error  等待文本出现  预约节目上线提醒
    FOR    ${i}   IN RANGE    5
            ${statusValue1}  run keyword and return status   wait until page contains   预约节目上线提醒    2
            exit for loop if  ${statusValue1}==False
            按次数返回  1    0
    END
    FOR    ${i}   IN RANGE    20
            ${statusValue}  run keyword and return status   wait until page contains element    ${首页logo}    2
            exit for loop if  ${statusValue}
            run keyword if  ${plugin_apk}!=0  等待  10
            go back
    END
    run keyword if  ${plugin_apk}!=0 or ${hotup_apk}!=0    判断是否在其他模式下
    ${statusValue1}  run keyword and return status   wait until page contains   按返回关闭广告    2
    run keyword if  ${statusValue1}  返回键
    ${statusValue2}  run keyword and return status   wait until page contains   关闭    2
    run keyword if  ${statusValue2}  返回键

判断是否在其他模式下
    按返回键直到出现模式判断信息
    ${status1}  run keyword and return status   wait until page contains element    ${少儿首页}    2
    ${status2}  run keyword and return status   wait until page contains element    ${简约直播小窗播放器}    2
    run keyword if  ${status1}==True    少儿模式切换时尚模式
    run keyword if  ${status2}==True    简约模式切换时尚模式

按返回键直到出现模式判断信息
    FOR    ${i}    IN RANGE   5
        ${status1}     run keyword and return status  wait until page contains element  ${少儿首页}   2
        ${status2}     run keyword and return status  wait until page contains element  ${简约直播小窗播放器}   2
        ${status3}     run keyword and return status  wait until page contains element  ${免费电影}   2
        Run Keyword If  '${status1}'=='True' or '${status2}'=='True' or '${status3}'=='True'    exit for loop
        ...     ELSE    按次数返回  1
    END
    log to console  已返回模式首页

退出应用
    [Documentation]  盒端退出应用程序
    解除网络限速
    ${status_value}  run keyword and return status   Close Application
    run keyword if  ${status_value}  log  应用关闭成功
    ...     ELSE    log  应用关闭失败

重新连接设备
    [Documentation]  重新连接设备
    ${adb_clear_log}    set variable  adb logcat -c
    ${adb_clear_arp}   set variable  adb shell "arp -n|awk '/^[1-9]/{system(\"arp -d \"$1)}'"
    ${adb_exit}  set variable  adb disconnect
    ${adb_connect}  set variable  adb connect ${device_id}
    ${adb_status}  set variable   adb devices
    ${info0}    cmd command  ${adb_clear_arp}
    ${info1}    cmd command  ${adb_clear_log}
    ${info2}    cmd command  ${adb_exit}
    等待  3
    ${info3}    cmd command  ${adb_connect}
    等待  3

清除设备缓存
    [Documentation]  清除设备缓存
    ${adb_clear_sync}    set variable  adb shell sync
    ${adb_clear_cache}   set variable  adb shell "echo 3 > /proc/sys/vm/drop_caches"
    ${adb_pm_clear}  set variable  adb shell pm clear ${app_package}
    ${info0}    cmd command  ${adb_clear_sync}
    ${info1}    cmd command  ${adb_clear_cache}
    ${info2}=    run keyword if  ${plugin_apk}==0 and ${hotup_apk}==0  cmd command  ${adb_pm_clear}  ELSE   log to console  不清空缓存
    run keyword if  ${plugin_apk}==0 and ${hotup_apk}==0   log to console   清空应用缓存
    run keyword if  ${force_reboot}!=0   强制重启应用   ELSE   log to console  不强制重启应用

强制重启应用
    [Documentation]  强制重启应用
    ${adb_pkill}    set variable  adb shell pkill ${app_package}
    ${info0}    cmd command  ${adb_pkill}
    等待  10
    log to console  已强制重启应用

杀进程重启应用
    [Documentation]  杀进程重启应用
    ${adb_pkill}    set variable  adb shell am force-stop ${app_package}
    ${info0}    cmd command  ${adb_pkill}
    home键
    等待  10
    log to console  已强制重启应用

等待出现校验结果_不校验数量
    [Documentation]  等待校验结果_不校验数量
    [Arguments]    ${field}    ${test_point}    ${field_table}  ${act_count}=1
    FOR    ${i}   IN RANGE    60
        ${result}    Check Result    ${field}    ${platform}    ${test_point}    ${field_table}    ${act_count}    ${TESTNAME}
        run keyword if   ${result['count'][0]}==0   sleep   2   ELSE    exit for loop
    END
    FOR    ${i}   IN RANGE    2
        ${result}    Check Result    ${field}    ${platform}    ${test_point}    ${field_table}    ${act_count}    ${TESTNAME}
        run keyword if   ${result['count'][0]}==0   Run Keywords   解除网络限速   AND  sleep  10  ELSE  exit for loop
    END
    ${error1}=   run keyword if  ${result['count'][0]}!=1    set variable  条数错误：${result['count'][1]}  ELSE   set variable   ${EMPTY}
    ${error2}=   run keyword if  ${result['field'][0]}!=1    set variable  字段错误：${result['field'][1]}  ELSE   set variable   ${EMPTY}
    ${error3}=   run keyword if  ${result['errdata'][0]}!=1  set variable  字段值错误：${result['errdata'][1]}  ELSE   set variable   ${EMPTY}
    ${error4}=   run keyword if  ${result['math'][0]}!=1  set variable  请求方式错误：${result['math'][1]}  ELSE   set variable   ${EMPTY}
    ${error}   catenate  SEPARATOR=   ${error1}    ${error2}    ${error3}   ${error4}
    run keyword if  ${result['field'][0]}!=1 or ${result['errdata'][0]}!=1 or ${result['math'][0]}!=1  fail  ${error}

返回首页
    [Documentation]  返回到APP首,失败的情况才返回到精选
    run keyword if  ${zhengqi_apk}!=0    Run Keywords   菜单键     AND     确认键
    FOR    ${i}   IN RANGE    5
        ${statusValue}     run keyword and return status    wait until page contains element    ${首页logo}  3
        run keyword if    ${statusValue}   exit for loop
        ...     ELSE    返回键
    END
    等待  5
    ${statusValue1}     run keyword and return status    wait until page contains element    ${首页logo}  3
    run keyword if    ${statusValue1}==False      Run Keywords    菜单键
    ...     AND     确认键
    ...     AND     返回精选页
    ...     ELSE    log to console  已返回首页
    循环判断顶部图片是否消失

返回精选页
    run keyword if  ${zhengqi_apk}==0    home键
    FOR    ${i}   IN RANGE    5
       ${text}  run keyword and return status  wait until page contains 精选
       exit for loop if   '${text}'=='精选'
       返回键
    END

返回沉浸模式默认分屏
    run keyword if  ${zhengqi_apk}==0    home键
    FOR    ${i}   IN RANGE    5
       ${text}  run keyword and return status  wait until page contains 精选
       exit for loop if   '${text}'=='精选'
       返回键
    END

获取WEB校验结果
    [Documentation]  获取上报数据的校验结果
    [Arguments]    ${field}    ${test_point}    ${field_table}    ${act_count}
    sleep  3
    ${result}    Check Result    ${field}    ${webplatform}    ${test_point}    ${field_table}    ${act_count}    ${TESTNAME}
    run keyword if  ${result['count'][0]}!=1    log     条数错误：${result['count'][1]}  error
    ...     ELSE    log     条数正确
    run keyword if  ${result['field'][0]}!=1    log     字段错误：${result['field'][1]}  error
    ...     ELSE    log     字段正确
    run keyword if  ${result['errdata'][0]}!=1    log     字段值错误：${result['errdata'][1]}  error
    ...     ELSE    log     字段值正确
#    run keyword if  (${result['count'][0]}==1 and ${result['field'][0]}==1 and ${result['errdata'][0]})==0   capture page screenshot  ${TESTNAME}.png
    should be true  (${result['count'][0]}==1 and ${result['field'][0]}==1 and ${result['errdata'][0]})==1        上报数据校验失败

清除历史上报数据
    [Documentation]  清除历史上报的数据
    Delete Data    ${platform}

清除WEB历史上报数据
    [Documentation]  清除历史上报的数据
    Delete Data    ${webplatform}

按次数返回
    [Arguments]    ${num}   ${sec}=2
    FOR    ${i}    IN RANGE   ${num}
       返回键  ${sec}
    END

按次数确认
    [Arguments]    ${num}   ${sec}=2
    FOR    ${i}    IN RANGE   ${num}
       确认键  ${sec}
    END

按返回直到出现元素
    [Arguments]    ${name}  ${sec}=1
    FOR    ${i}    IN RANGE   20
       ${status}     run keyword and return status    wait until page contains element    ${name}  ${sec}
       exit for loop if    ${status}
       按次数返回  1
    END
    等待  2

按返回直到出现内容
    [Arguments]    ${name}
    ${locator}  set variable  //*[@content-desc='${name}']
    FOR    ${i}    IN RANGE   20
       ${status}     run keyword and return status    wait until page contains element    ${locator}  1
       exit for loop if    ${status}
       按次数返回  1   3
    END

按返回直到出现文本
    [Arguments]    ${text}
    FOR    ${i}    IN RANGE   20
       ${status}     run keyword and return status    wait until page contains    ${text}  3
       exit for loop if    ${status}
       按次数返回  1
    END

按返回直到不出现元素
    [Arguments]    ${name}
    FOR    ${i}    IN RANGE   20
       ${status}     run keyword and return status    wait until page contains element    ${name}  3
       exit for loop if    ${status}==False
       按次数返回  1
    END

按返回直到焦点位于元素
    [Arguments]    ${name}
    FOR    ${i}    IN RANGE   20
        ${status}     run keyword and return status    wait until page contains element    ${name}  3
        ${focused}=  run keyword if  ${status}==True   get element attribute  ${name}    focused    ELSE    set variable    false
        run keyword if  '${focused}'=='true'    exit for loop   ELSE    按次数返回  1
    END

按返回直到焦点位于内容
    [Arguments]    ${name}
    ${locator}  set variable  //*[@focused="true" and @focusable="true" and @content-desc='${name}']
    FOR    ${i}    IN RANGE   20
       ${status}     run keyword and return status    wait until page contains element    ${locator}  3
       exit for loop if    ${status}
       按次数返回  1
    END

按返回直到焦点位于文本
    [Arguments]    ${name}
    ${locator}  set variable  //*[@focused="true" and @focusable="true" and @text='${name}']
    FOR    ${i}    IN RANGE   20
       ${status}     run keyword and return status    wait until page contains element    ${locator}  3
       exit for loop if    ${status}
       按次数返回  1
    END

按返回直到焦点位于文本父节点
    [Arguments]    ${name}
    ${locator}  set variable  //*[@focused="true" and @focusable="true"]/*[@text='${name}']
    FOR    ${i}    IN RANGE   20
       ${status}     run keyword and return status    wait until page contains element    ${locator}  3
       exit for loop if    ${status}
       按次数返回  1
    END

按返回直到焦点为指定id
    [Arguments]    ${id}
    ${locator}  set variable  //*[@focused="true" and @focusable="true" and @resource-id='${id}']
    FOR    ${i}    IN RANGE   20
       ${status}     run keyword and return status    wait until page contains element    ${locator}  3
       ${focused}=  run keyword if  ${status}==True  get element attribute  ${locator}    focused   ELSE    set variable    false
       exit for loop if    '${focused}'=='true'
       按次数返回  1
    END

按键直到焦点位于文本上
    [Arguments]    ${name}  ${text}=返回   ${time}=1
    ${locator}  set variable  //*[@text='${name}']
    FOR    ${i}    IN RANGE   50
       ${status}     run keyword and return status    wait until page contains element    ${locator}  ${time}
       ${focused}=  run keyword if  ${status}==True  get element attribute  ${locator}    focused   ELSE    set variable    false
       exit for loop if    '${focused}'=='true'
       run keyword if   '${text}'=='上'    向上  ${time}
       ...  ELSE IF   '${text}'=='下'  向下  ${time}
       ...  ELSE IF   '${text}'=='左'  向左  ${time}
       ...  ELSE IF   '${text}'=='右'  向右  ${time}
       ...  ELSE IF   '${text}'=='确认'  确认键  2
       ...  ELSE    返回键  2
    END

按键直到焦点位于文本父节点
    [Arguments]    ${name}  ${text}=返回  ${time}=1
    ${locator}  set variable  //*[@focused="true" and @focusable="true"]/*[@text='${name}']
    FOR    ${i}    IN RANGE   50
       ${status}     run keyword and return status    wait until page contains element    ${locator}  ${time}
#       ${focused}=  run keyword if  ${status}==True  get element attribute  ${locator}    focused   ELSE    set variable    false
       exit for loop if    ${status}
       run keyword if   '${text}'=='上'    向上  ${time}
       ...  ELSE IF   '${text}'=='下'  向下  ${time}
       ...  ELSE IF   '${text}'=='左'  向左  ${time}
       ...  ELSE IF   '${text}'=='右'  向右  ${time}
       ...  ELSE IF   '${text}'=='确认'  确认键  2
       ...  ELSE    返回键  2
    END

按键直到焦点位于文本爷爷节点
    [Arguments]    ${name}  ${text}=返回  ${time}=1
    ${locator}  set variable  //*[@text='${name}']/../..
    FOR    ${i}    IN RANGE   50
       ${status}     run keyword and return status    wait until page contains element    ${locator}  ${time}
       ${focused}=  run keyword if  ${status}==True  get element attribute  ${locator}    focused   ELSE    set variable    false
       exit for loop if    '${focused}'=='true'
       run keyword if   '${text}'=='上'    向上  ${time}
       ...  ELSE IF   '${text}'=='下'  向下  ${time}
       ...  ELSE IF   '${text}'=='左'  向左  ${time}
       ...  ELSE IF   '${text}'=='右'  向右  ${time}
       ...  ELSE IF   '${text}'=='确认'  确认键  2
       ...  ELSE    返回键  2
    END

按键直到焦点位于内容描述上
    [Arguments]    ${name}  ${text}=返回   ${time}=1
    ${locator}  set variable  //*[@focused="true" and @focusable="true" and @content-desc='${name}']
    FOR    ${i}    IN RANGE   50
       ${status}     run keyword and return status    wait until page contains element    ${locator}  ${time}
#       ${focused}=  run keyword if  ${status}==True  get element attribute  ${locator}    focused   ELSE    set variable    false
       exit for loop if    ${status}
       run keyword if   '${text}'=='上'    向上  ${time}
       ...  ELSE IF   '${text}'=='下'  向下  ${time}
       ...  ELSE IF   '${text}'=='左'  向左  ${time}
       ...  ELSE IF   '${text}'=='右'  向右  ${time}
       ...  ELSE IF   '${text}'=='确认'  确认键  2
       ...  ELSE    返回键  2
    END

按键直到焦点位于内容描述上_模糊匹配
    [Arguments]    ${name}  ${text}=返回   ${time}=1
    ${locator}  set variable  //*[contains(@content-desc,'${name}') and @focused="true" and @focusable="true"]
    FOR    ${i}    IN RANGE   50
       ${status}     run keyword and return status    wait until page contains element    ${locator}  ${time}
#       ${focused}=  run keyword if  ${status}==True  get element attribute  ${locator}    focused   ELSE    set variable    false
       exit for loop if    ${status}
       run keyword if   '${text}'=='上'    向上  ${time}
       ...  ELSE IF   '${text}'=='下'  向下  ${time}
       ...  ELSE IF   '${text}'=='左'  向左  ${time}
       ...  ELSE IF   '${text}'=='右'  向右  ${time}
       ...  ELSE IF   '${text}'=='确认'  确认键  2
       ...  ELSE    返回键  2
    END

按键直到出现文本信息
    [Arguments]    ${name}  ${text}=返回  ${time}=1
    ${locator}  set variable  //*[contains(@text,'${name}')]
    FOR    ${i}    IN RANGE   50
       ${status}     run keyword and return status    wait until page contains element  ${locator}  ${time}
       exit for loop if    ${status}
       run keyword if   '${text}'=='上'    向上  ${time}
       ...  ELSE IF   '${text}'=='下'  向下  ${time}
       ...  ELSE IF   '${text}'=='左'  向左  ${time}
       ...  ELSE IF   '${text}'=='右'  向右  ${time}
       ...  ELSE IF   '${text}'=='确认'  确认键  2
       ...  ELSE    返回键  2
    END

按键直到出现内容描述
    [Arguments]    ${name}  ${text}=返回  ${time}=1
    ${locator}  set variable  //*[contains(@content-desc,'${name}')]
    FOR    ${i}    IN RANGE   50
       ${status}     run keyword and return status    wait until page contains element  ${locator}  ${time}
       exit for loop if    ${status}
       run keyword if   '${text}'=='上'    向上  ${time}
       ...  ELSE IF   '${text}'=='下'  向下  ${time}
       ...  ELSE IF   '${text}'=='左'  向左  ${time}
       ...  ELSE IF   '${text}'=='右'  向右  ${time}
       ...  ELSE IF   '${text}'=='确认'  确认键  2
       ...  ELSE    返回键  2
    END

按键直到焦点位于元素上
    [Arguments]    ${locator}  ${text}=返回   ${time}=1
    FOR    ${i}    IN RANGE   50
       ${status}     run keyword and return status    wait until page contains element    ${locator}  ${time}
       ${focused}=  run keyword if  ${status}==True  get element attribute  ${locator}    focused   ELSE    set variable    false
       exit for loop if    '${focused}'=='true'
       run keyword if   '${text}'=='上'    向上  ${time}
       ...  ELSE IF   '${text}'=='下'  向下  ${time}
       ...  ELSE IF   '${text}'=='左'  向左  ${time}
       ...  ELSE IF   '${text}'=='右'  向右  ${time}
       ...  ELSE IF   '${text}'=='确认'  确认键  2
       ...  ELSE    返回键  2
    END

按键直到出现元素信息
    [Arguments]    ${locator}  ${text}=返回  ${time}=1
    FOR    ${i}    IN RANGE   50
       ${status}     run keyword and return status    wait until page contains element  ${locator}  ${time}
       exit for loop if    ${status}
       run keyword if   '${text}'=='上'    向上  ${time}
       ...  ELSE IF   '${text}'=='下'  向下  ${time}
       ...  ELSE IF   '${text}'=='左'  向左  ${time}
       ...  ELSE IF   '${text}'=='右'  向右  ${time}
       ...  ELSE IF   '${text}'=='确认'  确认键  2
       ...  ELSE    返回键  2
    END

等待
    [Arguments]    ${sec}
    sleep  ${sec}
    Log To Console    等待${sec}秒

点击元素
    [Documentation]  等待元素出现后，再进行点击
    [Arguments]  ${locator}  ${count}=1
    wait until page contains element  ${locator}   20
    FOR    ${i}    IN RANGE  ${count}
        click element  ${locator}
        sleep  1
    END

双击元素
    [Documentation]  等待元素出现后，再进行点击
    [Arguments]  ${locator}
    wait until page contains element  ${locator}   20
    tap  ${locator}     None    None    2

点击进入元素
    [Documentation]  等待元素出现后，再进行点击，并跳转成功
    [Arguments]  ${locator}  ${count}=1
    wait until page contains element  ${locator}   20
    click element  ${locator}
    等待  2
    ${status}     run keyword and return status    wait until page contains element  ${locator}   1
    run keyword if    '${status}'=='True'    click element  ${locator}
    ...     ELSE    log  进入元素成功

首页进入详情页
    [Documentation]  首页进入详情页
    ${status}     run keyword and return status    wait until page contains   关闭提醒    5
    run keyword if    '${status}'=='True'    按次数确认  2
    ...     ELSE    按次数确认  1

点击文本
    [Documentation]  等待文本出现后，再进行点击
    [Arguments]  ${text}
    wait until page contains  ${text}   20
    click text  ${text}     True

点击文本_模糊匹配
    [Documentation]  等待文本出现后，再进行点击
    [Arguments]  ${text}
    ${locator}  set variable  //*[contains(@text,"${text}")]
    wait until page contains element  ${locator}  20
    click element  ${locator}

点击内容描述
    [Documentation]  等待content-desc出现后，再进行点击
    [Arguments]  ${content-desc}
    wait until page contains element  accessibility_id=${content-desc}   20
    click element  accessibility_id=${content-desc}

点击内容描述_模糊匹配
    [Documentation]  等待content-desc出现后，再进行点击
    [Arguments]  ${content-desc}
    ${locator}  set variable  //*[contains(@content-desc,'${content-desc}')]
    wait until page contains element  ${locator}   20
    click element  ${locator}

点击进入内容描述
    [Documentation]  等待content-desc出现后，再进行点击
    [Arguments]  ${content-desc}
    wait until page contains element  accessibility_id=${content-desc}   20
    click element  accessibility_id=${content-desc}
    等待  2
    ${status}     run keyword and return status    wait until page contains element  accessibility_id=${content-desc}   1
    run keyword if    '${status}'=='True'    click element  accessibility_id=${content-desc}
    ...     ELSE    log  进入内容描述成功

按秒快进
    [Documentation]  按秒进行快进
    [Arguments]  ${sec}
    forward  ${sec}
    等待  5

按秒快退
    [Documentation]  按秒进行快退
    [Arguments]  ${sec}
    back forward  ${sec}
    等待  3

设置键点击
    [Documentation]  点击设置键
    settings  0
    等待  2

数字键进直播
    [Documentation]  按数字键进入直播
    [Arguments]  ${num}  ${time}=8
    @{keycode_list}     evaluate  list('${num}')
    FOR    ${keycode}  IN  @{keycode_list}
       ${keycode}  evaluate  ${keycode}+7
       press keycode   ${keycode}
    END
    wait until page contains element  ${直播播放器}  20
    等待  ${time}

数字输入进入快捷指令
    [Documentation]  按数字键进入快捷指令
    [Arguments]  ${num}
    @{keycode_list}     evaluate  list('${num}')
    FOR    ${keycode}  IN  @{keycode_list}
       ${keycode}  evaluate  ${keycode}+7
       press keycode   ${keycode}
    END
    等待  3

输入数字
    [Documentation]  输入数字
    [Arguments]  ${num}  ${time}=3
    @{keycode_list}     evaluate  list('${num}')
    FOR    ${keycode}  IN  @{keycode_list}
       ${keycode}  evaluate  ${keycode}+7
       press keycode   ${keycode}
    END
    等待  ${time}

播放退出
    [Documentation]  直播、点播、回看播放退出
#    FOR    ${i}   IN RANGE    5
#        ${statusexit}     run keyword and return status    wait until page contains element    ${退出}  3
#        run keyword if    ${statusexit}==True     Run Keywords
#        ...     等待  2
#        ...     AND     确认键
#        ...     AND     exit for loop
#        ...     ELSE    按次数返回  1
#    END
    等待  10
    FOR    ${i}   IN RANGE    3
        ${statusexit}     run keyword and return status    wait until page contains element    ${推荐图}  1
        run keyword if    ${statusexit}==True     按次数返回   1  ELSE   exit for loop
    END
    FOR    ${i}   IN RANGE    3
        ${statusexit}     run keyword and return status    wait until page contains element    ${点播打点推荐}  1
        run keyword if    ${statusexit}==True     按次数返回   1  ELSE   exit for loop
    END
    按次数返回   1
    等待  2

详情页退出
    [Documentation]  点播退出
    按次数返回   1    2
    FOR    ${i}   IN RANGE    3
        ${statusexit}     run keyword and return status    wait until page contains element    ${详情页退出挽留}  1
        run keyword if    ${statusexit}==True     按次数返回   1  ELSE   exit for loop
    END

按方向滑动
    [Documentation]  按方向进行滑动到元素出现
    [Arguments]  ${direction}   ${element}
    FOR    ${i}    IN RANGE    30
       run keyword if  '${direction}'=='上'     swipe by percent    50     50    50     80     200
       ...  ELSE IF    '${direction}'=='下'     swipe by percent    50     50    50     20     200
       ...  ELSE IF    '${direction}'=='左'     swipe by percent    50     50    80     50     200
       ...  ELSE IF    '${direction}'=='右'     swipe by percent    50     50    20     50     200
       ${status}   run keyword and return status  wait until page contains element  ${element}  2
       exit for loop if  ${status}
    END

按方向移动
    [Documentation]  按给定方向和次数进行移动
    [Arguments]  ${direction}   ${num}
    FOR    ${i}    IN RANGE    ${num}
       run keyword if  '${direction}'=='上'     向上
       ...  ELSE IF    '${direction}'=='下'     向下
       ...  ELSE IF    '${direction}'=='左'     向左
       ...  ELSE IF    '${direction}'=='右'     向右
    END

向下滑动
    [Documentation]  向下滑动出现元素
    [Arguments]  ${name}
    FOR    ${i}   IN RANGE    30
           ${statusname}     run keyword and return status    wait until page contains element    ${name}  1
           run keyword if    ${statusname}==True     exit for loop
           ...     ELSE     Swipe By Percent     50     50    50     20     200
    END

向上滑动
    [Documentation]  向上滑动出现元素
    [Arguments]  ${name}
    FOR    ${i}   IN RANGE    30
           ${statusname}     run keyword and return status    wait until page contains element    ${name}  1
           run keyword if    ${statusname}==True     exit for loop
           ...     ELSE     Swipe By Percent     50     50    50     80     200
    END

向左滑动
    [Documentation]  向左滑动出现元素
    [Arguments]  ${name}
    FOR    ${i}   IN RANGE    30
           ${statusname}     run keyword and return status    wait until page contains element    ${name}  1
           run keyword if    ${statusname}==True     exit for loop
           ...     ELSE     Swipe By Percent     50     50    80     50     200
    END

向右滑动
    [Documentation]  向右滑动出现元素
    [Arguments]  ${name}
    FOR    ${i}   IN RANGE    30
           ${statusname}     run keyword and return status    wait until page contains element    ${name}  1
           run keyword if    ${statusname}==True     exit for loop
           ...     ELSE     Swipe By Percent     50     50    20     50     200
    END

按次数上移
    [Arguments]    ${num}   ${time}=1
    FOR    ${i}    IN RANGE   ${num}
       向上   ${time}
    END

按次数下移
    [Arguments]    ${num}   ${time}=1
    FOR    ${i}    IN RANGE   ${num}
       向下   ${time}
    END

按次数左移
    [Arguments]    ${num}   ${time}=1
    FOR    ${i}    IN RANGE   ${num}
       向左   ${time}
    END

按次数右移
    [Arguments]    ${num}   ${time}=1
    FOR    ${i}    IN RANGE   ${num}
       向右   ${time}
    END

等待1秒
    等待  1

设置本地映射
    [Documentation]  关闭或打开Charles本地映射
    [Arguments]  ${status}
    set charles  tools/map-remote/  ${status}
    set charles  tools/map-local/  ${status}
#    set charles  tools/rewrite/  ${status}

清除缓存
    [Documentation]  清除系统缓存并重启
    clear_cache     ${app_package}
    ${statusname}     run keyword and return status    wait until page contains element    ${首页logo}  10
    run keyword if    ${statusname}==False     点击文本  芒果TV
    等待  30

重新启动
    [Documentation]  重启APP
    Reset Application
#    Close Application
    ${statusname}     run keyword and return status    wait until page contains element    ${首页logo}  5
    run keyword if    ${statusname}==False     home键
    等待  30
    run keyword if  ${zhengqi_apk}!=0    从政企进入首页
    ${statusValue1}  run keyword and return status   wait until page contains   按返回关闭广告    5
    run keyword if  ${statusValue1}  返回键
    ${statusValue2}  run keyword and return status   wait until page contains   关闭    5
    run keyword if  ${statusValue2}  go back

获取元素属性
    [Documentation]  获取元素的属性
    [Arguments]  ${element}  ${attribute}
    wait until page contains element  ${element}    20
    ${result}  get element attribute  ${element}  ${attribute}
    RETURN  ${result}

用例失败截屏
    [Documentation]  截取当前屏幕的图像
    run keyword if test failed  capture page screenshot  ${TESTNAME}.png

设备截屏
    [Documentation]  存在异常截屏
    ${time}  get sys date   0   timestamp
    ${png}  catenate  SEPARATOR=   ${log_path}     \${time}.png
    capture page screenshot  ${png}

执行命令
    [Documentation]  cmd中执行命令
    [Arguments]  ${cmd}
    ${result}  adb shell command  ${cmd}
    RETURN  ${result}

激活接口
    [Arguments]  ${req_path}  ${mock_ids}=${empty}  ${locked_status}=0  ${request_type}=${empty}
    interface active  ${tag_id}  ${mock_ids}  ${req_path}  ${request_type}  ${locked_status}

向下移动到元素
    [Arguments]  ${element}
    FOR    ${i}    IN RANGE   20
       向下  0
       ${result}  run keyword and return status  wait until page contains element  ${element}  1
       exit for loop if  ${result}
    END

获取元素包含文本
    [Arguments]  ${xpath}
    ${result}  create list
    ${xpath}  catenate  SEPARATOR=  ${xpath}  /descendant-or-self::*
    ${elements}  get webelements  ${xpath}
    FOR  ${element}  IN  @{elements}
        ${text}  get text  ${element}
        append to list  ${result}  ${text}
    END
    RETURN  ${result}

校验元素中是否包含文本
    [Arguments]  ${xpath}  ${text}
    wait until page contains  ${text}
    ${result}  获取元素包含文本  ${xpath}
    校验参数是否包含  ${result}  ${text}

直播退出
    [Documentation]  直播回看播放退出
    FOR    ${i}   IN RANGE    5
        ${statusexit}     run keyword and return status    wait until page contains element    ${直播播放器}  5
        exit for loop if  not ${statusexit}
        返回键
    END

短视频列表选中内容
    [Documentation]  短视频列表选中内容
    [Arguments]  ${name}
    ${locator}  set variable  //*[@resource-id="${app_package1}:id/video_list_rv"]/android.view.View[@selected="true"]
    ${content_desc}  get element attribute  ${locator}  name
    should be equal  ${content_desc}   ${name}

获取当前页面数据
    [Documentation]  获取当前页面数据
    ${page}  get source
    log  ${page}
    RETURN  ${page}

校验内容描述出现次数_指定页面
    [Documentation]  校验内容描述出现次数_指定页面
    [Arguments]  ${page}    ${name}  ${count}
    ${element}  set variable  //*[@content-desc="${name}"]
    ${result}=  get xml locator count  ${page}   ${element}  content\-desc
    run keyword if  '${result}'=='0' and '${count}'=='0'    log  "${name}"内容描述不存在
    ...     ELSE    should be equal  '${result}'  '${count}'

校验文本出现次数_指定页面
    [Documentation]  校验文本出现次数_指定页面
    [Arguments]  ${page}    ${text}  ${count}
    ${element}  set variable  //*[@text="${text}"]
    ${result}=  get xml locator count  ${page}   ${element}  text
    run keyword if  '${result}'=='0' and '${count}'=='0'    log  "${text}"文本不存在
    ...     ELSE    should be equal  '${result}'  '${count}'

获取屏幕宽高
    [Documentation]  获取屏幕宽高
    ${width}    ${height}    get android screen resolution
    RETURN  ${width}  ${height}

校验坐标图片是否正确
    [Arguments]  ${x0}  ${y0}  ${x1}  ${y1}  ${name}  ${value}
    ${obj}  get library instance  AppiumLibrary
    ${img_bs64}  get screenshot as base64  ${obj}
    check image similarity  ${x0}  ${y0}  ${x1}  ${y1}  ${name}  ${value}  ${img_bs64}

校验元素图片是否正确
    [Arguments]  ${locator}  ${name}  ${value}=0.9
    wait until page contains element  ${locator}  20
    ${location}  get element location  ${locator}
    ${size}  get element size  ${locator}
    ${x0}  set variable  ${location}[x]
    ${y0}  set variable  ${location}[y]
    ${x1}  evaluate  ${x0}+${size}[width]
    ${y1}  evaluate  ${y0}+${size}[height]
    校验坐标图片是否正确  ${x0}  ${y0}  ${x1}  ${y1}  ${name}  ${value}

校验文本图片是否正确
    [Arguments]  ${text}  ${name}  ${value}=0.9
    ${locator}  set variable  //*[@text="${text}"]
    校验元素图片是否正确  ${locator}  ${name}  ${value}

校验内容描述图片是否正确
    [Arguments]  ${des}  ${name}  ${value}=0.9
    ${locator}  set variable  //*[@content-desc="${des}"]
    校验元素图片是否正确  ${locator}  ${name}  ${value}

校验坐标图片是否包含文字
    [Arguments]  ${x0}  ${y0}  ${x1}  ${y1}  ${text}  ${ratio}=1
    ${obj}  get library instance  AppiumLibrary
    ${img_bs64}  get screenshot as base64  ${obj}
    check_image_contain_text_new  ${img_bs64}  ${text}  ${x0}  ${y0}  ${x1}  ${y1}  ${ratio}

校验元素图片是否包含文字
    [Arguments]  ${locator}  ${text}  ${ratio}=1
    wait until page contains element  ${locator}  20
    ${location}  get element location  ${locator}
    ${size}  get element size  ${locator}
    ${x0}  set variable  ${location}[x]
    ${y0}  set variable  ${location}[y]
    ${x1}  evaluate  ${x0}+${size}[width]
    ${y1}  evaluate  ${y0}+${size}[height]
    校验坐标图片是否包含文字  ${x0}  ${y0}  ${x1}  ${y1}  ${text}  ${ratio}

校验元素图片是否不包含文字
    [Arguments]  ${locator}  ${text}
    校验元素图片是否包含文字  ${locator}  [!${text}]

校验内容描述图片是否包含文字
    [Arguments]  ${des}  ${text}  ${ratio}=1
    ${locator}  set variable  //*[@content-desc="${des}"]
    校验元素图片是否包含文字  ${locator}  ${text}  ${ratio}

校验内容描述图片是否不包含文字
    [Arguments]  ${des}  ${text}
    ${locator}  set variable  //*[@content-desc="${des}"]
    校验元素图片是否包含文字  ${locator}  [!${text}]

校验文本图片是否包含文字
    [Arguments]  ${des}  ${text}  ${ratio}=1
    ${locator}  set variable  //*[@text="${des}"]
    校验元素图片是否包含文字  ${locator}  ${text}  ${ratio}

校验文本图片是否不包含文字
    [Arguments]  ${des}  ${text}
    ${locator}  set variable  //*[@text="${des}"]
    校验元素图片是否包含文字  ${locator}  [!${text}]

校验当前页面图片是否包含文字
    [Arguments]  ${text}  ${ratio}=1
    ${obj}  get library instance  AppiumLibrary
    ${img_bs64}  get screenshot as base64  ${obj}
    check_image_contain_text_new  ${img_bs64}  ${text}  None  None  None  None  ${ratio}

校验当前页面图片是否不包含文字
    [Arguments]  ${text}
    校验当前页面图片是否包含文字  [!${text}]

校验坐标图片是否发生变化
    [Arguments]  ${x0}  ${y0}  ${x1}  ${y1}  ${time}  ${change}=True  ${value}=1
    ${obj}  get library instance  AppiumLibrary
    ${bs64_str1}  get screenshot as base64  ${obj}
    run keyword if  ${time}  等待  ${time}
    ${bs64_str2}  get screenshot as base64  ${obj}
    run keyword if  ${time}  等待  ${time}
    ${bs64_str3}  get screenshot as base64  ${obj}
    check image change  ${x0}  ${y0}  ${x1}  ${y1}   ${bs64_str1}  ${bs64_str2}  ${bs64_str3}  ${change}  ${value}

校验元素图片是否发生变化
    [Arguments]  ${locator}  ${change}=True  ${value}=1  ${time}=0
    wait until page contains element  ${locator}  20
    ${location}  get element location  ${locator}
    ${size}  get element size  ${locator}
    ${x0}  set variable  ${location}[x]
    ${y0}  set variable  ${location}[y]
    ${x1}  evaluate  ${x0}+${size}[width]
    ${y1}  evaluate  ${y0}+${size}[height]
    校验坐标图片是否发生变化  ${x0}  ${y0}  ${x1}  ${y1}  ${change}  ${value}  ${time}

校验元素图片是否不发生变化
    [Arguments]  ${locator}   ${value}=1
    校验元素图片是否发生变化  ${locator}  False  ${value}

校验文本图片是否发生变化
    [Arguments]  ${text}
    ${locator}  set variable  //*[@text="${text}"]
    校验元素图片是否发生变化  ${locator}

校验文本图片是否不发生变化
    [Arguments]  ${text}  ${value}=1
    ${locator}  set variable  //*[@text="${text}"]
    校验元素图片是否发生变化  ${locator}  False  ${value}

校验内容描述图片是否发生变化
    [Arguments]  ${des}
    ${locator}  set variable  //*[@content-desc="${des}"]
    校验元素图片是否发生变化  ${locator}

校验内容描述图片是否不发生变化
    [Arguments]  ${des}     ${value}=1
    ${locator}  set variable  //*[@content-desc="${des}"]
    校验元素图片是否发生变化  ${locator}  False  ${value}

校验元素图片是否黑白
    [Arguments]  ${locator}  ${contain}=True
    ${obj}  get library instance  AppiumLibrary
    ${img_bs64}  get screenshot as base64  ${obj}
    wait until page contains element  ${locator}  20
    ${location}  get element location  ${locator}
    ${size}  get element size  ${locator}
    ${x0}  set variable  ${location}[x]
    ${y0}  set variable  ${location}[y]
    ${x1}  evaluate  ${x0}+${size}[width]
    ${y1}  evaluate  ${y0}+${size}[height]
    is_img_gray  ${x0}  ${y0}  ${x1}  ${y1}  ${contain}  ${img_bs64}

校验文本图片是否黑白
    [Arguments]  ${text}  ${contain}=True
    ${locator}  set variable  //*[@text="${text}"]
    校验元素图片是否黑白  ${locator}  ${contain}

校验内容描述图片是否黑白
    [Arguments]  ${des}  ${contain}=True
    ${locator}  set variable  //*[@content-desc="${des}"]
    校验元素图片是否黑白  ${locator}  ${contain}

设置日志大小
    [Documentation]  设置日志缓存大小
    [Arguments]  ${size}=10M
    ${adb_set}  set variable   adb logcat -G ${size}
    ${info0}    cmd command  ${adb_set}

清空设备日志
    [Documentation]  清空日志
    ${adb_del_log}  set variable   adb logcat -c
    ${info0}    cmd command  ${adb_del_log}

打印设备日志
    [Documentation]  打印设备日志
    run keyword if test failed   输出设备日志

输出设备日志
    [Documentation]  输出日志
    ${log}  catenate  SEPARATOR=   ${log_path}     \${TESTNAME}.log
    ${message}  set variable    ${TESTNAME}_用例日志
    ${time}    get sys date     0   time
    append to file  ${log}   ${time} ${message}\r   encoding=UTF-8
    ${adb_set}  set variable   adb logcat -v time >> ${log}
    ${info0}    cmd command  ${adb_set}

开始抓取日志
    [Documentation]  开始抓取日志
    ${log}  catenate  SEPARATOR=   ${log_path}     \\${TESTNAME}.log
    ${message}  set variable    ${TESTNAME}_用例日志
    ${time}    get sys date     0   time
    append to file  ${log}   ${time} ${message}\r   encoding=UTF-8
    start logcat  ${log}

关闭抓取日志
    [Documentation]  关闭抓取日志
    stop logcat

根据关键词提取日志内容
    [Documentation]  提取日志内容
    [Arguments]  ${keyword}  ${column}=A    ${start_row}=2
    ${input_file}  catenate  SEPARATOR=   ${log_path}     \\${TESTNAME}.log
    ${output_file}  catenate  SEPARATOR=   ${log_path}     \\性能测试数据.xlsx
    extract and write to excel  ${input_file}  ${output_file}  ${keyword}   ${column}   ${start_row}    ${TESTNAME}
