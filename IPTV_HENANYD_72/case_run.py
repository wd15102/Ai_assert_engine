#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import time
import shutil
import logging
import datetime
import threading
from config import *
from robot import run, rebot
from TestLibrary.mail import send_mail
from TestLibrary.common import CommonMethod
from TestLibrary.android_common import call_adb
from TestLibrary.ott_monkey import ott_monkey_test
from TestLibrary.auto_upgrade import AutoUpgrade
from TestLibrary.ResultModify import ResultModify
from appium_server_hendan import AppiumServerHendan as AppiumServer
from TestLibrary.analysis import generate_analysis_result
from TestLibrary.RobotUpdate.MainFuncction import UpdateResults
from TestLibrary.android_common import get_datetime, get_pkg_info, get_device_info
from TestLibrary.info_collect import collect_inter, collect_performance, monkey_test, collect_app_error_log
event = threading.Event()

os.environ['ANDROID_HOME'] = 'D:\\Android'
def start_collect_info():
    t1 = threading.Thread(target=collect_performance, args=(app_package, event,), daemon=True)
    t2 = threading.Thread(target=collect_app_error_log, daemon=True)
    t1.start()
    t2.start()
    if test_type == 1:
        t3 = threading.Thread(target=collect_inter, daemon=True)
        t3.start()
    event.set()


def result_clear():
    result_path = root_path + '/Result'
    if not os.path.isdir(result_path):
        os.mkdir(result_path)
    dir_list = os.listdir(result_path)
    for d in dir_list:
        try:
            d_date = datetime.datetime.strptime(d, '%Y%m%d%H%M')
            now_data = datetime.datetime.now()
            days = (now_data - d_date).days
            if days > 2:
                dir_path = os.path.join(result_path, d)
                shutil.rmtree(dir_path)
        except ValueError:
            logging.debug('date format error:' + d)


def result_mkdir():
    date_str = datetime.datetime.strftime(datetime.datetime.now(), '%Y%m%d%H%M')
    result_path = os.path.join(root_path, 'Result', date_str)
    if not os.path.isdir(result_path):
        os.mkdir(result_path)
    else:
        shutil.rmtree(result_path)
        os.mkdir(result_path)
    return result_path


def start_appium_server(random_port=False, output=None):
    """兼容原签名，内部使用 AppiumServerHendan"""
    server = AppiumServer()
    server.stop_server()
    return server.start_server(random_port=random_port, output=output)


def reset_http_proxy():
    cmd = 'adb shell settings put global http_proxy {}'
    call_adb(cmd.format('1.1.1.1:80'))
    call_adb(cmd.format(http_proxy))


def parse_case_path(pro, cases):
    cases_path_list = []
    cases_list = [i for i in cases.split(',') if i != '']
    if cases.find('媒资巡检') == -1:
        cases_root_path = os.path.join(root_path, pro, '测试用例')
    else:
        cases_root_path = os.path.join(root_path, pro, '媒资巡检')
    for case in cases_list:
        all_files = os.walk(cases_root_path)
        case_name = case + '.robot'
        flag = 0
        for i in all_files:
            if case_name in i[2]:
                case_abs_path = os.path.join(i[0], case_name)
                cases_path_list.append(case_abs_path)
                flag = 1
                break
        if flag == 0:
            logging.error('can not found case: ' + case_name)
    return cases_path_list


def case_run(cases, output):
    rerun_dir = os.path.join(output, 'rerun')
    if not os.path.isdir(rerun_dir):
        os.mkdir(rerun_dir)
    backup_dir = os.path.join(output, 'backup')
    if os.path.isdir(backup_dir):
        shutil.rmtree(backup_dir)
    output_xml = os.path.join(output, 'output.xml')
    rerun_xml = os.path.join(rerun_dir, 'output.xml')
    run(*cases, name='DP_AutoTest', outputdir=output, include=include_tag, exclude=exclude_tag)
    for i in range(Retry):
        status_code = run(*cases, name='DP_AutoTest', rerunfailed=output_xml, outputdir=rerun_dir)
        if status_code != 252:
            shutil.copytree(output, backup_dir)
            rebot(output_xml, rerun_xml, outputdir=output, output='output.xml', merge=True,
                  prerebotmodifier=ResultModify())
        status_code = run(*cases, name='DP_AutoTest', rerunfailedsuites=output_xml, outputdir=rerun_dir,
                          include=include_tag, exclude=exclude_tag)
        if status_code != 252:
            rebot(output_xml, rerun_xml, outputdir=output, output='output.xml', merge=True,
                  prerebotmodifier=ResultModify())


def start_run_case():
    start_appium_server()
    mac = get_device_info().get('mac')
    auto = AutoUpgrade()
    if proxy_reset==1:
        reset_http_proxy()
    start_collect_info()
    start_time = get_datetime()
    sys_argv = sys.argv
    if len(sys_argv) >= 3:
        pro, cases = sys_argv[1], sys_argv[2]
        test_cases = parse_case_path(pro, cases)
        if len(sys_argv) > 3:
            logging.error('case name error! %s' % sys_argv)
    else:
        test_cases = case_path
    result_path = None
    if test_type == 0 or test_type == 2:
        if auto_install == 1:
            run_list = []
            while True:
                event.clear()
                pkg_list = auto.get_pkg_list(start_time)
                for pkg_url in pkg_list:
                    if pkg_url not in run_list:
                        result_path = result_mkdir()
                        auto.install(pkg_url)
                        case_run(test_cases, result_path)
                        # UpdateResults(os.path.join(result_path, 'Output.xml'))
                        df = generate_analysis_result(mac, start_time, get_datetime())
                        send_mail(df, result_path)
                        run_list.append(pkg_url)
                call_adb('adb shell pm clear %s' % app_package)
                logging.info('can not get latest package')
                time.sleep(500)
        else:
            if auto_install == 2:
                auto.install(apk_url)
                pkg_path = os.path.join(root_path, 'Package', apk_url.split('/')[-1])
                pkg_info = get_pkg_info(pkg_path)
                set_app_package(pkg_info.get('app_package'))
                # set_app_activity(pkg_info.get('app_activity'))
            result_path = result_mkdir()
            case_run(test_cases, result_path)
            # UpdateResults(os.path.join(result_path, 'Output.xml'))
    elif test_type == 1:
        if auto_install == 2:
            auto.install(apk_url)
        # ott_monkey_test()
        monkey_test()
        CommonMethod.set_charles('tools/auto-save/', 'disable')
        CommonMethod.set_charles('recording/', 'stop')
    df = generate_analysis_result(mac, start_time, get_datetime())
    send_mail(df, result_path)
    if  end_off == 1:
        call_adb('adb shell poweroff')


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    start_run_case()
