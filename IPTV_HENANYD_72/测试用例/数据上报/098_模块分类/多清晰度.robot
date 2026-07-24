*** Settings ***
Documentation    Suite description
Library           AppiumLibrary
Resource          ../../../../IPTV_JX_72/对象库/公共方法.robot
Resource          ../../../../遥控按键.robot
Resource          ../../../../IPTV_JX_72/对象库/点播.robot
Resource          ../../../../IPTV_JX_72/对象库/详情页.robot
Resource          ../../../../IPTV_JX_72/对象库/首页.robot

Suite Setup     启动应用
Suite Teardown      退出应用
#Test Teardown   用例失败截屏

*** Test Cases ***
case_189 无指定无设置点播播放_启播
    [Documentation]    启播事件
    返回首页
    返回精选页
    确认键
    切换频道  电影
    按键直到焦点位于内容描述上  多清晰度指定4K  下
    按次数右移  1
    校验焦点是否在内容描述上  多清晰度不指定
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_189   ${datatable_prefix_apk}_splay

case_181 无指定无设置点播播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_181   ${datatable_prefix_apk}_play

case_164 无指定无设置点播播放_快退拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_164   ${datatable_prefix_apk}_drag

case_165 无指定无设置点播播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_165   ${datatable_prefix_apk}_drag

case_060 无指定无设置点播播放_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_060   ${datatable_prefix_apk}_pause

case_060 无指定无设置点播播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_060   ${datatable_prefix_apk}_resume

case_285 无指定无设置点播播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  多清晰度不指定
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_285   ${datatable_prefix_apk}_hb

case_194 无指定无设置点播播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_194   ${datatable_prefix_apk}_stop

case_190 指定付费清晰度播放_启播
    [Documentation]    启播事件
    校验焦点是否在内容描述上  多清晰度不指定
    按次数左移  1
    校验焦点是否在内容描述上  多清晰度指定4K
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_190   ${datatable_prefix_apk}_splay

case_182 指定付费清晰度播放_VV
    [Documentation]    VV事件
    获取校验结果_不上报  {'logtype': 'play','bid':'26.1.1.0'}    test_182   ${datatable_prefix_apk}_play

case_191 点播播放流畅媒资_启播
    [Documentation]    启播事件
    按返回直到焦点位于内容  多清晰度指定4K
    按键直到焦点位于内容描述上  指定流畅  下
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_191   ${datatable_prefix_apk}_splay

case_183 点播播放流畅媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_183   ${datatable_prefix_apk}_play

case_166 点播播放流畅媒资_快退拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_166   ${datatable_prefix_apk}_drag

case_167 点播播放流畅媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_167   ${datatable_prefix_apk}_drag

case_061 点播播放流畅媒资_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_061   ${datatable_prefix_apk}_pause

case_061 点播播放流畅媒资_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_061   ${datatable_prefix_apk}_resume

case_286 点播播放流畅媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  指定流畅
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_286   ${datatable_prefix_apk}_hb

case_195 点播播放流畅媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_195   ${datatable_prefix_apk}_stop

case_192 点播播放标清媒资_启播
    [Documentation]    启播事件
    校验焦点是否在内容描述上  指定流畅
    按次数右移  1
    校验焦点是否在内容描述上  指定标清
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_192   ${datatable_prefix_apk}_splay

case_184 点播播放标清媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_184   ${datatable_prefix_apk}_play

case_168 点播播放标清媒资_快退拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_168   ${datatable_prefix_apk}_drag

case_169 点播播放标清媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_169   ${datatable_prefix_apk}_drag

case_062 点播播放标清媒资_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_062   ${datatable_prefix_apk}_pause

case_062 点播播放标清媒资_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_062   ${datatable_prefix_apk}_resume

case_287 点播播放标清媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  指定标清
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_287   ${datatable_prefix_apk}_hb

case_196 点播播放标清媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_196   ${datatable_prefix_apk}_stop

case_193 点播播放高清媒资_启播
    [Documentation]    启播事件
    校验焦点是否在内容描述上  指定标清
    按次数右移  1
    校验焦点是否在内容描述上  指定高清
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_193   ${datatable_prefix_apk}_splay

case_185 点播播放高清媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_185   ${datatable_prefix_apk}_play

case_170 点播播放高清媒资_快退拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_170   ${datatable_prefix_apk}_drag

case_171 点播播放高清媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_171   ${datatable_prefix_apk}_drag

case_063 点播播放高清媒资_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_063   ${datatable_prefix_apk}_pause

case_063 点播播放高清媒资_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_063   ${datatable_prefix_apk}_resume

case_288 点播播放高清媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  指定高清
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_288   ${datatable_prefix_apk}_hb

case_197 点播播放高清媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_197   ${datatable_prefix_apk}_stop

case_194 点播播放超清媒资_启播
    [Documentation]    启播事件
    校验焦点是否在内容描述上  指定高清
    按次数右移  1
    校验焦点是否在内容描述上  指定超清
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_194   ${datatable_prefix_apk}_splay

case_186 点播播放超清媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_186   ${datatable_prefix_apk}_play

case_172 点播播放超清媒资_快退拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_172   ${datatable_prefix_apk}_drag

case_173 点播播放超清媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_173   ${datatable_prefix_apk}_drag

case_064 点播播放超清媒资_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_064   ${datatable_prefix_apk}_pause

case_064 点播播放超清媒资_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_064   ${datatable_prefix_apk}_resume

case_289 点播播放超清媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  指定超清
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_289   ${datatable_prefix_apk}_hb

case_198 点播播放超清媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_198   ${datatable_prefix_apk}_stop

case_195 点播播放蓝光媒资_启播
    [Documentation]    启播事件
    校验焦点是否在内容描述上  指定超清
    按次数右移  1
    校验焦点是否在内容描述上  指定蓝光
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_195   ${datatable_prefix_apk}_splay

case_187 点播播放蓝光媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_187   ${datatable_prefix_apk}_play

case_174 点播播放蓝光媒资_快退拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_174   ${datatable_prefix_apk}_drag

case_175 点播播放蓝光媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_175   ${datatable_prefix_apk}_drag

case_065 点播播放蓝光媒资_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_065   ${datatable_prefix_apk}_pause

case_065 点播播放蓝光媒资_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_065   ${datatable_prefix_apk}_resume

case_156 点播全屏清晰度浮层曝光
    [Documentation]    CV事件
    按次数上移  3    2
    按次数右移  2
    清除历史上报数据
    确认键
    获取校验结果  {'logtype': 'cv','mod':'c_bofangqingxidu'}    test_156   ${datatable_prefix_apk}_cv

case_381 点播全屏点击清晰度切换
    [Documentation]  点击事件
    等待  3
    按次数上移  3    2
    按次数右移  2
    确认键  1
    按次数右移  5
    清除历史上报数据
#    校验焦点是否在内容描述上  4K
    确认键
    获取校验结果  {'logtype':'click'}    test_381    ${datatable_prefix_apk}_click

case_290 点播播放蓝光媒资_退出心跳
    [Documentation]    心跳事件
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_290   ${datatable_prefix_apk}_hb

case_199 点播播放蓝光媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_199   ${datatable_prefix_apk}_stop

case_197 点播播放过程中切换清晰度_启播
    [Documentation]    启播事件
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_197   ${datatable_prefix_apk}_splay

case_189 点播播放过程中切换清晰度_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_189   ${datatable_prefix_apk}_play

case_178 点播播放过程中切换清晰度_快退拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_178   ${datatable_prefix_apk}_drag

case_179 点播播放过程中切换清晰度_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_179   ${datatable_prefix_apk}_drag

case_067 点播播放过程中切换清晰度_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_067   ${datatable_prefix_apk}_pause

case_067 点播播放过程中切换清晰度_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_067   ${datatable_prefix_apk}_resume

case_292 点播播放过程中切换清晰度_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  指定蓝光
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_292   ${datatable_prefix_apk}_hb

case_201 点播播放过程中切换清晰度_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_201   ${datatable_prefix_apk}_stop

case_196 点播播放4K媒资_启播
    [Documentation]    启播事件
    校验焦点是否在内容描述上  指定蓝光
    按次数右移  1
    校验焦点是否在内容描述上  指定4K
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_196   ${datatable_prefix_apk}_splay

case_188 点播播放4K媒资_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_188   ${datatable_prefix_apk}_play

case_176 点播播放4K媒资_快退拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_176   ${datatable_prefix_apk}_drag

case_177 点播播放4K媒资_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_177   ${datatable_prefix_apk}_drag

case_066 点播播放4K媒资_播放暂停
    [Documentation]    pause事件
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_066   ${datatable_prefix_apk}_pause

case_066 点播播放4K媒资_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_066   ${datatable_prefix_apk}_resume

case_291 点播播放4K媒资_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  指定4K
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_291   ${datatable_prefix_apk}_hb

case_200 点播播放4K媒资_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_200   ${datatable_prefix_apk}_stop

case_198 无指定设置付费清晰度降级播放_启播
    [Documentation]    启播事件
    校验焦点是否在内容描述上  指定4K
    按次数上移  2
    校验焦点是否在内容描述上  多清晰度不指定
    清除历史上报数据
    确认键
    等待详情页出现
    获取校验结果  {'logtype': 'splay','bid':'26.4.1'}    test_198   ${datatable_prefix_apk}_splay

case_190 无指定设置付费清晰度降级播放_VV
    [Documentation]    VV事件
    获取校验结果  {'logtype': 'play','bid':'26.1.1.0'}    test_190   ${datatable_prefix_apk}_play

case_180 无指定设置付费清晰度降级播放_快退拖拽
    [Documentation]    drag事件
    按次数左移  2
    确认键
    清除历史上报数据
    点播时移  左
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_180   ${datatable_prefix_apk}_drag

case_181 无指定设置付费清晰度降级播放_快进拖拽
    [Documentation]    drag事件
    清除历史上报数据
    点播时移  右
    获取校验结果      {'logtype': 'drag','bid':'26.1.25'}    test_181   ${datatable_prefix_apk}_drag

case_068 无指定设置付费清晰度降级播放_播放暂停
    [Documentation]    pause事件
    等待  3
    清除历史上报数据
    暂停键
    获取校验结果      {'logtype': 'pause'}    test_068   ${datatable_prefix_apk}_pause

case_068 无指定设置付费清晰度降级播放_暂停后恢复播放
    [Documentation]    resume事件
    清除历史上报数据
    暂停恢复
    获取校验结果      {'logtype': 'resume'}    test_068   ${datatable_prefix_apk}_resume

case_294 无指定设置付费清晰度降级播放_5分钟心跳
    [Documentation]    心跳事件
    等待  200
    清除历史上报数据
    等待  100
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_294   ${datatable_prefix_apk}_hb

case_293 无指定设置付费清晰度降级播放_退出心跳
    [Documentation]    心跳事件
    清除历史上报数据
    按返回直到焦点位于内容  多清晰度不指定
    获取校验结果  {'logtype': 'hb','bid':'26.1.25'}    test_293   ${datatable_prefix_apk}_hb

case_202 无指定设置付费清晰度降级播放_退出stop
    [Documentation]    stop事件
    获取校验结果  {'logtype': 'stop','bid':'26.1.25'}    test_202   ${datatable_prefix_apk}_stop
