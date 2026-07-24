*** Settings ***
Library           AppiumLibrary
Library           OperatingSystem
Library           String
Resource          ../../IPTV_HENANYD_72/对象库/公共方法.robot
Resource          ../../IPTV_HENANYD_72/对象库/搜索.robot
Resource          ../../IPTV_HENANYD_72/对象库/首页.robot

*** Keywords ***
媒资播放检查
    [Documentation]  媒资播放检查
    [Arguments]    ${name}  ${num}  ${element}
    确认键  5
    FOR    ${i}   IN RANGE    3
        ${statusValue}     run keyword and return status    wait until page contains element    ${影片名}  10
        run keyword if    ${statusValue}==True    exit for loop
    END
    ${statusValue}     run keyword and return status    wait until page contains element    ${影片名}  1
    run keyword if    ${statusValue}==True  打印日志  ******************开始播放媒资《${name}》：第${num}部******************
    ...  ELSE   打印日志  ******************播放媒资非《${name}》：第${num}部******************
    按返回直到出现元素  ${element}
#    ...     AND     媒资类型判断  ${name}    ${num}  ${element}
#    ...     ELSE IF   ${statusValue}==False   Run Keywords  按返回直到出现元素  ${element}  AND  打印日志  **********第${num}部媒资《${name}》播放失败：进入媒资详情页失败*********
#    ...     AND     打印媒资播放失败日志文件  ${name}

媒资类型判断
    [Documentation]  媒资类型判断
    [Arguments]    ${name}  ${num}  ${element}
    ${statusValue1}     run keyword and return status    wait until page contains element    ${选集}  5
    run keyword if  ${statusValue1}==True   Run Keywords    按次数下移  2    3   AND  按秒快退  3
    ${statusValue2}     run keyword and return status    wait until page contains element   ${电视剧第1集}  5
    run keyword if  ${statusValue1}==True and ${statusValue2}==True  电视剧类型循环检查  ${name}    ${num}  ${element}
    ...     ELSE IF     ${statusValue1}==True and ${statusValue2}==False    综艺类型循环检查    ${name}    ${num}  ${element}
    ...     ELSE IF     ${statusValue1}==False  电影类型循环检查    ${name}    ${num}  ${element}

电视剧类型循环检查
    [Documentation]  电视剧循环检查
    [Arguments]    ${name}  ${num}  ${element}
    ${statusValue0}     run keyword and return status    wait until page contains element    ${花絮}  1
    ${num1}  set variable   1
    ${playstatus}   set variable  True
    FOR    ${i}   IN RANGE    10000
        确认键
        Run Keyword And Ignore Error  等待页面出现元素信息  ${点播时间}    10
        ${statusValue}     run keyword and return status    等待页面出现文本信息  立即购买    1
        run keyword if  ${statusValue}==True    Run Keywords  打印日志  第${num}部媒资《${name}》：第${num1}集播放失败需要定购  AND  exit for loop
        ${time1}=   Wait Until Keyword Succeeds  20s  3s  获取媒资播放时间  ${点播当前播放时间}
        ${time2}=   Wait Until Keyword Succeeds  20s  3s  获取媒资播放时间  ${点播总时长}
        run keyword if    '${time1}'=='${time2}'    打印日志  媒资《${name}》：第${num1}集播放失败
        ...     ELSE    打印日志  媒资《${name}》：第${num1}集播放成功
        按次数下移  1
        向右  1
        ${num0}  evaluate   int(${num1})+1
        ${num1}  获取元素属性  ${当前焦点}  name
        ${num2}  evaluate    int(${num1})
        ${playstatus}=  run keyword if    '${time1}'=='${time2}' or ${playstatus}==False or '${num2}'>'${num0}'    set variable    False   ELSE    set variable    True
        run keyword if  ${num2} > ${num0}  打印日志  媒资《${name}》：播放失败缺第${num0}集
        ...  ELSE IF  ${num2} < ${num0}  检查是否集数重复  ${num}  ${num2}   ${name}
    END
    run keyword if  ${playstatus}==False    打印媒资播放失败日志文件  ${name}   ELSE    删除文件内容  ${name}
    run keyword if  ${statusValue0}==True  Run Keywords  按次数下移  3    AND  打印日志  开始播放媒资《${name}》花絮
    ...     AND     花絮循环检查  ${name}  ${num}
    按返回直到出现元素  ${element}

检查是否集数重复
    [Documentation]  检查是否集数重复
    [Arguments]    ${num}  ${num2}   ${name}
    按次数左移  1
    ${num3}  获取元素属性  ${当前焦点}  name
    ${num4}  evaluate    int(${num3})
    run keyword if  ${num4} == ${num2} and ${num4}!=1  Run Keywords    打印日志  媒资《${name}》：播放失败重复第${num2}集   AND     按次数右移  1
    ...     ELSE    Run Keywords  打印日志  第${num}部媒资《${name}》：播放结束  AND  exit for loop

综艺类型循环检查
    [Documentation]  综艺类型循环检查
    [Arguments]    ${name}  ${num}  ${element}
    ${statusValue0}     run keyword and return status    wait until page contains element    ${花絮}  1
    ${num1}  set variable   1
    ${name2}  set variable   1
    ${playstatus}   set variable  True
    FOR    ${i}   IN RANGE    10000
        确认键
        Run Keyword And Ignore Error  等待页面出现元素信息  ${点播时间}    10
        ${statusValue}     run keyword and return status    等待页面出现文本信息  立即购买    1
        run keyword if  ${statusValue}==True    Run Keywords  打印日志  第${num}部媒资《${name}》：第${num1}集播放失败需要定购  AND  exit for loop
        ${time1}=   Wait Until Keyword Succeeds  20s  3s  获取媒资播放时间  ${点播当前播放时间}
        ${time2}=   Wait Until Keyword Succeeds  20s  3s  获取媒资播放时间  ${点播总时长}
        run keyword if    '${time1}'=='${time2}'    打印日志  媒资《${name}》：第${num1}集<${name2}>播放失败
        ...     ELSE    打印日志  媒资《${name}》：第${num1}集<${name2}>播放成功
        ${playstatus}=  run keyword if    '${time1}'=='${time2}' or ${playstatus}==False    set variable    False   ELSE    set variable    True
        按次数下移  1
        ${name1}  获取元素属性  ${当前焦点}  name
        向右  1
        ${num1}  evaluate   int(${num1})+1
        ${name2}  获取元素属性  ${当前焦点}  name
        run keyword if  ${playstatus}==False    打印媒资播放失败日志文件  ${name}
        run keyword if  '${name1}' == '${name2}'  Run Keywords  打印日志  第${num}部媒资《${name}》：播放结束  AND  exit for loop
        ...  ELSE  log  继续播放
    END
    run keyword if  ${playstatus}==False    打印媒资播放失败日志文件  ${name}   ELSE    删除文件内容  ${name}
    run keyword if  ${statusValue0}==True  Run Keywords  按次数下移  3    AND  打印日志  开始播放媒资《${name}》花絮
    ...     AND     花絮循环检查  ${name}  ${num}
    按返回直到出现元素  ${element}

电影类型循环检查
    [Documentation]  电影类型循环检查
    [Arguments]    ${name}  ${num}  ${element}
    ${statusValue0}     run keyword and return status    wait until page contains element    ${花絮}  1
    ${playstatus}   set variable  True
    按次数左移  2
    FOR    ${i}   IN RANGE    1
        确认键
        Run Keyword And Ignore Error   等待页面出现元素信息  ${点播时间}    10
        ${statusValue}     run keyword and return status    等待页面出现文本信息  立即购买    1
        run keyword if  ${statusValue}==True    Run Keywords  打印日志  第${num}部媒资《${name}》：第${num1}集播放失败需要定购   AND  exit for loop
        ${time1}=   Wait Until Keyword Succeeds  20s  3s  获取媒资播放时间  ${点播当前播放时间}
        ${time2}=   Wait Until Keyword Succeeds  20s  3s  获取媒资播放时间  ${点播总时长}
        run keyword if    '${time1}'=='${time2}'    打印日志  媒资《${name}》：播放失败
        ...     ELSE    打印日志  媒资《${name}》：播放成功
        ${playstatus}=  run keyword if    '${time1}'=='${time2}' or ${playstatus}==False    set variable    False    ELSE   set variable    True
    END
    run keyword if  ${playstatus}==False    打印媒资播放失败日志文件  ${name}   ELSE    删除文件内容  ${name}
    run keyword if  ${statusValue0}==True  Run Keywords  按次数下移  3    AND  打印日志  开始播放媒资《${name}》花絮
    ...     AND     花絮循环检查  ${name}  ${num}
    按返回直到出现元素  ${element}

花絮循环检查
    [Documentation]  花絮循环检查
    [Arguments]    ${name}  ${num}
    ${num1}  set variable   1
    ${name2}  set variable   1
    ${playstatus}   set variable  True
    FOR    ${i}   IN RANGE    10000
        确认键
        Run Keyword And Ignore Error   等待页面出现元素信息  ${点播时间}    10
        ${statusValue}     run keyword and return status    等待页面出现文本信息  立即购买    1
        run keyword if  ${statusValue}==True    Run Keywords  打印日志  第${num}部媒资《${name}》花絮：第${num1}集播放失败需要定购  AND  exit for loop
        ${time1}=   Wait Until Keyword Succeeds  20s  3s  获取媒资播放时间  ${点播当前播放时间}
        ${time2}=   Wait Until Keyword Succeeds  20s  3s  获取媒资播放时间  ${点播总时长}
        run keyword if    '${time1}'=='${time2}'    打印日志  媒资《${name}》花絮：第${num1}集<${name2}>播放失败
        ...     ELSE    打印日志  媒资《${name}》花絮：第${num1}集<${name2}>播放成功
        ${playstatus}=  run keyword if    '${time1}'=='${time2}' or ${playstatus}==False    set variable    False   ELSE   set variable    True
        按次数上移  2
        向上  0
        ${name1}  获取元素属性  ${当前焦点}  name
        向右  1
        ${num1}  evaluate   int(${num1})+1
        ${name2}  获取元素属性  ${当前焦点}  name
        run keyword if  '${name1}' == '${name2}'  Run Keywords  打印日志  第${num}部媒资《${name}》花絮：播放结束  AND  exit for loop
        ...  ELSE  log  继续播放
    END
    run keyword if  ${playstatus}==False    打印媒资播放失败日志文件  ${name}   ELSE    删除文件内容  ${name}

片库列表循环
    [Documentation]  片库列表循环，第1个参数为开始播放位置，第2个参数为需要播放数量
    [Arguments]    ${start}  ${num}
    媒资播放检查起始位置  ${start}
    ${playnum}    evaluate    int(${start})
    FOR    ${i}   IN RANGE    ${num}
        ${name}  获取元素属性  ${当前焦点}  name
        媒资播放检查  ${name}  ${playnum}  ${片库搜索}
        按次数右移  1
        ${name1}  获取元素属性  ${当前焦点}  name
        run keyword if  '${name}'=='${name1}'    Run Keywords    按次数左移  4
        ...     AND     按次数下移  1
        ${playnum}    evaluate    ${playnum}+1
    END

媒资播放检查起始位置
    [Documentation]  媒资播放检查起始位置
    [Arguments]    ${start}
    ${row}  evaluate  ${start}//5
    ${columns}  evaluate  ${start}%5-1
    按次数下移  ${row}
    按次数右移  ${columns}

进入指定栏目
    [Documentation]  进入指定栏目
    [Arguments]    ${name1}  ${name2}
    返回首页
    返回精选页
    FOR    ${i}   IN RANGE    20
        ${name0}  获取元素属性  ${当前焦点}  name
        run keyword if  '${name0}'=='${name1}'  exit for loop
        ...     ELSE    按次数右移  1
    END
    确认键  5
    等待页面出现元素信息  ${片库搜索}
    打印日志  ---------------------------已进入《${name1}》片库---------------------------
    FOR    ${i}   IN RANGE    20
        ${name0}  获取元素属性  ${当前焦点}  name
        run keyword if  '${name0}'=='${name2}'  exit for loop
        ...     ELSE    向下  1
    END
    校验焦点是否在内容描述上  ${name0}
    打印日志  ------------------------已到达《${name2}》栏目------------------------
    按次数右移  1

获取媒资播放时间
    [Documentation]  获取媒资播放时间
    [Arguments]    ${element}
    ${time}  set variable   00:00:00
    向左  1
    ${page}  get source
    log  ${page}
    ${time}=  Run Keyword And Continue On Failure  get xml locator  ${page}  ${element}  content\-desc
    run keyword if  '${time}'==''   Run Keywords    fail  未获取到时间
    ...  ELSE  log  获取到时间<${time}>
    RETURN  ${time}

打印日志
    [Documentation]  打印日志，记录到console和日志文件
    [Arguments]    ${messagelog}
    ${message_log_filename}  catenate  SEPARATOR=   ${log_path}     \\messagelog\\message_log.txt
    ${time}    get sys date     0   time
    append to file  ${message_log_filename}   ${time} ${messagelog}\r   encoding=UTF-8
    log to console  ${time} ${messagelog}

打印媒资播放失败日志文件
    [Documentation]  打印媒资播放失败日志文件，记录到失败日志文件
    [Arguments]    ${messagelog}
    ${play_error_log}  catenate  SEPARATOR=   ${log_path}     \\messagelog\\play_error_log.txt
    ${statusValue}     run keyword and return status    file should exist  ${play_error_log}
    run keyword if  ${statusValue}==True    记录失败媒资  ${messagelog}   ${play_error_log}
    ...     ELSE    append to file  ${play_error_log}   ${messagelog}\r   encoding=UTF-8

记录失败媒资
    [Documentation]  打印媒资播放失败日志文件，记录到失败日志文件
    [Arguments]    ${messagelog}    ${play_error_log}
    ${file_content_status}  file content include  ${messagelog}    ${play_error_log}
    run keyword if  ${file_content_status}==True    log to console  文件内已存在该失败媒资
    ...     ELSE    append to file  ${play_error_log}   ${messagelog}\r   encoding=UTF-8

删除文件内容
    [Documentation]  删除文件内容
    [Arguments]    ${content}
    ${play_error_log}  catenate  SEPARATOR=   ${log_path}     \\messagelog\\play_error_log.txt
    ${statusValue}     run keyword and return status    file should exist  ${play_error_log}
    run keyword if  ${statusValue}==True    del content  ${content}    ${play_error_log}    ELSE    log to console  文件内不存在该内容

删除日志文件
    [Documentation]  删除日志文件
    ${message_log_filename}  catenate  SEPARATOR=   ${log_path}     \\messagelog\\message_log.txt
    ${statusValue}     run keyword and return status    file should exist  ${message_log_filename}
    run keyword if  ${statusValue}==True    remove file  ${message_log_filename}

按文件内容巡检指定媒资
    [Documentation]  按文件内容巡检指定媒资
    [Arguments]    ${filename}
    @{test_list}  read file    ${filename}
    ${num}  set variable    1
    FOR    ${name}  IN   @{test_list}
        ${search}   topinyin  ${name}
        搜索-输入搜索词  ${search}
        ${statusValue}     run keyword and return status    wait until page contains element    ${搜索为空}  1
        run keyword if  ${statusValue}==True    打印日志  ------------------------未搜索到第${num}部媒资《${name}》------------------------
        ...     ELSE    搜索后移动到指定媒资  ${name}  ${num}
        清空搜索结果
        ${num}  evaluate    ${num}+1
    END

按文件内容打洞巡检指定媒资
    [Documentation]  按文件内容巡检指定媒资
    [Arguments]    ${filename}
    @{test_list}  read file    ${filename}
    ${num}  set variable    1
    FOR    ${nameid}  IN   @{test_list}
        home键
        执行命令  am start -d "mgtviptvburrow://vod/vod_detail_page?from=${platform_name}&actionSourceId=${platform_name}&originalId=${nameid}"
        ${statusValue}     run keyword and return status    wait until page contains element    ${影片名}  10
        run keyword if  ${statusValue}==True    Run Keywords  打印日志  ******************开始播放媒资：第${num}部（${nameid}）******************  AND    等待详情页出现   AND    等待  5
        ...     ELSE    打印日志  ------------------------未找到第${num}部媒资（${nameid}）------------------------
        ${num}  evaluate    ${num}+1
        按次数返回  1    5
        delete line from file  ${filename}  1
    END

搜索后移动到指定媒资
    [Documentation]  搜索后移动到指定媒资
    [Arguments]    ${name}  ${num}
#    搜索结果媒资上焦点
    点击搜索结果媒资  1
    媒资播放检查  ${name}  ${num}   ${搜索键盘区}
#    FOR    ${i}   IN RANGE    20
#        ${text}     set variable    //*[@resource-id="${app_package1}:id/search_media_recycler_view"]/[@focused="true" and @focusable="true"]
#        ${statusValue}     run keyword and return status    wait until page contains element    ${text}  1
#        ${name1}=   run keyword if  ${statusValue}==True    获取元素属性  ${text}  name   ELSE    set variable    错误：已进入详情页
#        run keyword if  '${name1}'=='${name}'   exit for loop
#        按次数右移  1
#        ${name2}    获取元素属性  ${text}  name
#        run keyword if  '${name1}'=='${name2}'   Run Keywords    按次数左移  3   AND  按次数下移  1
#    END
#    run keyword if  '${name1}'=='${name}'   Run Keywords    打印日志  ------------------------找到第${num}部媒资《${name}》，开始播放检查------------------------
#    ...     AND  媒资播放检查  ${name}  ${num}   ${搜索键盘区}
#    ...     ELSE    打印日志  ------------------------未找到第${num}部媒资《${name}》------------------------

搜索结果媒资上焦点
    [Documentation]  搜索结果媒资上焦点
    ${locator}  set variable    xpath=//*[@resource-id="${appPackage1}:id/search_media_recycler_view"]/android.widget.RelativeLayout[1]/android.view.View[1]
    ${focused}  获取元素属性  ${locator}  focused
    ${focusable}    获取元素属性  ${locator}  focusable
    run keyword if  '${focused}'=='true' and '${focusable}'=='true'    log  搜索结果媒资已上焦点
    ...     ELSE    click element  ${locator}

接口返回状态_GET
    [Documentation]  接口返回状态_get
    [Arguments]    ${count}     ${url}
    ${httpstatus}   set variable  True
    FOR    ${i}   IN RANGE    ${count}
        ${code}   check requests status  ${url}
        run keyword if  ${code}==200    log to console  第${i}次测试：GET接口返回正常
        ...     ELSE IF  ${code}==-1  log to console  第${i}次测试：GET接口返回无响应：${code}
        ...     ELSE    log to console   第${i}次测试：GET接口返回异常：${code}
        ${httpstatus}=  run keyword if  ${code}==200 and ${httpstatus}==True    set variable  True   ELSE    set variable  False
    END
    run keyword if  ${httpstatus}==False    fail  GET接口返回存在异常

接口返回状态_POST
    [Documentation]  接口返回状态_get
    [Arguments]    ${count}     ${url}   ${data}
    ${httpstatus}   set variable  True
    FOR    ${i}   IN RANGE    ${count}
        ${code}   check requests status  ${url}  ${data}
        run keyword if  ${code}==200    log to console  第${i}次测试：POST接口返回正常
        ...     ELSE IF  ${code}==-1  log to console    第${i}次测试：POST接口返回无响应：${code}
        ...     ELSE    log to console   第${i}次测试：POST接口返回异常：${code}
        ${httpstatus}=  run keyword if  ${code}==200 and ${httpstatus}==True    set variable  True   ELSE    set variable  False
    END
    run keyword if  ${httpstatus}==False    fail  GET接口返回存在异常

接口返回_GET
    [Documentation]  接口测试_get
    [Arguments]    ${url}
    ${requests_get}   get requests  ${url}
    run keyword if  $requests_get==-1    fail  GET接口返回异常
    ...     ELSE    log to console  GET接口返回数据正常
    RETURN  ${requests_get}

接口返回_POST
    [Documentation]  接口返回_post
    [Arguments]    ${url}   ${data}  ${headers}=None
    ${requests_post}   get requests  ${url}  ${data}  ${headers}
    run keyword if  $requests_post==-1    fail  POST接口返回异常
    ...     ELSE    log to console  POST接口返回数据正常
    RETURN  ${requests_post}

接口返回json数据校验
    [Documentation]  接口返回数据json校验
    [Arguments]     ${json}     ${str_list}     ${value}
    #${json}格式为json
    #${str_list}格式为ad|1,creative,adformat   路径后跟|和数字：为指定第几个，默认为第1个
    ${resule}   check requests json value  ${json}   ${str_list}
    ${error_status}    run keyword and return status   校验参数是否包含  ${resule}   error=-2
    run keyword if  ${error_status}==True   Run Keywords    log to console  ${resule}   AND  fail    路径不正确
    ...  ELSE IF  $resule==-1  fail  路径为空，请指定路径
    ...  ELSE   校验参数是否相等    '${resule}'   '${value}'

接口返回json数据正则校验
    [Documentation]  接口返回数据json正则校验
    [Arguments]     ${json}     ${str_list}     ${value}    ${status}=True
    #${json}格式为json
    #${str_list}格式为ad|1,creative,adformat   路径后跟|和数字：为指定第几个，默认为第1个
    #${value}为正则表达式，如为<\d>等格式则需要进行转义需要填入<\\d>
    ${resule}   check requests json value  ${json}   ${str_list}
    ${error_status}    run keyword and return status   校验参数是否包含  ${resule}   error=-2
    run keyword if  ${error_status}==True   Run Keywords    log to console  ${resule}   AND  fail    路径不正确
    ...  ELSE IF  $resule==-1  fail  路径为空，请指定路径
    ...  ELSE   参数正则匹配    ${resule}   ${value}  ${status}

接口返回json数据指定参数值
    [Documentation]  接口返回数据的指定参数值
    [Arguments]     ${json}     ${str_list}
    #${json}格式为json
    #${str_list}格式为ad|1,creative,adformat   路径后跟|和数字：为指定第几个，默认为第1个
    ${resule}   check requests json value  ${json}   ${str_list}
    ${error_status}    run keyword and return status   校验参数是否包含  ${resule}   error=-2
    run keyword if  ${error_status}==True   Run Keywords    log to console  ${resule}   AND  fail    路径不正确
    ...  ELSE IF  $resule==-1  fail  路径为空，请指定路径
    ...  ELSE   log  ${resule}
    RETURN  ${resule}

接口返回json数据中存在指定参数
    [Documentation]  接口返回数据json校验
    [Arguments]  ${json}     ${str_list}    ${status}=True
    #${status}为True表示指定路径参数存在，为False表示指定路径参数不存在
    ${resule}   check requests json value  ${json}   ${str_list}
    ${error_status}    run keyword and return status   校验参数是否包含  ${resule}   error=-2
    run keyword if  '${error_status}'=='${status}'   fail  参数校验不通过
    ...     ELSE    log to console  参数校验通过

接口参数MD5加密
    [Documentation]  接口参数MD5加密
    [Arguments]     ${str_list}
    ${md5}  computeMD5  ${str_list}
    RETURN  ${md5}

参数正则匹配
    [Documentation]  参数正则匹配
    [Arguments]     ${str}  ${regular}  ${status}
    ${ret}=  run keyword if  ${status}==True  should match regexp   '${str}'  ${regular}    ELSE    SET VARIABLE  无需匹配
    ${status_value}  run keyword and return status  should match regexp   '${str}'  ${regular}
    run keyword if  ${status_value}==${status}  log  校验成功   ELSE   fail  校验失败

随机进行指定的操作
    [Documentation]  随机进行指定的操作
    [Arguments]    ${loop}  ${num}=8
    FOR    ${i}   IN RANGE    ${loop}
        ${random_num}  evaluate  random.randint(1,${num})  random
        run keyword if  ${random_num}==1  向上
        ...     ELSE IF  ${random_num}==2  向下
        ...     ELSE IF  ${random_num}==3  向左
        ...     ELSE IF  ${random_num}==4  向右
        ...     ELSE IF  ${random_num}==5  Run Keywords    打印页面信息   AND  确认键
        ...     ELSE IF  ${random_num}==6  按秒快进  1
        ...     ELSE IF  ${random_num}==7  按秒快退  1
        ...     ELSE IF  ${random_num}==8  Run Keywords    打印页面信息   返回键
        ...     ELSE    Run Keywords    home键  AND  log to console  首页
    END

打印页面信息
    [Documentation]  打印页面信息
    ${info}  get source
    log  ${info}

判断选片大师分屏加载内容
    [Documentation]  判断选片大师分屏加载内容
    等待频道内容出现    ${内容框}  ${选片大师内容}
    ${status}     run keyword and return status  wait until page contains element  ${选片大师内容}   2
    run keyword if  '${status}'=='True'    打印日志  Pass
    ...  ELSE  打印日志  Failed

分屏随机切换
    [Documentation]  分屏随机切换
    [Arguments]    ${num}=13
    ${random_num1}  evaluate  random.randint(1,${num})  random
    ${random_num2}  evaluate  random.randint(1,${num})  random
    返回首页
    按返回直到焦点为指定id    ${首页分屏}
    按次数左移  ${random_num1}   3
    按次数右移  ${random_num2}   3

网络限速配置
    [Documentation]  网络限速配置
    [Arguments]    ${num}=10   ${eth}=eth0
    ${adb_net_command0}    set variable  adb shell "busybox ifconfig | grep eth"
    ${info0}    cmd command   ${adb_net_command0}
    ${status}     run keyword and return status  校验参数是否包含  ${info0}  eth0
    ${eth}=   run keyword if  '${status}'=='True'    set variable    eth0    ELSE    set variable    eth1
    ${adb_net_command1}   set variable  tc qdisc del dev eth0 root
    ${adb_net_command2}   catenate  SEPARATOR=   ${adb_net_command1};  tc qdisc add dev eth0 root handle 1: htb default 10
    ${adb_net_command3}   catenate  SEPARATOR=   ${adb_net_command2};  tc class add dev eth0 parent 1: classid 1:10 htb rate ${num}Kbps ceil ${num}Kbps
    ${adb_net_command4}   catenate  SEPARATOR=   ${adb_net_command3};  tc class add dev eth0 parent 1: classid 1:11 htb rate 10000Kbps ceil 20000Kbps
    ${adb_net_command5}   catenate  SEPARATOR=   ${adb_net_command4};  tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dport 5555 0xffff flowid 1:11
    ${adb_net_command6}   catenate  SEPARATOR=   ${adb_net_command5};  tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip sport 5555 0xffff flowid 1:11
    ${info1}    adb shell command  ${adb_net_command6}
    log to console  设置限速

解除网络限速
    [Documentation]  网络限速配置
    [Arguments]    ${time}=5
    ${adb_net_command1}    set variable  tc qdisc del dev eth0 root;tc class del dev eth0 root
    ${info1}    adb shell command  ${adb_net_command1}
    log to console  关闭限速
    等待  ${time}