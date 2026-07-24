#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
单模板检查器 — 封装"一个模板"的完整检查流程。

职责：
  1. screenshot_with_focus  — 截图 + XML dump + 找焦点 + 画绿框
  2. crop_template_region   — dump XML → extract_template_regions → 裁剪 → 可选画绿框
  3. check_template_with_ai — 构造 prompt → 调 AI → 解析 JSON 判决
  4. handle_expected_false  — 从 XML 区域列表判断模板是否不存在

不依赖 ChannelRunner，可以被其他上下文独立使用。
"""

import os, time, json, traceback, re
import xml.etree.ElementTree as ET
from datetime import datetime
from typing import Optional

from lib.adb_utils import (
    screenshot, kill_stale_uiautomator, dump_uiautomator, dpad_down,
)
from lib.focus_detector import _parse_bounds, draw_focus_mark
from lib.focus_checker import get_focus_info
from lib.element_checker import wait_page_stable
from lib.logger import log_info, log_ok, log_warn, log_error, log_step
from lib.template_region_extractor import extract_template_regions
from lib.ai_service import AIService
from engine_config.config import DEFAULT_MODEL
from PIL import Image


_AI = AIService()


class TemplateInspector:
    """单模板检查器。"""

    def __init__(self, output_dir: str, screenshot_prefix: str = 'tmp'):
        """
        Args:
            output_dir: 输出文件（截图、裁剪图、标记图）存放目录
            screenshot_prefix: 截图文件名前缀
        """
        self.output_dir = output_dir
        self.screenshot_prefix = screenshot_prefix
        self._last_focus_rect = None  # 底部重复检测用
        os.makedirs(output_dir, exist_ok=True)

    # ── 公共工具 ──

    @staticmethod
    def _ts() -> str:
        return datetime.now().strftime('%Y%m%d_%H%M%S')

    @staticmethod
    def _fix_xml_format(raw: str) -> str:
        s = raw
        s = re.sub(r'<\s+(\w)', r'<\1', s)
        s = re.sub(r'<\s*/(\w)', r'</\1', s)
        s = re.sub(r'(\w)\s+-\s+(\w)', r'\1-\2', s)
        s = re.sub(r'<\?xml[^>]*\?>', '<?xml version="1.0" encoding="utf-8"?>', s)
        return s

    # ════════════════════════════════════════════════════════════
    # 方法 1: 截图 + 找焦点 + 画绿框
    # ════════════════════════════════════════════════════════════

    def screenshot_with_focus(self, tag: str) -> dict:
        """
        截图 → XML dump → 找焦点 → 画绿色焦点框。

        Returns:
            {'screenshot': str, 'marked': str, 'focus_rect': [x,y,w,h] or None, 'desc': str}
        """
        ts = self._ts()
        shot_path = screenshot(f'{self.screenshot_prefix}_{tag}_{ts}.png')
        if not shot_path or not os.path.exists(shot_path):
            log_error('截图失败')
            return {'screenshot': '', 'marked': '', 'focus_rect': None, 'desc': ''}

        wait_page_stable(timeout=5)

        fi = get_focus_info(out_dir=self.output_dir)
        marked_path = ''
        focus_rect = None
        desc = fi.get('content_desc', '')

        if fi.get('has_focus'):
            bounds_str = fi.get('bounds', '')
            focus_rect = _parse_bounds(bounds_str)
            if focus_rect:
                marked_path = draw_focus_mark(shot_path, focus_rect, desc, '',
                                              self.output_dir) or ''
                log_ok(f'✅ 焦点框: {desc} @ {bounds_str}')

        return {
            'screenshot': shot_path,
            'marked': marked_path,
            'focus_rect': focus_rect,
            'desc': desc,
        }

    # ════════════════════════════════════════════════════════════
    # 方法 2: 模板区域裁剪
    # ════════════════════════════════════════════════════════════

    def crop_template_region(self, template_name: str, screenshot_path: str,
                             focus_rect: list = None,
                             template_titles: list[str] = None) -> dict:
        """
        dump XML → extract_template_regions → 匹配模板 → 裁剪 → 可选画绿框。

        Args:
            template_name: 模板名称（用于区域匹配）
            screenshot_path: 截图路径
            focus_rect: 可选焦点矩形 [x, y, w, h]，用来在裁剪图上画绿框

        Returns:
            {'crop': 裁剪图路径 or '', 'marked': 裁剪+绿框图路径 or ''}
        """
        if not screenshot_path or not os.path.exists(screenshot_path):
            log_warn(f'  crop_template_region: 截图不存在 {screenshot_path}')
            return {'crop': '', 'marked': ''}

        try:
            kill_stale_uiautomator()
        except Exception:
            pass

        xml_path = dump_uiautomator(out_dir=self.output_dir, retries=2)
        if not xml_path:
            log_warn(f'  crop_template_region: XML dump 失败')
            return {'crop': '', 'marked': ''}

        with open(xml_path, 'r', encoding='utf-8') as f:
            raw = f.read()
        raw = self._fix_xml_format(raw)
        root = ET.fromstring(raw)

        try:
            regions = extract_template_regions(root, template_titles=template_titles)
        except ValueError as e:
            log_warn(f'  crop_template_region: {e}')
            return {'crop': '', 'marked': ''}

        if not regions:
            log_warn(f'  crop_template_region: 未提取到任何模板区域')
            return {'crop': '', 'marked': ''}

        # 精确匹配模板名（region name = 完整 content-desc，不含缩写）
        matched = None
        for r in regions:
            if r['name'] == template_name:
                matched = r
                break
        if not matched:
            log_warn(f'  未精确匹配 "{template_name}"，可用: {[r["name"] for r in regions]}')
            matched = regions[0]
            log_warn(f'  降级使用第一个区域 "{matched["name"]}"')

        crop_box = (matched['x1'], matched['y1'], matched['x2'], matched['y2'])
        try:
            img = Image.open(screenshot_path)
            cropped = img.crop(crop_box)
            ts = self._ts()
            safe_name = re.sub(r'[\\/:*?"<>|]', '_', template_name)[:40]
            crop_path = os.path.join(self.output_dir, f'crop_{safe_name}_{ts}.png')
            cropped.save(crop_path)
            log_info(f'  ✅ 裁剪完成: {os.path.relpath(crop_path)}')
            log_info(f'    区域: [{matched["x1"]},{matched["y1"]}][{matched["x2"]},{matched["y2"]}] '
                     f'({matched["width"]}x{matched["height"]})  cards={matched["card_count"]}')

            marked_path = ''
            if focus_rect and len(focus_rect) == 4:
                fx, fy, fw, fh = focus_rect
                local_x = fx - matched['x1']
                local_y = fy - matched['y1']
                log_info(f'  🟢 在裁剪图上画焦点框: 屏幕({fx},{fy},{fw},{fh}) → 裁剪坐标({local_x},{local_y},{fw},{fh})')
                try:
                    from PIL import ImageDraw as _idraw
                    _marked_img = Image.open(crop_path).copy()
                    _draw = _idraw.Draw(_marked_img)
                    _draw.rectangle([local_x, local_y, local_x + fw, local_y + fh],
                                    outline='#00FF00', width=3)
                    marked_path = os.path.join(self.output_dir, f'crop_marked_{safe_name}_{ts}.png')
                    _marked_img.save(marked_path)
                    log_info(f'  ✅ 裁剪标记图完成: {os.path.relpath(marked_path)}')
                except Exception as _e:
                    log_warn(f'  裁剪图画焦点框失败: {_e}')

            return {'crop': crop_path, 'marked': marked_path}
        except Exception as e:
            log_error(f'  crop_template_region 异常: {e}')
            traceback.print_exc()
            return {'crop': '', 'marked': ''}

    # ════════════════════════════════════════════════════════════
    # 方法 3: AI 视觉检查
    # ════════════════════════════════════════════════════════════

    def check_template_with_ai(self, template_name: str, crop_img: str,
                               public_checks: list, exclusive_checks: list) -> dict:
        """
        对一个模板图片做 AI 视觉检查。

        Args:
            template_name: 模板名称（仅用于日志和 prompt）
            crop_img: 待检查图片路径
            public_checks: 公共检查项列表 [{'名称', '说明'}, ...]
            exclusive_checks: 专属检查项列表 [{'名称', '说明'}, ...]

        Returns:
            {'template_name': str, 'total': int, 'passed': int, 'failed': int, 'items': [...]}
        """
        log_info(f'  AI 检查: {template_name}')
        items = []

        if not crop_img or not os.path.exists(crop_img):
            items.append({'name': '(无截图)', 'passed': False, 'detail': '截图不存在'})
            return {
                'template_name': template_name,
                'total': 1, 'passed': 0, 'failed': 1,
                'items': items,
            }

        # 构造检查项列表
        check_items = []
        for pc in public_checks:
            check_items.append({
                'name': pc.get('名称', '公共检查'),
                'prompt': pc.get('说明', '检查是否正常'),
            })
        for ec in exclusive_checks:
            check_items.append({
                'name': ec.get('名称', '专属检查'),
                'prompt': ec.get('说明', '检查是否正常'),
            })
        # 没有配置检查项时用默认值
        if not check_items:
            check_items = [
                {'name': '布局展示', 'prompt': '该模板布局展示是否正常？有无错位、遮挡、大面积空白？'},
                {'name': '海报加载', 'prompt': '所有海报/卡片图片是否已正常加载？有无白块、裂图、红色占位图？'},
                {'name': '文字显示', 'prompt': '所有文字（标题、描述）是否清晰无乱码、无重叠、无截断？'},
            ]

        for idx, ci in enumerate(check_items):
            name = ci['name']
            prompt = ci['prompt']
            try:
                full_prompt = (
                    f'这是模板「{template_name}」的截图，绿色方框标记了当前焦点位置。\n'
                    f'请检查以下项目：\n{prompt}\n'
                    f'\n请严格按照以下 JSON 格式回复（不要加 markdown 代码块）：\n'
                    f'  {{ "result": "pass", "reason": "简要原因" }}\n'
                    f'  {{ "result": "fail", "reason": "具体问题描述" }}'
                )
                result = _AI.ask(
                    full_prompt, image=crop_img,
                    max_tokens=200, timeout=30,
                    template_name=template_name,
                    check_index=idx + 1,
                    total_checks=len(check_items),
                    verbose=False,
                )

                reply = result.strip()
                passed = self._parse_ai_result(reply)
                items.append({'name': name, 'passed': passed, 'detail': reply})
                icon = '✅' if passed else '❌'
                if passed:
                    log_ok(f'    {icon} {name}: 通过 → {reply[:80]}')
                else:
                    log_warn(f'    {icon} {name}: 失败 → {reply[:80]}')
            except Exception as e:
                items.append({'name': name, 'passed': False, 'detail': f'AI异常: {e}'})
                log_error(f'    ⚠ {name}: AI 异常: {e}')
            time.sleep(0.5)

        passed = sum(1 for it in items if it['passed'])
        failed = len(items) - passed
        return {
            'template_name': template_name,
            'total': len(items),
            'passed': passed,
            'failed': failed,
            'items': items,
        }

    @staticmethod
    def _parse_ai_result(reply: str) -> bool:
        """
        三级降级解析 AI 返回结果：
          1. JSON 解析（首选）
          2. 正则提取 JSON 对象
          3. 关键词判定（"pass" 在前 60 字且无 "fail"）
        """
        try:
            import json as _json
            parsed = _json.loads(reply)
            if isinstance(parsed, dict):
                return parsed.get('result', '').lower() == 'pass'
            if isinstance(parsed, list) and len(parsed) > 0:
                return parsed[0].get('result', '').lower() == 'pass'
            return False
        except (_json.JSONDecodeError, AttributeError):
            m = re.search(r'\{(?:[^{}]|(?:\{[^{}]*\}))*\}', reply)
            if m:
                try:
                    import json as _json
                    parsed = _json.loads(m.group(0))
                    return parsed.get('result', '').lower() == 'pass'
                except Exception:
                    pass
            rl = reply.lower()
            return 'pass' in rl[:60] and 'fail' not in rl[:60]

    # ════════════════════════════════════════════════════════════
    # 方法 4: expected=false 检查
    # ════════════════════════════════════════════════════════════

    def check_template_absent(self, template_name: str) -> bool:
        """
        从当前 XML 区域列表判断指定模板是否未出现。
        Returns: True=不存在(符合预期), False=异常出现
        """
        _xml = dump_uiautomator(out_dir=self.output_dir, retries=1)
        if not _xml:
            log_warn('  check_template_absent: XML dump 失败，假设不存在')
            return True

        with open(_xml, 'r', encoding='utf-8') as _f:
            _r = _f.read()
        _r = self._fix_xml_format(_r)
        try:
            _root = ET.fromstring(_r)
            _regs = extract_template_regions(_root, template_titles=template_titles)
            for _reg in _regs:
                if _reg['name'] == template_name:
                    return False  # 模板异常出现
        except Exception:
            pass
        return True  # 不存在，符合预期

    # ════════════════════════════════════════════════════════════
    # 方法 5: 完整检查一个模板（一步到位）
    # ════════════════════════════════════════════════════════════

    def inspect(self, template_name: str, public_checks: list = None,
                exclusive_checks: list = None,
                template_idx: int = 0,
                template_titles: list[str] = None) -> dict:
        """
        完整检查一个模板：截图 → 裁剪 → AI 判决。

        Returns:
            与 ChannelRunner 兼容的结果 dict：
            {
                'sn', 'title', 'status', 'templates', 'screenshots',
                'abnormalities', 'check_items', 'ai_model'
            }
        """
        public_checks = public_checks or []
        exclusive_checks = exclusive_checks or []

        # 5a. 截图 + 画绿框
        snap = self.screenshot_with_focus(f'template_{template_idx}')
        rect = snap.get('focus_rect', None)

        # 5b. 底部重复检测
        if rect and rect[1] >= 900 and self._last_focus_rect is not None \
                and abs(rect[0] - self._last_focus_rect[0]) < 10 \
                and abs(rect[1] - self._last_focus_rect[1]) < 10:
            log_warn(f'  焦点底部重复，已到底')
            return {'_bottom_repeat': True}

        self._last_focus_rect = rect

        # 5c. 裁剪
        crop_result = self.crop_template_region(
            template_name, snap.get('screenshot', ''),
            focus_rect=rect, template_titles=template_titles)
        crop_path = crop_result.get('crop', '')
        crop_marked_path = crop_result.get('marked', '')

        # 5d. 确定 AI 图片
        if crop_marked_path and os.path.exists(crop_marked_path):
            img_for_ai = crop_marked_path
        elif crop_path:
            img_for_ai = crop_path
        else:
            img_for_ai = snap.get('marked') or snap.get('screenshot', '')

        # 5e. AI 检查
        check_result = self.check_template_with_ai(
            template_name, img_for_ai, public_checks, exclusive_checks)
        total = check_result['total']
        passed = check_result['passed']
        failed = check_result['failed']

        # 5f. 组装结果
        status = 'normal' if failed == 0 else ('warning' if failed < total else 'abnormal')
        abns = []
        check_items_detail = []
        for it in check_result['items']:
            check_items_detail.append({
                'name': it['name'],
                'passed': it['passed'],
                'detail': it['detail'],
            })
            if not it['passed']:
                abns.append(f"[{it['name']}] {it['detail']}")

        screenshots_entry = []
        if snap.get('screenshot'):
            screenshots_entry.append({'file': snap['screenshot'], 'label': '原始截图'})
        marked_report = crop_marked_path or snap.get('marked', '')
        if marked_report:
            screenshots_entry.append({'file': marked_report, 'label': '焦点标记图'})

        return {
            'sn': template_idx,
            'title': template_name,
            'status': status,
            'templates': [{'templateName': template_name, 'cardCount': 0}],
            'screenshots': screenshots_entry,
            'abnormalities': abns,
            'check_items': check_items_detail,
            'ai_model': DEFAULT_MODEL,
            '_total': total,
            '_passed': passed,
            '_failed': failed,
            '_bottom_repeat': False,
        }


# ════════════════════════════════════════════════════════════
# 便捷函数 — 不实例化也可以调用
# ════════════════════════════════════════════════════════════

def _inspect_single(template_name: str, public_checks: list = None,
                    exclusive_checks: list = None, output_dir: str = None,
                    screenshot_prefix: str = 'tmp') -> dict:
    """便捷调用：创建一个临时 TemplateInspector 并执行完整检查。"""
    out = output_dir or os.path.join(os.getcwd(), 'tmp_inspect')
    inspector = TemplateInspector(out, screenshot_prefix)
    return inspector.inspect(template_name, public_checks, exclusive_checks)
