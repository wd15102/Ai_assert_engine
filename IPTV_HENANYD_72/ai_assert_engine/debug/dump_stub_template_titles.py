#!/usr/bin/env python3
"""调试脚本：打印测试桩 datas[*].title vs defaultTemlpateData.templateName 对照"""
import json, sys, os

stub = r'D:\WorkCode\DP\DP_AutoTest\IPTV_HENANYD_72\测试桩\GetInitMetaData_精选频道.json'
data = json.load(open(stub, 'r', encoding='utf-8'))
datas = data['templateDatas'][0]['datas']

print(f"合计 {len(datas)} 个 datas 条目")
print()
for i, d in enumerate(datas):
    title = d.get('title', '(空)')
    dtd = d.get('defaultTemlpateData') or {}
    tpl_name = dtd.get('templateName', '(空)')
    sn = d.get('serialNumber', '(空)')
    dtd_name = dtd.get('name', '(空)')
    print(f"[{sn:3s}] title={title:40s} | templateName={tpl_name}")
