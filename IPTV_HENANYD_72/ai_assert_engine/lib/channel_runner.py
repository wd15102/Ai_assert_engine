#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
频道巡检引擎 — 负责执行"任何频道"的自动巡检。

设计原则：
  - 一次封装，所有频道复用
  - 测试用例只提供"配置数据"（30 行以内）
  - 单模板检查委托给 TemplateInspector
"""

import sys, os, time, json, traceback, re
import xml.etree.ElementTree as ET
from datetime import datetime
from typing import Optional, List, Dict, Any
from collections import defaultdict

# ── 路径 — 调用方必须 os.chdir + sys.path.insert 到 ai_assert_engine 目录 ──
_PROJECT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(_PROJECT)
sys.path.insert(0, _PROJECT)

from lib.adb_utils import (
    adb_shell, keyevent, home, back, ok,
    dpad_up, dpad_down, dpad_left, dpad_right,
    screenshot, kill_stale_uiautomator, prewarm_appium, dump_uiautomator,
)
from lib.focus_detector import find_focus_from_xml, _parse_bounds, draw_focus_mark
from lib.focus_checker import get_focus_info
from lib.element_checker import wait_page_stable
from lib import stub_parser as stub
from lib.logger import log, log_step, log_ok, log_warn, log_error, log_info, set_log_file
from lib.template_region_extractor import extract_template_regions
from lib.ai_service import AIService
from lib.log_checker import LogcatWatcher
from lib.log_analyzer import LogAnalyzer
from engine_config.config import MODELS
from lib.reporter import generate_html_report
from engine.template_prompt_builder import _load_checkpoints
from lib.template_inspector import TemplateInspector
from PIL import Image
from lib.stub_parser import load_json


class ChannelRunner:
    """频道巡检引擎 — 加载配置后自动完成全流程巡检。

    用法：实例化 → 调用 .run()
    """

    def __init__(self, channel_name: str, bind_instance_id: str,
                 output_dir: str = None, screenshot_prefix: str = None,
                 checkpoint_key: str = None, report_title: str = None):
        """
        Args:
            channel_name: 中文频道名，如 "直播" / "精选"
            bind_instance_id: 测试桩 bindInstanceId，如 "zhibo_6.0"
            output_dir: 输出目录（默认 auto/{channel_name}）
            screenshot_prefix: 截图文件名前缀（默认取 channel_name 首二字）
            checkpoint_key: checkpoints.json 中的频道键名（默认 "{channel_name}频道"）
            report_title: HTML 报告标题（默认 "{channel_name}频道模板自动巡检"）
        """
        self.channel_name = channel_name
        self.bind_instance_id = bind_instance_id
        self.output_dir = output_dir or os.path.join(_PROJECT, 'auto', channel_name)
        self.screenshot_prefix = screenshot_prefix or channel_name[:2]
        self.checkpoint_key = checkpoint_key or f'{channel_name}频道'
        self.report_title = report_title or f'{channel_name}频道模板自动巡检'

        # 运行时状态
        self.test_results: List[dict] = []
        self.templates: List[dict] = []
        self.template_count = 0
        self.current_template_idx = 0
        self.public_checks: List[dict] = []
        self.channel_checks: List[dict] = []
        self.expected_map: Dict[str, bool] = {}
        self.seen_bounds: set = set()

        # 日志分析
        self.log_watcher = LogcatWatcher()
        self.log_analysis: Optional[dict] = None

        # 创建子组件
        self.inspector = TemplateInspector(
            output_dir=self.output_dir,
            screenshot_prefix=self.screenshot_prefix,
        )

    # ════════════════════════════════════════════════════════════
    # 公共工具
    # ════════════════════════════════════════════════════════════

    @staticmethod
    def _rel(path: str) -> str:
        if not path:
            return ''
        try:
            r = os.path.relpath(path, _PROJECT)
            return r if not r.startswith('..') else path
        except ValueError:
            return path

    @staticmethod
    def _ts() -> str:
        return datetime.now().strftime('%Y%m%d_%H%M%S')

    # ════════════════════════════════════════════════════════════
    # 导航 — 参数化
    # ════════════════════════════════════════════════════════════

    def _build_tab_name_map(self):
        """构建 导航标题 ↔ sn 映射。"""
        channels = stub.get_channel_list()
        return ({ch['title']: ch['sn'] for ch in channels},
                {ch['sn']: ch['title'] for ch in channels})

    def navigate(self) -> bool:
        """导航到目标频道。HOME → 计算方向/步数 → 到达后 OK 确认。"""
        log_step(f'导航到"{self.channel_name}"频道')

        home()
        home()
        time.sleep(2)
        wait_page_stable(timeout=5)

        fi = get_focus_info(out_dir=self.output_dir)
        cur_title = fi.get('content_desc', '')
        log_info(f'当前焦点: "{cur_title}" @ {fi.get("bounds","")}')

        if cur_title == self.channel_name or self.channel_name in cur_title:
            log_ok(f'✅ 当前焦点已在"{self.channel_name}"tab')
            dpad_down()
            time.sleep(0.8)
            return True

        title_to_sn, sn_to_title = self._build_tab_name_map()
        target_sn = None
        cur_sn = None
        for ch in stub.get_channel_list():
            if ch['bindInstanceId'] == self.bind_instance_id:
                target_sn = ch['sn']
            if cur_title and ch['title'] in cur_title:
                cur_sn = ch['sn']

        if cur_sn is None:
            log_warn(f'当前焦点 "{cur_title}" 未在频道列表中找到，默认 sn=4')
            cur_sn = 4
        if target_sn is None:
            log_error(f'❌ 未找到目标频道 (bindInstanceId={self.bind_instance_id})')
            return False

        steps = abs(target_sn - cur_sn)
        direction = 'left' if target_sn < cur_sn else 'right'
        log_info(f'从 "{sn_to_title.get(cur_sn,cur_sn)}"(sn={cur_sn}) → '
                 f'"{self.channel_name}"(sn={target_sn}) => {direction} {steps} 步')

        fn = dpad_left if direction == 'left' else dpad_right
        for i in range(steps):
            fn()
            time.sleep(0.3 if i < 3 else 0.2)

        time.sleep(0.5)
        wait_page_stable(timeout=5)

        fi = get_focus_info(out_dir=self.output_dir)
        cur_title = fi.get('content_desc', '')
        log_info(f'到达: "{cur_title}" @ {fi.get("bounds","")}')

        if cur_title == self.channel_name or self.channel_name in cur_title:
            log_ok(f'✅ 已进入{self.channel_name}频道')
            dpad_down()
            time.sleep(0.8)
            return True

        log_warn(f'⚠ 导航到{self.channel_name}后焦点不匹配，但继续执行')
        return True

    # ════════════════════════════════════════════════════════════
    # 测试桩加载
    # ════════════════════════════════════════════════════════════

    def load_stub(self) -> bool:
        """加载当前频道的测试桩，填充 self.templates。"""
        log_step(f'加载{self.channel_name}频道测试桩')
        channels = stub.get_channel_list()
        target_ch = None
        for ch in channels:
            if ch['title'] == self.channel_name:
                target_ch = ch
                break
        if not target_ch:
            log_error(f'❌ 导航菜单中未找到"{self.channel_name}"频道')
            return False

        log_info(f'导航条目: sn={target_ch["sn"]}, bindInstanceId={target_ch["bindInstanceId"]}')
        stub_path = stub.find_channel_stub(target_ch)
        if not stub_path:
            log_error(f'❌ 未找到{self.channel_name}频道测试桩文件')
            return False

        self.templates = stub.extract_template_info(stub_path)
        self.template_count = len(self.templates)
        self._template_titles = [t.get('name', '') for t in self.templates if t.get('name')]
        log_ok(f'✅ 测试桩: {os.path.basename(stub_path)} ({self.template_count} 个模板)')
        for i, t in enumerate(self.templates):
            tname = t.get('templateName', '') or t.get('templateId', '?')
            log_info(f'  [{i+1}] {tname}')
        return True

    # ════════════════════════════════════════════════════════════
    # Checkpoints 加载
    # ════════════════════════════════════════════════════════════

    def load_checkpoints(self):
        """加载 checkpoints.json，构建 expected_map。"""
        log_info('─' * 50)
        log_info('步骤 3/5: 加载模板 checkpoints')
        checkpoint_data = _load_checkpoints()
        self.public_checks = (checkpoint_data.get('公共检查', [])
                              if checkpoint_data else [])
        self.channel_checks = (
            checkpoint_data.get('频道模板检查点', {}).get(self.checkpoint_key, [])
            if checkpoint_data else [])
        self.expected_map = {}
        for entry in self.channel_checks:
            self.expected_map[entry['模板名']] = entry.get('expected', True)
        expected_false_count = sum(1 for v in self.expected_map.values() if not v)
        log_ok(f'已加载 {len(self.public_checks)} 条公共检查 + {len(self.channel_checks)} 个模板专属检查 '
               f'+ {expected_false_count} 个expected=false')

    # ════════════════════════════════════════════════════════════
    # 模板间导航
    # ════════════════════════════════════════════════════════════

    def _get_focus_center_y_from_root(self, root) -> Optional[int]:
        """从已解析的 XML root 中找 focused 节点 center-Y。"""
        try:
            focused = root.find('.//*[@focused="true"]')
            if focused is None:
                return None
            bounds = focused.attrib.get('bounds', '')
            m = re.match(r'\[(\d+),(\d+)\]\[(\d+),(\d+)\]', bounds)
            if m:
                y1, y3 = int(m.group(2)), int(m.group(4))
                return (y1 + y3) // 2
            return None
        except Exception:
            return None

    def _find_next_expected_idx(self, current_idx: int) -> int:
        """找到当前索引之后第一个 expected=true 的模板索引，跳过 expected=false。"""
        for k in range(current_idx + 1, len(self.templates)):
            tname_k = (self.templates[k].get('templateName', '')
                       or self.templates[k].get('templateId', ''))
            # 精确匹配优先（避免 "6竖图" 子串误匹配 "6竖图排行"）
            if tname_k in self.expected_map:
                if self.expected_map[tname_k]:
                    return k
                log_info(f'  跳过 expected=false 模板: {tname_k}')
                continue
            # 模糊匹配兜底
            _exp = True
            for _ek, _ev in self.expected_map.items():
                if tname_k in _ek or _ek in tname_k:
                    _exp = _ev
                    break
            if not _exp:
                log_info(f'  跳过 expected=false 模板: {tname_k}')
                continue
            return k
        return -1

    def navigate_to_next_template(self, current_idx: int) -> bool:
        """基于区域坐标匹配的模板间导航。"""
        next_real_idx = self._find_next_expected_idx(current_idx)
        if next_real_idx < 0:
            log_info('已是最后一个模板或后续都是 expected=false，无需导航')
            return True

        next_name = (self.templates[next_real_idx].get('templateName', '')
                     or self.templates[next_real_idx].get('templateId', ''))
        log_info(f'  导航: [{current_idx}] → [{next_real_idx}] {next_name}')

        def _fallback_blind(msg: str) -> bool:
            log_warn(f'  {msg}，降级盲走 6 步')
            for _ in range(6):
                dpad_down()
                time.sleep(0.25)
            return True

        xml_path = dump_uiautomator(out_dir=self.output_dir, retries=2)
        if not xml_path:
            return _fallback_blind('XML dump 失败')

        with open(xml_path, 'r', encoding='utf-8') as f:
            raw = f.read()
        raw = self.inspector._fix_xml_format(raw)
        root = ET.fromstring(raw)

        try:
            regions = extract_template_regions(root, template_titles=self._template_titles)
        except Exception as e:
            return _fallback_blind(f'extract_template_regions 异常: {e}')

        if not regions:
            return _fallback_blind('未提取到任何区域')

        log_info(f'  页面区域一览 ({len(regions)} 个):')
        for r in regions:
            log_info(f'    {r["name"]:30s} Y=[{r["y1"]},{r["y2"]})  {r["width"]}x{r["height"]}')

        target_region = None
        for r in regions:
            if r['name'] == next_name:
                target_region = r
                break
        if target_region is None:
            log_warn(f'  未找到模板 "{next_name}" 对应区域，用区域顺序推定')
            sorted_regions = sorted(regions, key=lambda x: x['y1'])
            target_y1 = (sorted_regions[next_real_idx]['y1']
                         if next_real_idx < len(sorted_regions)
                         else sorted_regions[-1]['y1'])
        else:
            target_y1 = target_region['y1']

        log_info(f'  目标 Y 阈值: {target_y1}')

        for step in range(1, 31):
            dpad_down()
            time.sleep(0.35)

            _xml_path = dump_uiautomator(out_dir=self.output_dir, retries=1)
            if not _xml_path:
                continue
            try:
                with open(_xml_path, 'r', encoding='utf-8') as _f:
                    _raw = _f.read()
                _raw = self.inspector._fix_xml_format(_raw)
                _step_root = ET.fromstring(_raw)

                _step_regions = extract_template_regions(_step_root, template_titles=self._template_titles)
                focus_cy = self._get_focus_center_y_from_root(_step_root)

                if _step_regions:
                    _matched_region = None
                    for r in _step_regions:
                        if r['name'] == next_name:
                            _matched_region = r
                            break
                    if _matched_region:
                        if focus_cy is not None and focus_cy >= _matched_region['y1']:
                            log_ok(f'    ↓{step} 焦点 Y={focus_cy} 已进入「{next_name}」'
                                   f' [{_matched_region["y1"]},{_matched_region["y2"]}) ✓')
                            time.sleep(1.0)
                            wait_page_stable(timeout=5)
                            return True
                        log_info(f'    ↓{step} 模板「{next_name}」在区域中但焦点 Y={focus_cy} '
                                 f'未进入 Y≥{_matched_region["y1"]}，继续下移')
                    if len(_step_regions) > len(regions):
                        log_info(f'    ↓{step} 新区域 {len(_step_regions)} 个（之前 {len(regions)}）')
                        regions = _step_regions
                        for r in regions:
                            if r['name'] == next_name:
                                target_y1 = r['y1']
                                break

                if focus_cy is None:
                    continue
                if step % 5 == 0:
                    log_info(f'    ↓{step} 焦点 Y={focus_cy} (目标={next_name})')
            except Exception:
                continue

        log_warn(f'    30 步后未到达 {next_name}，降级放行')
        return True

    # ════════════════════════════════════════════════════════════
    # expected=false 处理
    # ════════════════════════════════════════════════════════════

    def _build_expected_false_result(self, tname: str,
                                     current_template_idx: int) -> dict:
        """expected=false 模板的检查结果。"""
        absent = self.inspector.check_template_absent(tname)
        detail = ('模板未出现在区域列表中 ✓' if absent
                  else f'模板「{tname}」异常出现在区域列表中')
        if absent:
            log_ok(f'  ✅ expected=false: 通过(不存在)')
        else:
            log_warn(f'  ❌ expected=false: 失败(模板异常出现)')

        return {
            'sn': current_template_idx + 1,
            'title': f'{tname} (不支持)',
            'status': 'normal' if absent else 'warning',
            'templates': [{'templateName': tname, 'cardCount': 0}],
            'screenshots': [],
            'abnormalities': [] if absent else [detail],
            'check_items': [{
                'name': '不支持的模板',
                'passed': absent,
                'detail': ('本项目不支持此模板展示，未检测到模板，符合预期'
                           if absent else '模板异常出现在区域中'),
            }],
            'ai_model': 'N/A',
        }

    # ════════════════════════════════════════════════════════════
    # 底部兜底裁剪
    # ════════════════════════════════════════════════════════════

    def _bottom_crop_fallback(self, snap: dict, idx: int) -> str:
        """最后一个模板且裁剪失败时，用最后一区域 Y 做全宽裁剪。"""
        crop_path = ''
        try:
            xml_path = dump_uiautomator(out_dir=self.output_dir, retries=1)
            if xml_path:
                with open(xml_path, 'r', encoding='utf-8') as f:
                    raw = f.read()
                raw = self.inspector._fix_xml_format(raw)
                root = ET.fromstring(raw)
                regions = extract_template_regions(root, template_titles=self._template_titles)
                if regions:
                    last_y = max(r.get('y', 0) for r in regions)
                    last_h = next((r['h'] for r in regions if r.get('y', 0) == last_y), 400)
                    img_path = snap.get('screenshot', '')
                    if img_path and os.path.exists(img_path):
                        from PIL import Image
                        img = Image.open(img_path)
                        w, h = img.size
                        bottom_img = img.crop((0, last_y, w, min(h, last_y + last_h + 100)))
                        crop_path = os.path.join(self.output_dir,
                                                  f'crop_bottom_{idx+1}.png')
                        bottom_img.save(crop_path)
                        log_ok(f'  ✅ 底部全宽裁剪成功: {self._rel(crop_path)} '
                               f'({w}x{bottom_img.size[1]})')
        except Exception as e:
            log_warn(f'  底部裁剪兜底失败: {e}')
        return crop_path

    # ════════════════════════════════════════════════════════════
    # 运行入口
    # ════════════════════════════════════════════════════════════

    def run(self):
        """执行全流程巡检。"""
        os.makedirs(self.output_dir, exist_ok=True)
        prewarm_appium()

        log_info('')
        log_info('=' * 60)
        log_info(self.report_title)
        log_info('=' * 60)
        log_info('')

        self.test_results = []
        t_start = time.time()

        try:
            # ── 启动 logcat 监控（巡检全程捕获） ──
            self.log_watcher.start()
            log_info('Logcat 监控已启动（巡检全程捕获）')

            # ── 步骤 1: 导航 ──
            log_info('─' * 50)
            log_info(f'步骤 1/5: 导航到{self.channel_name}频道')
            ok_nav = self.navigate()
            if not ok_nav:
                log_warn(f'❌ 导航失败，尝试 HOME 后重试')
                home()
                time.sleep(2)
                ok_nav = self.navigate()
                if not ok_nav:
                    raise RuntimeError(f'无法导航到{self.channel_name}频道')

            # ── 步骤 2: 测试桩 ──
            log_info('─' * 50)
            log_info('步骤 2/5: 加载测试桩 & 分析模板')
            if not self.load_stub():
                raise RuntimeError(f'未找到{self.channel_name}频道模板')

            # ── 步骤 3: checkpoints ──
            self.load_checkpoints()

            # ── 步骤 4: 逐模板检查 ──
            log_info('─' * 50)
            log_info(f'步骤 4/5: 逐模板检查（共 {self.template_count} 个模板）')

            self.current_template_idx = 0
            self.seen_bounds = set()

            while self.current_template_idx < self.template_count:
                tmpl = self.templates[self.current_template_idx]
                tname = tmpl.get('templateName', '') or tmpl.get('templateId', '?')

                # expected 判定（精确匹配优先）
                is_expected = True
                best_match = None
                for entry in self.channel_checks:
                    tpl = entry.get('模板名', '')
                    if tpl == tname:
                        best_match = entry
                        break
                    if best_match is None and (tpl in tname or tname in tpl):
                        best_match = entry
                if best_match is not None:
                    is_expected = best_match.get('expected', True)

                log_info('─' * 40)
                log_info(f'模板 [{self.current_template_idx+1}/{self.template_count}]: {tname}'
                         + ('' if is_expected else ' (expected=false)'))

                if not is_expected:
                    result = self._build_expected_false_result(
                        tname, self.current_template_idx)
                    self.test_results.append(result)
                    self.current_template_idx += 1
                    continue

                self.seen_bounds = set()

                # 4a: 查找该模板的专属检查（精确匹配优先）
                exclusive = []
                best_exclusive = None
                for entry in self.channel_checks:
                    tpl = entry.get('模板名', '')
                    if tpl == tname:
                        best_exclusive = entry
                        break
                    if best_exclusive is None and (tpl in tname or tname in tpl):
                        best_exclusive = entry
                if best_exclusive is not None:
                    exclusive = best_exclusive.get('专属检查', [])

                # 4b: 委托 TemplateInspector 完成截图→裁剪→绿框→AI（公共+专属一起）
                insp_result = self.inspector.inspect(
                    tname,
                    public_checks=self.public_checks,
                    exclusive_checks=exclusive,
                    template_idx=self.current_template_idx + 1,
                    template_titles=self._template_titles,
                )

                # 底部重复检测
                if insp_result.get('_bottom_repeat'):
                    log_warn(f'  焦点底部重复，已到底，跳过后续模板')
                    break

                # 4c: 底部兜底（最后一个模板且裁剪失败）
                if (not insp_result.get('screenshots')
                        and self.current_template_idx == self.template_count - 1):
                    snap = self.inspector.screenshot_with_focus(
                        f'template_{self.current_template_idx+1}')
                    crop_path = self._bottom_crop_fallback(
                        snap, self.current_template_idx)
                    if crop_path:
                        insp_result['screenshots'].append(
                            {'file': crop_path, 'label': '底部全宽裁剪'})

                # 4d: 组装最终结果（补充 cardCount）
                result = dict(insp_result)
                result['sn'] = self.current_template_idx + 1
                result['templates'] = [{
                    'templateName': tname,
                    'cardCount': tmpl.get('pageCount', 0),
                }]
                self.test_results.append(result)

                # 日志摘要
                status = result['status']
                total_insp = insp_result.get('_total', 0)
                passed_insp = insp_result.get('_passed', 0)
                _icon = '✅' if status == 'normal' else ('⚠️' if status == 'warning' else '❌')
                if status == 'normal':
                    log_ok(f'{_icon} {tname}: 通过 {passed_insp}/{total_insp}')
                else:
                    log_warn(f'{_icon} {tname}: 通过 {passed_insp}/{total_insp}')
                for ab in result.get('abnormalities', []):
                    log_warn(f'    ⚠ {ab}')

                # 4e: 导航到下一个
                at_target = self.navigate_to_next_template(self.current_template_idx)
                self.current_template_idx += 1
                if not at_target:
                    log_info(f'  已到底，跳过后续 {self.template_count - self.current_template_idx} 个模板')
                    break

            log_info('─' * 50)
            log_ok('全部模板检查完成')

        except KeyboardInterrupt:
            log_warn('\n⚠️ 用户中断执行')
            self._stop_log_watcher()
            self._report_final()
            return
        except Exception as e:
            log_error(f'❌ 测试异常: {e}')
            traceback.print_exc()
            self.test_results.append({
                'sn': len(self.test_results) + 1,
                'title': '测试异常中断',
                'status': 'error',
                'templates': [],
                'screenshots': [],
                'abnormalities': [f'{type(e).__name__}: {str(e)[:200]}'],
                'check_items': [],
                'ai_model': '',
            })

        self._stop_log_watcher()
        self._analyze_logs()
        self._report_final()

    # ════════════════════════════════════════════════════════════
    # 日志分析
    # ════════════════════════════════════════════════════════════

    def _stop_log_watcher(self):
        """停止 logcat 监控。"""
        try:
            if self.log_watcher:
                self.log_watcher.stop()
        except Exception:
            pass

    def _analyze_logs(self):
        """用 Agnes 2.0 Flash Thinking 分析巡检过程中捕获的日志。"""
        agnes_cfg = MODELS.get('agnes-2.0-flash', {})
        if not agnes_cfg.get('api_key'):
            log_info('agnes-2.0-flash 未配置 api_key，跳过日志分析')
            log_info('如需开启日志根因分析，请在 engine_config/config.py MODELS 中设置 agnes-2.0-flash.api_key')
            return

        if not self.log_watcher:
            return

        events = self.log_watcher.get_events(min_level='WARN')
        if not events:
            log_info('巡检期间未捕获到 WARN+ 日志，跳过分析')
            return

        log_info('─' * 50)
        log_info(f'日志分析: Logcat 捕获 {len(events)} 条 WARN+ 事件，开始 Thinking 根因分析...')

        try:
            analyzer = LogAnalyzer()
            result = analyzer.analyze(
                events,
                source_label=f'{self.channel_name}频道巡检',
                thinking_budget=4096,
            )
            self.log_analysis = result

            if result:
                crash_n = len(result.get('crash_root_causes', []))
                anr_n = len(result.get('anr_root_causes', []))
                other_n = len(result.get('other_issues', []))
                log_ok(f'日志分析完成: {crash_n} 崩溃根因, {anr_n} ANR根因, {other_n} 其他问题')
                for rec in result.get('recommendations', []):
                    log_info(f'  💡 建议: {rec[:120]}')
            else:
                log_warn('日志分析返回空结果')

        except Exception as e:
            log_error(f'日志分析异常: {e}')
            import traceback
            traceback.print_exc()

    # ════════════════════════════════════════════════════════════
    # 报告
    # ════════════════════════════════════════════════════════════

    def _report_final(self):
        """生成 HTML 报告 + 打印摘要。"""
        from datetime import datetime as _dt
        # 估算耗时——从第一行日志到最后
        import time as _time

        log_info('─' * 50)
        log_info('步骤 5/5: 生成 HTML 报告')

        report_path = generate_html_report(self.test_results, 0,
                                            log_analysis=self.log_analysis)
        if report_path:
            log_info(f'✅ 报告已生成: {self._rel(report_path)}')
        else:
            log_error('❌ 报告生成失败')

        log_info('')
        log_info('=' * 60)
        log_info('📊 测试结果摘要')
        log_info('=' * 60)
        total = len(self.test_results)
        norm = sum(1 for r in self.test_results if r['status'] == 'normal')
        warn = sum(1 for r in self.test_results if r['status'] == 'warning')
        abn = sum(1 for r in self.test_results if r['status'] in ('abnormal', 'error'))
        log_info(f'  总计模板: {total}')
        log_info(f'  通过(✅): {norm}')
        log_info(f'  警告(⚠️): {warn}')
        log_info(f'  异常(❌): {abn}')
        log_info('')
        for r in self.test_results:
            _icon = '✅' if r['status'] == 'normal' else ('⚠️' if r['status'] == 'warning' else '❌')
            log_info(f"  {_icon} [{r['sn']}] {r['title']}")
            for ab in r.get('abnormalities', []):
                log_info(f"        ⚠ {ab[:120]}")
        log_info('')
        if report_path:
            log_info(f'📋 报告文件: {self._rel(report_path)}')
        log_info('=' * 60)
        log_info('')
