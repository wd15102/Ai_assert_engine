*** Settings ***
Documentation    简约模式PV和STAY事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../IPTV_JX_72/对象库/片库.robot
Resource          ../../../../IPTV_JX_72/对象库/搜索.robot
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot

Suite Setup  启动应用
Suite Teardown  退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_157 从正常模式切换到简约模式
    [Documentation]  PV事件
    到达切换模式入口
    确认键
    清除历史上报数据
    点击元素  ${简约版}
    获取校验结果  {'logtype':'pv'}    test_157    ${datatable_prefix_apk}_pv

case_158 简约模式点击切换模式按钮呼出切换模式页
    [Documentation]  PV事件
    等待元素出现  ${简约直播小窗播放器}
    按次数上移  2
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'pv'}    test_158    ${datatable_prefix_apk}_pv

case_150 从简约模式点击切换模式按钮呼出切换模式页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    返回键  3
    获取校验结果  {'logtype':'stay'}    test_150    ${datatable_prefix_apk}_stay

case_159 简约模式按返回键呼出切换模式页
    [Documentation]  PV事件
#    按次数下移  1
    清除历史上报数据
#    按返回直到出现元素  ${简约版}
    确认键
    获取校验结果  {'logtype':'pv'}    test_159    ${datatable_prefix_apk}_pv

case_160 简约模式进入直播频道
    [Documentation]  PV事件
    返回键
    数字键进直播  2
    播放退出
    清除历史上报数据
    点击元素  ${简约直播小窗播放器}
    等待  8
    获取校验结果  {'logtype':'pv'}    test_160    ${datatable_prefix_apk}_pv

case_161 直播频道返回简约模式
    [Documentation]  PV事件
    清除历史上报数据
    播放退出
    获取校验结果  {'logtype':'pv'}    test_161    ${datatable_prefix_apk}_pv

case_151 从简约模式进入直播频道停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_151    ${datatable_prefix_apk}_stay

case_152 从直播频道返回简约模式停留后进入直播频道
    [Documentation]  STAY事件
    清除历史上报数据
    数字键进直播  2
    获取校验结果  {'logtype':'stay'}    test_152    ${datatable_prefix_apk}_stay

case_162 简约模式进入搜索页
    [Documentation]  PV事件
    播放退出
    清除历史上报数据
    点击内容描述  搜索
    确认键
    等待搜索页出现
    获取校验结果  {'logtype':'pv'}    test_162    ${datatable_prefix_apk}_pv

case_163 搜索页返回简约模式
    [Documentation]  PV事件
    按次数右移  1
    清除历史上报数据
    按返回直到出现内容   观看历史
    获取校验结果  {'logtype':'pv'}    test_163    ${datatable_prefix_apk}_pv

case_153 从简约模式进入搜索页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_153    ${datatable_prefix_apk}_stay

case_164 简约模式进入回看列表
    [Documentation]  PV事件
    清除历史上报数据
    点击内容描述  回看
    确认键
    按次数右移  1
    获取校验结果  {'logtype':'pv'}    test_164    ${datatable_prefix_apk}_pv

case_165 回看列表返回简约模式
    [Documentation]  PV事件
    清除历史上报数据
    按返回直到出现内容  观看历史
    获取校验结果  {'logtype':'pv'}    test_165    ${datatable_prefix_apk}_pv

case_154 从简约模式进入回看列表停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_154    ${datatable_prefix_apk}_stay

case_168 简约模式进入历史记录
    [Documentation]  PV事件
    清除历史上报数据
    点击内容描述  观看历史
    确认键
    等待文本出现  观看历史
    按次数左移  1
    获取校验结果  {'logtype':'pv'}    test_168    ${datatable_prefix_apk}_pv

case_166 简约模式进入媒资详情页
    [Documentation]  PV事件
    按次数右移  3
    清除历史上报数据
    确认键  20
    获取校验结果  {'logtype':'pv'}    test_166    ${datatable_prefix_apk}_pv

case_167 媒资详情页返回简约模式
    [Documentation]  PV事件
    清除历史上报数据
    按返回直到出现文本  观看历史
    获取校验结果  {'logtype':'pv'}    test_167    ${datatable_prefix_apk}_pv

case_155 从简约模式进入媒资详情页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_155    ${datatable_prefix_apk}_stay

case_169 历史记录返回简约模式
    [Documentation]  PV事件
    清除历史上报数据
    按返回直到出现内容  搜索
    获取校验结果  {'logtype':'pv'}    test_169    ${datatable_prefix_apk}_pv

case_156 从简约模式首页进入历史记录停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_156    ${datatable_prefix_apk}_stay

case_170 简约模式进入片库主页
    [Documentation]  PV事件
    按次数下移  3    3
    按次数左移  1
    清除历史上报数据
    确认键
    等待片库内容出现
    获取校验结果  {'logtype':'pv'}    test_170    ${datatable_prefix_apk}_pv

case_171 片库主页返回简约模式
    [Documentation]  PV事件
    清除历史上报数据
    返回键
    获取校验结果  {'logtype':'pv'}    test_171    ${datatable_prefix_apk}_pv

case_157 从简约模式首页进入片库主页停留后返回
    [Documentation]  STAY事件
    获取校验结果  {'logtype':'stay'}    test_157    ${datatable_prefix_apk}_stay

case_158 从片库主页返回简约模式首页停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'stay'}    test_158    ${datatable_prefix_apk}_stay

case_172 从简约模式切换到正常模式
    [Documentation]  PV事件
    home键
    按次数返回  1
    按次数上移  2
    按次数右移  1
    确认键
#    按返回直到出现元素  ${时尚版}
#    等待  5
    清除历史上报数据
    点击元素  ${时尚版}
    等待  10
    获取校验结果  {'logtype':'pv'}    test_172    ${datatable_prefix_apk}_pv

case_159 从简约模式切换到正常模式停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    切换频道  电视剧
    获取校验结果  {'logtype':'stay'}    test_159    ${datatable_prefix_apk}_stay

case_173 从少儿模式切换到简约模式
    [Documentation]  PV事件
    到达切换模式入口
    确认键
    点击元素  ${少儿版}
    等待  5
    按次数上移  2
#    按返回直到出现元素  ${数字一}
    确认键
    点击验证页答案
    等待  2
    清除历史上报数据
    点击元素  ${简约版}
    等待  5
    获取校验结果  {'logtype':'pv'}    test_173    ${datatable_prefix_apk}_pv

case_160 从少儿模式切换到简约模式停留后返回
    [Documentation]  STAY事件
    清除历史上报数据
    点击内容描述  观看历史
    确认键
    获取校验结果  {'logtype':'stay'}    test_160    ${datatable_prefix_apk}_stay

case_253 开机启动进入简约模式
    [Documentation]  PV事件
    清除历史上报数据
    杀进程重启应用
    获取校验结果  {'logtype':'pv'}    test_253    ${datatable_prefix_apk}_pv

case_174 从简约模式切换到少儿模式
    [Documentation]  PV事件
#    按返回直到出现元素  ${少儿版}
    按次数上移  2
    按次数右移  1
    确认键  5
    清除历史上报数据
    点击元素  ${少儿版}
    获取校验结果  {'logtype':'pv'}    test_174    ${datatable_prefix_apk}_pv

case_161 从简约模式切换到少儿模式停留后返回
    [Documentation]  STAY事件
    等待元素出现  ${少儿切换模式}
    清除历史上报数据
    进入媒资详情页  母亲
    获取校验结果  {'logtype':'stay'}    test_161    ${datatable_prefix_apk}_stay

