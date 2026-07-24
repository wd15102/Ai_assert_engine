*** Settings ***
Library     AppiumLibrary
Library     TestLibrary
Library     ../TestLibrary/image_process.py
Variables   config.py
Resource    遥控按键.robot

*** Keywords ***
获取校验结果
    [Documentation]  获取上报数据的校验结果
    [Arguments]    ${field}    ${test_point}    ${field_table}  ${act_count}=1
    FOR    ${i}   IN RANGE    3
        ${result}    Check Result    ${field}    ${platform}    ${test_point}    ${field_table}    ${act_count}    ${TESTNAME}
        run keyword if   ${result['count'][0]}==0   sleep   2   ELSE    exit for loop
    END
    #    run keyword if  ${result['count'][0]}!=1    log   条数错误：${result['count'][1]}  error
    #    run keyword if  ${result['field'][0]}!=1    log   字段错误：${result['field'][1]}  error
    #    run keyword if  ${result['errdata'][0]}!=1  log   字段值错误：${result['errdata'][1]}  error
#    run keyword if  ${result['count'][0]}!=1 or ${result['field'][0]}!=1 or ${result['errdata'][0]}!=1    fail  ${result}
#    ${error}    set variable   ${EMPTY}
    ${error1}=   run keyword if  ${result['count'][0]}!=1    set variable  条数错误：${result['count'][1]}  ELSE   set variable   ${EMPTY}
    ${error2}=   run keyword if  ${result['field'][0]}!=1    set variable  字段错误：${result['field'][1]}  ELSE   set variable   ${EMPTY}
    ${error3}=   run keyword if  ${result['errdata'][0]}!=1  set variable  字段值错误：${result['errdata'][1]}  ELSE   set variable   ${EMPTY}
    ${error4}=   run keyword if  ${result['math'][0]}!=1  set variable  请求方式错误：${result['math'][1]}  ELSE   set variable   ${EMPTY}
    ${error}   catenate  SEPARATOR=   ${error1}    ${error2}    ${error3}   ${error4}
    run keyword if  ${result['count'][0]}!=1 or ${result['field'][0]}!=1 or ${result['errdata'][0]}!=1 or ${result['math'][0]}!=1  fail  ${error}

获取校验结果_不上报
    [Documentation]  获取不上报的数据校验结果
    [Arguments]    ${field}    ${test_point}    ${field_table}
    sleep  3
    ${result}    check result    ${field}    ${platform}    ${test_point}    ${field_table}     1    ${TESTNAME}
    run keyword if  ${result['count'][0]}!=0    log     条数错误：${result['count'][0]}  error
    ...     ELSE    log     条数正确，未上报
#    run keyword if  (${result['count'][0]}==0)==0   capture page screenshot  ${TESTNAME}.png
    should be true  (${result['count'][0]}==0)==1    上报数据校验失败

获取校验结果_数量校验
    [Documentation]  获取上报数据的校验结果，只校验数量
    [Arguments]    ${field}    ${test_point}    ${field_table}  ${act_count}=1
    FOR    ${i}   IN RANGE    3
        ${result}    Check Result    ${field}    ${platform}    ${test_point}    ${field_table}    ${act_count}    ${TESTNAME}
        run keyword if   ${result['count'][0]}==0   sleep   2   ELSE    exit for loop
    END
    ${error1}=   run keyword if  ${result['count'][0]}!=1    set variable  条数错误：${result['count'][1]}  ELSE   set variable   ${EMPTY}
    ${error}   catenate  SEPARATOR=   ${error1}
    run keyword if  ${result['count'][0]}!=1  fail  ${error}

执行开始时间
    [Documentation]  获取当前测试机时间
    [Arguments]    ${time}
    ${now}    get autotest time  ${time}
    log to console  执行开始时间<${now}>

执行时间
    [Documentation]  判断循环执行时间
    [Arguments]    ${starttime}  ${time}
    ${now}    get autotest time
    ${time0}  get autotest time  ${now}
    run keyword if  int(${now})-int(${starttime}) >= int(${time})   Run Keywords    log to console  已到达执行时间<${time0}>   AND    exit for loop
    ...    ELSE     log  未到达执行时间

等待页面出现文本信息
    [Arguments]  ${text}  ${timeout}=5
    wait until page contains  ${text}  ${timeout}

等待页面不出现文本信息
    [Arguments]  ${text}  ${timeout}=5
    wait until page does not contain  ${text}  ${timeout}

等待页面出现元素信息
    [Arguments]  ${locator}  ${timeout}=5
    ${clean_xpath}    去掉xpath前缀     ${locator}
    wait until page contains element  ${clean_xpath}  ${timeout}

等待页面不出现元素信息
    [Arguments]  ${locator}  ${timeout}=5
    wait until page does not contain element  ${locator}  ${timeout}

等待页面出现内容描述信息
    [Arguments]  ${content-desc}  ${timeout}=5
    ${locator}  set variable  //*[@content-desc='${content-desc}']
    wait until page contains element  ${locator}  ${timeout}

等待页面出现内容描述信息_模糊匹配
    [Arguments]  ${content-desc}  ${timeout}=5
    ${locator}  set variable  //*[contains(@content-desc,'${content-desc}')]
    wait until page contains element  ${locator}  ${timeout}

等待页面不出现内容描述信息
    [Arguments]  ${content-desc}  ${timeout}=5
    ${locator}  set variable  xpath=//*[@content-desc='${content-desc}']
    wait until page does not contain element  ${locator}  ${timeout}

校验参数是否相等
    [Arguments]  ${first}   ${second}
    should be equal  ${first}   ${second}

校验参数是否不相等
    [Arguments]  ${first}   ${second}
    should not be equal  ${first}   ${second}

校验参数是否包含
    [Arguments]  ${container}   ${item}
    should contain  ${container}   ${item}

校验参数是否不包含
    [Arguments]  ${container}   ${item}
    should not contain  ${container}   ${item}

校验参数是否为真
    [Arguments]  ${condition}
    should be true  ${condition}

校验焦点是否在元素上
    [Arguments]  ${locator}
    ${clean_xpath}    去掉xpath前缀     ${locator}
    wait until page contains element  ${clean_xpath}
    ${focused}     get element attribute  ${clean_xpath}    focused
    should be true      '${focused}'=='true'

校验焦点是否在指定元素的子节点的内容描述上
    [Arguments]  ${locator}  ${name}   ${sec}=1
    ${locator}  set variable  ${locator}//*[@focused="true" and @focusable="true" and @content-desc="${name}"]
    ${clean_xpath}    去掉xpath前缀     ${locator}
    wait until page contains element  ${clean_xpath}    ${sec}

校验焦点是否在两个元素其中一个上
    [Arguments]  ${locator1}  ${locator2}
    ${clean_xpath1}    去掉xpath前缀     ${locator1}
    ${clean_xpath2}    去掉xpath前缀     ${locator2}
    wait until page contains element  ${clean_xpath1}
    wait until page contains element  ${clean_xpath2}
    ${focused1}     get element attribute  ${locator1}    focused
    ${focused2}     get element attribute  ${locator2}    focused
    run keyword if  '${focused1}'=='false' and '${focused2}'=='false'  fail  焦点不正确

校验焦点是否在内容描述上
    [Arguments]  ${text}    ${sec}=3
    ${locator}  set variable  //*[@focused="true" and @focusable="true" and @content-desc="${text}"]
    wait until page contains element  ${locator}    ${sec}

校验焦点是否在指定几个内容描述上
    [Arguments]  ${text1}=aaa   ${text2}=aaa    ${text3}=aaa  ${text4}=aaa   ${text5}=aaa
    ${locator1}   set variable  //*[@focused="true" and @focusable="true" and @content-desc="${text1}"]
    ${locator2}   set variable  //*[@focused="true" and @focusable="true" and @content-desc="${text2}"]
    ${locator3}   set variable  //*[@focused="true" and @focusable="true" and @content-desc="${text3}"]
    ${locator4}   set variable  //*[@focused="true" and @focusable="true" and @content-desc="${text4}"]
    ${locator5}   set variable  //*[@focused="true" and @focusable="true" and @content-desc="${text5}"]
    sleep  3
    ${statusValue1}  run keyword and return status   wait until page contains element  ${locator1}    1
    ${statusValue2}  run keyword and return status   wait until page contains element  ${locator2}    1
    ${statusValue3}  run keyword and return status   wait until page contains element  ${locator3}    1
    ${statusValue4}  run keyword and return status   wait until page contains element  ${locator4}    1
    ${statusValue5}  run keyword and return status   wait until page contains element  ${locator5}    1
    run keyword if  ${statusValue1}==False and ${statusValue2}==False and ${statusValue3}==False and ${statusValue4}==False and ${statusValue5}==False  fail  焦点不在指定内容描述上

校验焦点是否在内容描述子节点上
    [Arguments]  ${text}    ${sec}=3
    ${locator}  set variable  //*[@content-desc="${text}"]//*[@focused="true" and @focusable="true"]
    wait until page contains element  ${locator}    ${sec}

校验焦点是否在内容描述上_模糊匹配
    [Arguments]  ${text}
    ${locator}  set variable  //*[contains(@content-desc,'${text}')]
    wait until page contains element  ${locator}
    ${focused}     get element attribute  ${locator}    focused
    should be true      '${focused}'=='true'

校验选中是否在内容描述上
    [Arguments]  ${text}
    ${locator}  set variable  //*[@selected="true" and @content-desc="${text}"]
    wait until page contains element  ${locator}

校验焦点是否在文本上
    [Arguments]  ${text}  ${sec}=20
    ${locator}  set variable  //*[@focused="true" and @focusable="true" and @text="${text}"]
    wait until page contains element  ${locator}  ${sec}

校验焦点是否在文本上_模糊匹配
    [Arguments]  ${text}    ${sec}=2
#    ${locator}  set variable  //*[contains(@text,'${text}')]
    ${locator}  set variable  //*[@focused="true" and @focusable="true" and contains(@text,'${text}')]
    wait until page contains element  ${locator}  ${sec}
#    ${focused}     get element attribute  ${locator}    focused
#    should be true      '${focused}'=='true'

校验元素文本内容是否为指定值
    [Arguments]  ${locator}     ${string}
    ${clean_xpath}    去掉xpath前缀     ${locator}
    wait until page contains element  ${clean_xpath}  20
    ${str}      get text    ${clean_xpath}
    should be equal  ${str}     ${string}

校验元素内容描述是否为指定值
    [Arguments]  ${locator}     ${string}   ${time}=20
    ${clean_xpath}    去掉xpath前缀     ${locator}
    wait until page contains element  ${clean_xpath}  ${time}
    ${str}  get element attribute   ${locator}  ${contentDescription}
    ${str}  run keyword if   '${str}'==''   get element attribute   ${locator}  content-desc    ELSE    set variable  ${str}
    should be equal  ${str}  ${string}

校验元素出现的次数
    [Arguments]  ${locator}     ${count}    ${time}=3
    ${clean_xpath}    去掉xpath前缀     ${locator}
    run keyword if  ${count}!=0     wait until page contains element  ${clean_xpath}  20
    ...     ELSE    等待  ${time}
#    ${elements}  get webelements  ${locator}
#    length should be  ${elements}  ${count}
    ${page}  get source
    ${result}  get matching xpath count  ${clean_xpath}
    run keyword if  ${result}==0 and ${count}==0    log  "${locator}"元素不存在
    ...     ELSE    should be equal  ${result}  ${count}

校验元素文本出现的次数
    [Arguments]  ${text}     ${count}     ${time}=3
    ${locator}  set variable  //*[@text='${text}']
    run keyword if  ${count}!=0    wait until page contains   ${text}  20
    ...     ELSE    等待  ${time}
    ${page}  get source
    ${result}  get matching xpath count  ${locator}
    run keyword if  ${result}==0 and ${count}==0    log  "${text}"文本不存在
    ...     ELSE    should be equal  ${result}  ${count}

校验元素文本出现的次数_模糊匹配
    [Arguments]  ${text}     ${count}
    ${locator}  set variable  //*[contains(@text,"${text}")]
    run keyword if  ${count}!=0    wait until page contains element  ${locator}  20
    ...     ELSE    等待  3
    ${result}  get matching xpath count  ${locator}
    run keyword if  ${result}==0 and ${count}==0    log  "${text}"文本不存在
    ...     ELSE    should be equal  ${result}  ${count}

校验指定元素下文本出现的次数_模糊匹配
    [Arguments]  ${text}    ${name}     ${count}
    ${locator}  set variable  ${name}//*[contains(@text,"${text}")]
    ${clean_xpath}    Evaluate    '${locator}'[6:] if '${locator}'.startswith('xpath=') else '${locator}'
    run keyword if  ${count}!=0    wait until page contains element  ${locator}  20
    ...     ELSE    等待  3
    ${result}  get matching xpath count  ${clean_xpath}
    run keyword if  ${result}==0 and ${count}==0    log  "${text}"文本不存在
    ...     ELSE    should be equal  ${result}  ${count}

校验内容描述出现次数
    [Arguments]  ${text}  ${count}  ${time}=3
    ${locator}  set variable  //*[@content-desc="${text}"]
    run keyword if  '${count}'=='0'     等待  ${time}
    ...     ELSE    wait until page contains  ${text}  20
    ${result}  get matching xpath count  ${locator}
    run keyword if  ${result}==0 and ${count}==0    log  "${text}"内容描述不存在
    ...     ELSE    should be equal  ${result}  ${count}

校验内容描述出现次数_模糊匹配
    [Arguments]  ${text}  ${count}
    ${locator}  set variable  //*[contains(@content-desc,"${text}")]
    run keyword if  ${count}!=0     wait until page contains element  ${locator}  20
    ...     ELSE    等待  3
    ${result}  get matching xpath count  ${locator}
    run keyword if  ${result}==0 and ${count}==0    log  "${text}"内容描述不存在
    ...     ELSE    should be equal  ${result}  ${count}

校验元素位置是否居中
    [Arguments]  ${locator}  ${deviation}=250
    ${height}  get window height
    ${height}  evaluate  int(${height})
    wait until page contains element  ${locator}  20
    ${location}  get element location  ${locator}
    ${y}  evaluate  int(${location}[y])
    ${result}  evaluate  abs(${height}/2-${y})
    should be true  ${result}<${deviation}

校验数字是否相等
    [Arguments]  ${first}   ${second}
    Should Be Equal As Numbers    ${first}   ${second}

去掉xpath前缀
    [Arguments]    ${locator}
    # 先判断是否以 xpath= 开头
    ${has_prefix}    Run Keyword And Return Status    Should Start With    ${locator}    xpath=
    # 有才去掉，没有保持原样
    ${clean}    Run Keyword If    ${has_prefix}
    ...    Get Substring    ${locator}    6
    ...    ELSE
    ...    Set Variable    ${locator}
    RETURN    ${clean}