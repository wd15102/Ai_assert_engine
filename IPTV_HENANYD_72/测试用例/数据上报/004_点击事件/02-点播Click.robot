*** Settings ***
Documentation    点播点击事件
Resource          ../../../../IPTV_JX_72/对象库/点播.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_021 点击点播详情页菜单中的顶部海报
    [Documentation]  点击事件
    返回首页
    返回精选页
    到达试看电影入口
    确认键
    等待详情页出现
    按次数上移  4
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_021    ${datatable_prefix_apk}_click

点击详情页顶部会员投放位
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_021    ${datatable_prefix_apk}_click

case_022 点击点播详情页菜单中的搜索
    [Documentation]  点击事件
    等待订购中心出现
    返回键
    等待详情页出现
    按次数右移  1
    清除历史上报数据
    确认键
    等待搜索页出现
    获取校验结果  {'logtype':'click'}    test_022    ${datatable_prefix_apk}_click

case_023 点击点播详情页菜单中的开通会员
    [Documentation]  点击事件
    返回键
    按次数右移  1
    清除历史上报数据
    确认键
    等待订购中心出现
    获取校验结果  {'logtype':'click'}    test_023    ${datatable_prefix_apk}_click

case_024 点击点播详情页菜单中的我的
    [Documentation]  点击事件
    返回键
    按次数右移  1
    清除历史上报数据
    确认键
    等待我的页出现
    获取校验结果  {'logtype':'click'}    test_024    ${datatable_prefix_apk}_click

case_025 点击点播详情页的选集
    [Documentation]  点击事件
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    清除历史上报数据
    点播播放选集  1
    获取校验结果  {'logtype':'click'}    test_025    ${datatable_prefix_apk}_click

case_025_1 详情页中手动切集
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_025    ${datatable_prefix_apk}_click

case_255 点击点播暂停推荐浮层的继续播放
    [Documentation]  点击事件
    按次数右移  1
    确认键
    等待页面出现文本信息  继续播放
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_255    ${datatable_prefix_apk}_click

case_256 点击点播暂停推荐浮层的关闭广告
    [Documentation]  点击事件
    确认键
    等待页面出现文本信息  关闭广告
    按次数左移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_256    ${datatable_prefix_apk}_click

case_026 点击点播详情页的明星
    [Documentation]  点击事件
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    按键直到焦点位于内容描述上  李溪芮   下
    按次数左移  1
    清除历史上报数据
    确认键
    等待明星页出现
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_026    ${datatable_prefix_apk}_click

case_026_1 点击详情页相关明星fpa上报
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_026    ${datatable_prefix_apk}_click

case_295 详情页移动算法数据接入模块的曝光
    [Documentation]  模块曝光事件
    按次数返回  1    5
    清除历史上报数据
    按次数下移  1
    获取校验结果  {'logtype':'show','module_id':'common_6v_template3'}    test_295    ${datatable_prefix_apk}_show

case_027 点击点播详情页的相关推荐
    [Documentation]  点击事件
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_027    ${datatable_prefix_apk}_click

case_027_1 点击详情页算法推荐的通栏中的海报
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_027    ${datatable_prefix_apk}_click

case_027_2 点击详情页移动算法数据接入通栏中的海报
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_027    ${datatable_prefix_apk}_click

case_260 详情页看了还会看点击
    [Documentation]  点击事件
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    按键直到焦点位于内容描述上  李溪芮   下
    按次数下移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_260    ${datatable_prefix_apk}_click

case_260_1 详情页中手动切换其它合集
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_260    ${datatable_prefix_apk}_click

case_260_2 点击详情页算法推荐的通栏
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click','lastp':'ch_channel'}    test_260    ${datatable_prefix_apk}_click

case_030 点击点播详情页的广告位
    [Documentation]  点击事件
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    按次数上移  1
    清除历史上报数据
    确认键  5
    获取校验结果  {'logtype':'click'}    test_030    ${datatable_prefix_apk}_click

case_030_1 点击详情页长海报
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_030    ${datatable_prefix_apk}_click

case_029 点击点播详情页的更多详情
    [Documentation]  点击事件
    按次数返回  1
    按键直到焦点位于内容描述上  更多  上
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_029    ${datatable_prefix_apk}_click

case_257 点击详情页图片推荐位（开通按钮旁边）
    [Documentation]  点击事件
    按返回直到出现元素  ${详情页推广}
    清除历史上报数据
    点击元素  ${详情页推广}
    获取校验结果  {'logtype':'click'}    test_257    ${datatable_prefix_apk}_click

点击详情页付费推广位
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_257    ${datatable_prefix_apk}_click

case_031 点击点播详情页的全屏
    [Documentation]  点击事件
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_031    ${datatable_prefix_apk}_click

case_033 点击点播详情页的订购
    [Documentation]  点击事件
    返回精选页
    到达试看电影入口
    确认键
    等待详情页出现
    按次数左移  1
    清除历史上报数据
    按次数右移  1
    确认键
    获取校验结果      {'logtype':'click'}    test_033    ${datatable_prefix_apk}_click

case_033_1 点击详情页开通会员按钮_无权益
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_033    ${datatable_prefix_apk}_click

case_034 点击点播详情页的推广位
    [Documentation]  点击事件
    返回精选页
    点击元素  ${试看电影}
    等待详情页出现
    清除历史上报数据
    点击元素  ${详情页广告}
    获取校验结果  {'logtype':'click'}    test_034    ${datatable_prefix_apk}_click

case_035 点击点播详情页的花絮
    [Documentation]  点击事件
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    按次数下移  1
    按次数右移  1
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_035    ${datatable_prefix_apk}_click

case_035_1 详情页中手动切换花絮
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_035    ${datatable_prefix_apk}_click

case_036 点击点播详情页的收藏
    [Documentation]  点击事件
    返回精选页
    到达免费电视剧入口
    确认键
    等待详情页出现
    清除历史上报数据
    点击元素  ${详情页收藏}
    点击元素  ${详情页收藏}
    获取校验结果  {'logtype':'click'}    test_036    ${datatable_prefix_apk}_click

case_037 点击点播全屏播放页的选集
    [Documentation]  点击事件
    点播播放选集  1
    按次数下移  2    2
    按次数右移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_037    ${datatable_prefix_apk}_click

case_037_1 全屏播放中手动切集
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_037    ${datatable_prefix_apk}_click

case_039 点击点播全屏播放页的花絮
    [Documentation]  点击事件
    等待  5
    按次数上移  2    2
    按次数右移  1    2
    按次数下移  1
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_039    ${datatable_prefix_apk}_click

case_039_1 全屏播放中手动切换花絮
    [Documentation]  点击事件
    获取校验结果  {'logtype':'click'}    test_039    ${datatable_prefix_apk}_click

case_308 点播全屏播放，播放反馈模块点击
    [Documentation]  点击事件
    按次数上移  4
    按次数右移  1
    确认键  2
#    run keyword if  'HNDX' in '${project}'  按次数右移  1
    按次数下移  1
    按次数右移  3    0
    清除历史上报数据
    确认键
    获取校验结果  {'logtype':'click'}    test_308    ${datatable_prefix_apk}_click