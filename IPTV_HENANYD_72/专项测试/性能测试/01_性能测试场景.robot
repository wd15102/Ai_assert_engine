*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../IPTV_HNYD_64/对象库/公共方法.robot
Resource          ../../../IPTV_HNYD_64/对象库/首页.robot
Resource          ../../../IPTV_HNYD_64/对象库/专项测试.robot
Resource          ../../../系统方法.robot

Suite Setup     启动应用
Suite Teardown      退出应用

*** Test Cases ***
case_001 我的页面进入消费记录页面
    [Documentation]  我的页面进入消费记录页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    返回首页
    返回精选页
    按次数上移  1
    按次数右移  2
    确认键
    等待我的页出现
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在内容描述上  消费记录
        确认键
        等待页面出现文本信息  消费记录
        随机进行指定的操作  30   5
        按返回直到出现元素  ${版本信息}
    END

case_002 我的页面进入我的订购页面
    [Documentation]  我的页面进入我的订购页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    按返回直到出现元素  ${版本信息}
    按次数右移  1
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在内容描述上  我的订购
        确认键
        等待页面出现文本信息  我的订购
        按返回直到出现元素  ${版本信息}
    END

case_003 我的页面进入微信绑定页面
    [Documentation]  我的页面进入微信绑定页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    按返回直到出现元素  ${版本信息}
    按次数右移  1
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在内容描述上  绑定微信
        确认键
        等待页面出现文本信息  绑定微信
        确认键
        按返回直到出现元素  ${版本信息}
    END

case_004 我的页面进入会员卡激活页面
    [Documentation]  我的页面进入会员卡激活页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    按返回直到出现元素  ${版本信息}
    按次数右移  1
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在内容描述上  会员卡激活
        确认键
        等待页面出现文本信息  会员卡激活
        随机进行指定的操作  30   5
        按返回直到出现元素  ${版本信息}
    END

case_005 我的页面进入观看历史页面
    [Documentation]  我的页面进入观看历史页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    按返回直到出现元素  ${版本信息}
    按次数下移  2
    按次数右移  5
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在元素上  ${全部记录}
        确认键
        等待页面出现元素信息  ${全部删除}
        校验焦点是否在文本上  观看历史
        按返回直到出现元素  ${版本信息}
    END

case_006 我的页面进入我的收藏页面
    [Documentation]  我的页面进入我的收藏页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    返回首页
    返回精选页
    按次数上移  1
    按次数右移  2
    确认键
    等待我的页出现
    按次数下移  1
    按次数右移  1    3
    按次数下移  1
    按次数右移  5
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在元素上  ${全部记录}
        确认键
        等待页面出现元素信息  ${全部删除}
        校验焦点是否在文本上  节目收藏
        按返回直到出现元素  ${版本信息}
    END

case_007 我的页面进入我赞过的页面
    [Documentation]  我的页面进入我赞过的页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    返回首页
    返回精选页
    按次数上移  1
    按次数右移  2
    确认键
    等待我的页出现
    按次数下移  3
    按次数右移  3
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在元素上  ${全部赞过}
        确认键
        等待页面出现元素信息  ${删除}
        校验焦点是否在文本上  我赞过的
        按返回直到出现元素  ${常见问题}
    END

case_008 我的页面进入常见问题页面
    [Documentation]  我的页面进入常见问题页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    按返回直到出现元素  ${常见问题}
    按次数下移  1
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在元素上  ${常见问题}
        确认键
        等待页面出现文本信息  常见问题
        随机进行指定的操作  30   5
        按返回直到出现元素  ${常见问题}
    END

case_009 我的页面进入关于我们页面
    [Documentation]  我的页面进入关于我们页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    按返回直到出现元素  ${常见问题}
    按次数右移  1
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在元素上  ${关于我们}
        确认键
        等待页面出现文本信息  关于我们
        按返回直到出现元素  ${关于我们}
    END

case_010 我的页面进入设置页面
    [Documentation]  我的页面进入设置页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    按返回直到出现元素  ${常见问题}
    按次数右移  1
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在元素上  ${设置}
        确认键
        等待页面出现文本信息  设置
        随机进行指定的操作  30   5
        按返回直到出现元素  ${设置}
    END

case_011 我的页面进入问题反馈页面
    [Documentation]  我的页面进入问题反馈页面，检查性能指标
    ${starttime}    get autotest time
    执行开始时间  ${starttime}
    按返回直到出现元素  ${常见问题}
    按次数右移  1
    FOR    ${i}   IN RANGE    100000
        执行时间  ${starttime}  5400
        校验焦点是否在元素上  ${问题反馈}
        确认键
        等待页面出现文本信息  问题反馈
        随机进行指定的操作  30   5
        按返回直到出现元素  ${问题反馈}
    END

