*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../IPTV_JX_72/对象库/专项测试.robot
Resource          ../../../系统方法.robot

#Suite Setup     启动应用
#Suite Teardown      退出应用

*** Test Cases ***
推荐接口测试_推荐消息请求
    [Documentation]    专项测试：post接口测试
    ${headers}  set variable  {"Content-type":"application/json"}
    ${hosts}  set variable  http://10.2.219.213:6600/MSGManage/msg/mg_msg
    ${data}  set variable  {"id":"12123456711211111115411321211162","templateid":"b91051e583f34b0084296438f3a7cca4","summary":"消息简介，不超过100汉字，内容超长测试，看能展示多少字，字数超长会多少会截断","action":"2","toApk":"7","site":"site_5","style":"style_1","contentType":"60","userAccounts":"0120034564739526637","resPkgList":[],"handleType":"1","closetime":"30","startTime":"","endTime":"","title":"继续观看《乘风破浪 第三季》，按“OK键”跳转，再看看多少字数会超长","img":"http://hnydiptvimg.yys.mgtv.com:6600/picture/zypt/pic/2022/09/28/20220928174448.png","mark":"活动","content":{\"type\":\"2\",\"data\":{\"action\":\"m_open_detail_page\",\"programId\":\"00000000000000000001000000064297\",\"videoId\":\"00000000000000000001000000064296\",\"fullScreen\":0}} }
#    ${data}  set variable  {"id":"1111111111111111111111111111223333","action":"2","audienceChoose":"1","autoClose":"1","autoPop":"1","toApk":"7","site":"site_5","style":"style_1","contentType":"60","userAccounts":"0127584564791881106","closetime":"15","startTime":"2022-09-26 14:28:30","endTime":"2022-09-28 16:28:30","title":"继续观看《披荆斩棘第二季》","img":"http://hnydiptvimg.yys.mgtv.com:6600/picture/zypt/pic/2022/09/26/20220926174314.png","content":{\"video_type\": \"\", \"video_id\": \"32022081811433619251112999021998\", \"media_assets_id\": \"variety\", \"video_index\": \"\"} }
#    ${data}  set variable  {'id': '11111111111111111111111111122222', 'action': '2', 'toApk': '7', 'site': 'site_5', 'contentType': '60', 'userAccounts': '0120034564739526637', 'closetime': '15', 'startTime': '2022-09-27 10:03:24', 'endTime': '2022-09-27 17:03:24', 'title': '继续观看《披荆斩棘 第二季》', 'content': '{"video_type": "", "video_id": "32022081811433619251112999021998", "media_assets_id": "variety", "video_index": ""}'}
    ${str}  接口返回_POST  ${hosts}  ${data}  ${headers}
    log to console  ${data}
#    接口返回json数据正则校验  ${str}    success  \\d

#任务体系消息测试_模块消息请求
#    [Documentation]    专项测试：get接口测试
#    ${url}  set variable  http://10.200.20.112:10180/MSGManage/msg/bayes_msg?message_id=ed923fb14ae0407cb23177dcf1774f39&uuid=0120034564739526637
#    ${str}  接口返回_GET  ${url}

#应急广播接口测试
###    接口返回json数据正则校验  ${str}    success  \\d
#    [Documentation]    专项测试：post接口测试
#    ${headers}  set variable  {"Content-type":"application/json"}
#    ${hosts}  set variable  http://10.2.204.82:10180/MSGManage/msg/yingji_msg
#    ${data}  set variable  {"id":"12123456111111111125411321111213114","summary":"应急广播测试，应急广播测试，应急广播测试，应急广播测试，应急广播测试，应急广播测试，应急广播测试，应急广播测试，应急广播测试，应急广播测试，应急广播测试。","style":"style_2","closetime":"180","img":"","mark":"2","area":"499999999999"}
##    ${data}  set variable  {"id":"1111111111111111111111111111223333","action":"2","audienceChoose":"1","autoClose":"1","autoPop":"1","toApk":"7","site":"site_5","style":"style_1","contentType":"60","userAccounts":"0127584564791881106","closetime":"15","startTime":"2022-09-26 14:28:30","endTime":"2022-09-28 16:28:30","title":"继续观看《披荆斩棘第二季》","img":"http://hnydiptvimg.yys.mgtv.com:6600/picture/zypt/pic/2022/09/26/20220926174314.png","content":{\"video_type\": \"\", \"video_id\": \"32022081811433619251112999021998\", \"media_assets_id\": \"variety\", \"video_index\": \"\"} }
##    ${data}  set variable  {'id': '11111111111111111111111111122222', 'action': '2', 'toApk': '7', 'site': 'site_5', 'contentType': '60', 'userAccounts': '0120034564739526637', 'closetime': '15', 'startTime': '2022-09-27 10:03:24', 'endTime': '2022-09-27 17:03:24', 'title': '继续观看《披荆斩棘 第二季》', 'content': '{"video_type": "", "video_id": "32022081811433619251112999021998", "media_assets_id": "variety", "video_index": ""}'}
#    ${str}  接口返回_POST  ${hosts}  ${data}  ${headers}
#    log to console  ${data}