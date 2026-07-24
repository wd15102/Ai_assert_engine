#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import os, sys
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from lib.ai_service import ai

# # 1. 判断文本是否存在
exists = ai.ocr_exists("免费电影·惊天破")
print(f"文本存在: {exists}")

# # 2. 返回坑位中心点坐标
# result = ai.ocr_find("免费电影·惊天破")
# if result:
#     print(f"坑位中心: cx={result['cx']}, cy={result['cy']}")
# else:
#     print("未找到")

