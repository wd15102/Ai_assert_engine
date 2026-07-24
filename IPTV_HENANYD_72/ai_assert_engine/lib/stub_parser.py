#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试桩解析模块 — 读取 JSON 测试桩，提取频道列表与模板元数据
"""

import os
import json
import re

from engine_config.config import NAV_FILE, STUB_DIR

# 模板 → 焦点下移次数映射
# 与 scroll_crop_engine.TEMPLATE_SCROLL_MAP 保持同步
TEMPLATE_SCROLL_MAP = {
    'common_live_mid2_template': 7,   # 直播居中模版新（11个卡片，需7次下键移出）
}

def _log(msg, level='INFO'):
    from lib.logger import log
    log(msg, level)

def get_template_scroll(template_info):
    """
    检测是否有特殊模板，返回该模板需要的最大 DPAD_DOWN 次数
    用于控制循环次数（保证有足够轮次把焦点移出来）
    """
    for t in template_info:
        for keyword, sc in TEMPLATE_SCROLL_MAP.items():
            if keyword in t.get('templateId', ''):
                return sc
    return 0
# ══════════════════════════════════════════════════════════════
# JSON 加载
# ══════════════════════════════════════════════════════════════

def load_json(path):
    """安全加载 JSON 文件，不存在或解析失败返回 None"""
    if not os.path.exists(path):
        _log(f'文件不存在: {path}', 'WARN')
        return None
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception as e:
        _log(f'JSON 解析失败: {path} — {e}', 'ERROR')
        return None


# ══════════════════════════════════════════════════════════════
# 频道列表
# ══════════════════════════════════════════════════════════════

def get_channel_list():
    """
    从导航 JSON（guidePlusList）解析频道列表
    返回 [{"sn": int, "title": str, "bindInstanceId": str}]，按 sn 排序
    """
    nav = load_json(NAV_FILE)
    if not nav:
        return []

    datas = nav['templateDatas'][0]['datas']
    channels = []

    for d in datas:
        da = d.get('defaultActions') or {}
        sa = d.get('selectedActions') or {}

        try:
            sn = int(d.get('serialNumber', '0'))
        except ValueError:
            continue

        bind_id = sa.get('bindInstanceId', '') or da.get('bindInstanceId', '')
        channels.append({
            'sn': sn,
            'title': d.get('title', ''),
            'bindInstanceId': bind_id,
        })

    channels.sort(key=lambda c: c['sn'])
    return channels


# ══════════════════════════════════════════════════════════════
# 测试桩查找与匹配
# ══════════════════════════════════════════════════════════════

# 注意：KEYWORD_MAP 已移除。匹配仅通过 bindInstanceId → instacneId 精确比对。


# ------------------------------------------------------------
# 基于内容的测试桩索引
# ------------------------------------------------------------

_STUB_INDEX_CACHE = None  # 模块级缓存，只构建一次


def _extract_instacne_ids(filepath):
    """
    从测试桩 JSON 提取该文件自己的顶层 instacneId（文件身份标识）。
    只取 templateDatas[0].instacneId，不取模板内部引用的 bindInstanceId，
    避免其他文件的引用 ID 导致匹配混乱。
    """
    try:
        data = load_json(filepath)
        if not data:
            return set(), set()
        ids, names = set(), set()
        tds = data.get('templateDatas', [])
        for td in tds:
            iid = td.get('instacneId')
            if iid:
                ids.add(iid)
            iname = td.get('instacneName')
            if iname:
                names.add(iname)
        return ids, names
    except Exception as e:
        _log(f'_extract_instacne_ids 出错: {e}', 'WARN')
        return set(), set()


def _norm_filename(f):
    """规范化文件名：去掉 .json 和 GetInitMetaData_ 前缀"""
    n = f.replace('.json', '')
    if n.startswith('GetInitMetaData_'):
        n = n[len('GetInitMetaData_'):]
    if n.endswith('.json'):
        n = n[:-5]
    return n


def _build_stub_index():
    """构建测试桩 instacneId 索引，返回 (id_idx, candidates)"""
    global _STUB_INDEX_CACHE
    if _STUB_INDEX_CACHE is not None:
        return _STUB_INDEX_CACHE

    try:
        candidates = [f for f in os.listdir(STUB_DIR)
                      if f.startswith('GetInitMetaData')
                      and not f.endswith('.bak')
                      and not f.endswith('.py')]
    except FileNotFoundError:
        _log(f'测试桩目录不存在: {STUB_DIR}', 'ERROR')
        _STUB_INDEX_CACHE = ({}, [])
        return _STUB_INDEX_CACHE

    id_idx = {}  # instacneId -> [(filepath, norm_name)]

    for f in candidates:
        fp = os.path.join(STUB_DIR, f)
        norm = _norm_filename(f)
        ids, _ = _extract_instacne_ids(fp)
        for iid in ids:
            id_idx.setdefault(iid, []).append((fp, norm))

    _STUB_INDEX_CACHE = (id_idx, candidates)
    _log(f'索引构建完成: {len(id_idx)}组instacneId, {len(candidates)}个文件', 'INFO')
    return _STUB_INDEX_CACHE


def find_channel_stub(channel):
    """
    通过 bindInstanceId 精确匹配测试桩 JSON 中的 "instacneId"。
    """
    bind_id = channel['bindInstanceId']
    title = channel['title']
    id_idx, candidates = _build_stub_index()

    if not candidates:
        return None

    # 唯一策略：instacneId 精确匹配
    if bind_id and bind_id in id_idx:
        matches = id_idx[bind_id]
        if len(matches) == 1:
            _log(f'instacneId匹配: {os.path.basename(matches[0][0])}', 'INFO')
            return matches[0][0]
        # 重复 instacneId，优先选文件名含频道名的
        title_words = set(w for w in re.split(r'[ _]', title) if w)
        scored = []
        for fp, norm in matches:
            # 文件名含频道名算最佳匹配
            score = 0
            if title in norm or norm in title:
                score = 10
            else:
                # 按单词覆盖打分
                name_words = set(w for w in re.split(r'[ _]', norm) if w)
                overlap = len(title_words & name_words)
                if overlap > 0:
                    score = overlap
            scored.append((score, fp, norm))
        scored.sort(key=lambda x: (-x[0], x[1]))
        best_fp, best_norm = scored[0][1], scored[0][2]
        _log(f'instacneId复用({len(matches)}文件)，选最优: {os.path.basename(best_fp)} (score={scored[0][0]})', 'INFO')
        return best_fp

    _log(f'未匹配: title="{title}" bind={bind_id}', 'WARN')
    return None


# ══════════════════════════════════════════════════════════════
# 模板信息提取
# ══════════════════════════════════════════════════════════════

def extract_template_info(stub_path):
    """
    从测试桩文件中提取模板元数据（按页面排列顺序）。
    按 templateDatas[0].datas[*].defaultTemlpateData 顺序提取，
    保留每块在页面中的位置索引。
    返回 [{sort, name, templateId, templateName, card_count, card_titles}]
    """
    data = load_json(stub_path)
    if not data:
        return []

    templates = []
    tds = data.get('templateDatas', [])
    if not tds or not tds[0].get('datas'):
        return templates

    datas = tds[0]['datas']
    seen_keys = set()

    for idx, d in enumerate(datas):
        dtd = d.get('defaultTemlpateData') or {}
        tid = dtd.get('templateId', '')
        # 用 datas[*].title（页面实际展示的模板标题），不用 defaultTemlpateData.templateName
        tname = d.get('title', '')
        if not tid or not tname:
            continue
        # 同一 templateId 跳过重复（用 tid+idx 做排重键，避免同名不同区的模板被跳）
        key = (tid, idx)
        if key in seen_keys:
            continue
        seen_keys.add(key)

        # 检查该模板下的 datas（卡片数）
        sub_datas = dtd.get('datas') or dtd.get('dataList') or []
        if isinstance(sub_datas, list):
            card_count = len(sub_datas)
            card_titles = [str(sd.get('title', '')) for sd in sub_datas[:10] if sd.get('title')]
        else:
            card_count = 0
            card_titles = []

        templates.append({
            'sort': idx,
            'name': tname,
            'templateId': tid,
            'templateName': tname,
            'card_count': card_count,
            'card_titles': card_titles,
        })

    return templates
def build_expected_summary(template_info):
    """
    根据模板信息生成预期摘要，用于 AI 提示词（带页面位置顺序）。
    返回字符串，如（从上到下排列）：
    第1块 → 模板"首屏4横图通栏模板"：预计 4 个坑位（1行4列）
    第2块 → 模板"common_recommend_v2_template3"：预计 6 个坑位（推荐流）
    ...
    """
    sorted_info = sorted(template_info, key=lambda x: x.get('sort', 0))
    summary_lines = []
    for t in sorted_info:
        sort_idx = t.get('sort', 0)
        name = t.get('templateName', '未知模板')
        count = t.get('card_count', 0)
        # 从名称推断布局（可扩展规则）
        if '4横图' in name or '4h' in name:
            layout = '1行4列'
        elif '通栏' in name:
            layout = '通栏（1行多列）'
        elif '推荐' in name:
            layout = '推荐流（横向滚动）'
        elif '列表' in name:
            layout = '列表（多行1列）'
        elif '居中' in name:
            layout = '居中布局'
        else:
            layout = '未指定布局'
        summary_lines.append(f'第{sort_idx+1}块 → 模板"{name}"：预计 {count} 个坑位（{layout}）')
    return '\n'.join(summary_lines)
