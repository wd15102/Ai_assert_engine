*** Settings ***
Documentation    消息方法
Library  AppiumLibrary
Resource          ../../IPTV_HENANYD_72/对象库/公共方法.robot
Resource          ../../IPTV_HENANYD_72/对象库/专项测试.robot

*** Keywords ***
发送消息
    [Documentation]  IPTV终端发送消息
    [Arguments]    ${mark}  ${contentType}  ${userAccounts}  ${site}=site_2  ${closetime}=15  ${style}=style_1    ${toApk}=1    ${saveLocal}=1    ${popLimited}=1   ${verMod}=0  ${popPage}=0
#    消息参数配置
#    ${mark}：消息标识，任意填写。
#    ${contentType}：消息类型。1：系统公告；6：系统其他消息；9：首页刷新消息；60：营销消息；70：任务消息。
#    ${userAccounts}：账号；
#    ${site}：弹窗位置。site_1：中间；site_2：右下角；site_3：全屏(霸屏)；site_4：不弹框；site_5：右上角。
#    ${closetime}：自动关闭时间，单位秒
#    ${style}:消息展示样式，style_1:纯文字；style_2: 文字和图片；style_3: 固定宽高纯图片（电信、联通，消息弹出框全为图片）；style_4: 可变宽高纯图（不规则图片，针对移动）。
#    ${toApk}:1:首页、2:个人、3:服务、4:VIP专区、5:观看记录、6:搜索、7:详情页、8:栏目页、9:订购页、10:明星页、11：直播播放、12：回看页、13：点播播放、14：apk专题  15：第三方app  16：消息盒子  17：短视频页  18：UP主页  19：UP主视频播放页  20：跳转插件    23：跳转简约版 24：微信助手绑定页面
#    ${saveLocal}：是否进消息盒子。1 : 是；2 : 否
#    ${autoClose}：是否自动关闭，1：自动关闭；0：不自动关闭。
#    ${popLimited}：弹出是否受限，1 : 是（默认）、2 : 否
#    ${popPage}：弹出页面。0 : 不限、1 : EPG分屏、2 : 点播详情页、3：合集的根栏目id
    ${startTime}    get_sys_date    0   time    -1
    ${endTime}    get_sys_date    0   time    10
    ${time}  get autotest time
    ${id}   set variable    302947952a7241fe752ce${time}
    ${name}  set variable   测试消息
    ${title}  set variable   消息标题${mark}
    ${summary}  set variable   最新动漫少儿节目看《小猪佩奇7》《百变校巴2》
    ${img}  set variable   http://127.0.0.1:80/hengtu1.jpg
    ${content}  根据toApk生成content    ${toApk}
    ${action}   根据toApk生成action     ${toApk}
    ${autoClose}    根据closetime生成autoClose  ${closetime}
    ${popPageName}  根据popPage生成popPageName  ${popPage}
    ${adb_messge}    set variable  am broadcast -a com.msg.test.recieve --es com.intent.msg.test.recieve "{\\"id\\":\\"${id}\\",\\"name\\":\\"${name}\\",\\"title\\":\\"${title}\\",\\"mark\\":\\"${mark}\\",\\"site\\":\\"${site}\\",\\"summary\\":\\"${summary}\\",\\"contentType\\":\\"${contentType}\\",\\"action\\":\\"${action}\\",\\"taskId\\":\\"9876541230\\",\\"toApk\\":\\"${toApk}\\",\\"content\\":\\"${content}\\",\\"startTime\\":\\"${startTime}\\",\\"endTime\\":\\"${endTime}\\",\\"status\\":\\"2\\",\\"autoClose\\":\\"${autoClose}\\",\\"perCount\\":\\"50\\",\\"intervalTime\\":\\"0\\",\\"delayTime\\":\\"5\\",\\"isDelete\\":\\"0\\",\\"audienceChoose\\":\\"1\\",\\"groupId\\":\\"/data/tomcat-7.0.73/webapps/MSGManage/data/uploadPic/少儿.txt\\",\\"closetime\\":\\"${closetime}\\",\\"userAccounts\\":\\"${userAccounts}\\",\\"userMacs\\":\\"\\",\\"img\\":\\"${img}\\",\\"upload\\":\\"http://10.255.0.118/upload\\",\\"spId\\":\\"ddd35b256ede4b33ad9e0be1540bfdfa\\",\\"style\\":\\"${style}\\",\\"apkversion\\":\\"\\",\\"saveLocal\\":\\"${saveLocal}\\",\\"autoPop\\":\\"1\\",\\"popLimited\\":\\"${popLimited}\\",\\"popPageName\\":\\"${popPageName}\\",\\"popPage\\":\\"${popPage}\\",\\"popStartTime\\":\\"${startTime}\\",\\"popEndTime\\":\\"${endTime}\\",\\"verMod\\":\\"${verMod}\\"}"
    log  ${adb_messge}
    ${info}    adb shell command  ${adb_messge}  'UTF-8'

发送消息_弹窗限制
    [Documentation]  IPTV终端发送弹窗限制
    [Arguments]    ${mark}  ${contentType}  ${userAccounts}  ${perCount}=5    ${intervalTime}=0   ${delayTime}=5    ${poppriority}=1
#    ${perCount}：每日弹出总次数
#    ${intervalTime}：距上次弹出间隔
#    ${delayTime}：弹出判断延时
    ${site}   set variable    site_2
    ${closetime}   set variable    15
    ${style}   set variable    style_1
    ${toApk}   set variable    1
    ${saveLocal}   set variable    1
    ${popLimited}   根据消息类型确认是否受限    ${contentType}
    ${verMod}   set variable    0
    ${popPage}   set variable    0
    ${startTime}    get_sys_date    0   time    -1
    ${endTime}    get_sys_date    0   time    10
    ${time}  get autotest time
    ${id}   set variable    302947952a7241fe752ce${time}
    ${name}  set variable   测试消息
    ${title}  set variable   消息标题${mark}
    ${summary}  set variable   最新动漫少儿节目看《小猪佩奇7》《百变校巴2》
    ${img}  set variable   http://127.0.0.1:80/hengtu1.jpg
    ${content}  根据toApk生成content    ${toApk}
    ${action}   根据toApk生成action     ${toApk}
    ${autoClose}    根据closetime生成autoClose  ${closetime}
    ${popPageName}  根据popPage生成popPageName  ${popPage}
    ${adb_messge}    set variable  am broadcast -a com.msg.test.recieve --es com.intent.msg.test.recieve "{\\"id\\":\\"${id}\\",\\"name\\":\\"${name}\\",\\"title\\":\\"${title}\\",\\"mark\\":\\"${mark}\\",\\"site\\":\\"${site}\\",\\"summary\\":\\"${summary}\\",\\"contentType\\":\\"${contentType}\\",\\"action\\":\\"${action}\\",\\"taskId\\":\\"9876541230\\",\\"poppriority\\":\\"${poppriority}\\",\\"toApk\\":\\"${toApk}\\",\\"content\\":\\"${content}\\",\\"startTime\\":\\"${startTime}\\",\\"endTime\\":\\"${endTime}\\",\\"status\\":\\"2\\",\\"autoClose\\":\\"${autoClose}\\",\\"perCount\\":\\"${perCount}\\",\\"intervalTime\\":\\"${intervalTime}\\",\\"delayTime\\":\\"${delayTime}\\",\\"isDelete\\":\\"0\\",\\"audienceChoose\\":\\"1\\",\\"groupId\\":\\"/data/tomcat-7.0.73/webapps/MSGManage/data/uploadPic/少儿.txt\\",\\"closetime\\":\\"${closetime}\\",\\"userAccounts\\":\\"${userAccounts}\\",\\"userMacs\\":\\"\\",\\"img\\":\\"${img}\\",\\"upload\\":\\"http://10.255.0.118/upload\\",\\"spId\\":\\"ddd35b256ede4b33ad9e0be1540bfdfa\\",\\"style\\":\\"${style}\\",\\"apkversion\\":\\"\\",\\"saveLocal\\":\\"${saveLocal}\\",\\"autoPop\\":\\"1\\",\\"popLimited\\":\\"${popLimited}\\",\\"popPageName\\":\\"${popPageName}\\",\\"popPage\\":\\"${popPage}\\",\\"popStartTime\\":\\"${startTime}\\",\\"popEndTime\\":\\"${endTime}\\",\\"verMod\\":\\"${verMod}\\"}"
    log  ${adb_messge}
    ${info}    adb shell command  ${adb_messge}  'UTF-8'

发送消息_图片测试
    [Documentation]  IPTV终端发送弹窗限制
    [Arguments]    ${mark}  ${contentType}  ${userAccounts}   ${img_format}=jpg
#    ${perCount}：每日弹出总次数
#    ${intervalTime}：距上次弹出间隔
#    ${delayTime}：弹出判断延时
    ${perCount}   set variable    5
    ${intervalTime}   set variable    0
    ${delayTime}   set variable    5
    ${poppriority}   set variable    1
    ${site}   set variable    site_2
    ${closetime}   set variable    15
    ${style}   set variable    style_2
    ${toApk}   set variable    1
    ${saveLocal}   set variable    1
    ${popLimited}   根据消息类型确认是否受限    ${contentType}
    ${verMod}   set variable    0
    ${popPage}   set variable    0
    ${startTime}    get_sys_date    0   time    -1
    ${endTime}    get_sys_date    0   time    10
    ${time}  get autotest time
    ${id}   set variable    302947952a7241fe752ce${time}
    ${name}  set variable   测试消息
    ${title}  set variable   消息标题${mark}
    ${summary}  set variable   最新动漫少儿节目看《小猪佩奇7》《百变校巴2》
    ${img}  根据图片格式生成图片地址    ${img_format}
    ${content}  根据toApk生成content    ${toApk}
    ${action}   根据toApk生成action     ${toApk}
    ${autoClose}    根据closetime生成autoClose  ${closetime}
    ${popPageName}  根据popPage生成popPageName  ${popPage}
    ${adb_messge}    set variable  am broadcast -a com.msg.test.recieve --es com.intent.msg.test.recieve "{\\"id\\":\\"${id}\\",\\"name\\":\\"${name}\\",\\"title\\":\\"${title}\\",\\"mark\\":\\"${mark}\\",\\"site\\":\\"${site}\\",\\"summary\\":\\"${summary}\\",\\"contentType\\":\\"${contentType}\\",\\"action\\":\\"${action}\\",\\"taskId\\":\\"9876541230\\",\\"poppriority\\":\\"${poppriority}\\",\\"toApk\\":\\"${toApk}\\",\\"content\\":\\"${content}\\",\\"startTime\\":\\"${startTime}\\",\\"endTime\\":\\"${endTime}\\",\\"status\\":\\"2\\",\\"autoClose\\":\\"${autoClose}\\",\\"perCount\\":\\"${perCount}\\",\\"intervalTime\\":\\"${intervalTime}\\",\\"delayTime\\":\\"${delayTime}\\",\\"isDelete\\":\\"0\\",\\"audienceChoose\\":\\"1\\",\\"groupId\\":\\"/data/tomcat-7.0.73/webapps/MSGManage/data/uploadPic/少儿.txt\\",\\"closetime\\":\\"${closetime}\\",\\"userAccounts\\":\\"${userAccounts}\\",\\"userMacs\\":\\"\\",\\"img\\":\\"${img}\\",\\"upload\\":\\"http://10.255.0.118/upload\\",\\"spId\\":\\"ddd35b256ede4b33ad9e0be1540bfdfa\\",\\"style\\":\\"${style}\\",\\"apkversion\\":\\"\\",\\"saveLocal\\":\\"${saveLocal}\\",\\"autoPop\\":\\"1\\",\\"popLimited\\":\\"${popLimited}\\",\\"popPageName\\":\\"${popPageName}\\",\\"popPage\\":\\"${popPage}\\",\\"popStartTime\\":\\"${startTime}\\",\\"popEndTime\\":\\"${endTime}\\",\\"verMod\\":\\"${verMod}\\"}"
    log  ${adb_messge}
    ${info}    adb shell command  ${adb_messge}  'UTF-8'

发送营销消息
    [Documentation]    发送营销消息
    [Arguments]    ${mark}  ${userAccounts}  ${closetime}
    ${startTime}    get_sys_date    0   time    0
    ${endTime}    get_sys_date    0   time    10
    ${time}  get autotest time
    ${id}   set variable    121234561111111111154${time}
    ${templateid}   set variable    ${营销id}
    ${headers}  set variable  {"Content-type":"application/json"}
    ${hosts}  set variable  ${消息地址}
    ${data}  set variable  {"id":"${id}","templateid":"${templateid}","summary":"消息简介，不超过100汉字，内容超长测试，看能展示多少字，字数超长会多少会截断","action":"2","toApk":"7","site":"site_5","style":"style_1","contentType":"60","userAccounts":"${userAccounts}","closetime":"${closetime}","startTime":"","endTime":"","title":"继续观看《乘风破浪 第三季》，按“OK键”跳转，再看看多少字数会超长","img":"http://hnydiptvimg.yys.mgtv.com:6600/picture/zypt/pic/2022/09/28/20220928174448.png","mark":"${mark}","content":{\"type\":\"2\",\"data\":{\"action\":\"m_open_detail_page\",\"programId\":\"32020011120442157027745780295818\",\"videoId\":\"60ae3c84ca1f418a8369220bd21918e1\",\"fullScreen\":0}} }
    ${str}   接口返回_POST  ${hosts}  ${data}  ${headers}

发送任务消息
    [Documentation]    发送任务消息
    [Arguments]    ${userAccounts}
    ${url}  set variable  ${任务消息地址}?message_id=${任务id}&uuid=${userAccounts}
    ${str}  接口返回_GET  ${url}

发送应急广播
    [Documentation]    发送应急广播
    [Arguments]    ${mark}  ${userAccounts}  ${closetime}
    ${startTime}    get_sys_date    0   time    -1
    ${endTime}    get_sys_date    0   time    10
    ${time}  get autotest time
    ${id}   set variable    302947952a7241fe752ce${time}
    ${title}  根据mark生成应急广播级别    ${mark}
    ${name}  根据mark生成应急广播颜色  ${mark}
    ${verMod}   set variable   0
    ${summary}  set variable   \u5e94\u6025\u5e7f\u64ad\u6d4b\u8bd5\uff0c\u53d7\u5f3a\u96f7\u96e8\u4e91\u56e2\u5f71\u54cd\uff0c\u6211\u5e02\u90e8\u5206\u5730\u533a\u7d2f\u79ef\u96e8\u91cf\u5df2\u8fbe\u0035\u0030\u6beb\u7c73\uff0c\u9884\u8ba1\u5f3a\u964d\u96e8\u4ecd\u5c06\u6301\u7eed\uff0c\u5e02\u6c14\u8c61\u53f0\u4e8e\u0030\u0036\u65f6\u0035\u0035\u5206\u5c06\u66b4\u96e8\u9884\u8b66\u4fe1\u53f7\u5347\u7ea7\u4e3a\u6a59\u8272\uff0c\u5176\u4ed6\u533a\u66b4\u96e8\u9ec4\u8272\u548c\u5168\u5e02\u96f7\u96e8\u5927\u98ce\u9ec4\u8272\u9884\u8b66\u4fe1\u53f7\uff0c\u8bf7\u6ce8\u610f\u9632\u5fa1\u3002
    ${adb_messge}    set variable  am broadcast -a com.msg.test.recieve --es com.intent.msg.test.recieve "{\\"id\\":\\"${id}\\",\\"name\\":\\"${name}\\",\\"area\\":\\"4999\\",\\"title\\":\\"${title}\\",\\"mark\\":\\"${mark}\\",\\"site\\":\\"\\",\\"summary\\":\\"${summary}\\",\\"contentType\\":\\"80\\",\\"action\\":\\"\\",\\"taskId\\":\\"9876541230\\",\\"poppriority\\":\\"\\",\\"toApk\\":\\"\\",\\"content\\":\\"\\",\\"startTime\\":\\"${startTime}\\",\\"endTime\\":\\"${endTime}\\",\\"status\\":\\"2\\",\\"autoClose\\":\\"1\\",\\"perCount\\":\\"5\\",\\"intervalTime\\":\\"7200\\",\\"delayTime\\":\\"300\\",\\"isDelete\\":\\"0\\",\\"audienceChoose\\":\\"0\\",\\"groupId\\":\\"\\",\\"closetime\\":\\"${closetime}\\",\\"userAccounts\\":\\"${userAccounts}\\",\\"userMacs\\":\\"\\",\\"img\\":\\"\\",\\"upload\\":\\"\\",\\"spId\\":\\"ddd35b256ede4b33ad9e0be1540bfdfa\\",\\"style\\":\\"style_2\\",\\"apkversion\\":\\"\\",\\"saveLocal\\":\\"2\\",\\"autoPop\\":\\"1\\",\\"popLimited\\":\\"1\\",\\"popPageName\\":\\"\\",\\"popPage\\":\\"0\\",\\"popStartTime\\":\\"${startTime}\\",\\"popEndTime\\":\\"${endTime}\\",\\"verMod\\":\\"${verMod}\\"}"
    log  ${adb_messge}
    ${info}    adb shell command  ${adb_messge}  'UTF-8'

微信一键锁屏
    [Documentation]    微信一键锁屏
    [Arguments]    ${userAccounts}   ${type}=1
    ${startTime}    get_sys_date    0   time    -1
    ${endTime}    get_sys_date    0   time    10
    ${time}  get autotest time
    ${id}   set variable    302947952a7241fe752ce${time}
    log  ${type}
    ${lockScreen}=  run keyword if  '${type}'=='1'    set variable  true  ELSE   set variable   false
    ${adb_messge}    set variable  am broadcast -a com.msg.test.recieve --es com.intent.msg.test.recieve "{\\"id\\":\\"${id}\\",\\"name\\":\\"weixin\\",\\"title\\":\\"weixin\\",\\"mark\\":\\"\\",\\"site\\":\\"\\",\\"contentType\\":\\"50\\",\\"content\\":\\"{\\\\\\"type\\\\\\":\\\\\\"3\\\\\\",\\\\\\"data\\\\\\":{\\\\\\"lockScreen\\\\\\":\\\\\\"${lockScreen}\\\\\\"}}\\",\\"startTime\\":\\"${startTime}\\",\\"endTime\\":\\"${endTime}\\",\\"status\\":\\"2\\",\\"autoClose\\":\\"\\",\\"perCount\\":\\"5\\",\\"intervalTime\\":\\"7200\\",\\"delayTime\\":\\"300\\",\\"isDelete\\":\\"0\\",\\"audienceChoose\\":\\"1\\",\\"groupId\\":\\"\\",\\"closetime\\":\\"\\",\\"userAccounts\\":\\"${userAccounts}\\",\\"userMacs\\":\\"\\",\\"upload\\":\\"\\",\\"poppriority\\":\\"\\",\\"style\\":\\"\\",\\"saveLocal\\":\\"2\\",\\"autoPop\\":\\"1\\",\\"popLimited\\":\\"2\\",\\"popPageName\\":\\"\\",\\"popPage\\":\\"0\\",\\"popStartTime\\":\\"\\",\\"popEndTime\\":\\"\\",\\"verMod\\":\\"0\\",\\"resPkgList\\":[],\\"handleType\\":\\"\\"}"
    log  ${adb_messge}
    ${info}    adb shell command  ${adb_messge}  'UTF-8'

根据mark生成应急广播级别
    [Documentation]    根据mark生成应急广播级别
    [Arguments]    ${mark}
    #电影分屏弹窗，详情页弹窗，综艺媒资弹窗
    ${title}=  run keyword if  ${mark}==1  set variable   红色预警
    ...     ELSE IF    ${mark}==2  set variable   橙色预警
    ...     ELSE IF    ${mark}==3  set variable   黄色预警
    ...     ELSE IF    ${mark}==4  set variable   蓝色预警
    ...     ELSE    set variable   未知级别
    [return]   ${title}

根据mark生成应急广播颜色
    [Documentation]    根据mark生成应急广播级别
    [Arguments]    ${mark}
    ${name}=  run keyword if  ${mark}==1  set variable   \#FF3434,#AE1F3A
    ...     ELSE IF    ${mark}==2  set variable   \#FF9F23,#FF3D17
    ...     ELSE IF    ${mark}==3  set variable   \#FFD623,#FFA927
    ...     ELSE IF    ${mark}==4  set variable   \#238EFF,#4027FF
    ...     ELSE    set variable   \#384958,#573949
    [return]   ${name}

检查消息是否接收到
    [Documentation]    检查消息是否接收到
    [Arguments]    ${name}  ${time}=60
    FOR    ${i}   IN RANGE    3
        ${statusValue}  run keyword and return status   wait until page contains   ${name}    ${time}
        run keyword if  ${statusValue}  exit for loop    ELSE    重新启动
    END
    等待文本出现  ${name}  ${time}

根据toApk生成content
    [Documentation]    根据toApk生成content
    [Arguments]    ${toApk}
    ${detail}   set variable    {\\\\\\"video_type\\\\\\":\\\\\\"\\\\\\",\\\\\\"video_id\\\\\\":\\\\\\"00000000000000000001000000064296\\\\\\",\\\\\\"media_assets_id\\\\\\":\\\\\\"00000001000000001002000000000022\\\\\\",\\\\\\"category_id\\\\\\":\\\\\\"\\\\\\",\\\\\\"video_index\\\\\\":\\\\\\"\\\\\\"}
    ${category}     set variable    {\\\\\\"media_asset_id\\\\\\":\\\\\\"\\\\\\",\\\\\\"category_id\\\\\\":\\\\\\"00000001000000001002000000000041\\\\\\"}
    ${order}    set variable    ${订购地址}
    ${starId}   set variable    {\\\\\\"label_id\\\\\\":\\\\\\"ef46b647e3594ca3aa234574b790da8d\\\\\\",\\\\\\"actor_id\\\\\\":\\\\\\"\\\\\\"}
    ${live}     set variable    {\\\\\\"video_id\\\\\\":\\\\\\"00000001000000001001000000000035\\\\\\",\\\\\\"channel_no\\\\\\":\\\\\\"1\\\\\\"}
    ${specialId}       set variable    {\\\\\\"nns_special_id\\\\\\":\\\\\\"ZXXJSHNDBLTX\\\\\\"}
    ${up}  set variable    {\\\\\\"artist_id\\\\\\":\\\\\\"874ab2b50cc64cd9a2d2b156e44f4b31\\\\\\"}
    ${topic}      set variable    {\\\\\\"topic_id\\\\\\":\\\\\\"18\\\\\\",\\\\\\"sub_topic_id\\\\\\":\\\\\\"25\\\\\\",\\\\\\"programId\\\\\\":\\\\\\"VRS10013856\\\\\\"}
    ${content}=  run keyword if  ${toApk}==7  set variable   ${detail}
    ...     ELSE IF    ${toApk}==8  set variable   ${category}
    ...     ELSE IF    ${toApk}==9  set variable   ${order}
    ...     ELSE IF    ${toApk}==10  set variable   ${starId}
    ...     ELSE IF    ${toApk}==11  set variable   ${live}
    ...     ELSE IF    ${toApk}==14  set variable   ${specialId}
    ...     ELSE IF    ${toApk}==17  set variable   ${topic}
    ...     ELSE IF    ${toApk}==18  set variable   ${up}
    ...     ELSE    set variable   {}
    [return]   ${content}

根据toApk生成action
    [Documentation]    根据toApk生成content
    [Arguments]    ${toApk}
    ${action}=  run keyword if  ${toApk}==9  set variable   1
    ...     ELSE IF    ${toApk}>24  set variable   2
    ...     ELSE    set variable   2
    [return]   ${action}

根据closetime生成autoClose
    [Documentation]    根据closetime生成autoClose
    [Arguments]    ${closetime}
    ${autoClose}=  run keyword if  ${closetime}==15 or ${closetime}==30 or ${closetime}==60  set variable   1
    ...     ELSE    set variable   0
    [return]   ${autoClose}

根据popPage生成popPageName
    [Documentation]    根据popPage生成popPageName
    [Arguments]    ${popPage}
    #电影分屏弹窗，详情页弹窗，综艺媒资弹窗
    ${popPageName}=  run keyword if  ${popPage}==1  set variable   dianying_5
    ...     ELSE IF    ${popPage}==2  set variable   00000001000000000005000000166936
    ...     ELSE IF    ${popPage}==3  set variable   00000001000000001002000000000020
    ...     ELSE    set variable   {}
    [return]   ${popPageName}

检查消息不出现
    [Documentation]    检查消息不出现
    [Arguments]    ${text}  ${time}=10
    ${statusValue}  run keyword and return status   wait until page contains   ${text}    ${time}
    run keyword if  ${statusValue}==True  fail    失败原因：消息弹窗出现    ELSE    log to console  消息在指定时间未出现

等待消息消失
    [Documentation]    等待消息消失
    [Arguments]    ${text}  ${time}=20
    FOR    ${i}   IN RANGE    ${time}
        ${statusValue}  run keyword and return status   wait until page contains   ${text}    1
        run keyword if  ${statusValue}==False  exit for loop
    END

根据图片格式生成图片地址
    [Documentation]    根据图片格式生成图片地址
    [Arguments]    ${img_format}
    ${img}=  run keyword if  "${img_format}"=="jpg"  set variable   http://127.0.0.1:80/hengtu1.jpg
    ...     ELSE IF    "${img_format}"=="png"  set variable   http://127.0.0.1:80/laoniandianying0.png
    ...     ELSE IF    "${img_format}"=="gif"  set variable   http://127.0.0.1:80/jiaodiangif.gif
    ...     ELSE    set variable   http://127.0.0.1:80/shutu1.jpg
    [return]   ${img}

根据消息类型确认是否受限
    [Documentation]    根据contentType生成popLimited
    [Arguments]    ${contentType}
    #电影分屏弹窗，详情页弹窗，综艺媒资弹窗
    ${popLimited}=  run keyword if  ${contentType}==1  set variable   2
    ...     ELSE IF    ${contentType}==6  set variable   1
    ...     ELSE    set variable   1
    [return]   ${popLimited}

