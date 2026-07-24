*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../IPTV_HNYD_64/对象库/专项测试.robot

#Suite Setup     启动应用
#Suite Teardown      退出应用

*** Test Cases ***
专项测试接口测试_详情页info接口测试
    [Documentation]    专项测试：get接口测试
    ${str}  接口返回_GET  http://58.20.27.26:6060/iptv_epg/video/info?platform=IPTV%2B&userIp=192.168.204.179&userMac=B4-01-42-47-0D-1C&areaCode=0099900&mod=S65&pageSize=100&cid=cf335887d5194a97894a829c3bce330e&operator=2&version=YYS.6.4.0.Y28.6.HNLTIPTV.0.0_Pre_Release&city=0&pf=1&abt=6%7CAB1&stbId=00000443001B90500001B40142470D1C&cp=HW&ocid=VRS290346&appVersion=YYS.6.4.0.Y28.6.HNLTIPTV.0.0_Pre_Release&userToken=94A%40tv87672157046083941971943072&userId=073108975368A%40tv&device=S65&mf=ChinaGCI&license=a09de5cec83b7a804a24c04647f97380fe380809
    接口返回json数据校验  ${str}    data,modules,list|1,tabs|3,title   11-15

专项测试接口测试_广告接口测试
    [Documentation]    专项测试：post接口测试
    ${headers}  set variable  {"Content-type":"application/x-www-form-urlencoded;charset=UTF-8","User-Agent":"Dalvik/1.6.0 (Linux; U; Android 4.4.2; S65 Build/00000443001B90500001)","Connection":"keep-alive"}
    ${hosts}  set variable  http://${host_ad}:80/ad_request
    ${data}  set variable  userIp=192.168.204.179&media_assets_id=movie&os_ver=4.4.2&area_code=0099900&app_type=8&mac=B4-01-42-47-0D-1C&auth_flag=1&channel_code=hnlt&android_sdk_ver=19&version=YYS.6.4.0.Y28.6.HNLTIPTV.0.0_Pre_Release&user_account=073108975368A%40tv&ext_param=%7B%22product_list%22%3A%22%22%7D&abt=6%7CAB1&userToken=94A%40tv87672157046083941971943072&ticket=94A%40tv87672157046083941971943072&special_id=&userId=073108975368A%40tv&action=16&business_id=1&model_code=S65&video_id=5a0cbf7c36c472b2c86c8b9e371c320f&mf=ChinaGCI&license=a09de5cec83b7a804a24c04647f97380fe380809&capability_version=YYS.6.4.0.Y28.6.HNLTIPTV.0.0_Pre_Release&platform=IPTV%2B&rom_version=&request_param=%7B%22p%22%3A%7B%22c%22%3A%7B%22brand%22%3A%22S65%22%2C%22cdn%22%3A%22HW%22%2C%22mac%22%3A%22B4-01-42-47-0D-1C%22%2C%22mn%22%3A%22S65%22%2C%22os%22%3A%224.4.2%22%2C%22ts%22%3A1628059018%2C%22type%22%3A200%2C%22version%22%3A%22YYS.6.4.0.Y28.6.HNLTIPTV.0.0_Pre_Release%22%7D%2C%22ex%22%3A%7B%22extdata%22%3A%22%22%7D%2C%22m%22%3A%7B%22aid%22%3A607694529%2C%22allowad%22%3A110110%2C%22p%22%3A50000%2C%22ptype%22%3A%22float%22%7D%2C%22u%22%3A%7B%22usertype%22%3A%22%22%2C%22usrid%22%3A%22073108975368A%40tv%22%2C%22vip%22%3A0%7D%7D%2C%22v%22%3A%7B%22v%22%3A%7B%22cmsrid%22%3A%22movie%22%2C%22ctid%22%3A%22%22%2C%22hid%22%3A0%2C%22hidstr%22%3A%225a0cbf7c36c472b2c86c8b9e371c320f%22%2C%22id%22%3A0%2C%22idstr%22%3A%225a0cbf7c36c472b2c86c8b9e371c320f%22%2C%22ispay%22%3A0%2C%22ispreview%22%3A0%2C%22vrstype%22%3A%22movie%22%7D%7D%7D&areaCode=0099900&mod=S65&input_type=json&buss_id=000099901&category_id=&device_id=3337f5ad64fba8a1e77b2e07a152e6b8efe9ceaa&operator=2&ip=192.168.204.179&sign=d5b297a77312d78ab58b30ba18f4f2bfc757ef9b&time_zone=GMT%2B08%3A00&pf=1&service_number=&cp=HW&uuid=mgtvB4%3A01%3A42%3A47%3A0D%3A1C&mac_id=B4-01-42-47-0D-1C&
    ${str}  接口返回_POST  ${hosts}  ${data}  ${headers}
    接口返回json数据正则校验  ${str}    success  \\d

专项测试接口测试_百度接口测试
    [Documentation]    专项测试：https接口测试
    ${str}  接口返回_GET  https://gw.bz.mgtv.com/klk/home/knowledge/list?did=aa422545-330f-4153-b0d6-d0535c3c93bf&osType=android&osVersion=10&platform=h5&phaseId=1&page=1&pageSize=3
    接口返回json数据校验  ${str}    code   200
    接口返回json数据正则校验  ${str}    data|2,categoryName   [\u4e00-\u9fa5_a-zA-Z0-9_]{2,10}

接口测试_EPGindex接口是否为正式环境地址
    [Documentation]    专项测试：EPGindex接口测试
    ${url}  set variable    http://otthnydepg.yys.mgtv.com:6600/IPTV_EPG/StartUp/EPGIndex?platform=OTT&stbId=004903FF0003204018170C4933BEF892&abt=&userIp=192.168.205.75&userMac=0C-49-33-BE-F8-92&cp=&areaCode=&appVersion=YYS.6.4.0.Y3.6.HNYD.0.0_Pre_Release&mod=MGV2000-J-04_HUNAN&userId=0104352533271690912&mf=MIGU_JIUZHOU&operator=3&version=YYS.6.4.0.Y3.6.HNYD.0.0_Pre_Release
    ${str}  接口返回_GET  ${url}
    ${epgUrl}   接口返回json数据指定参数值  ${str}    epgUrl
    ${parameterList}    接口返回json数据指定参数值  ${str}    parameterList
    接口返回json数据正则校验  ${str}  epgUrl   ((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})(\\.((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})){3}  False
    接口返回json数据正则校验  ${str}    parameterList  ((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})(\\.((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})){3}  False