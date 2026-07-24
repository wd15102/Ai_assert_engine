*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/专项测试.robot

Suite Setup     设置本地映射  disable
Suite Teardown      设置本地映射  enable

*** Test Cases ***
专项测试接口状态查询测试_大数据上报接口
    [Documentation]    接口状态查询测试
    ${data1}  catenate  SEPARATOR=  ${data_addr1}   /dispatcher.do?model=M301A_UM9_HUNAN&uvip=0&lics=f6e121fb3003b5321fd67d2d655506c8bc763a05&ntime=1611903229262&mac=748F1B6E6000&lt=1278&aver=YYS.6.3.1.Y3.6.HNYDIPTV.0.0_Release&lob=&abt=6%7CAB1&paid=380fb93d31b24684827f4e36e99d21f0&lastp=&isdebug=0&src=mgtv&mf=CMIOT_JIULIAN&sp_code=13%26%E5%88%9D%E4%B8%AD%E4%B8%89%E5%B9%B4%E7%BA%A7&lastpid=-1&bid=26.1.13&agemod=4&asid=&platform=IPTV%2B&logtype=stay&did=00490300000298800002748F1B6E6000&sessionid=40d9e0bf-918e-4b85-beae-838384323d49&url=&operator=3&ref=&cntpid=ch_home&staytime=13277018&lot=1&sver=4.4.2&uuid=0120034564739526637&patchid=ae933fe&cntp=ch_channel
    ${http}  catenate  SEPARATOR=  ${data_addr1}   /dispatcher.do
    接口返回状态_GET  10   ${data1}
    接口返回状态_POST  10  ${http}   {"abt":"6|AB1","agemod":"0","asid":"","aver":"YYS.6.2.0.Y3.6.HNYDIPTV.0.0_Pre_Release","bid":"26.1.3","city":"A31J0","did":"00490300000298800002748F1B6E6000","halt":"1","isdebug":"0","lics":"f6e121fb3003b5321fd67d2d655506c8bc763a05","logtype":"st","mac":"748F1B6E6000","mf":"CMIOT_JIULIAN","model":"M301A_UM9_HUNAN","ntime":"1598317973919","operator":"3","patchid":"73b48fe","platform":"IPTV+","sessionid":"a761a07b-d1be-4159-894e-a2cd23f4c8c8","src":"mgtv","sver":"4.4.2","ugroup":"g19A31J00000","uuid":"0120034564739526637","uvip":"0"}

专项测试接口状态查询测试_推荐算法上报接口
    [Documentation]    接口状态查询测试
    ${http}  catenate  SEPARATOR=   ${data_addr2}   /dispatcher.do
    接口返回状态_POST  10  ${http}    model=M301A_UM9_HUNAN&uvip=0&rectype=002&lics=f6e121fb3003b5321fd67d2d655506c8bc763a05&ntime=1598318574869&mac=748F1B6E6000&aid=00000001000000001002000000000021&net=cable&offset_menta_data=%5Bnull%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%5D&resolvetime=94&aver=YYS.6.2.0.Y3.6.HNYDIPTV.0.0_Pre_Release&abt=6%7CAB1&paid=5b8c8fe1e0564c6fa49f0d5dba5ba2c6&mnl=%25E7%25BB%25AF%25E9%2597%25BB%25E8%25AE%25A1%25E5%2588%2592%253B%25E5%259E%25AB%25E5%25BA%2595%25E8%2581%2594%25E7%259B%259F%253B%25E7%2594%25A8%25E4%25B8%2580%25E7%2594%259F%25E5%258E%25BB%25E7%2588%25B1%25E4%25BD%25A0%253B%25E5%25A5%25B3%25E7%2594%259F%25E6%2597%25A5%25E8%25AE%25B0%25E4%25B9%258B%25E5%2581%259A%25E5%2586%25B3%25E5%25AE%259A%25E4%25BA%258B%25E5%258A%25A1%25E6%2589%2580%253B%25E5%25B0%258F%25E9%25B1%25BC%25E5%2584%25BF%25E4%25B8%258E%25E8%258A%25B1%25E6%2597%25A0%25E7%25BC%25BA%253B%25E7%25A7%258B%25E9%25A6%2599&midl=00000001000000000001000000108185%253B00000001000000001002000000015657%253B00000001000000000001000000180212%253B00000001000000000002000000095791%253B00000001000000000002000000095786%253B00000001000000000002000000095784&moduleid=&reclob=strategy%253A303%2526score%253A0.32%2526seqid%253A123%2526pagenum%253A2%253Bstrategy%253A303%2526score%253A0.32%2526seqid%253A123%2526pagenum%253A2%253Bstrategy%253A303%2526score%253A0.32%2526seqid%253A123%2526pagenum%253A2%253Bnull%253Bnull%253Bnull&isdebug=0&src=mgtv&mf=CMIOT_JIULIAN&bid=rec_26.1.16&agemod=0&asid=&platform=IPTV%2B&modulepos=1&mod=1&logtype=show&did=00490300000298800002748F1B6E6000&sessionid=a761a07b-d1be-4159-894e-a2cd23f4c8c8&cid=00000001000000001002000000000046&operator=3&ip=100.115.25.190&duration=303&cntpid=00000001000000000005000000166934&contentpos=1%253B2%253B3%253B4%253B5%253B6&sver=4.4.2&uuid=0120034564739526637&act=recv1&patchid=73b48fe&module_menta_data=&cntp=v_play

