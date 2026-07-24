*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Library           TestLibrary
Resource          ../../../IPTV_HNYD_63/对象库/专项测试.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
#专项测试_数据库操作
#    ${sql}  set variable  SELECT * FROM auto_test.iptv_ott_apk_HNYD61_click ioahc where test_point='test_001'
#    ${data}  select mysql  ${sql}

专项测试_随机操作
    随机进行指定的操作  12345678

