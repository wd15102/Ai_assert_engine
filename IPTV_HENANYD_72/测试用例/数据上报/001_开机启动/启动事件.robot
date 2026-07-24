*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot

#Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_001 启动事件公共字段检查
    [Tags]  iptv  P0
    [Documentation]    启动事件
    comment    开启appiumServer
    清除设备缓存
    Open Application    http://${appium_server}/wd/hub    deviceName=${device_id}    udid=${device_id}    platformName=Android    platformVersion=${platform_version}
    ...    appPackage=${appPackage}    appActivity=${appActivity}   newCommandTimeout=60   resetKeyboard=true  unicodeKeyboard=true    automationName=${automationName}   noReset=${noReset}  skipServerInstallation=true  skipDeviceInitialization=true
    清除历史上报数据
    wait until page contains element    ${appPackage1}:id/top_container    30
    获取校验结果  {'logtype':'st','bid':'26.1.3'}    test_001   ${datatable_prefix_apk}_st

case_002 设备正常启动
    [Tags]  iptv  P0
    [Documentation]    启动事件
    获取校验结果  {'logtype':'st','bid':'26.1.3'}    test_002   ${datatable_prefix_apk}_st