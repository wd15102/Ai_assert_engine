#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
报告生成模块 — 生成交互式 HTML 报告
支持展开/折叠、搜索过滤、接口与 UI 元素映射展示
"""

import os
import json
import html
from datetime import datetime
from typing import Optional, List, Dict

from lib.adb_utils import _log


# HTML 模板
HTML_TEMPLATE = """<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>影视详情页接口分析报告</title>
<style>
 Reset & Base 
*, *::before, *::after {{ box-sizing: border-box; margin: 0; padding: 0; }}
body {{ font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f7fa; color: #333; line-height: 1.6; }}

 Header 
.header {{ background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%); color: white; padding: 24px 32px; }}
.header h1 {{ font-size: 24px; font-weight: 600; margin-bottom: 4px; }}
.header .meta {{ font-size: 13px; opacity: 0.8; }}
.header .meta span {{ margin-right: 16px; }}

 Summary Cards 
.summary {{ display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; padding: 24px 32px; }}
.card {{ background: white; border-radius: 12px; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); text-align: center; }}
.card .number {{ font-size: 32px; font-weight: 700; color: #0f3460; }}
.card .label {{ font-size: 13px; color: #888; margin-top: 4px; }}

 Search & Filter 
.controls {{ padding: 0 32px 16px; display: flex; gap: 12px; flex-wrap: wrap; align-items: center; }}
.search-box {{ flex: 1; min-width: 280px; position: relative; }}
.search-box input {{ width: 100%; padding: 10px 16px 10px 40px; border: 1px solid #ddd; border-radius: 8px; font-size: 14px; outline: none; transition: border-color 0.2s; }}
.search-box input:focus {{ border-color: #0f3460; }}
.search-box .icon {{ position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #999; }}
.filter-group {{ display: flex; gap: 8px; flex-wrap: wrap; }}
.filter-btn {{ padding: 8px 16px; border: 1px solid #ddd; border-radius: 20px; background: white; cursor: pointer; font-size: 13px; transition: all 0.2s; }}
.filter-btn:hover {{ background: #f0f4f8; }}
.filter-btn.active {{ background: #0f3460; color: white; border-color: #0f3460; }}

 Collapsible Sections 
.section {{ margin: 0 32px 16px; background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden; }}
.section-header {{ padding: 16px 20px; cursor: pointer; display: flex; justify-content: space-between; align-items: center; user-select: none; transition: background 0.2s; }}
.section-header:hover {{ background: #f8fafc; }}
.section-header h2 {{ font-size: 16px; font-weight: 600; display: flex; align-items: center; gap: 8px; }}
.section-header .badge {{ background: #e8f0fe; color: #0f3460; padding: 2px 10px; border-radius: 12px; font-size: 12px; font-weight: 500; }}
.section-header .arrow {{ transition: transform 0.3s; }}
.section-header .arrow.open {{ transform: rotate(180deg); }}
.section-content {{ padding: 0 20px 20px; display: none; }}
.section-content.open {{ display: block; }}

 API Table 
.api-table {{ width: 100%; border-collapse: collapse; font-size: 13px; }}
.api-table th {{ text-align: left; padding: 10px 12px; background: #f8fafc; font-weight: 600; border-bottom: 2px solid #e2e8f0; position: sticky; top: 0; }}
.api-table td {{ padding: 10px 12px; border-bottom: 1px solid #f1f5f9; vertical-align: top; }}
.api-table tr:hover {{ background: #f8fafc; }}
.url-cell {{ max-width: 400px; word-break: break-all; }}
.url-cell a {{ color: #1a73e8; text-decoration: none; }}
.url-cell a:hover {{ text-decoration: underline; }}
.method-tag {{ display: inline-block; padding: 2px 8px; border-radius: 4px; font-size: 11px; font-weight: 600; }}
.method-GET {{ background: #e8f5e9; color: #2e7d32; }}
.method-POST {{ background: #e3f2fd; color: #1565c0; }}
.method-PUT {{ background: #fff3e0; color: #e65100; }}
.method-DELETE {{ background: #fce4ec; color: #c62828; }}
.function-tag {{ display: inline-block; padding: 2px 8px; border-radius: 4px; font-size: 11px; background: #f3e5f5; color: #6a1b9a; }}
.core-badge {{ display: inline-block; padding: 2px 6px; border-radius: 4px; font-size: 10px; background: #fff3e0; color: #e65100; margin-left: 4px; }}
.status-ok {{ color: #2e7d32; }}
.status-error {{ color: #c62828; }}
.duration {{ font-size: 12px; color: #888; }}

 Detail Panel 
.detail-panel {{ display: none; margin-top: 8px; padding: 12px; background: #f8fafc; border-radius: 8px; font-size: 12px; }}
.detail-panel.show {{ display: block; }}
.detail-panel h4 {{ font-size: 12px; font-weight: 600; margin: 8px 0 4px; color: #555; }}
.detail-panel pre {{ background: #fff; padding: 8px; border-radius: 4px; overflow-x: auto; font-size: 11px; max-height: 300px; overflow-y: auto; border: 1px solid #e2e8f0; }}
.detail-toggle {{ color: #1a73e8; cursor: pointer; font-size: 12px; }}
.detail-toggle:hover {{ text-decoration: underline; }}

 UI Mapping 
.ui-map {{ display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 12px; }}
.ui-item {{ border: 1px solid #e2e8f0; border-radius: 8px; padding: 12px; }}
.ui-item.matched {{ border-left: 4px solid #2e7d32; }}
.ui-item.unmatched {{ border-left: 4px solid #ccc; }}
.ui-item .ui-name {{ font-weight: 600; font-size: 14px; margin-bottom: 4px; }}
.ui-item .ui-region {{ font-size: 11px; color: #888; margin-bottom: 8px; }}
.ui-item .api-url {{ font-size: 11px; color: #1a73e8; word-break: break-all; }}
.ui-item .api-desc {{ font-size: 11px; color: #555; margin-top: 4px; }}

 Screenshot 
.screenshot-frame {{ border: 2px solid #e2e8f0; border-radius: 8px; overflow: hidden; margin: 16px 0; background: #1a1a2e; max-height: 500px; }}
.screenshot-frame img {{ width: 100%; display: block; }}

 Footer 
.footer {{ text-align: center; padding: 24px; font-size: 12px; color: #999; }}

 Responsive 
@media (max-width: 768px) {{
    .header, .summary, .controls, .section {{ padding-left: 16px; padding-right: 16px; }}
    .search-box {{ min-width: 200px; }}
    .api-table {{ font-size: 12px; }}
    .url-cell {{ max-width: 200px; }}
}}
</style>
</head>
<body>

<div class="header">
    <h1>影视详情页接口分析报告</h1>
    <div class="meta">
        <span>生成时间: {timestamp}</span>
        <span>设备: {device}</span>
        <span>捕获方式: {capture_method}</span>
        <span>总请求数: {total_requests}</span>
    </div>
</div>

<div class="summary">
    <div class="card">
        <div class="number">{total_apis}</div>
        <div class="label">接口总数</div>
    </div>
    <div class="card">
        <div class="number">{core_apis}</div>
        <div class="label">核心接口</div>
    </div>
    <div class="card">
        <div class="number">{host_count}</div>
        <div class="label">域名数量</div>
    </div>
    <div class="card">
        <div class="number">{function_count}</div>
        <div class="label">功能分类</div>
    </div>
    <div class="card">
        <div class="number">{ui_mapped}</div>
        <div class="label">UI 已映射</div>
    </div>
</div>

<div class="controls">
    <div class="search-box">
        <span class="icon">&#128269;</span>
        <input type="text" id="searchInput" placeholder="搜索 URL、参数、功能名..." oninput="filterAPIs()">
    </div>
    <div class="filter-group">
        <button class="filter-btn active" data-filter="all" onclick="setFilter('all', this)">全部</button>
        <button class="filter-btn" data-filter="core" onclick="setFilter('core', this)">仅核心</button>
        {filter_buttons}
    </div>
</div>

<!-- 接口列表 -->
<div class="section">
    <div class="section-header" onclick="toggleSection(this)">
        <h2>接口列表 <span class="badge" id="apiCount">{total_apis}</span></h2>
        <span class="arrow">&#9660;</span>
    </div>
    <div class="section-content open">
        <table class="api-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>功能</th>
                    <th>方法</th>
                    <th>URL</th>
                    <th>关键参数</th>
                    <th>状态</th>
                    <th>耗时</th>
                    <th>详情</th>
                </tr>
            </thead>
            <tbody id="apiTableBody">
                {api_rows}
            </tbody>
        </table>
    </div>
</div>

<!-- UI 映射 -->
<div class="section">
    <div class="section-header" onclick="toggleSection(this)">
        <h2>接口 → UI 元素映射 <span class="badge">{ui_mapped}/{ui_total}</span></h2>
        <span class="arrow">&#9660;</span>
    </div>
    <div class="section-content open">
        <div class="ui-map">
            {ui_mapping_cards}
        </div>
    </div>
</div>

<!-- 功能分组 -->
<div class="section">
    <div class="section-header" onclick="toggleSection(this)">
        <h2>功能分组 <span class="badge">{function_count}</span></h2>
        <span class="arrow">&#9660;</span>
    </div>
    <div class="section-content open">
        {function_groups}
    </div>
</div>

<!-- 详情页截图 -->
{screenshot_section}

<div class="footer">
    由 AI 自动化测试引擎生成 | 接口分析工具 v1.0
</div>

<script>
let currentFilter = 'all';
let searchQuery = '';

function toggleSection(header) {{
    const content = header.nextElementSibling;
    const arrow = header.querySelector('.arrow');
    content.classList.toggle('open');
    arrow.classList.toggle('open');
}}

function filterAPIs() {{
    searchQuery = document.getElementById('searchInput').value.toLowerCase();
    applyFilters();
}}

function setFilter(filter, btn) {{
    currentFilter = filter;
    document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    applyFilters();
}}

function applyFilters() {{
    const rows = document.querySelectorAll('#apiTableBody tr');
    let count = 0;
    rows.forEach(row => {{
        const url = row.dataset.url || '';
        const func = row.dataset.function || '';
        const isCore = row.dataset.core === 'true';
        const text = (url + ' ' + func + ' ' + (row.textContent || '')).toLowerCase();
        
        let show = true;
        if (searchQuery && !text.includes(searchQuery)) show = false;
        if (currentFilter === 'core' && !isCore) show = false;
        
        row.style.display = show ? '' : 'none';
        if (show) count++;
    }});
    document.getElementById('apiCount').textContent = count;
}}

function toggleDetail(id) {{
    const el = document.getElementById('detail-' + id);
    el.classList.toggle('show');
}}

function toggleAllDetails() {{
    const panels = document.querySelectorAll('.detail-panel');
    const anyOpen = [...panels].some(p => p.classList.contains('show'));
    panels.forEach(p => p.classList.toggle('show', !anyOpen));
}}

// 展开所有 section
document.querySelectorAll('.section-content').forEach(c => c.classList.add('open'));
document.querySelectorAll('.arrow').forEach(a => a.classList.add('open'));
</script>

</body>
</html>
"""


class ReportGenerator:
    """生成交互式 HTML 报告"""

    def __init__(self, output_dir: str = None):
        self.output_dir = output_dir or os.path.join(
            os.path.dirname(__file__), '..', '测试报告', 'reports'
        )
        os.makedirs(self.output_dir, exist_ok=True)

    def generate(self, analyzer, capture_method: str = 'logcat',
                 device: str = '', screenshot_path: Optional[str] = None,
                 output_name: Optional[str] = None) -> str:
        """生成报告

        analyzer: ApiAnalyzer 实例，包含分析结果
        capture_method: 捕获方式 ('charles' 或 'logcat')
        device: 设备信息
        screenshot_path: 截图文件路径
        output_name: 输出文件名（不含扩展名）
        返回生成的文件路径
        """
        api_list = analyzer.api_list
        summary = analyzer.summary
        ui_mapping = analyzer.ui_mapping

        # 生成 API 表格行
        api_rows = self._build_api_rows(api_list)

        # 生成 UI 映射卡片
        ui_cards = self._build_ui_cards(ui_mapping)

        # 生成功能分组内容
        func_groups = self._build_function_groups(summary.get('grouped_apis', {}))

        # 生成筛选按钮
        filter_btn_list = self._build_filter_buttons(summary.get('grouped_apis', {}))

        # 截图部分
        screenshot_html = self._build_screenshot_section(screenshot_path)

        # 填充模板
        html_content = HTML_TEMPLATE.format(
            timestamp=datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            device=device or '未指定',
            capture_method='Charles 代理' if capture_method == 'charles' else 'ADB Logcat',
            total_requests=summary.get('total_requests', 0),
            total_apis=len(api_list),
            core_apis=sum(1 for a in api_list if a.get('is_core')),
            host_count=len(summary.get('hosts', [])),
            function_count=len(summary.get('functions', {})),
            ui_mapped=sum(1 for m in ui_mapping if m.get('matched_api')),
            ui_total=len(ui_mapping),
            filter_buttons=filter_btn_list,
            api_rows=api_rows,
            ui_mapping_cards=ui_cards,
            function_groups=func_groups,
            screenshot_section=screenshot_html,
        )

        # 保存文件
        if not output_name:
            output_name = f'detail_api_report_{datetime.now().strftime("%Y%m%d_%H%M%S")}'
        output_path = os.path.join(self.output_dir, f'{output_name}.html')

        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(html_content)

        _log(f'报告已生成: {output_path}', 'OK')
        return output_path

    def _build_api_rows(self, api_list: List[Dict]) -> str:
        """构建 API 表格行"""
        rows = []
        for i, api in enumerate(api_list, 1):
            url = api.get('url', '')
            method = api.get('method', 'GET')
            host = api.get('host', '')
            path = api.get('path', '')
            function = api.get('function', '其他')
            is_core = api.get('is_core', False)
            status = api.get('status', '')
            duration = api.get('duration', 0)
            key_params = api.get('key_params', {})

            # 参数摘要
            param_summary = ', '.join(f'{k}={v}' for k, v in list(key_params.items())[:4])
            if len(key_params) > 4:
                param_summary += f' (+{len(key_params) - 4})'

            # 状态样式
            status_class = 'status-ok' if str(status).startswith('2') else 'status-error' if status else ''

            # 详情面板
            detail_html = self._build_detail_html(i, api)

            rows.append(f"""
<tr data-url="{html.escape(url).lower()}" data-function="{html.escape(function).lower()}" data-core="{'true' if is_core else 'false'}">
    <td>{i}</td>
    <td><span class="function-tag">{html.escape(function)}</span>{'<span class="core-badge">核心</span>' if is_core else ''}</td>
    <td><span class="method-tag method-{method}">{method}</span></td>
    <td class="url-cell"><a href="{html.escape(url)}" target="_blank" title="{html.escape(url)}">{html.escape(path or url[:80])}</a></td>
    <td>{html.escape(param_summary)}</td>
    <td><span class="{status_class}">{status}</span></td>
    <td class="duration">{duration}ms</td>
    <td><span class="detail-toggle" onclick="toggleDetail({i})">展开</span></td>
</tr>
<tr>
    <td colspan="8">
        <div class="detail-panel" id="detail-{i}">
            {detail_html}
        </div>
    </td>
</tr>""")
        return '\n'.join(rows) if rows else '<tr><td colspan="8" style="text-align:center;color:#999;padding:24px;">无数据</td></tr>'

    def _build_detail_html(self, index: int, api: Dict) -> str:
        """构建详情面板 HTML"""
        url = api.get('url', '')
        host = api.get('host', '')
        query = api.get('query', '')
        key_params = api.get('key_params', {})
        request_body = api.get('request_body', '')
        response_body = api.get('response_body', '')
        timestamp = api.get('timestamp', '')
        source_tag = api.get('source_tag', '')

        html_parts = []
        html_parts.append(f'<div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">')
        html_parts.append(f'<div><h4>完整 URL</h4><pre>{html.escape(url)}</pre></div>')
        html_parts.append(f'<div><h4>域名</h4><pre>{html.escape(host)}</pre></div>')
        html_parts.append(f'</div>')

        if key_params:
            params_json = json.dumps(key_params, ensure_ascii=False, indent=2)
            html_parts.append(f'<h4>关键参数</h4><pre>{html.escape(params_json)}</pre>')

        if request_body:
            html_parts.append(f'<h4>请求体</h4><pre>{html.escape(request_body[:2000])}</pre>')

        if response_body:
            # 尝试格式化 JSON
            try:
                resp_json = json.loads(response_body)
                resp_formatted = json.dumps(resp_json, ensure_ascii=False, indent=2)
                html_parts.append(f'<h4>响应体 (JSON)</h4><pre>{html.escape(resp_formatted[:3000])}</pre>')
            except (json.JSONDecodeError, ValueError):
                html_parts.append(f'<h4>响应体</h4><pre>{html.escape(response_body[:3000])}</pre>')

        if source_tag:
            html_parts.append(f'<h4>来源 TAG</h4><pre>{html.escape(source_tag)} @ {html.escape(timestamp)}</pre>')

        return '\n'.join(html_parts)

    def _build_ui_cards(self, ui_mapping: List[Dict]) -> str:
        """构建 UI 映射卡片"""
        cards = []
        for item in ui_mapping:
            ui = item.get('ui_element', {})
            api = item.get('matched_api')
            confidence = item.get('confidence', 'low')

            matched_class = 'matched' if api else 'unmatched'
            ui_name = ui.get('name', '未知')
            ui_region = ui.get('region', '')

            api_url = ''
            api_desc = '未匹配到接口'
            if api:
                api_url = api.get('url', '')
                api_desc = api.get('description', '')

            cards.append(f"""
<div class="ui-item {matched_class}">
    <div class="ui-name">{html.escape(ui_name)}</div>
    <div class="ui-region">区域: {html.escape(ui_region)}</div>
    <div class="api-url">{html.escape(api_url[:100]) if api_url else api_desc}</div>
    <div class="api-desc">{html.escape(api_desc)}</div>
</div>""")
        return '\n'.join(cards) if cards else '<p style="color:#999;text-align:center;padding:24px;">无 UI 映射数据</p>'

    def _build_function_groups(self, grouped_apis: Dict) -> str:
        """构建功能分组内容"""
        if not grouped_apis:
            return '<p style="color:#999;text-align:center;padding:24px;">无分组数据</p>'

        parts = []
        for func_name, apis in grouped_apis.items():
            api_items = []
            for api in apis:
                url = api.get('url', '')
                method = api.get('method', 'GET')
                status = api.get('status', '')
                api_items.append(f'<li>{method} {html.escape(url[:120])} <small style="color:#888">({status})</small></li>')

            api_items_str = '\n'.join(api_items)
            parts.append(f"""
<div style="margin-bottom:16px;">
    <h3 style="font-size:14px;margin-bottom:8px;">{html.escape(func_name)} <small style="color:#888">({len(apis)}个)</small></h3>
    <ul style="padding-left:20px;font-size:13px;line-height:1.8;">
        {api_items_str}
    </ul>
</div>""")
        return '\n'.join(parts)

    def _build_filter_buttons(self, grouped_apis: Dict) -> str:
        """构建功能筛选按钮"""
        buttons = []
        for func_name in list(grouped_apis.keys())[:10]:
            buttons.append(f'<button class="filter-btn" data-filter="{html.escape(func_name)}" onclick="setFilter(\'{html.escape(func_name)}\', this)">{html.escape(func_name)}</button>')
        return '\n'.join(buttons)

    def _build_screenshot_section(self, screenshot_path: Optional[str]) -> str:
        """构建截图展示部分"""
        if not screenshot_path or not os.path.exists(screenshot_path):
            return ''

        # 将报告同目录下的截图复制到输出目录
        rel_path = os.path.basename(screenshot_path)
        dest_path = os.path.join(self.output_dir, rel_path)
        try:
            import shutil
            shutil.copy2(screenshot_path, dest_path)
        except Exception:
            pass

        return f"""
<div class="section">
    <div class="section-header" onclick="toggleSection(this)">
        <h2>详情页截图</h2>
        <span class="arrow">&#9660;</span>
    </div>
    <div class="section-content open">
        <div class="screenshot-frame">
            <img src="{rel_path}" alt="详情页截图">
        </div>
    </div>
</div>"""
