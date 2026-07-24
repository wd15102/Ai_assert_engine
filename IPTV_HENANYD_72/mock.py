#!/usr/bin/env python
# -*- coding: utf-8 -*-
from config import project

#测试桩标签ID
tag_id = 20 if 'ott' in project.lower() else  21  if 'dingling' in project.lower() else  43

#广告接口
广告 = '/ad_request'

广告_前贴_空 = 'APIMC832000000189755690' if 'ott' in project.lower() else 'APIMC142000000210488992'
广告_前贴_非空 = 'APIMC502000001850672382' if 'ott' in project.lower() else 'APIMC114000001048489584'
广告_开屏_视频 = 'APIMC208000000326258374' if 'ott' in project.lower() else 'APIMC429000001764559546'
广告_直播退出_非空 = 'APIMC776000000048618462' if 'ott' in project.lower() else 'APIMC252000001425268375'
广告_直播暂停_非空 = 'APIMC734000002109561725' if 'ott' in project.lower() else 'APIMC557000001645201072'
广告_点播角标_非空 = 'APIMC110000002126773114' if 'ott' in project.lower() else 'APIMC822000001186140300'
广告_点播推荐位_非空 = 'APIMC420000001645964263' if 'ott' in project.lower() else 'APIMC401000000950478759'
广告_点播暂停_非空 = 'APIMC168000001497246598' if 'ott' in project.lower() else 'APIMC602000001854224292'
广告_点播退出_非空 = 'APIMC015000000054437058' if 'ott' in project.lower() else 'APIMC412000001628263096'

#叮铃learning接口
绑定状态 = '/screen/learning'

未绑定家长 = 'APIMC119000001160678539'
未绑定学生 = 'APIMC245000000342001353'
绑定学生 = 'APIMC673000001069239357'

#叮铃getuser接口
家长管理入口绑定状态  = '/screen/getuser'

getuser_已绑定家长 = 'APIMC677000000556734255'
getuser_未绑定家长 = 'APIMC218000000857717280'

#叮铃密码接口
退出密码 = '/screen/userpwd'

退出无密码 = 'APIMC320000001842942220'
退出有密码 = 'APIMC602000000214915438'


#接口测试参数
host_ad = '119.39.13.136'