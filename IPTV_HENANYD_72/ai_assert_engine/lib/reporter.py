#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
报告生成模块 — HTML 测试报告
"""

import os
import shutil
from datetime import datetime

from engine_config.config import OUTPUT_DIR, REPORT_DIR, NORMAL_DIR, ABNORMAL_DIR, SCREENSHOT_DIR


def _log(msg, level='INFO'):
    from lib.logger import log
    log(msg, level)


# ══════════════════════════════════════════════════════════════
# 资源管理
# ══════════════════════════════════════════════════════════════

def ensure_dirs():
    """确保所有输出目录存在"""
    for d in [SCREENSHOT_DIR, NORMAL_DIR, ABNORMAL_DIR, REPORT_DIR]:
        os.makedirs(d, exist_ok=True)


def copy_screenshot(source_file, target_dir, new_name):
    """将截图复制到对应的分类目录"""
    os.makedirs(target_dir, exist_ok=True)
    ext = os.path.splitext(source_file)[1] or '.png'
    dest = os.path.join(target_dir, f'{new_name}{ext}')
    shutil.copy2(source_file, dest)
    return dest


# ══════════════════════════════════════════════════════════════
# HTML 报告
# ══════════════════════════════════════════════════════════════

_STATUS_ICON = {
    'normal': 'OK', 'warning': '!!', 'abnormal': 'XX',
    'unknown': '??', 'error': '!!',
}


def generate_html_report(results, total_elapsed, log_analysis=None):
    """
    生成 HTML 格式的测试报告

    Args:
        results: 测试结果列表
        total_elapsed: 总耗时
        log_analysis: 可选，日志分析结果（LogAnalyzer 返回的 dict）

    返回报告文件路径
    """
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    total = len(results)
    normal_count = sum(1 for r in results if r.get('status', 'error') == 'normal')
    warning_count = sum(1 for r in results if r.get('status', '') == 'warning')
    abnormal_count = sum(1 for r in results if r.get('status', '') == 'abnormal')

    all_rows = ''
    for r in results:
        icon = _STATUS_ICON.get(r.get('status', 'unknown'), '??')

        # 截图（带标签说明）
        screenshots_html = ''
        for s in r.get('screenshots', []):
            rel = os.path.relpath(s['file'], OUTPUT_DIR)
            label = s.get('label', '')
            screenshots_html += (
                f'<div style="display:inline-block;text-align:center;margin:4px;">'
                f'<img src="../{rel}" '
                f'style="max-width:320px;border:1px solid #ddd;border-radius:4px;">'
                f'<div style="font-size:11px;color:#888;margin-top:2px;">{label}</div>'
                f'</div>'
            )

        # 模板
        templates_html = ''
        for t in r.get('templates', []):
            templates_html += (
                f'<div style="margin:2px 0;font-size:13px;color:#555;">'
                f'{t.get("templateName", "")} ({t.get("cardCount", 0)}个卡片)'
                f'</div>'
            )

        # 异常
        abn_html = ''
        for ab in r.get('abnormalities', []):
            abn_html += f'<div style="color:#d32f2f;font-size:13px;">{ab}</div>'

        # 检查项明细
        checks_html = ''
        for ci in r.get('check_items', []):
            icon_c = '✅' if ci['passed'] else '❌'
            checks_html += (
                f'<div style="font-size:12px;margin:1px 0;">'
                f'{icon_c} <b>{ci["name"]}</b> {ci["detail"]}'
                f'</div>'
            )
        if checks_html:
            ai_model = r.get('ai_model', '')
            checks_html = f'<div style="font-size:11px;color:#999;margin-bottom:4px;">AI模型: {ai_model}</div>' + checks_html

        # 不支持模板备注
        title = r["title"]
        extra_note = ''
        for it in r.get('check_items', []):
            if '不支持的模板' in it.get('name', ''):
                extra_note = '<div style="font-size:12px;color:#ff9800;margin-top:4px;">⚠ 该项目不支持此模板展示，未检测到模板，符合预期</div>'
                break

        content_cell = templates_html + extra_note + (abn_html if abn_html else '<span style="color:#4caf50;font-size:13px;">正常</span>') + checks_html

        all_rows += f'''
<tr style="border-bottom:1px solid #e0e0e0;">
    <td style="padding:8px;text-align:center;">{r["sn"]}</td>
    <td style="padding:8px;font-weight:bold;">{title}</td>
    <td style="padding:8px;text-align:center;font-weight:bold;font-size:16px;">{icon}</td>
    <td style="padding:8px;">{content_cell}</td>
    <td style="padding:8px;"><div style="display:flex;flex-wrap:wrap;">{
        screenshots_html if screenshots_html else '<span style="color:#999;">无截图</span>'
    }</div></td>
</tr>'''

    # ── 日志分析区块 ──
    log_section = ''
    if log_analysis:
        crash_items = log_analysis.get('crash_root_causes', [])
        anr_items = log_analysis.get('anr_root_causes', [])
        other_items = log_analysis.get('other_issues', [])
        recommendations = log_analysis.get('recommendations', [])
        confidence = log_analysis.get('confidence', 'low')
        overview = log_analysis.get('overview', '')

        _sev_color = {'critical': '#d32f2f', 'high': '#e65100', 'medium': '#ff9800', 'low': '#999'}

        crash_html = ''
        for i, c in enumerate(crash_items):
            sev = c.get('severity', 'low')
            col = _sev_color.get(sev, '#999')
            crash_html += (
                '<div style="background:#fff3f3;border-left:4px solid ' + col + ';margin:8px 0;padding:12px;border-radius:4px;">'
                + '<div style="font-weight:bold;color:' + col + ';">💥 崩溃 #' + str(i+1) + ' <span style="font-size:11px;margin-left:8px;color:#666;">severity: ' + sev + '</span></div>'
                + '<div style="margin:6px 0;font-size:13px;">' + c.get('issue','') + '</div>'
                + '<div style="background:#fafafa;padding:6px;font-size:12px;color:#888;border-radius:3px;font-family:monospace;">' + c.get('evidence','') + '</div>'
                + '</div>'
            )

        anr_html = ''
        for i, c in enumerate(anr_items):
            sev = c.get('severity', 'low')
            col = _sev_color.get(sev, '#999')
            anr_html += (
                '<div style="background:#fff8e1;border-left:4px solid ' + col + ';margin:8px 0;padding:12px;border-radius:4px;">'
                + '<div style="font-weight:bold;color:' + col + ';">⏳ ANR #' + str(i+1) + ' <span style="font-size:11px;margin-left:8px;color:#666;">severity: ' + sev + '</span></div>'
                + '<div style="margin:6px 0;font-size:13px;">' + c.get('issue','') + '</div>'
                + '<div style="background:#fafafa;padding:6px;font-size:12px;color:#888;border-radius:3px;font-family:monospace;">' + c.get('evidence','') + '</div>'
                + '</div>'
            )

        other_html = ''
        for i, c in enumerate(other_items):
            sev = c.get('severity', 'low')
            col = _sev_color.get(sev, '#999')
            other_html += (
                '<div style="border-left:4px solid ' + col + ';margin:6px 0;padding:8px 12px;">'
                + '<div style="font-weight:bold;font-size:13px;color:' + col + ';">⚠ ' + c.get('issue','') + ' <span style="font-size:11px;color:#666;">(' + sev + ')</span></div>'
                + '<div style="font-size:12px;color:#888;margin-top:4px;">' + c.get('evidence','') + '</div>'
                + '</div>'
            )

        rec_html = ''
        for rec in recommendations:
            rec_html += '<li style="margin:4px 0;font-size:13px;">' + rec + '</li>'
        if rec_html:
            rec_html = '<ul style="margin:8px 0;padding-left:20px;">' + rec_html + '</ul>'

        has_warnings = crash_html or anr_html or other_html

        log_section = (
            '<div style="margin-top:24px;border-top:2px solid #eee;padding-top:16px;">'
            + '<div style="display:flex;align-items:center;gap:10px;margin-bottom:12px;">'
            + '<h2 style="font-size:18px;margin:0;color:#333;">🧠 日志根因分析</h2>'
            + '<span style="font-size:11px;background:#f0f0f0;padding:2px 8px;border-radius:10px;">Confidence: ' + confidence + '</span>'
            + '<span style="font-size:11px;color:#999;">Agnes 2.0 Flash (Thinking)</span>'
            + '</div>'
            + '<div style="font-size:13px;color:#555;margin-bottom:12px;">' + overview + '</div>'
        )

        if crash_html:
            log_section += '<div style="margin-top:12px;"><h3 style="font-size:15px;color:#d32f2f;margin:0 0 8px 0;">💥 崩溃根因</h3>' + crash_html + '</div>'
        if anr_html:
            log_section += '<div style="margin-top:12px;"><h3 style="font-size:15px;color:#e65100;margin:0 0 8px 0;">⏳ ANR 根因</h3>' + anr_html + '</div>'
        if other_html:
            log_section += '<div style="margin-top:12px;"><h3 style="font-size:15px;color:#ff9800;margin:0 0 8px 0;">⚠ 其他异常</h3>' + other_html + '</div>'
        if rec_html:
            log_section += (
                '<div style="margin-top:16px;background:#e8f5e9;padding:12px;border-radius:6px;">'
                + '<div style="font-weight:bold;font-size:14px;color:#2e7d32;margin-bottom:4px;">💡 修复建议</div>'
                + rec_html + '</div>'
            )

        if not has_warnings and not rec_html:
            log_section += '<div style="color:#4caf50;font-size:14px;padding:16px 0;">✅ 日志分析完成，未发现明显异常</div>'

        log_section += '</div>'

    html = f'''<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>首页模板巡查报告 - {now}</title>
<style>
body {{ font-family: -apple-system, 'Microsoft YaHei', sans-serif; background: #f5f5f5; margin: 0; padding: 20px; }}
.container {{ max-width: 1400px; margin: auto; background: white; border-radius: 12px; padding: 24px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }}
h1 {{ color: #333; font-size: 24px; margin: 0 0 8px 0; }}
.subtitle {{ color: #888; font-size: 14px; margin-bottom: 20px; }}
.summary-bar {{ display: flex; gap: 20px; padding: 16px 20px; background: #f8f9fa; border-radius: 8px; margin-bottom: 20px; }}
.summary-item {{ text-align: center; flex: 1; }}
.summary-item .num {{ font-size: 28px; font-weight: bold; }}
.summary-item .label {{ font-size: 13px; color: #888; }}
.summary-item.normal .num {{ color: #4caf50; }}
.summary-item.warning .num {{ color: #ff9800; }}
.summary-item.abnormal .num {{ color: #d32f2f; }}
table {{ width: 100%; border-collapse: collapse; }}
th {{ background: #f5f5f5; padding: 10px 8px; text-align: left; font-size: 13px; color: #666; border-bottom: 2px solid #ddd; }}
td {{ vertical-align: top; }}
tr:hover {{ background: #fafafa; }}
img:hover {{ transform: scale(1.5); z-index: 10; position: relative; cursor: zoom-in; }}
.footer {{ margin-top: 20px; text-align: center; color: #aaa; font-size: 12px; }}
</style>
</head>
<body>
<div class="container">
    <h1>首页模板巡查报告</h1>
    <div class="subtitle">河南移动 IPTV | 测试时间: {now} | 耗时: {total_elapsed:.0f}秒</div>
    <div class="summary-bar">
        <div class="summary-item normal"><div class="num">{normal_count}</div><div class="label">正常</div></div>
        <div class="summary-item warning"><div class="num">{warning_count}</div><div class="label">警告</div></div>
        <div class="summary-item abnormal"><div class="num">{abnormal_count}</div><div class="label">异常</div></div>
        <div class="summary-item"><div class="num">{total}</div><div class="label">总计</div></div>
    </div>
    <table><thead><tr><th style="width:40px;">#</th><th style="width:120px;">频道</th><th style="width:40px;">状态</th><th>模板 / 异常</th><th>截图</th></tr></thead>
    <tbody>{all_rows}</tbody></table>
    {log_section}
    <div class="footer">截图已分类: normal/ abnormal/ | 系统自动生成</div>
</div>
</body>
</html>'''

    report_file = os.path.join(
        REPORT_DIR,
        f'report_{datetime.now().strftime("%Y%m%d_%H%M%S")}.html'
    )
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write(html)

    _log(f'报告已保存: {report_file}', 'DONE')
    return report_file
