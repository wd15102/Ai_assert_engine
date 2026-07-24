*** Settings ***
Documentation    首页方法
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot
Resource   ../../IPTV_HENANYD_72/系统方法.robot

*** Keywords ***
切换频道
    [Documentation]  根据频道名称切换频道并等待频道内容加载完毕
    [Arguments]  ${name}
    FOR  ${i}  IN RANGE  3
        循环判断顶部图片是否消失
        循环判断是否到达频道  ${name}
        ${content_desc}  get element attribute  ${当前焦点}  contentDescription
        ${status}  run keyword and return status  wait until page contains  数据获取异常，请稍后重试    2
        run keyword if  ${status}==True or '${content_desc}'!='${name}'   Run Keywords  log to console  数据异常，需要重新启动  AND    重新启动
        ...  ELSE   Run Keywords    log to console  到达频道<${name}>，内容展示正常  AND    exit for loop
    END
    等待  1

切换频道1
    [Documentation]  根据频道名称切换频道并等待频道内容加载完毕
    [Arguments]  ${name}
    FOR  ${i}  IN RANGE  3
        ${content_desc}     获取当前分屏
        按返回直到焦点位于内容  ${content_desc}
        计算两个分屏之间的差距并移动  ${content_desc}  ${name}
        ${content_desc}  get element attribute  ${当前焦点}  contentDescription
        ${status}  run keyword and return status  wait until page contains  数据获取异常，请稍后重试    2
        run keyword if  ${status}==True or '${content_desc}'!='${name}'   Run Keywords  log to console  数据异常，需要重新启动  AND    重新启动
        ...  ELSE   Run Keywords    log to console  到达频道<${name}>，内容展示正常  AND    exit for loop
    END
    等待  1

获取当前分屏
    ${locator}  set variable  //*[@resource-id="${app_package1}:id/channel_tabs"]/android.view.View[@selected="true"]
    ${content_desc}  get element attribute  ${locator}  contentDescription
    RETURN  ${content_desc}

计算两个分屏之间的差距并移动
    [Arguments]  ${name1}   ${name2}
    ${locator1}  set variable  //*[@content-desc='${name1}']
    ${locator2}  set variable  //*[@content-desc='${name2}']
    ${page}  get source
    ${index1}     get xml locator  ${page}  ${locator1}    index
    ${index2}     get xml locator  ${page}  ${locator2}    index
    ${num1}  evaluate    ${index2}-${index1}
    ${num2}   evaluate    abs(${num1})
    run keyword if  ${num1}>0  按次数右移  ${num2}  ELSE   按次数左移  ${num2}

循环判断顶部图片是否消失
    [Arguments]  ${time}=2
    FOR  ${i}  IN RANGE  20
        ${status}     run keyword and return status  wait until page contains element  ${顶部通栏}   2
        run keyword if  ${status}==False   exit for loop  ELSE   等待  ${time}
    END

循环判断是否到达频道
    [Arguments]  ${name}
    FOR  ${i}  IN RANGE  5
#        ${focused}     get element attribute  xpath=//android.view.View[@content-desc="${name}"]    focused
        ${content_desc}  get element attribute  ${当前焦点}  contentDescription
        run keyword if  '${content_desc}'=='${name}'   exit for loop
        ...     ELSE    点击内容描述    ${name}
        等待  2
        等待频道内容出现    ${内容框}  ${选片大师内容}
    END

等待频道内容出现
    [Documentation]  等待元素加载出现
    [Arguments]  ${name1}    ${name2}   ${time}=3
    FOR    ${i}    IN RANGE   ${time}
        ${status1}     run keyword and return status  wait until page contains element  ${name1}   2
        ${status2}     run keyword and return status  wait until page contains element  ${name2}   2
        Run Keyword If  '${status1}'=='True' or '${status2}'=='True'    exit for loop
        ...     ELSE    log to console  正在加载，继续等待
    END

直播频道进入回看列表
    [Documentation]  从直播频道进入回看列表
    点击内容描述  回看
    wait until page contains element  ${回看频道}   10
    等待  2
    向右
    按键直到焦点位于内容描述上  湖南卫视高清   左

到达频道回看入口
    返回精选页
    切换频道  直播
    按次数下移  2
    按次数左移  1

到达切换模式入口
    返回精选页
    按键直到焦点位于内容描述上  切换模式  上

到达沉浸模式切换模式入口
    返回精选页
    按键直到焦点位于内容描述上  沉浸切换模式  上

到达搜索入口
    返回精选页
    按键直到焦点位于内容描述上  切换模式  上
    按次数右移  1

到达开通会员入口
    返回精选页
    按键直到焦点位于内容描述上  切换模式  上
    按次数右移  2

到达我的页面入口
    返回精选页
    按键直到焦点位于内容描述上  切换模式  上
    按次数右移  3

到达免费电影入口
    返回精选页
    按次数下移  1
    校验焦点是否在元素上  ${免费电影}

到达试看电影入口
    返回精选页
    按次数下移  1
    按次数右移  1
    校验焦点是否在元素上  ${试看电影}

到达付费电影入口
    返回精选页
    按次数下移  1
    按次数右移  2
    校验焦点是否在元素上  ${付费电影}

到达免费电视剧入口
    返回精选页
    按次数下移  1
    按次数右移  1
    按次数下移  1
    校验焦点是否在元素上  ${免费电视剧}

到达付费电视剧入口
    返回精选页
    按次数下移  1
    按次数右移  2
    按次数下移  1
    校验焦点是否在元素上  ${付费电视剧}

到达免费综艺入口
    返回精选页
    按次数下移  2
    按次数右移  1
    按键直到焦点位于元素上  ${免费综艺}    右
    校验焦点是否在元素上  ${免费综艺}

到达试看综艺入口
    返回精选页
    按次数下移  2
    按次数右移  2
    按键直到焦点位于元素上  ${试看综艺}    右
    校验焦点是否在元素上  ${试看综艺}

到达付费综艺入口
    返回精选页
    按次数下移  2
    按次数右移  3
    按键直到焦点位于元素上  ${付费综艺}    右
    校验焦点是否在元素上  ${付费综艺}

到达专题入口
    返回精选页
    切换频道  全部
    切换频道  精选
    切换频道  电视剧
    按次数下移  2
    按次数右移  2

到达小窗播放专题入口
    返回精选页
    确认键
    切换频道  全部
    切换频道  精选
    切换频道  电视剧
    按次数下移  2
    按次数右移  3
    校验焦点是否在内容描述上  小窗播放专题

到达短视频模板专题入口
    返回精选页
    切换频道  全部
    切换频道  精选
    切换频道  电视剧
    按次数下移  2
    按次数右移  4
    校验焦点是否在内容描述上  短视频模板专题

到达组合专题入口
    返回精选页
    切换频道  全部
    切换频道  精选
    切换频道  电视剧
    按次数下移  2

到达会员片库入口
    返回精选页
    切换频道  全部
    切换频道  精选
    切换频道  电视剧
    按次数下移  2
    按次数右移  1

到达首页观看记录入口
    返回精选页
    按次数下移  2
    按键直到焦点位于元素上  ${精选观看历史}  右

到达消息页面入口
    返回精选页
    按键直到焦点位于内容描述上  切换模式  上
    按次数右移  4

到达短视频轮播入口
    返回精选页
    确认键
    切换频道  全部
    切换频道  精选
    切换频道  电视剧
    按次数下移  1    3
    按次数右移  1

到达短视频标签入口
    返回精选页
    确认键
    切换频道  全部
    切换频道  精选
    切换频道  电视剧
    按次数下移  1    3
    按次数右移  4

到达推荐2.0首页入口
    返回精选页
    按次数下移  3
    按键直到出现内容描述  少儿模板  下
    校验焦点是否在内容描述上  天天向上1

到达首页明星入口
    返回精选页
    按次数下移  15
    按键直到出现内容描述  6方图  下
    按次数右移  3
    校验焦点是否在内容描述上  张天爱

到达轮播主题小窗入口
    返回精选页
    确认键
    切换频道  综艺
    按次数下移  2
    校验焦点是否在内容描述上  跳轮播主题-指定频道

到达轮播主题全屏入口
    返回精选页
    确认键
    切换频道  综艺
    按次数下移  2
    按次数右移  1
    校验焦点是否在内容描述上  跳轮播主题全屏-指定频道

到达选片大师独立页入口
    返回精选页
    确认键
    切换频道  综艺
    按次数下移  1
    按次数右移  2
    校验焦点是否在内容描述上  选片大师独立页面

到达会员片库页
    [Documentation]  到达会员片库页
    返回精选页
    确认键
    切换频道  全部
    切换频道  精选
    切换频道  电视剧
    等待  3
    按次数下移  2
    按次数右移  1
    确认键
    等待元素出现  ${会员片库标题}
    等待  2

点击验证页答案
    等待元素出现  ${数字一}
    ${num1}  get text  ${数字一}
    ${num2}  get text  ${数字二}
    ${symbol}   get text  ${计算符}
    ${symbol}  set variable if  '${symbol}'=='+'   +    ${symbol}
    ${symbol}  set variable if  '${symbol}'=='－'   -    ${symbol}
    ${symbol}  set variable if  '${symbol}'=='×'   *    ${symbol}
    ${symbol}  set variable if  '${symbol}'=='÷'   /    ${symbol}
    ${result}   evaluate  str(int(${num1}${symbol}${num2}))
#    log to console  ${num1}${symbol}${num2}=${result}
    @{result_list}  evaluate  list('${result}')
    FOR  ${i}  IN  @{result_list}
#        ${locate}   evaluate  "${答案}".format('${i}')
#        点击元素  ${locate}
#        点击答案  ${i}
        点击答案_新  ${i}
    END

点击答案
    [Arguments]  ${num}
    FOR  ${i}   IN RANGE    4
        ${text}  get element attribute  ${当前焦点}  text
        run keyword if  '${text}'=='${num}'   exit for loop
        ...     ELSE    按次数右移  1
    END
    ${text}  get element attribute  ${当前焦点}  text
    清除历史上报数据
    run keyword if  '${text}'=='${num}'     Run Keywords    确认键     AND     按次数左移  4
    ...     ELSE    log to console  无此答案

点击答案_新
    [Arguments]  ${num}
    清除历史上报数据
    ${text}  get element attribute  ${当前焦点}  text
    ${row}    evaluate    int(${num})%5-int(${text})%5
    ${row1}   evaluate    abs(${row})
    ${column}    evaluate    int(${num})//5-int(${text})//5
    ${column1}   evaluate    abs(${column})
    run keyword if  ${row}>0  按次数右移  ${row1}  ELSE   按次数左移  ${row1}
    run keyword if  ${column}>0  按次数下移  ${column1}  ELSE   按次数上移  ${column1}
    ${text1}  get element attribute  ${当前焦点}  text
    run keyword if  '${text1}'=='${num}'  确认键    ELSE  log to console  无此答案

行业版切换内容到行业1
    ${statusname}  run keyword and return status   等待页面出现内容描述信息  行业1
    run keyword if    ${statusname}==False     Run Keywords   返回首页
    ...  AND    返回精选页
    ...  AND    按次数左移  4
    ...  AND    等待  3
    ...  AND    按次数下移  1
    ...  AND    确认键
    ...  AND    按次数右移  1
    ...  AND    确认键
    ...  AND    按次数左移  2
    ...  AND    确认键  5
    ...  ELSE   log to console  已切换到行业1

少儿模式切换时尚模式
    按返回直到出现元素  ${数字一}
    等待页面出现元素信息  ${数字一}
    校验焦点是否在元素上  ${备选答案一}
    点击验证页答案
    等待页面出现元素信息  ${少儿版}
    按次数左移  3
    确认键
    等待页面出现元素信息  ${免费电影}  20
    log to console  已切换到时尚模式首页

简约模式切换时尚模式
    按返回直到出现元素  ${时尚版}
    按次数左移  1
    确认键
    等待页面出现元素信息  ${免费电影}  20
    log to console  已切换到时尚模式首页

直播列表分类下的频道数量
    [Documentation]  计算直播列表分类下的频道数量
    [Arguments]  ${name1}  ${name2}   ${num}
    ${locator1}  set variable  //*[@resource-id="${app_package1}:id/content"]/android.view.View[@content-desc="${name1}"]
    ${locator2}  set variable  //*[@resource-id="${app_package1}:id/content"]/android.view.View[@content-desc="${name2}"]
    ${page}  get source
    ${index1}     get xml locator  ${page}  ${locator1}    index
    ${index2}     get xml locator  ${page}  ${locator2}    index
    ${num1}  evaluate    ${index2}-${index1}-1
    should be equal   '${num}'   '${num1}'

两个内容描述中间元素数量
    [Documentation]  两个内容描述中间元素数量
    [Arguments]  ${name1}  ${name2}   ${num}
    ${locator1}  set variable  //*[@content-desc='${name1}']
    ${locator2}  set variable  //*[@content-desc='${name2}']
    ${page}  get source
    ${index1}     get xml locator  ${page}  ${locator1}    index
    ${index2}     get xml locator  ${page}  ${locator2}    index
    ${num1}  evaluate    ${index2}-${index1}-1
    should be equal   '${num}'   '${num1}'

等待抽屉模块下分类出现
    [Documentation]  校验抽屉模块下分类是否存在
    [Arguments]  ${name}    ${timeout}=5
    ${locator}  set variable  //*[@resource-id="${app_package1}:id/tab_rv"]/android.view.View[@content-desc="${name}"]
    wait until page contains element  ${locator}  ${timeout}

体育赛程指定日期下赛程数量
    [Documentation]  体育赛程指定日期下赛程数量
    [Arguments]  ${name1}  ${name2}   ${num}
    ${locator1}  set variable  //*[@resource-id="${app_package1}:id/iptv_sport_events_rv"]/android.widget.TextView[@text="${name1}"]
    ${locator2}  set variable  //*[@resource-id="${app_package1}:id/iptv_sport_events_rv"]/android.widget.TextView[@text="${name2}"]
    ${page}  get source
    ${index1}     get xml locator  ${page}  ${locator1}    index
    ${index2}     get xml locator  ${page}  ${locator2}    index
    ${num1}  evaluate    ${index2}-${index1}-1
    should be equal   '${num}'   '${num1}'

呼出版本信息
    [Documentation]  呼出版本信息
    菜单键
    按次数上移  4
    按次数下移  4
    菜单键

检查应急广播消息是否存在
    [Documentation]  检查应急广播消息是否存在
    [Arguments]  ${name}
    ${width}  ${height}  获取屏幕宽高
    ${width_k}    evaluate    ${width}/1920
    ${height_k}    evaluate    ${height}/1080
    ${x0}    evaluate  96*${width_k}
    ${y0}    evaluate  0*${height_k}
    ${x1}    evaluate  240*${width_k}
    ${y1}    evaluate  120*${height_k}
    校验坐标图片是否包含文字    ${x0}   ${y0}   ${x1}   ${y1}   ${name}

检查应急广播消息不存在
    [Documentation]  检查应急广播消息不存在
    [Arguments]  ${name}
    ${width}  ${height}  获取屏幕宽高
    ${width_k}    evaluate    ${width}/1920
    ${height_k}    evaluate    ${height}/1080
    ${x0}    evaluate  96*${width_k}
    ${y0}    evaluate  0*${height_k}
    ${x1}    evaluate  240*${width_k}
    ${y1}    evaluate  120*${height_k}
    ${status}  run keyword and return status    校验坐标图片是否包含文字    ${x0}   ${y0}   ${x1}   ${y1}   ${name}
    run keyword if  ${status}==False  log to console  图片不存在  ELSE   fail    图片存在

等待应急广播消失
    [Documentation]  等待应急广播消失
    [Arguments]  ${name}    ${time}
    ${width}  ${height}  获取屏幕宽高
    ${width_k}    evaluate    ${width}/1920
    ${height_k}    evaluate    ${height}/1080
    ${x0}    evaluate  96*${width_k}
    ${y0}    evaluate  0*${height_k}
    ${x1}    evaluate  240*${width_k}
    ${y1}    evaluate  120*${height_k}
    FOR  ${i}   IN RANGE    ${time}
        ${status}  run keyword and return status    校验坐标图片是否包含文字    ${x0}   ${y0}   ${x1}   ${y1}   ${name}
        run keyword if  ${status}==True  等待  1   ELSE   exit for loop
    END

检查应急广播内容是否变更
    [Documentation]  检查应急广播消息是否存在
    [Arguments]  ${time}=5
    ${width}  ${height}  获取屏幕宽高
    ${width_k}    evaluate    ${width}/1920
    ${height_k}    evaluate    ${height}/1080
    ${x0}    evaluate  240*${width_k}
    ${y0}    evaluate  0*${height_k}
    ${x1}    evaluate  1600*${width_k}
    ${y1}    evaluate  120*${height_k}
    校验坐标图片是否发生变化    ${x0}   ${y0}   ${x1}   ${y1}   ${time}

循环检查分屏内容加载情况
    [Documentation]  循环检查分屏内容加载情况
    按秒快退  2
    FOR  ${i}   IN RANGE    20
        ${content_desc}  get element attribute  ${当前焦点}  contentDescription
        ${status}  run keyword and return status  wait until page contains  数据获取异常，请稍后重试    5
        run keyword if  ${status}==True   Run Keywords  log to console  数据异常，需要重新启动  AND    设备截屏
        ...  ELSE   Run Keywords    log to console  到达频道<${content_desc}>，内容展示正常   AND    按次数右移  1
        ${content_desc1}  get element attribute  ${当前焦点}  contentDescription
        run keyword if  '${content_desc1}'=='${content_desc}'   exit for loop
    END

命令打开debug日志
    [Documentation]  命令打开debug日志
    菜单键
    按次数下移  3
    按次数上移  3
    按次数返回  1

打开调试开关
    [Documentation]  打开调试开关
    home键
    按次数上移  2
    按键直到焦点位于内容描述上  电视营业厅    右
    确认键
    等待元素出现  ${版本信息_新}
    按键直到焦点位于内容描述上  订购信息页    下
    按键直到焦点位于内容描述上  关于我们  右
    确认键
    等待文本出现  客服电话
    按次数下移  3
    按次数上移  3

关闭微信引导弹窗
    [Documentation]  关闭微信引导弹窗
    ${status}     run keyword and return status    wait until page contains   关闭提醒    1
    run keyword if    '${status}'=='True'    按次数确认  1
    ...     ELSE    log to console  无微信引导弹窗

沉浸模式进入标准模式
    [Documentation]  沉浸模式进入标准模式
    home键
    按次数上移  5
    按次数右移  1
    确认键
    按次数右移  1
    确认键
    等待元素出现  ${首页logo}

从即映进入即映独立页入口
    [Documentation]  从即映进入即映独立页
    返回沉浸模式默认分屏
    切换频道  影视
    按键直到出现内容描述  二维码通栏模板  下
    按次数下移  1
    按键直到焦点位于内容描述上  即映独立页    右

从标准进入即映独立页入口
    [Documentation]  从标准进入即映独立页
    返回精选页
    切换频道  电视剧
    按次数下移  1
    按键直到焦点位于内容描述上  电视剧  下
    按次数下移  1
    按键直到焦点位于内容描述上  即映独立页    右