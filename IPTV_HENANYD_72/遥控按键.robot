*** Settings ***
Library           AppiumLibrary

*** Keywords ***
返回键
    [Arguments]  ${sec}=2
    Run Keyword And Return Status    Press keycode   4
    sleep    ${sec}
    Log To Console    按了返回按键

home键
    Run Keyword And Return Status    Press Keycode    3
    sleep    2
    Log To Console   按了HOME按键


回车键
    Run Keyword And Return Status    Press Keycode    66
    sleep    2
    Log To Console   按了回车按键

菜单键
    [Arguments]  ${sec}=2
    Run Keyword And Return Status    Press Keycode    82
    sleep    ${sec}
    Log To Console   按了菜单键

确认键
    [Arguments]  ${sec}=2
    Run Keyword And Return Status    Press Keycode    23
    sleep    ${sec}
    Log To Console   按了确认键

设置键
    Run Keyword And Return Status    Press Keycode    176
    sleep    2
    Log To Console   按了设置按键

向上
    [Arguments]  ${sec}=2
    Run Keyword And Return Status    Press Keycode    19
    sleep    ${sec}
    Log To Console   按了上键

向下
    [Arguments]  ${sec}=2
    Run Keyword And Return Status    Press Keycode    20
    sleep    ${sec}
    Log To Console   按了下键

向左
    [Arguments]  ${sec}=2
    Run Keyword And Return Status    Press Keycode    21
    sleep    ${sec}
    Log To Console   按了向左键

向右
    [Arguments]  ${sec}=2
    Run Keyword And Return Status    Press Keycode    22
    sleep    ${sec}
    Log To Console   按了右键


音量+
    [Arguments]  ${sec}=0
    Press Keycode    24
    sleep    ${sec}
    Log To Console   按了音量+

音量-
    Press Keycode    25
    sleep    2

静音
    Press Keycode    164
    sleep    2

频道+
    Press Keycode   166
    sleep   2

频道-
    Press Keycode   167
    sleep   2

删除键
    Press Keycode    112
    sleep    2

数字0
    [Arguments]  ${sec}=2
    Press Keycode    7
    sleep    ${sec}

数字1
    [Arguments]  ${sec}=2
    Press Keycode    8
    sleep    ${sec}

数字2
    [Arguments]  ${sec}=2
    Press Keycode    9
    sleep    ${sec}

数字3
    [Arguments]  ${sec}=2
    Press Keycode    10
    sleep    ${sec}

数字4
    [Arguments]  ${sec}=2
    Press Keycode    11
    sleep    ${sec}

数字5
    [Arguments]  ${sec}=2
    Press Keycode    12
    sleep    ${sec}

数字6
    [Arguments]  ${sec}=2
    Press Keycode    13
    sleep    ${sec}

数字7
    [Arguments]  ${sec}=2
    Press Keycode    14
    sleep    ${sec}

数字8
    [Arguments]  ${sec}=2
    Press Keycode    15
    sleep    ${sec}

数字9
    [Arguments]  ${sec}=2
    Press Keycode    16
    sleep    ${sec}

红键
    Press Keycode    183
    sleep    2

绿键
    [Arguments]  ${sec}=2
    Press Keycode    184
    sleep    ${sec}

黄键
    Press Keycode    185
    sleep    2

蓝键
    Press Keycode    186
    sleep    2

联通红键
    Press Keycode    132
    sleep    2

联通绿键
    Press Keycode    131
    sleep    2

联通黄键
    Press Keycode    133
    sleep    2

联通蓝键
    Press Keycode    134
    sleep    2

F1键
    Press Keycode    136
    sleep    2

F2键
    [Arguments]  ${sec}=2
    Press Keycode    137
    sleep    ${sec}

F3键
    Press Keycode    138
    sleep    2

F4键
    Press Keycode    139
    sleep    2

快进
    [Arguments]  ${sec}=2
    Press Keycode   90
    sleep    ${sec}

快退
    [Arguments]  ${sec}=2
    Press Keycode   89
    sleep    ${sec}

暂停键
    [Arguments]  ${sec}=2
    Press Keycode    85
    sleep    ${sec}

确定双击
    [Arguments]  ${sec}=2
    Press Keycode    23
    Press Keycode    23
    sleep    ${sec}

搜索键
    [Arguments]  ${sec}=2
    Press Keycode    84
    sleep    ${sec}

角色键
    [Documentation]  牛奶盒子专用
    [Arguments]  ${sec}=2
    Press Keycode    142
    sleep    ${sec}
