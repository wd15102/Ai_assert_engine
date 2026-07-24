*** Settings ***
Documentation    少儿模式PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../IPTV_JX_72/对象库/片库.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_146 精选页呼出切换模式页
    [Documentation]  PV事件
    到达切换模式入口
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_146    ${datatable_prefix_apk}_pv

case_143 从精选频道呼出切换模式页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_143    ${datatable_prefix_apk}_stay

case_147 从少儿模式点击切换模式按钮呼出少儿验证页
    [Documentation]  PV事件
    到达切换模式入口
    确认键
    点击元素  ${少儿版}
    等待元素出现  ${少儿开通会员}
    按次数上移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_147    ${datatable_prefix_apk}_pv

case_144 从少儿模式点击切换模式按钮呼出少儿验证页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_144    ${datatable_prefix_apk}_stay

case_148 从少儿模式按返回键呼出少儿验证页
    [Documentation]  PV事件
    清除历史上报数据
    按返回直到出现元素  ${数字一}
    获取校验结果  {'logtype':'pv'}    test_148    ${datatable_prefix_apk}_pv

case_149 少儿验证页跳转到切换模式页
    [Documentation]  PV事件
    按次数返回  1
    按次数上移  1
    确认键
    清除历史上报数据
    点击验证页答案
    获取校验结果  {'logtype':'pv'}    test_149    ${datatable_prefix_apk}_pv

case_145 从少儿验证页进入切换模式页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'stay'}    test_145    ${datatable_prefix_apk}_stay

case_150 少儿模式进入媒资详情页
    [Documentation]  PV事件
    清除历史上报数据
    进入媒资详情页  母亲
    获取校验结果  {'logtype':'pv'}    test_150    ${datatable_prefix_apk}_pv

case_151 媒资详情页返回少儿模式首页
    [Documentation]  PV事件
    清除历史上报数据
    详情页退出
    获取校验结果  {'logtype':'pv'}    test_151    ${datatable_prefix_apk}_pv

case_146 从少儿模式首页进入媒资详情页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_146    ${datatable_prefix_apk}_stay

case_147 从媒资详情页返回少儿模式首页停留后再进入媒资详情页
    [Documentation]  STAY事件
    清除历史上报数据
    进入媒资详情页  母亲
    获取校验结果  {'logtype':'stay'}    test_147    ${datatable_prefix_apk}_stay

case_152 少儿模式进入片库主页
    [Documentation]  PV事件
    详情页退出
    清除历史上报数据
    点击元素  ${少儿最新上线}
    等待片库内容出现
    获取校验结果  {'logtype':'pv'}    test_152    ${datatable_prefix_apk}_pv

case_153 片库主页返回少儿模式
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_153    ${datatable_prefix_apk}_pv

case_148 从少儿模式首页进入片库主页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_148    ${datatable_prefix_apk}_stay

case_154 少儿模式进入搜索页
    [Documentation]  PV事件
    按次数上移  2
    向右
    确认键
    清除历史上报数据
    点击验证页答案
    等待搜索页出现
    获取校验结果  {'logtype':'pv'}    test_154    ${datatable_prefix_apk}_pv

case_155 搜索页返回少儿模式
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_155    ${datatable_prefix_apk}_pv

case_149 从少儿模式首页进入搜索页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_149    ${datatable_prefix_apk}_stay

case_254 开机启动进入少儿模式
    [Documentation]  PV事件
    清除历史上报数据
    杀进程重启应用
    获取校验结果  {'logtype':'pv'}    test_254    ${datatable_prefix_apk}_pv

case_156 从少儿模式切换到正常模式
    [Documentation]  PV事件
    按返回直到出现元素  ${数字一}
    清除历史上报数据
    点击验证页答案
    等待元素出现  ${免费电影}
    获取校验结果  {'logtype':'pv'}    test_156    ${datatable_prefix_apk}_pv

case_162 从少儿模式切换到正常模式停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道  电视剧
    获取校验结果  {'logtype':'stay'}    test_162    ${datatable_prefix_apk}_stay