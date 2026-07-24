#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
@Project ：DP_AutoTest 
@File    ：1.py
@IDE     ：PyCharm 
@Author  ：Mgtv-wudong
@Date    ：2026/7/3 16:05 
'''
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
将当前文件夹下所有不带 .json 和 .xml 后缀的文件，统一加上 .json 后缀。
（不处理子目录，不处理已以 .json 或 .xml 结尾的文件）
"""

import os

def main():
    # 获取当前工作目录下的所有条目
    for item in os.listdir('测试桩'):
        # 跳过子目录
        if os.path.isdir(item):
            continue

        # 检查是否以 .json 或 .xml 结尾（忽略大小写）
        lower_item = item.lower()
        if lower_item.endswith('.json') or lower_item.endswith('.xml'):
            continue

        # 新文件名 = 原名 + .json
        new_name = item + '.json'

        # 如果新文件名已存在，跳过
        if os.path.exists(new_name):
            print(f'⚠️ 跳过: "{item}" → "{new_name}" 已存在')
            continue

        # 执行重命名
        try:
            os.rename(item, new_name)
            print(f'✅ "{item}" → "{new_name}"')
        except Exception as e:
            print(f'❌ 重命名失败: "{item}" → "{new_name}" 错误: {e}')

if __name__ == '__main__':
    main()