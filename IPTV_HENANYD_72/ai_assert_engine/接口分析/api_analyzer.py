#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
API 分析模块 — 分析接口请求，识别接口功能，映射到 UI 元素
"""

import re
import json
from typing import Optional, List, Dict, Tuple
from collections import defaultdict

from lib.adb_utils import _log


class ApiAnalyzer:
    """分析捕获的接口请求，识别功能和映射 UI"""

    # 接口功能关键词映射
    API_FUNCTION_PATTERNS = {
        '详情信息': [r'detail', r'info', r'vod/info', r'vod/detail', r'program/detail', r'content/detail'],
        '推荐内容': [r'recommend', r'rec', r'related', r'similar', r'guess', r'like'],
        '剧集列表': [r'episode', r'playlist', r'chapter', r'season', r'part'],
        '播放地址': [r'play', r'stream', r'url', r'm3u8', r'mpd', r'video'],
        '评论互动': [r'comment', r'reply', r'discuss', r'review'],
        '用户信息': [r'user', r'profile', r'account', r'member'],
        '收藏操作': [r'favorite', r'collect', r'bookmark', r'like'],
        '搜索接口': [r'search', r'query', r'suggest', r'hot'],
        '导航配置': [r'nav', r'menu', r'tab', r'category', r'channel'],
        '模板配置': [r'template', r'layout', r'config', r'style'],
        'EPG数据': [r'epg', r'guide', r'schedule', r'program'],
        '初始化': [r'init', r'start', r'boot', r'launch'],
        '广告配置': [r'ad', r'banner', r'splash', r'promotion'],
        '内容列表': [r'list', r'feed', r'index', r'home'],
        '角标配置': [r'corner', r'badge', r'mark', r'tag'],
    }

    def __init__(self):
        self.api_list: List[Dict] = []
        self.ui_mapping: List[Dict] = []
        self.summary: Dict = {}

    def analyze(self, requests: List[Dict]) -> Dict:
        """分析接口请求列表"""
        if not requests:
            _log('无接口请求可分析', 'WARN')
            return self._empty_result()

        self.api_list = []
        for req in requests:
            analyzed = self._analyze_single(req)
            self.api_list.append(analyzed)

        # 按功能分组
        grouped = self._group_by_function()

        # 生成摘要
        self.summary = {
            'total_requests': len(self.api_list),
            'hosts': list(set(r.get('host', '') for r in self.api_list)),
            'functions': {k: len(v) for k, v in grouped.items()},
            'grouped_apis': grouped,
        }

        _log(f'分析完成: {len(self.api_list)} 个接口, {len(grouped)} 个功能分组', 'OK')
        return self.summary

    def _analyze_single(self, req: Dict) -> Dict:
        """分析单个接口请求"""
        url = req.get('url', '')
        path = req.get('path', '')
        query = req.get('query', '')

        # 识别功能
        function = self._identify_function(url)

        # 提取关键参数
        key_params = self._extract_key_params(req)

        # 判断是否为核心接口
        is_core = self._is_core_api(function, path)

        # 生成接口描述
        description = self._generate_description(function, path, key_params)

        return {
            'url': url,
            'method': req.get('method', 'GET'),
            'host': req.get('host', ''),
            'path': path,
            'query': query,
            'params': req.get('params', {}),
            'key_params': key_params,
            'function': function,
            'description': description,
            'is_core': is_core,
            'status': req.get('status', ''),
            'duration': req.get('duration', 0),
            'timestamp': req.get('timestamp', ''),
            'source_tag': req.get('source_tag', ''),
            'response_body': req.get('response_body', '')[:2000] if req.get('response_body') else '',
            'request_body': req.get('request_body', '')[:1000] if req.get('request_body') else '',
        }

    def _identify_function(self, url: str) -> str:
        """根据 URL 识别接口功能"""
        url_lower = url.lower()
        for func_name, patterns in self.API_FUNCTION_PATTERNS.items():
            for pattern in patterns:
                if re.search(pattern, url_lower):
                    return func_name
        return '其他'

    def _extract_key_params(self, req: Dict) -> Dict[str, str]:
        """提取关键业务参数"""
        params = req.get('params', {})
        key_params = {}

        # 常见关键参数名
        key_names = [
            'id', 'vodId', 'programId', 'contentId', 'channelId', 'categoryId',
            'episodeId', 'seasonId', 'userId', 'accountId',
            'title', 'name', 'keyword',
            'page', 'pageSize', 'pageNum', 'limit', 'offset',
            'version', 'ver', 'platform', 'device',
            'instanceId', 'templateId', 'menuId',
            'code', 'type', 'category',
        ]

        for name in key_names:
            if name in params:
                key_params[name] = params[name]
            # 尝试大小写变体
            for k in params:
                if k.lower() == name.lower():
                    key_params[k] = params[k]
                    break

        return key_params

    def _is_core_api(self, function: str, path: str) -> bool:
        """判断是否为核心接口"""
        core_functions = {'详情信息', '推荐内容', '剧集列表', '播放地址', 'EPG数据', '初始化'}
        return function in core_functions

    def _generate_description(self, function: str, path: str, key_params: Dict) -> str:
        """生成接口描述"""
        desc = function
        if key_params:
            param_str = ', '.join(f'{k}={v}' for k, v in list(key_params.items())[:3])
            desc += f' ({param_str})'
        return desc

    def _group_by_function(self) -> Dict[str, List[Dict]]:
        """按功能分组"""
        grouped = defaultdict(list)
        for api in self.api_list:
            func = api.get('function', '其他')
            grouped[func].append(api)
        return dict(grouped)

    def _empty_result(self) -> Dict:
        """空结果"""
        return {
            'total_requests': 0,
            'hosts': [],
            'functions': {},
            'grouped_apis': {},
        }

    def map_to_ui_elements(self, ui_elements: List[Dict] = None) -> List[Dict]:
        """将接口映射到 UI 元素

        ui_elements: UI 元素列表，每个元素包含 {name, text, position, screenshot_region}
        如果没有提供，使用默认的详情页 UI 元素映射
        """
        if not ui_elements:
            ui_elements = self._get_default_detail_ui_elements()

        mapping = []
        for ui in ui_elements:
            matched_api = self._find_matching_api(ui)
            mapping.append({
                'ui_element': ui,
                'matched_api': matched_api,
                'confidence': 'high' if matched_api else 'low',
            })

        self.ui_mapping = mapping
        _log(f'UI 映射完成: {len(mapping)} 个元素, {sum(1 for m in mapping if m["matched_api"])} 个匹配', 'OK')
        return mapping

    def _get_default_detail_ui_elements(self) -> List[Dict]:
        """获取默认的详情页 UI 元素列表"""
        return [
            {'name': '影片标题', 'keywords': ['title', 'name', 'vodName', 'programName'], 'region': 'top'},
            {'name': '影片描述', 'keywords': ['desc', 'description', 'intro', 'summary'], 'region': 'top'},
            {'name': '播放按钮', 'keywords': ['play', 'stream', 'url', 'm3u8'], 'region': 'center'},
            {'name': '剧集列表', 'keywords': ['episode', 'playlist', 'chapter', 'season'], 'region': 'center'},
            {'name': '推荐海报', 'keywords': ['recommend', 'rec', 'related', 'similar'], 'region': 'bottom'},
            {'name': '评分信息', 'keywords': ['score', 'rating', 'rank'], 'region': 'top'},
            {'name': '导演/演员', 'keywords': ['director', 'actor', 'cast', 'star'], 'region': 'top'},
            {'name': '分类标签', 'keywords': ['category', 'tag', 'type', 'genre'], 'region': 'top'},
            {'name': '收藏按钮', 'keywords': ['favorite', 'collect', 'bookmark'], 'region': 'center'},
            {'name': '分享按钮', 'keywords': ['share'], 'region': 'center'},
        ]

    def _find_matching_api(self, ui_element: Dict) -> Optional[Dict]:
        """为 UI 元素匹配最相关的接口"""
        keywords = ui_element.get('keywords', [])
        region = ui_element.get('region', '')

        best_match = None
        best_score = 0

        for api in self.api_list:
            score = 0
            url = api.get('url', '').lower()
            path = api.get('path', '').lower()
            function = api.get('function', '').lower()

            for kw in keywords:
                kw_lower = kw.lower()
                if kw_lower in url:
                    score += 3
                if kw_lower in path:
                    score += 5
                if kw_lower in function:
                    score += 2

            # 核心接口加分
            if api.get('is_core'):
                score += 1

            if score > best_score:
                best_score = score
                best_match = api

        return best_match if best_score > 0 else None

    def get_api_by_function(self, function: str) -> List[Dict]:
        """按功能名获取接口列表"""
        return [api for api in self.api_list if api.get('function') == function]

    def get_core_apis(self) -> List[Dict]:
        """获取核心接口列表"""
        return [api for api in self.api_list if api.get('is_core')]

    def get_statistics(self) -> Dict:
        """获取统计信息"""
        if not self.api_list:
            return {}

        hosts = defaultdict(int)
        functions = defaultdict(int)
        methods = defaultdict(int)

        for api in self.api_list:
            hosts[api.get('host', '')] += 1
            functions[api.get('function', '')] += 1
            methods[api.get('method', '')] += 1

        return {
            'total': len(self.api_list),
            'hosts': dict(hosts),
            'functions': dict(functions),
            'methods': dict(methods),
            'core_count': sum(1 for a in self.api_list if a.get('is_core')),
        }
