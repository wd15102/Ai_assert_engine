#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
焦点智能导航器 — 精确计算从当前焦点到目标元素的最短遥控器按键路径

能力：
  ✅ 同区域内：网格化定位，算精确方向步数
  ✅ 跨区域：相邻检测 + 方向优先级排序 + 交叉区域校验
  ✅ 兼容 Android TV / 机顶盒 / OTT 场景
  ✅ 不依赖 Appium，直接解析 uiautomator dump XML

用法：
  from lib.focus_navigator import FocusNavigator
  from lib import adb_utils as adb

  nav = FocusNavigator()
  xml_str = adb.adb_shell(['shell', 'uiautomator', 'dump', '/dev/tty'])
  steps = nav.move_to_target(xml_str, "[77,415][511,711]")
  # → ['向右', '向右', '向下', '确定']

来源：从 TestLibrary/AndroidTVFocus.py 移植核心算法，适配 ai_assert_engine 体系
"""

import re
import xml.etree.ElementTree as ET
from typing import Optional


# ══════════════════════════════════════════════════════════════
# Rectangle — bounds 矩形数据模型
# ══════════════════════════════════════════════════════════════

class Rectangle:
    """解析 bounds="[x1,y1][x2,y2]" 字符串，提供各种坐标属性"""

    _instances = {}

    def __new__(cls, bounds):
        if bounds in cls._instances:
            return cls._instances[bounds]
        instance = super().__new__(cls)
        cls._instances[bounds] = instance
        return instance

    def __init__(self, bounds):
        if not hasattr(self, '_initialized'):
            self._initialized = True
            self.bounds = bounds
            parts = [int(i) for i in bounds.replace("[", ",").replace("]", "").split(',') if i]
            self._bounds = parts  # [x1, y1, x2, y2]

    @property
    def top_left(self):
        return self._bounds[0:2]

    @property
    def bottom_right(self):
        return self._bounds[2:]

    @property
    def center(self):
        return (self._bounds[0] + self._bounds[2]) / 2, (self._bounds[1] + self._bounds[3]) / 2

    @property
    def top_left_x(self):
        return self._bounds[0]

    @property
    def top_left_y(self):
        return self._bounds[1]

    @property
    def bottom_right_x(self):
        return self._bounds[2]

    @property
    def bottom_right_y(self):
        return self._bounds[3]

    @property
    def center_x(self):
        return (self._bounds[0] + self._bounds[2]) / 2

    @property
    def center_y(self):
        return (self._bounds[1] + self._bounds[3]) / 2

    @property
    def width(self):
        return self._bounds[2] - self._bounds[0]

    @property
    def height(self):
        return self._bounds[3] - self._bounds[1]

    @classmethod
    def clear_instances(cls):
        cls._instances.clear()

    def __repr__(self):
        return f"bounds:{self._bounds} at {id(self)}"


# ══════════════════════════════════════════════════════════════
# FocusNavigator — 焦点导航核心算法
# ══════════════════════════════════════════════════════════════

class FocusNavigator:
    """
    焦点智能导航器。

    核心流程：
      1. parse_layout(page_source) → 解析 XML 中的可点击元素，按父容器分组
      2. 不规则区域自动分割为规则网格
      3. move_to_target(xml_str, target_bounds) → 算最短按键序列
         同区域：网格索引差
         跨区域：相邻检测 → 方向优先级 → 交叉校验
    """

    # 按键常量映射
    KEYCODE_MAP = {
        '向上': 19, '向下': 20, '向左': 21, '向右': 22, '确定': 23, '等待': -1,
    }

    def __init__(self):
        self.area_elements = []   # [{parent_rect: [child_rect, ...]}, ...]
        self.focus_element = None # 当前焦点元素 Rectangle
        self.focus_bounds = None  # 当前焦点 bounds 字符串
        self.root = None

    # ──────────────────────────────────────────────
    # 解析 XML
    # ──────────────────────────────────────────────

    def parse_layout(self, page_source: str):
        """
        解析 uiautomator dump XML，构建区域网格。

        page_source: uiautomator dump 输出的 XML 文本
                     或已保存的 XML 文件路径
        """
        Rectangle.clear_instances()
        self.area_elements = []
        self.focus_element = None
        self.focus_bounds = None

        # 支持传入文件路径或 XML 文本
        if page_source.strip().startswith('<?xml'):
            xml_text = page_source
        else:
            with open(page_source, 'r', encoding='utf8') as f:
                xml_text = f.read()

        self.root = ET.fromstring(xml_text)

        # XPath：找焦点元素和可点击元素
        focus_xpath = './/*[@focusable="true"][@focused="true"]'
        clickable_xpath = './/*[@focusable="true"][@clickable="true"]'

        # 当前焦点
        focus_node = self.root.find(focus_xpath)
        if focus_node is not None:
            self.focus_bounds = focus_node.attrib.get('bounds')
            self.focus_element = Rectangle(self.focus_bounds)

        # 根元素 bounds（用于过滤全屏元素）
        root_bounds = self.root.find("./").attrib.get('bounds') if self.root.find("./") is not None else ''

        # 获取所有可上焦 + 可点击的元素
        elements = self.root.findall(clickable_xpath)
        for element in elements:
            eb = element.attrib.get('bounds', '')
            if eb == root_bounds:
                continue  # 跳过全屏元素（如 OTT 切全屏后返回）
            child = Rectangle(eb)
            if child in self.child_elements:
                continue

            # 找直接父节点
            parent = None
            for elem in self.root.iter():
                if element in elem:
                    parent = Rectangle(elem.attrib.get('bounds'))
                    break

            if parent is None:
                continue

            # 检查是否已有该父区域
            exist_dict = next((item for item in self.area_elements if item.get(parent)), None)
            if exist_dict:
                exist_dict[parent].append(child)
            else:
                self.area_elements.append({parent: [child]})

        # 分割不规则区域
        for area in list(self.area_elements):
            for area_parent, area_children in area.items():
                if not self._is_rule_area(area_children):
                    self.area_elements.remove(area)
                    self._split_area(area_parent, area_children)

        # 缩小父区域范围 + 排序子元素
        for index, area in enumerate(self.area_elements):
            for area_parent, area_children in area.items():
                self._modify_area_range(area_children, index)
                self._sort_area_children(area_children, index)

    # ──────────────────────────────────────────────
    # 区域网格算法
    # ──────────────────────────────────────────────

    @staticmethod
    def _is_in_area(current: Rectangle, target: Rectangle) -> bool:
        return (current.top_left_x >= target.top_left_x and
                current.top_left_y >= target.top_left_y and
                current.bottom_right_x <= target.bottom_right_x and
                current.bottom_right_y <= target.bottom_right_y)

    def _is_same_area(self, current: Rectangle, target: Rectangle) -> bool:
        return self._get_parent_from_child(current) == self._get_parent_from_child(target)

    @staticmethod
    def _calculate_size(elements):
        rows = len(set(y.center_y for y in elements))
        cols = len(set(x.center_x for x in elements))
        return rows, cols

    def _is_rule_area(self, child_elements):
        """判断是否规则网格区域"""
        rows, cols = self._calculate_size(child_elements)
        if (rows - 1) * cols > len(child_elements):
            return False  # 行数不完整
        for index, element in enumerate(child_elements):
            if index == 0:
                continue
            if (element.center_y != child_elements[index - 1].center_y and
                    element.center_x != child_elements[0].center_x):
                return False
        return True

    def _split_area(self, area_parent: Rectangle, area_children: list):
        """将不规则区域分割为多个规则区域"""
        children = []
        for element in area_children:
            if not children:
                children.append(element)
            else:
                center_x, center_y = element.center
                children_center_x = [item.center_x for item in children]
                children_center_y = [item.center_y for item in children]
                if center_y in children_center_y:
                    children.append(element)
                elif center_x == children_center_x[0]:
                    children.append(element)
                else:
                    self._modify_area_range(children)
                    children = [element]
        self.area_elements.append({Rectangle(area_parent.bounds): children})

    def _modify_area_range(self, area_children: list, index: int = None):
        """缩小父区域范围为子元素最小外接矩形"""
        min_x = min(c.top_left_x for c in area_children)
        min_y = min(c.top_left_y for c in area_children)
        max_x = max(c.bottom_right_x for c in area_children)
        max_y = max(c.bottom_right_y for c in area_children)
        bounded = Rectangle(f'[{min_x},{min_y}][{max_x},{max_y}]')
        if index is not None:
            self.area_elements[index] = {bounded: area_children}
        else:
            self.area_elements.append({bounded: area_children})

    @staticmethod
    def _sort_area_children(area_children: list, index: int):
        """同区域子元素按 y 再按 x 排序"""
        area_children.sort(key=lambda c: (c.center[-1], c.center[0]))

    @property
    def parent_elements(self):
        return [key for item in self.area_elements for key in item.keys()]

    @property
    def child_elements(self):
        merged = [value for item in self.area_elements for value in item.values()]
        flat = [item for sublist in merged for item in sublist]
        return flat

    def _get_parent_from_child(self, child: Rectangle):
        for area in self.area_elements:
            for area_parent, area_children in area.items():
                if child in area_children:
                    return area_parent
        return None

    def _get_children_from_child(self, child: Rectangle):
        for area in self.area_elements:
            for area_parent, area_children in area.items():
                if child in area_children:
                    return area_children
        return None

    # ──────────────────────────────────────────────
    # 区域内导航
    # ──────────────────────────────────────────────

    def _focus_in_area_move(self, target: Rectangle) -> list:
        """同区域内：网格索引差计算方向步数"""
        area_children = self._get_children_from_child(self.focus_element)
        rows, cols = self._calculate_size(area_children)
        grid = [list(area_children[i:i + cols]) for i in range(0, rows * cols, cols)]
        element_positions = {char: (row, col)
                             for row, row_elements in enumerate(grid)
                             for col, char in enumerate(row_elements)}

        move_order = []
        current = self.focus_element

        while current.center != target.center:
            entry = element_positions.get(current)
            if entry is None:
                center = current.center
                entry = next((pos for key, pos in element_positions.items()
                              if key.center == center), None)
            if entry is None:
                return ['等待']

            current_row, current_col = entry
            target_entry = element_positions.get(target)
            if target_entry is None:
                center = target.center
                target_entry = next((pos for key, pos in element_positions.items()
                                     if key.center == center), None)
            if target_entry is None:
                return ['等待']

            target_row, target_col = target_entry
            row_diff = target_row - current_row
            col_diff = target_col - current_col

            if row_diff < 0:
                move_order.append('向上')
                current = grid[current_row - 1][current_col]
            elif row_diff > 0:
                move_order.append('向下')
                current = grid[current_row + 1][current_col]
            elif col_diff < 0:
                move_order.append('向左')
                current = grid[current_row][current_col - 1]
            elif col_diff > 0:
                move_order.append('向右')
                current = grid[current_row][current_col + 1]

        return move_order

    # ──────────────────────────────────────────────
    # 跨区域导航
    # ──────────────────────────────────────────────

    def _is_adjacent(self, area1: Rectangle, area2: Rectangle):
        """判断两个区域是否相邻，并返回方向"""
        a1 = area1.top_left + area1.bottom_right  # [x1,y1,x2,y2]
        a2 = area2.top_left + area2.bottom_right

        areas = {f"a{i+1}": list(item.top_left + item.bottom_right)
                 for i, item in enumerate(self.parent_elements)}

        # 垂直重叠（同列）
        if a1[0] < a2[2] and a1[2] > a2[0]:
            if a1[3] <= a2[1]:  # a1 在 a2 上方
                if not any(a1[3] <= areas[k][1] < a2[1]
                           for k in areas if areas[k] != a1 and areas[k] != a2):
                    return True, "down"
            elif a2[3] <= a1[1]:  # a2 在 a1 上方
                if not any(a2[3] <= areas[k][1] < a1[1]
                           for k in areas if areas[k] != a1 and areas[k] != a2):
                    return True, "up"

        # 水平重叠（同行）
        if a1[1] < a2[3] and a1[3] > a2[1]:
            if a1[2] <= a2[0]:  # a1 在 a2 左边
                if not any(a1[2] <= areas[k][0] < a2[0]
                           for k in areas if areas[k] != a1 and areas[k] != a2):
                    return True, "right"
            elif a2[2] <= a1[0]:  # a2 在 a1 左边
                if not any(a2[2] <= areas[k][0] < a1[0]
                           for k in areas if areas[k] != a1 and areas[k] != a2):
                    return True, "left"

        return False, "不相邻"

    def _get_relative_position(self, area1: Rectangle, area2: Rectangle) -> list:
        """计算两个区域的相对方向（按距离/相邻优先级排序）"""
        x_distance = abs(area1.center_x - area2.center_x)
        y_distance = abs(area1.center_y - area2.center_y)

        relative_position = []
        if area1.center_y < area2.center_y:
            relative_position.append("down")
        else:
            relative_position.append("up")
        if area1.center_x < area2.center_x:
            relative_position.append("right")
        else:
            relative_position.append("left")

        # 距离越远的优先级越高
        if len(relative_position) > 1:
            if x_distance > y_distance:
                if relative_position[0] in ('up', 'down'):
                    relative_position.reverse()
            else:
                if relative_position[0] in ('left', 'right'):
                    relative_position.reverse()

        # 相邻的优先级更高
        ret, dire = self._is_adjacent(area1, area2)
        if ret and relative_position[-1] == dire:
            relative_position.reverse()

        return relative_position

    def _focus_can_move_to_direction(self, target: Rectangle, dire: str) -> bool:
        """检查当前方向是否有可到达的交叉区域"""
        focus_parent = self._get_parent_from_child(self.focus_element)
        if focus_parent is None:
            return False

        x1_min, y1_min = focus_parent.top_left
        x1_max, y1_max = focus_parent.bottom_right

        for element in self.parent_elements:
            if element == focus_parent:
                continue
            x2_min, y2_min = element.top_left
            x2_max, y2_max = element.bottom_right

            if dire in ('up', 'down'):
                if x1_max >= x2_min and x1_min <= x2_max:
                    if dire == 'up' and y1_min > y2_min:
                        return True
                    if dire == 'down' and y1_min < y2_min:
                        return True
            else:
                if y1_max >= y2_min and y1_min <= y2_max:
                    if dire == 'left' and x1_min > x2_min:
                        return True
                    if dire == 'right' and x1_min < x2_min:
                        return True
        return False

    def _focus_move_out_area(self, target: Rectangle) -> list:
        """跨区域：先走到边界再跳出"""
        focus_parent = self._get_parent_from_child(self.focus_element)
        target_parent = self._get_parent_from_child(target)

        if not focus_parent or not target_parent:
            return ['等待']

        relative_position = self._get_relative_position(focus_parent, target_parent)
        if not relative_position:
            return ['等待']

        direction = None
        for direction in relative_position:
            if self._focus_can_move_to_direction(self.focus_element, direction):
                break
        else:
            return ['等待']

        area_children = self._get_children_from_child(self.focus_element)
        rows, cols = self._calculate_size(area_children)
        grid = [list(area_children[i:i + cols]) for i in range(0, rows * cols, cols)]
        element_positions = {char: (row, col)
                             for row, row_elements in enumerate(grid)
                             for col, char in enumerate(row_elements)}

        current_row, current_col = element_positions.get(self.focus_element, (0, 0))

        if direction == '向上':
            return ['向上'] * (current_row + 1)
        elif direction == '向下':
            return ['向下'] * (rows - current_row)
        elif direction == '向左':
            return ['向左'] * (current_col + 1)
        else:
            return ['向右'] * (cols - current_col)

    # ──────────────────────────────────────────────
    # 主入口
    # ──────────────────────────────────────────────

    def move_to_target(self, page_source: str, target_bounds: str) -> list:
        """
        计算从当前焦点到目标 bounds 的最短遥控器按键序列。

        参数：
          page_source: uiautomator dump 的 XML 文本 或 XML 文件路径
          target_bounds: 目标元素的 bounds 字符串，如 "[77,415][511,711]"

        返回：
          ['向下', '向右', '向下', ...]  的方向序列
          []  表示已在目标位置
          ['等待']  表示需要重新 dump（UI 可能已变化）

        注意：
          - 返回的是**方向**序列，不是按键码
          - 调用方需自行在每次按键后等待页面稳定
          - 若返回 ['等待']，应重新 dump 并重试
        """
        self.parse_layout(page_source)

        if not self.focus_element:
            return ['等待']

        if self.focus_bounds == target_bounds:
            return []  # 已在目标位置

        target = Rectangle(target_bounds)
        if self._is_same_area(self.focus_element, target):
            return self._focus_in_area_move(target)
        else:
            return self._focus_move_out_area(target)

    def move_and_execute(self, page_source: str, target_bounds: str,
                         press_ok: bool = False, adb_shell_fn=None) -> bool:
        """
        便捷方法：算路径 + 自动按键执行。

        参数：
          page_source: XML 文本或文件路径
          target_bounds: 目标 bounds
          press_ok: 到达后是否按 OK 键
          adb_shell_fn: adb_shell 函数（用于执行按键）

        返回：
          True 表示成功到达，False 表示失败
        """
        steps = self.move_to_target(page_source, target_bounds)
        if steps == ['等待']:
            return False
        if adb_shell_fn is None:
            return True  # 不执行，只验证路径

        for direction in steps:
            keycode = self.KEYCODE_MAP.get(direction)
            if keycode and keycode > 0:
                adb_shell_fn(['shell', 'input', 'keyevent', str(keycode)])

        if press_ok:
            adb_shell_fn(['shell', 'input', 'keyevent', '23'])

        return True

    @staticmethod
    def parse_bounds(bounds_str: str) -> Optional[list]:
        """解析 bounds 字符串为 [x, y, w, h]"""
        if not bounds_str or '][' not in bounds_str:
            return None
        try:
            parts = bounds_str.replace('[', '').split(']')
            x1, y1 = parts[0].split(',')
            x2, y2 = parts[1].split(',')
            return [int(x1), int(y1), int(x2) - int(x1), int(y2) - int(y1)]
        except (ValueError, IndexError):
            return None

    @staticmethod
    def find_bounds_by_desc(page_source: str, content_desc: str) -> Optional[str]:
        """
        在 XML 中根据 contentDescription 查找元素 bounds。

        参数：
          page_source: XML 文本
          content_desc: 目标元素的 contentDescription 值

        返回：
          bounds 字符串如 "[77,415][511,711]"，未找到返回 None
        """
        try:
            root = ET.fromstring(page_source)
            xpath = f'.//*[@content-desc="{content_desc}"]'
            node = root.find(xpath)
            if node is not None:
                return node.attrib.get('bounds')
        except Exception:
            pass
        return None

    @staticmethod
    def find_bounds_by_text(page_source: str, text: str) -> Optional[str]:
        """根据 text 属性查找元素的 bounds"""
        try:
            root = ET.fromstring(page_source)
            xpath = f'.//*[@text="{text}"]'
            node = root.find(xpath)
            if node is not None:
                return node.attrib.get('bounds')
        except Exception:
            pass
        return None


# ══════════════════════════════════════════════════════════════
# 快捷使用
# ══════════════════════════════════════════════════════════════

def quick_move_to_desc(content_desc: str, adb_utils_module=None,
                       press_ok: bool = False) -> bool:
    """
    一键操作：dump XML → 找 content_desc → 算路径 → 按键到达。

    参数：
      content_desc: 目标元素的 contentDescription
      adb_utils_module: 传入 lib.adb_utils 模块引用
      press_ok: 到达后是否按 OK

    用法：
      from lib import adb_utils as adb
      from lib.focus_navigator import quick_move_to_desc

      quick_move_to_desc("直播", adb, press_ok=True)
    """
    if adb_utils_module is None:
        raise ValueError("需要传入 adb_utils 模块")

    # 1. dump XML
    xml_str = adb_utils_module.adb_shell(
        ['shell', 'uiautomator', 'dump', '/dev/tty'])
    if 'UI hierchary dumped' not in xml_str and 'dumped' not in xml_str:
        xml_str = adb_utils_module.adb_shell(
            ['shell', 'uiautomator', 'dump', '/dev/tty'], timeout=15)
    # 从输出提取 XML 部分
    xml_lines = xml_str.splitlines()
    xml_text = None
    for line in xml_lines:
        if line.strip().startswith('<?xml'):
            xml_text = line
            break
    if not xml_text:
        # dump 到文件再读取
        adb_utils_module.adb_shell(
            ['shell', 'rm', '/sdcard/ui_dump.xml'])
        adb_utils_module.adb_shell(
            ['shell', 'uiautomator', 'dump', '/sdcard/ui_dump.xml'], timeout=15)
        xml_text = adb_utils_module.adb_shell(
            ['shell', 'cat', '/sdcard/ui_dump.xml'])

    # 2. 找目标 bounds
    target_bounds = FocusNavigator.find_bounds_by_desc(xml_text, content_desc)
    if not target_bounds:
        raise ValueError(f"未找到 contentDesc='{content_desc}' 的元素")

    # 3. 算路径 + 执行
    nav = FocusNavigator()
    return nav.move_and_execute(xml_text, target_bounds,
                                press_ok=press_ok,
                                adb_shell_fn=adb_utils_module.adb_shell)


def quick_move_to_bounds(target_bounds: str, adb_utils_module=None,
                         press_ok: bool = False) -> bool:
    """直接指定 bounds 的一键操作"""
    if adb_utils_module is None:
        raise ValueError("需要传入 adb_utils 模块")

    xml_str = adb_utils_module.adb_shell(
        ['shell', 'uiautomator', 'dump', '/dev/tty'])
    xml_lines = xml_str.splitlines()
    xml_text = None
    for line in xml_lines:
        if line.strip().startswith('<?xml'):
            xml_text = line
            break
    if not xml_text:
        adb_utils_module.adb_shell(
            ['shell', 'rm', '/sdcard/ui_dump.xml'])
        adb_utils_module.adb_shell(
            ['shell', 'uiautomator', 'dump', '/sdcard/ui_dump.xml'], timeout=15)
        xml_text = adb_utils_module.adb_shell(
            ['shell', 'cat', '/sdcard/ui_dump.xml'])

    nav = FocusNavigator()
    return nav.move_and_execute(xml_text, target_bounds,
                                press_ok=press_ok,
                                adb_shell_fn=adb_utils_module.adb_shell)
