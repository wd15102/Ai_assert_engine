*** Settings ***
Documentation    首页点击事件
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_254 点击精选频道智能推荐2.0通栏中的海报
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数下移  3
    按键直到焦点位于内容描述上  天天向上1    下
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click','lob':'mtitle'}    test_254    ${datatable_prefix_apk}_click

case_196 点击少儿模板功能按钮
    [Documentation]  点击事件
    按次数返回  1    4
    按次数下移  1
    清除历史上报数据
    确认键
    等待订购中心出现
    获取校验结果  {'logtype':'click'}    test_196    ${datatable_prefix_apk}_click

case_197 点击少儿模板媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数右移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_197    ${datatable_prefix_apk}_click

case_198 点击分类3通栏媒资
    [Documentation]  点击事件
    等待页面出现文本信息  风犬少年的天空  30
    按次数返回  1    2
    按次数下移  1
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_198    ${datatable_prefix_apk}_click

case_199 点击6竖图媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_199    ${datatable_prefix_apk}_click

case_200 点击6竖图排行媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_200    ${datatable_prefix_apk}_click

case_201 点击6竖图即将上映媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_201    ${datatable_prefix_apk}_click

case_202 点击4横图媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_202    ${datatable_prefix_apk}_click

case_203 点击3横图媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_203    ${datatable_prefix_apk}_click

case_204 点击2横图媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_204    ${datatable_prefix_apk}_click

case_205 点击1横图媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_205    ${datatable_prefix_apk}_click

case_206 点击6横图媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_206    ${datatable_prefix_apk}_click

case_207 点击6圆图媒资
    [Documentation]  点击事件
    按次数返回  1    3
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','cntp':'ch_channel'}    test_207    ${datatable_prefix_apk}_click

case_208 点击6方图媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_208    ${datatable_prefix_apk}_click

case_209 点击抽屉模块
    [Documentation]  点击事件
    返回首页
    按次数返回  1
    返回精选页
    切换频道  电视剧
    按次数下移  5
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_209    ${datatable_prefix_apk}_click

case_210 点击二维码通栏模块
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_210    ${datatable_prefix_apk}_click

case_211 点击沉浸式闪图模块产品包
    [Documentation]  点击事件
    返回首页
    按次数返回  1
    返回精选页
    按次数右移  2
    等待  5
#    按次数下移  1
#    清除历史上报数据
#    确认键  5
#    获取校验结果  {'logtype':'click'}    test_211    ${datatable_prefix_apk}_click

case_212 点击沉浸式闪图模块媒资
    [Documentation]  点击事件
#    按次数返回  1    5
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_212    ${datatable_prefix_apk}_click

case_233 点击首页聚类推荐媒资
    [Documentation]  点击事件
    返回首页
    返回精选页
    按次数下移  20
    按键直到焦点位于内容描述上  动漫专题  下
    按次数下移  1
    按次数左移  3
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lob':'moduleid'}    test_233    ${datatable_prefix_apk}_click

case_234 点击首页相关明星
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lob':'moduleid'}    test_234    ${datatable_prefix_apk}_click

case_235 点击首页相关推荐媒资
    [Documentation]  点击事件
    按次数返回  1    2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lob':'moduleid'}    test_235    ${datatable_prefix_apk}_click

case_236 点击我的页面相关推荐媒资
    [Documentation]  点击事件
    到达我的页面入口
    确认键
    等待我的页出现
    按次数下移  3
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lob':'moduleid'}    test_236    ${datatable_prefix_apk}_click

case_261 组合专题顶部菜单点击
    [Documentation]  点击事件
    到达组合专题入口
    确认键
    等待组合专题页出现
    按次数上移  2
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_261    ${datatable_prefix_apk}_click

case_237 点击组合专题相关推荐媒资
    [Documentation]  点击事件
    按次数返回  1
    按次数下移  10
    按次数左移  1
    校验焦点是否在内容描述上  绯闻计划
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lob':'moduleid'}    test_237    ${datatable_prefix_apk}_click

case_237_1 组合专题页内模块点击
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','lob':'moduleid'}    test_237    ${datatable_prefix_apk}_click