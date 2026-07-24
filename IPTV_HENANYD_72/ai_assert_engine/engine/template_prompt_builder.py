#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
模板提示词构建器

从测试桩 JSON 加载频道模板列表 → 自动匹配 checkpoints.json 中的模板描述和检查点 →
自动拼接 system_prompt，直接传给 ai_service 使用。

核心使用模式：
  from template_prompt_builder import prompt_builder

  # 1. 加载频道提示词（基于测试桩）
  builder = prompt_builder.load(stub_path="测试桩/GetInitMetaData_直播频道.json")

  # 2a. 单个模板提示词
  sp = builder.build_for_template("直播居中模版新")
  result = ai.ask("描述这个模板的布局", system_prompt=sp)

  # 2b. 全部模板提示词（用于整页分析）
  sp = builder.build_for_channel()
  result = ai.ask("分析整个页面的布局和异常", system_prompt=sp)

  # 2c. 快捷方法（一行调用）
  result = ai.ask_template("描述这个模板的布局", builder, "直播居中模版新")
"""

import os
import json
import re
import sys

_PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if _PROJECT_DIR not in sys.path:
    sys.path.insert(0, _PROJECT_DIR)

from lib import stub_parser
from engine_config.config import PROJECT_ROOT

from typing import Optional


# ── 日志 ──
try:
    from lib.logger import log
except ImportError:
    def log(msg, level='INFO'):
        print(f"[{level}] {msg}")


# ══════════════════════════════════════════════════════════════
# checkpoints.json 加载
# ══════════════════════════════════════════════════════════════

_CHECKPOINTS_PATH = os.path.join(
    PROJECT_ROOT, 'ai_assert_engine', 'template_prompts', 'checkpoints.json'
)
_checkpoints_cache = None


def _load_checkpoints():
    """加载 checkpoints.json 并缓存"""
    global _checkpoints_cache
    if _checkpoints_cache is not None:
        return _checkpoints_cache
    try:
        with open(_CHECKPOINTS_PATH, 'r', encoding='utf-8') as f:
            _checkpoints_cache = json.load(f)
        log(f'[TPB] 已加载 checkpoints.json ({os.path.basename(_CHECKPOINTS_PATH)})', 'INFO')
    except Exception as e:
        log(f'[TPB] 加载 checkpoints.json 失败: {e}', 'WARN')
        _checkpoints_cache = {}
    return _checkpoints_cache


# ══════════════════════════════════════════════════════════════
# 模板名称匹配
# ══════════════════════════════════════════════════════════════

def _fuzzy_match(name: str, candidates: list) -> Optional[dict]:
    """
    模糊匹配模板名。
    规则：
      1. 完全一致传
      2. 测试桩名包含 checkpoints 名
      3. checkpoints 名包含测试桩名
      4. 去除版本号前缀后匹配（如 "3.18 首屏4横图通栏模板" → "首屏4横图通栏模板"）
    """
    if not name or not candidates:
        return None

    # 1) 精确匹配
    for c in candidates:
        if c.get('模板名') == name:
            return c

    # 2) 测试桩名包含 checkpoints 名
    for c in candidates:
        cn = c.get('模板名', '')
        if cn and cn in name:
            return c

    # 3) checkpoints 名包含测试桩名
    for c in candidates:
        cn = c.get('模板名', '')
        if cn and name in cn:
            return c

    # 4) 去版本号前缀对比
    clean_name = re.sub(r'^[\d.]+\s*', '', name).strip()
    for c in candidates:
        cn = c.get('模板名', '')
        clean_cn = re.sub(r'^[\d.]+\s*', '', cn).strip()
        if clean_name == clean_cn or clean_name in clean_cn or clean_cn in clean_name:
            return c

    return None


# ══════════════════════════════════════════════════════════════
# TemplatePromptBuilder
# ══════════════════════════════════════════════════════════════

class TemplatePromptBuilder:
    """
    模板提示词构建器。

    使用方式：
      builder = TemplatePromptBuilder()
      builder.load(stub_path="测试桩/GetInitMetaData_直播频道.json")

      # 单个模板提示词
      sp = builder.build_for_template("直播居中模版新")
      # 全部模板提示词
      sp = builder.build_for_channel()
    """

    def __init__(self):
        self._channel_name = ""
        self._templates = []            # 来自 stub_parser.extract_template_info
        self._checkpoints = {}           # 来自 checkpoints.json
        self._matched_checkpoints = []   # 匹配结果 [{template_info, checkpoint, common_checks}]

    # ── 加载 ────────────────────────────────────────────────

    def load(self, stub_path: str) -> "TemplatePromptBuilder":
        """
        从测试桩 JSON 加载频道和模板信息，自动匹配 checkpoints.json。

        参数：
          stub_path: 测试桩 JSON 文件路径

        返回：
          self（链式调用）
        """
        # 1) 解析测试桩
        self._templates = stub_parser.extract_template_info(stub_path)
        if not self._templates:
            log('[TPB] 测试桩中未找到模板信息', 'WARN')
            return self

        # 2) 推断频道名（从 stub 文件名 + 模板数据）
        fname = os.path.basename(stub_path)
        ch_match = re.search(r'GetInitMetaData_(.+?)\.json', fname)
        if ch_match:
            self._channel_name = ch_match.group(1)
        else:
            # 兜底：从 stub 文件名取
            self._channel_name = os.path.splitext(fname)[0].replace('GetInitMetaData_', '')

        log(f'[TPB] 频道: {self._channel_name}, 模板数: {len(self._templates)}', 'INFO')

        # 3) 加载 checkpoints
        cp = _load_checkpoints()
        cps_map = cp.get('频道模板检查点', {})
        # 匹配频道：精确 → 前缀包含 → 短名包含
        channel_cps = cps_map.get(self._channel_name, [])
        if not channel_cps:
            for ck in cps_map:
                if ck in self._channel_name or self._channel_name in ck:
                    channel_cps = cps_map[ck]
                    log(f'[TPB] 频道名模糊匹配: "{self._channel_name}" → "{ck}"', 'INFO')
                    break
        common_checks = cp.get('公共检查', [])

        if not channel_cps:
            log(f'[TPB] checkpoints.json 中未找到频道「{self._channel_name}」的模板检查点', 'WARN')

        # 4) 匹配：每个测试桩模板 → checkpoints 中的描述
        self._matched_checkpoints = []
        for t in self._templates:
            tname = t.get('templateName', t.get('name', ''))
            matched = _fuzzy_match(tname, channel_cps)
            self._matched_checkpoints.append({
                'template': t,
                'checkpoint': matched,
                'common_checks': common_checks,
            })
            if matched:
                desc = matched.get('描述', '(无描述)')
                expected = matched.get('expected', True)
                extra = matched.get('专属检查', [])
                log(f'[TPB]   ✔ {tname}', 'OK')
                log(f'[TPB]     描述: {desc}', 'INFO')
                log(f'[TPB]     预期: {"展示" if expected else "不展示"}', 'INFO')
                if extra:
                    for item in extra:
                        log(f'[TPB]     专属检查: [{item["名称"]}] {item.get("说明", "")}', 'INFO')
                else:
                    log(f'[TPB]     专属检查: (无)', 'INFO')
            else:
                log(f'[TPB]   ~ {tname} → 无 checkpoints 匹配，使用默认', 'INFO')

        # 打印公共检查
        if common_checks:
            log(f'[TPB]   公共检查项 ({len(common_checks)} 条):', 'INFO')
            for item in common_checks:
                log(f'[TPB]     - [{item["名称"]}] {item.get("说明", "")}', 'INFO')

        return self

    def load_raw(self, channel_name: str, template_list: list) -> "TemplatePromptBuilder":
        """
        直接传入频道名+模板列表（不读测试桩文件）。

        用于已有 template_info 的场景，避免重复解析。

        参数：
          channel_name: 频道名（如 "直播"）
          template_list: stub_parser.extract_template_info 返回的列表
        """
        self._channel_name = channel_name
        self._templates = template_list
        cp = _load_checkpoints()
        cps_map = cp.get('频道模板检查点', {})
        channel_cps = cps_map.get(channel_name, [])
        if not channel_cps:
            for ck in cps_map:
                if ck in channel_name or channel_name in ck:
                    channel_cps = cps_map[ck]
                    log(f'[TPB] load_raw 频道名模糊匹配: "{channel_name}" → "{ck}"', 'INFO')
                    break
        common_checks = cp.get('公共检查', [])

        self._matched_checkpoints = []
        for t in template_list:
            tname = t.get('templateName', t.get('name', ''))
            matched = _fuzzy_match(tname, channel_cps)
            self._matched_checkpoints.append({
                'template': t,
                'checkpoint': matched,
                'common_checks': common_checks,
            })
            if matched:
                desc = matched.get('描述', '(无描述)')
                expected = matched.get('expected', True)
                extra = matched.get('专属检查', [])
                log(f'[TPB]   ✔ {tname}', 'OK')
                log(f'[TPB]     描述: {desc}', 'INFO')
                log(f'[TPB]     预期: {"展示" if expected else "不展示"}', 'INFO')
                if extra:
                    for item in extra:
                        log(f'[TPB]     专属检查: [{item["名称"]}] {item.get("说明", "")}', 'INFO')
            else:
                log(f'[TPB]   ~ {tname} → 无 checkpoints 匹配，使用默认', 'INFO')

        if common_checks:
            log(f'[TPB]   公共检查项 ({len(common_checks)} 条):', 'INFO')
            for item in common_checks:
                log(f'[TPB]     - [{item["名称"]}] {item.get("说明", "")}', 'INFO')

        return self

    # ── 属性 ────────────────────────────────────────────────

    @property
    def channel_name(self) -> str:
        return self._channel_name

    @property
    def templates(self) -> list:
        return self._templates

    @property
    def template_names(self) -> list:
        return [t.get('templateName', t.get('name', '')) for t in self._templates]

    def get_checkpoint(self, template_name: str) -> Optional[dict]:
        """获取指定模板的 checkpoints 条目"""
        for mc in self._matched_checkpoints:
            t = mc['template']
            tname = t.get('templateName', t.get('name', ''))
            if tname == template_name or template_name in tname or tname in template_name:
                return mc['checkpoint']
        return None

    # ── 构建提示词 ──────────────────────────────────────────

    def _build_template_block(self, idx: int, mc: dict) -> str:
        """构建单个模板的描述块"""
        t = mc['template']
        cp = mc['checkpoint']
        common = mc['common_checks']

        tname = t.get('templateName', t.get('name', f'模板#{idx+1}'))
        card_count = t.get('card_count', 0)
        tid = t.get('templateId', '')

        lines = [f'第{idx+1}块模板：{tname}']

        # 基本信息
        if card_count:
            lines.append(f'  - 预计卡片数：{card_count}')
        if tid:
            lines.append(f'  - 模板ID：{tid}')

        # checkpoints 描述
        if cp:
            desc = cp.get('描述', '')
            expected = cp.get('expected', None)
            extra_checks = cp.get('专属检查', [])
        else:
            desc = ''
            expected = None
            extra_checks = []

        if desc:
            lines.append(f'  - 预期布局：{desc}')
        if expected is not None:
            lines.append(f'  - 预期状态：{"应该展示" if expected else "不应该展示（项目不支持此模板）"}')

        # 公共检查项
        if common:
            lines.append(f'  - 公共检查：{", ".join(c["名称"] for c in common)}')

        # 专属检查项
        if extra_checks:
            lines.append(f'  - 专属检查：{", ".join(c["名称"] for c in extra_checks)}')

        return '\n'.join(lines)

    def build_for_channel(self) -> str:
        """
        构建频道全量模板提示词（用于整页截图分析）。

        返回 system_prompt 字符串。
        """
        if not self._matched_checkpoints:
            return _DEFAULT_SYSTEM_PROMPT

        blocks = []
        for i, mc in enumerate(self._matched_checkpoints):
            blocks.append(self._build_template_block(i, mc))

        template_text = '\n\n'.join(blocks)

        # 汇总所有专属检查项
        all_extra = []
        for mc in self._matched_checkpoints:
            if mc['checkpoint']:
                for item in mc['checkpoint'].get('专属检查', []):
                    all_extra.append(f'  - [{mc["template"].get("templateName", "")}] {item["名称"]}: {item["说明"]}')

        extra_text = '\n'.join(all_extra) if all_extra else '无'

        return _build_full_prompt(
            channel_name=self._channel_name,
            template_text=template_text,
            extra_text=extra_text,
        )

    def build_for_template(self, template_name: str) -> str:
        """
        构建单个模板的专属提示词（用于单模板裁剪图分析）。

        参数：
          template_name: 模板名（与测试桩中的 templateName 匹配）

        返回 system_prompt 字符串。
        """
        # 找到匹配项
        target = None
        for i, mc in enumerate(self._matched_checkpoints):
            t = mc['template']
            tname = t.get('templateName', t.get('name', ''))
            if tname == template_name or template_name in tname or tname in template_name:
                target = (i, mc)
                break

        if not target:
            log(f'[TPB] 未找到模板「{template_name}」，使用默认提示词', 'WARN')
            return _DEFAULT_SINGLE_TEMPLATE_PROMPT.format(template_name=template_name)

        idx, mc = target
        block = self._build_template_block(idx, mc)

        return _build_single_template_prompt(
            channel_name=self._channel_name,
            template_block=block,
            template_name=template_name,
        )

    def build_compact(self, template_name: str = "") -> str:
        """
        构建紧凑版提示词（仅检查点列表，省 token）。
        适合 vqa() 布尔判断场景。

        参数：
          template_name: 为空则全部模板
        """
        if template_name:
            cp = self.get_checkpoint(template_name)
            if not cp:
                return _DEFAULT_SYSTEM_PROMPT

            common = _load_checkpoints().get('公共检查', [])
            extra = cp.get('专属检查', [])
            expected = cp.get('expected', None)
            desc = cp.get('描述', '')

            lines = [
                f'当前频道：{self._channel_name}',
                f'当前模板：{template_name}',
                f'模板描述：{desc}' if desc else '',
            ]
            if expected is not None:
                lines.append(f'该模板{"应该" if expected else "不应该"}展示')
            if common:
                lines.append(f'公共检查: {", ".join(c["名称"] for c in common)}')
            if extra:
                lines.append(f'专属检查: {", ".join(c["名称"] for c in extra)}')
            return '\n'.join(filter(None, lines))
        else:
            lines = [f'当前频道：{self._channel_name}']
            for mc in self._matched_checkpoints:
                t = mc['template']
                cp = mc['checkpoint']
                tname = t.get('templateName', '')
                if cp:
                    expected = "展示" if cp.get('expected', True) else "不展示"
                    lines.append(f'  模板「{tname}」：{expected}，{cp.get("描述", "")[:80]}')
                else:
                    lines.append(f'  模板「{tname}」：无特殊说明')
            return '\n'.join(lines)


# ══════════════════════════════════════════════════════════════
# 系统提示词模板
# ══════════════════════════════════════════════════════════════

_DEFAULT_SYSTEM_PROMPT = (
    "你是一个电视大屏（Android TV）UI 测试工程师。"
    "请根据提供的电视屏幕截图，分析模板布局、焦点位置、海报加载状态、文字显示是否正常。"
)

_DEFAULT_SINGLE_TEMPLATE_PROMPT = """你是一个电视大屏（Android TV）UI 测试工程师。
当前模板：{template_name}
请分析截图中的模板布局、卡片排列、海报加载状态、文字显示是否正常。"""


def _build_full_prompt(channel_name: str, template_text: str, extra_text: str) -> str:
    return f"""你是一个电视大屏（Android TV）UI 测试工程师。
当前测试的是 IPTV 机顶盒首页的「{channel_name}」频道。

该频道预期展示以下模板（从上到下排列）：

{template_text}

───
特别提醒：
1. 焦点识别：在大屏电视上，被焦点选中的卡片/海报边框会有**白色实线框**或被放大。
   如果焦点在导航栏（频道标签），被选中的频道标签有**浅蓝色背景**。
2. 模板判断：如果某模板在预期中标记为「不应该展示」，但截图中出现了完整模板内容，判定为异常。
3. 异常判定：破图/裂图/白块/文字重叠/布局错位/大面积空白 都属于异常。
───

专属检查项汇总：
{extra_text}

请分析截图并回答问题。"""


def _build_single_template_prompt(channel_name: str, template_block: str, template_name: str) -> str:
    return f"""你是一个电视大屏（Android TV）UI 测试工程师。
当前测试的是 IPTV 机顶盒「{channel_name}」频道的模板「{template_name}」。

模板信息：
{template_block}

───
特别提醒：
1. 焦点识别：被焦点选中的卡片/海报有**白色实线框**或被放大。
   如果焦点在导航栏，被选中的频道标签有**浅蓝色背景**。
2. 异常判定：破图/裂图/白块/文字重叠/布局错位 都属于异常。
───

请分析截图并回答问题。"""


# ══════════════════════════════════════════════════════════════
# 模块级单例（与 ai_service 风格一致）
# ══════════════════════════════════════════════════════════════

prompt_builder = TemplatePromptBuilder()
