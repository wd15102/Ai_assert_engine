#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
@Project ：DP_AutoTest 
@File    ：1.py
@IDE     ：PyCharm 
@Author  ：Mgtv-wudong
@Date    ：2026/7/19 09:41 
'''
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
提取测试桩 JSON 文件中所有业务模板的信息，打印成表格。
自动跳过容器模板（如 2 UI层级绑定模板(二级)），只显示实际业务模板。
表头注明各列取值来源。

用法:
    # 命令行传参
    python extract_stub_info.py [路径]

    # 在代码中调用
    from extract_stub_info import main
    main('D:/path/to/stub.json')
"""

import os
import sys
import json
import glob
import argparse
from typing import List, Dict, Any


def find_json_files(path: str) -> List[str]:
    if os.path.isfile(path) and path.lower().endswith('.json'):
        return [path]
    elif os.path.isdir(path):
        return glob.glob(os.path.join(path, '**', '*.json'), recursive=True)
    else:
        return glob.glob(os.path.join(path if path else '.', '**', '*.json'), recursive=True)


def get_card_count(template_obj: Dict[str, Any]) -> int:
    default_td = template_obj.get('defaultTemlpateData')
    if isinstance(default_td, dict):
        inner_datas = default_td.get('datas')
        if isinstance(inner_datas, list):
            return len(inner_datas)
    datas = template_obj.get('datas')
    if isinstance(datas, list):
        return len(datas)
    return 0


def is_container_template(data: Dict[str, Any]) -> bool:
    """
    判断是否为容器模板（如 2 UI层级绑定模板(二级)）
    特征：templateId 包含 'template2' 或 templateName 包含 '层级绑定'
    """
    template_id = data.get('templateId', '')
    template_name = data.get('templateName', '')
    if 'template2' in template_id or '层级绑定' in template_name:
        return True
    # 如果同时满足以下条件，也认为是容器：
    # - 有 datas 数组，且 datas 中的每个元素都有 defaultTemlpateData
    # - 自身 title 为空或为容器相关名称
    datas = data.get('datas', [])
    if isinstance(datas, list) and len(datas) > 0:
        has_inner_templates = all(
            isinstance(item, dict) and item.get('defaultTemlpateData')
            for item in datas
        )
        if has_inner_templates:
            return True
    return False


def extract_business_templates(data: Any, file_name: str = '') -> List[Dict[str, Any]]:
    """
    提取所有业务模板，跳过容器模板。
    直接遍历 datas 数组，根据 defaultTemlpateData 提取真正的业务模板。
    """
    results = []

    if isinstance(data, list):
        for item in data:
            results.extend(extract_business_templates(item, file_name))
        return results

    if not isinstance(data, dict):
        return results

    # ── 如果当前对象是业务模板（有 title 且有 defaultTemlpateData，且不是容器） ──
    if data.get('defaultTemlpateData') and data.get('title'):
        if not is_container_template(data):
            default_td = data.get('defaultTemlpateData', {})
            template_name = default_td.get('templateName', '')
            card_count = len(default_td.get('datas', []))
            serial_number = data.get('serialNumber', '')

            results.append({
                '序号': serial_number,
                '标题 (取自 title)': data.get('title', ''),
                '完整模板名称': template_name,
                '坑位数量': card_count,
                '备注': f'Title:{data.get("title", "")}',
            })
            # 不再递归进入 defaultTemlpateData，避免重复提取
            return results

    # ── 递归深入 ──
    if 'datas' in data and isinstance(data['datas'], list):
        results.extend(extract_business_templates(data['datas'], file_name))

    if 'templateDatas' in data:
        results.extend(extract_business_templates(data['templateDatas'], file_name))

    return results


def print_table(rows: List[Dict[str, Any]], file_name: str = ''):
    if not rows:
        print(f'{file_name}: 无业务模板数据')
        return

    headers = [
        '序号',
        '标题 (取自 title)',
        '完整模板名称 (取自 defaultTemlpateData.templateName)',
        '坑位数量 (取自 defaultTemlpateData.datas)',
        '备注'
    ]
    keys = ['序号', '标题', '完整模板名称', '坑位数量', '备注']

    col_widths = {h: len(h) for h in headers}
    for row in rows:
        for i, k in enumerate(keys):
            val = str(row.get(k, ''))
            col_widths[headers[i]] = max(col_widths[headers[i]], len(val))

    def print_sep():
        print('+' + '+'.join('-' * (col_widths[h] + 2) for h in headers) + '+')

    def print_row(row):
        line = '|'
        for i, h in enumerate(headers):
            val = str(row.get(keys[i], ''))
            line += f' {val:<{col_widths[h]}} |'
        print(line)

    if file_name:
        print(f'\n📂 文件: {file_name}')
    print_sep()
    print_row({k: k for k in keys})
    print_sep()
    for row in rows:
        print_row(row)
    print_sep()
    print(f'总计业务模板数: {len(rows)}')


def main(path: str = None):
    if path is None:
        parser = argparse.ArgumentParser(
            description='提取测试桩 JSON 文件中的业务模板信息（跳过容器模板），打印表格'
        )
        parser.add_argument(
            'path',
            nargs='?',
            default='.',
            help='JSON 文件或目录路径（默认当前目录）'
        )
        args = parser.parse_args()
        target_path = args.path
    else:
        target_path = path

    files = find_json_files(target_path)
    if not files:
        print(f'未找到任何 .json 文件 (路径: {target_path})', file=sys.stderr)
        sys.exit(1)

    all_results = []
    for f in files:
        try:
            with open(f, 'r', encoding='utf-8') as fp:
                data = json.load(fp)
        except Exception as e:
            print(f'[错误] 读取文件 {f} 失败: {e}', file=sys.stderr)
            continue

        rows = extract_business_templates(data, os.path.basename(f))
        if rows:
            print_table(rows, os.path.basename(f))
            all_results.extend(rows)
        else:
            print(f'[信息] {os.path.basename(f)}: 无业务模板数据')

    if len(files) > 1:
        print(f'\n📊 共处理 {len(files)} 个文件，总计 {len(all_results)} 个业务模板')




if __name__ == '__main__':
    # 命令行执行时，可传参
    main("D:\WorkCode\DP\DP_AutoTest\IPTV_HENANYD_72\测试桩\GetInitMetaData_精选频道.json")