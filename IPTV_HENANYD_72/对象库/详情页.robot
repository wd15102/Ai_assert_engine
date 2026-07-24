*** Settings ***
Documentation    详情页方法
Library  AppiumLibrary
Resource  ../../IPTV_HENANYD_72/对象库/公共方法.robot


*** Keywords ***
进入媒资详情页
    [Documentation]  点击媒资名字进入媒资详情页
    [Arguments]  ${name}
    点击内容描述  ${name}
    ${status}     run keyword and return status    wait until page contains element    ${详情页收藏}  5
    run keyword if    ${status}==True     log to console  已进入详情页
    ...     ELSE    点击内容描述  ${name}
    等待详情页出现

焦点移动到顶部
    [Documentation]  将焦点移动到顶部菜单的第一个位置
    点击元素  ${详情页顶部菜单}
    按方向移动  上    2

焦点移动到顶部推广
    [Documentation]  从详情页顶部的推广按钮进入推广页
    焦点移动到顶部

焦点移动到搜索
    [Documentation]  从详情页顶部的搜索按钮进入搜索页
    焦点移动到顶部
    按方向移动  右    1

焦点移动到开通会员
    [Documentation]  从详情页顶部的开通会员按钮进入开通会员页
    焦点移动到顶部
    按方向移动  右    2

焦点移动到我的
    [Documentation]  从详情页顶部的我的按钮进入我的页
    焦点移动到顶部
    按方向移动  右    3

向右滑动显集
    [Documentation]  向右滑动到显示集数
    [Arguments]  ${num}
    ${series}   evaluate  "${剧集列表}".format('${num}')
    FOR    ${i}    IN RANGE    30
       swipe by percent    60     100    498     498     200
       ${status}   run keyword and return status  wait until page contains element  ${series}  2
       exit for loop if  ${status}
    END

切换集数
    [Documentation]  根据剧集序号进行切换
    [Arguments]  ${num}
    ${num1}  evaluate  ${num}-1
    ${series}   evaluate  "${剧集列表}".format(${num1})
    点击元素  ${series}

点击全屏或购买
    [Documentation]  详情页进入全屏播放
    点击元素  ${全屏}

全屏播放
    [Documentation]  点击小视频进入全屏播放
    点击元素  ${全屏}

返回详情页
    [Documentation]  返回详情页
    按返回直到出现元素  ${详情页收藏}

显示相关推荐
    [Documentation]  向下滑动到相关推荐
    按方向滑动  下    ${绯闻计划}

显示看了还会看
    [Documentation]  向下滑动到看了还会看
    按方向滑动  下    ${血色蔷薇}

呼出选集浮层
    [Documentation]  全屏播放页呼出选集浮层
    等待  3
    按次数下移  2
    按次数上移  1
    wait until page contains  选集

订购返回详情页
    [Documentation]  从订购页中返回到详情页
    返回键
    ${status}   run keyword and return status  wait until page contains element  ${订购包}  2
    run keyword if  ${status}==True   Run Keywords    向下
    ...  AND  向左
    ...  AND  确认键
    ...  ELSE   log to console  已返回详情页

海报媒资校验
    [Documentation]  海报媒资校验
    [Arguments]  ${name}    ${num}=1
    确认键  5
    ${status}   run keyword and return status   等待页面出现文本信息  提示  1
    run keyword if  ${status}==False  Run Keywords   等待页面出现元素信息  ${详情页收藏}
    ...     AND     校验元素文本出现的次数  ${name}    ${num}
    ...     AND     log to console  跳转媒资成功
    ...     ELSE    log to console  进入详情页报错
    详情页退出

详情页检查瀑布流
    [Documentation]  详情页检查瀑布流
    按键直到出现元素信息  ${明星区域}  下
    按键直到出现元素信息  ${推荐区域}  下

详情页进全屏
    [Documentation]  详情页进全屏
