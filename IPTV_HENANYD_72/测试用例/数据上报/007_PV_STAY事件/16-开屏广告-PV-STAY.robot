*** Settings ***
Documentation    直播回看时移PV和STAY事件
Variables         ../../../../IPTV_JX_72/mock.py
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot

Suite Setup   激活接口  ${广告}   ${广告_开屏_视频}
Suite Teardown  run keywords  退出应用  AND  激活接口  ${广告}    ${广告_前贴_空},${广告_直播退出_非空},${广告_直播暂停_非空},${广告_点播角标_非空},${广告_点播推荐位_非空},${广告_点播暂停_非空}
#Test Teardown   用例失败截屏

*** Test Cases ***
case_256 开屏广告
    [Documentation]  PV事件
    清除历史上报数据
     Open Application    http://${appium_server}/wd/hub    deviceName=${device_id}    udid=${device_id}    platformName=Android    platformVersion=4.4.2
    ...    appPackage=${appPackage}    appActivity=${appActivity}   newCommandTimeout=60   resetKeyboard=true  unicodeKeyboard=true    automationName=UiAutomator1
    等待页面出现文本信息  按返回键关闭广告    30
    获取校验结果  {'logtype':'pv','cntp':'openscr_rec'}    test_256    ${datatable_prefix_apk}_pv

