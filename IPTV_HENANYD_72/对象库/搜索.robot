*** Settings ***
Documentation    搜索方法
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot

*** Keywords ***
切换到全键盘
    点击文本  全键盘

切换到九宫格
    点击文本    九宫格

进入搜索页
    ${locator}  set variable    xpath=//*[@resource-id="${appPackage1}:id/top_menu_view"]/android.widget.ImageView[1]
    wait until page contains element    ${locator}      20
    click element  ${locator}
    wait until page contains  element   id=${appPackage1}:id/search_edit_rect     20

搜索-九宫格输入搜索词
    [Arguments]    ${search_text}
    @{text_list}   evaluate  list('${search_text}')
    切换到九宫格
    FOR    ${i}    IN  @{text_list}
        等待  3
        click element  android=new UiSelector().resourceId("${appPackage1}:id/t9_keyboard_gridview").fromParent(new UiSelector().textContains("${i}"))
        wait until page contains element    ${九宫格展开}  5
        click element   //*[@resource-id="${appPackage1}:id/t9_keyboard_layout"]/android.widget.RelativeLayout/descendant::android.widget.TextView[@text='${i}']
    END
    等待搜索页出现

搜索-删除单个搜索词
    [Arguments]
    wait until page contains element    ${删除搜索}    20
    click element  ${删除搜索}
    等待搜索页出现

搜索-输入搜索词
    [Arguments]    ${search_text}
    @{text_list}   evaluate  list('${search_text}')
    等待搜索页出现
    切换到全键盘
    FOR    ${i}    IN  @{text_list}
        点击搜索文本  ${i}
    END
    等待搜索页出现

搜索-输入搜索词-新
    [Arguments]    ${search_text}
    @{text_list}   evaluate  list('${search_text}')
    等待搜索页出现
    切换到全键盘
    :FOR    ${i}    IN  @{text_list}
    \   点击搜索文本  ${i}
    等待搜索页出现

点击搜索文本
    [Documentation]  等待文本出现后，再进行点击
    [Arguments]  ${text}
    wait until page contains element   xpath=//*[@resource-id="${appPackage1}:id/full_keyboard_gridview"]/android.widget.TextView[contains(@text,'${text}')]   20
    click element  xpath=//*[@resource-id="${appPackage1}:id/full_keyboard_gridview"]/android.widget.TextView[contains(@text,'${text}')]

焦点移动到搜索结果
    [Documentation]  焦点从搜索区移动到搜索结果
    点击文本_模糊匹配  全部结果

点击搜索结果媒资
    [Documentation]  按序号点击搜索结果中的媒资，序号从1开始
    [Arguments]    ${num}
    Run Keyword And Ignore Error    焦点移动到搜索结果
    ${num1}  evaluate    ${num}-1
    ${locator0}   set variable    xpath=//*[@resource-id="${appPackage1}:id/search_media_recycler_view"]/android.view.View[@index=\'0\']
    ${status}     run keyword and return status  wait until page contains element  ${locator0}   2
    ${locator}=  Run Keyword If  ${status}==False  set variable    xpath=//*[@resource-id="${appPackage1}:id/search_media_recycler_view"]/android.widget.RelativeLayout[@index=\'${num1}\']
    ...  ELSE   set variable    xpath=//*[@resource-id="${appPackage1}:id/search_media_recycler_view"]/android.view.View[@index=\'${num1}\']
    wait until page contains element    ${locator}      20
    Run Keyword If  ${status}==False  click element  ${locator}
    ...     ELSE    焦点移动到指定媒资上   ${num1}
    等待  3

点击搜索推荐媒资
    [Documentation]  按序号点击搜索推荐中的媒资，序号从1开始
    [Arguments]    ${num}
    ${num1}  evaluate    ${num}-1
    ${locator}  set variable    xpath=//*[@resource-id="${appPackage1}:id/media_item_view" and @index=\'${num1}\']
    wait until page contains element    ${locator}      20
    click element  ${locator}

焦点移动到指定媒资上
    [Documentation]  存在搜索媒资时，焦点移动到指定媒资上
    [Arguments]    ${num}
    按次数左移  1
    按次数下移  1
    按次数上移  10   0
    按次数上移  1    3
    等待搜索页出现
    按次数右移  1
    ${row}    evaluate    int(${num})%3
    ${column}    evaluate    int(${num})//3
    run keyword if  ${row}>0  按次数右移  ${row}
    run keyword if  ${column}>0  按次数下移  ${column}

点击搜索结果明星
    [Documentation]  按序号点击搜索结果中的媒资，序号从1开始
    [Arguments]    ${num}
    ${locator}  set variable    xpath=//*[@resource-id="${appPackage1}:id/search_star_recycler_view"]/android.widget.RelativeLayout[${num}]
    wait until page contains element    ${locator}      20
    click element  ${locator}

点击搜索历史媒资
    [Documentation]  按序号点击搜索历史中的媒资，序号从1开始
    [Arguments]    ${num}
    ${locator}  set variable    xpath=//*[@resource-id="${appPackage1}:id/search_history_recycler_view"]/android.widget.TextView[@index='${num}']
    wait until page contains element    ${locator}      20
    click element  ${locator}

返回搜索页面
    [Documentation]  返回搜索页面
    :FOR    ${i}   IN RANGE    5
    \    ${statusValue}     run keyword and return status   wait until page contains element    xpath=//android.widget.TextView[@text='大家都在搜']  2
    \   log  ${statusValue}
    \   run keyword if    ${statusValue}   exit for loop
    \   Go Back
    \   sleep  2

清空搜索结果
    [Documentation]  返回搜索页面
    按返回直到出现元素  ${清空搜索}
    wait until page contains element    ${清空搜索}  5
    click element  ${清空搜索}
    sleep  2

等待搜索出现
    [Documentation]  等待元素加载出现
    [Arguments]  ${name1}    ${name2}   ${name3}   ${name4}  ${time}=5
    FOR    ${i}    IN RANGE   ${time}
        ${status1}     run keyword and return status  wait until page contains element  ${name1}   2
        ${status2}     run keyword and return status  wait until page contains element  ${name2}   2
        ${status3}     run keyword and return status  wait until page contains element  ${name3}   2
        ${status4}     run keyword and return status  wait until page contains element  ${name4}   2
        Run Keyword If  '${status1}'=='True' or '${status2}'=='True' or '${status3}'=='True' or '${status4}'=='True'    exit for loop
        ...     ELSE    log to console  正在加载，继续等待
    END

搜索结果海报是否存在指定媒资
    [Documentation]  搜索结果海报是否存在指定媒资
    [Arguments]    ${name}  ${time}=5
    wait until page contains element    xpath=//android.view.View[contains(@content-desc,'${name}')]  ${time}

搜索-校验焦点是否在指定字母上
    [Documentation]  全键盘字母元素信息
    [Arguments]    ${name}
    ${locator}      set variable    //android.widget.TextView[contains(@text,'${name}')]
    ${focused}     get element attribute  ${locator}    focused
    should be true      '${focused}'=='true'

搜索-校验焦点是否在指定媒资上
    [Documentation]     焦点是否在指定媒资上
    [Arguments]    ${name}
    ${locator}      set variable    //android.view.View[@content-desc='${name}']
    ${focused}     get element attribute  ${locator}    focused
    should be true      '${focused}'=='true'

搜索-校验焦点是否在指定搜索结果位上
    [Documentation]     焦点是否在指定媒资上
    [Arguments]    ${num}
    ${locator}      set variable    //*[@resource-id="${app_package1}:id/search_media_recycler_view"]/android.view.View[${num}]
    ${focused}     get element attribute  ${locator}    focused
    should be true      '${focused}'=='true'

搜索-校验键盘元素的数量
    [Arguments]     ${count}
    ${locator}  set variable    //*[@resource-id="${appPackage1}:id/input_keyboard_fragment"]/descendant::android.widget.TextView
    ${result}  get matching xpath count  ${locator}
    should be equal  ${result}  ${count}

搜索-校验媒资数量
    [Arguments]     ${count}
    ${locator}  set variable    //*[@resource-id="${appPackage1}:id/media_item_view"]
    ${result}  get matching xpath count  ${locator}
    should be equal  ${result}  ${count}

搜索-校验搜索结果媒资数量
    [Arguments]     ${count}
    ${locator}  set variable    //*[@resource-id="${appPackage1}:id/search_media_recycler_view"]/descendant::android.view.View
    ${result}  get matching xpath count  ${locator}
    should be equal  ${result}  ${count}

语音输入
    [Arguments]     ${text}
    ${adb_messge}    set variable  am startservice -a com.iflytek.xiri2.START --es startmode text --es text ${text}
    ${info}    adb shell command  ${adb_messge}  'UTF-8'
    等待  3