#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
# 河南移动iptv
project = 'IPTV_HENANYD_72'
version = 'iptv_jx_release'
appium_server = '127.0.0.1:4723'
device_id = '192.168.100.2:5555'
# uuid = '004701FF0001182001A460313B2AC1D5' # CM101s机顶盒的
uuid = '0047130030014430231224D9048AAD26' # CM311-5-CH机顶盒的
local_ip = ''
single = True   # 单设备模式：使用上面 device_id；False 则自动扫描所有adb在线设备
# platform = 'LinuxUAndroid4.4.2CM101sBuild/CM101s'
platform = 'LinuxUAndroid9CM311-5-CHBuild/CM311-5-CH'
platform_version = '9'
app_package = 'com.huawei.tvbox'
app_activity = 'com.fonsview.mangotv.MainActivity'
automationName = 'UiAutomator2'
# case_path = [r'E:\Users\admin\PycharmProjects\DP_AutoTest\IPTV_JX_72\测试用例_行业版',
#             r'E:\Users\admin\PycharmProjects\DP_AutoTest\IPTV_JX_72\测试用例_移动联通',
#            r'E:\Users\admin\PycharmProjects\DP_AutoTest\IPTV_JX_72\测试用例\数据上报',
#            r'E:\Users\admin\PycharmProjects\DP_AutoTest\IPTV_JX_72\测试用例\功能测试']
case_path = [r'D:\WorkCode\DP\DP_AutoTest\IPTV_HENANYD_72\测试用例\功能测试\01_首页模板功能\首页通栏模板.robot'] # 单独运行该条用例
datatable_prefix_apk = 'iptv_apk_JX72'
datatable_prefix_web = 'iptv_web_JX72'
http_proxy = '192.168.100.8:8888'
Tags = ['smoke','P0']
log_path = os.path.dirname(__file__) + '\Result\IPTV_HENANYD72'
data_addr1= 'http://iptvtestlog.cslgtest.imgo.tv'
end_off = 0


# apk安装
auto_install = 0  # 0：不更新    1：全自动更新    2：根据url更新
apk_url = ''

# 用例标记
include_tag = []
exclude_tag = []

# 校验服务域名端口
check_server = 'http://10.200.8.114:80'

# mock服务域名端口
mock_server = 'http://10.1.172.175'

# 邮件
mail_host = 'mx.mgpost.imgo.tv'
mail_user = 'autotest@mgpost.imgo.tv'
mail_pass = '43zzERmMqk3LQvY'
sender = 'autotest@mgpost.imgo.tv'
receivers = ['wudong@mgtv.com']

# 其它
root_path = os.path.dirname(__file__)
database = 'root:!%40%23123qwe@172.31.111.88:3306/devices'
white_list = ['B860AV1.1-T', 'nunai-box', 'M301A']
test_type = 0   # 0：功能   1：monkey   2：性能
run_time = 12    # 小时
Retry = 0   # 失败用例重试次数   0：不重试
plugin_apk = 0  # 是否执行插件版本   0：不执行
hotup_apk = 0  # 是否执行热修复版本   0：不执行
zhengqi_apk = 0  # 是否执行政企版本   0：不执行
force_reboot = 0    # 是否强制重启，针对部分机顶盒清缓存和杀进程不能重启的情况   0：不执行
reconnet = 0    # 是否启动前重启连接设备   0：不连接
force_home = 0   #是否启动时强制回到首页（针对移动IPTV盒子）
proxy_reset = 0   #是否启动前重置代理数据   0：不重置

def set_app_package(value):
    global app_package
    old_str = app_package
    app_package = value
    file_data = ""
    file_path = os.path.join(root_path, 'config.py')
    with open(file_path, "r", encoding="utf-8") as f:
        for line in f:
            if old_str in line:
                line = line.replace(old_str, value, 1)
            file_data += line
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(file_data)


def set_app_activity(value):
    global app_activity
    old_str = app_activity
    app_activity = value
    file_data = ""
    file_path = os.path.join(root_path, 'config.py')
    with open(file_path, "r", encoding="utf-8") as f:
        for line in f:
            if old_str in line:
                line = line.replace(old_str, value, 1)
            file_data += line
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(file_data)
