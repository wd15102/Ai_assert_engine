#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
AI 视觉问答服务 — 统一入口，全局可调用


核心能力：
  ai.vqa("当前焦点在首屏4横图通栏模板的第一个海报上吗？")  → True/False
  ai.ask("描述当前屏幕上可见的所有模板和卡片布局")         → str
  ai.vqa_object("列出所有可见模板", response_format=...)    → BaseModel
  ai.vqa_batch(["问题1", "问题2"])                          → [bool, bool]

特点：
  - 每次调用自动截取当前设备屏幕（不需要传图片参数）
  - 布尔值检测通过预定义的中/英文真假值列表
  - 模块级单例: from ai_service import ai 即可使用
"""

import os
import sys
import json
import base64
import io
import re
import time
import requests
import urllib3
from typing import Optional, Union, List, Type, Dict, Any
from PIL import Image


# ── 路径──  项目根目录（config.py 所在位置）
_PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if _PROJECT_DIR not in sys.path:
    sys.path.insert(0, _PROJECT_DIR)

from engine_config.config import MODELS, DEFAULT_MODEL
from engine.template_prompt_builder import _load_checkpoints

# ── HTTP连接池（复用连接，避免每次TLS握手） ──
_http_pool = None

def _get_http_pool():
    """获取或创建HTTP连接池（Keep-Alive复用）"""
    global _http_pool
    if _http_pool is None:
        try:
            import urllib3
            _http_pool = urllib3.PoolManager(
                maxsize=4,
                retries=urllib3.Retry(0),
            )
        except ImportError:
            return None
    return _http_pool

# ── 日志 ──
try:
    from lib.logger import log
except ImportError:
    def log(msg, level='INFO'):
        print(f"[{level}] {msg}")


# ══════════════════════════════════════════════════════════════
# 设备接口 — 自动截屏
# ══════════════════════════════════════════════════════════════

def _auto_screenshot() -> Optional[str]:
    """自动截取当前设备屏幕，返回本地文件路径"""
    try:
        from lib import adb_utils
        ts = time.strftime('%Y%m%d_%H%M%S')
        filename = f'vqa_auto_{ts}.png'
        path = adb_utils.screenshot(filename)
        if path and os.path.exists(path):
            return path
    except Exception as e:
        log(f'自动截图失败: {e}', 'WARN')

    # 兜底：直接用 adb
    try:
        from engine_config import SCREENSHOT_DIR, ADB_DEVICE
        import subprocess
        ts = time.strftime('%Y%m%d_%H%M%S')
        filename = f'vqa_auto_{ts}.png'
        remote = f'/sdcard/{filename}'
        local = os.path.join(SCREENSHOT_DIR, filename)
        subprocess.run(
            ['adb', '-s', ADB_DEVICE, 'shell', 'screencap', '-p', remote],
            capture_output=True, timeout=10,
        )
        subprocess.run(
            ['adb', '-s', ADB_DEVICE, 'pull', remote, local],
            capture_output=True, timeout=10,
        )
        subprocess.run(
            ['adb', '-s', ADB_DEVICE, 'shell', 'rm', remote],
            capture_output=True, timeout=5,
        )
        if os.path.exists(local) and os.path.getsize(local) > 0:
            return local
    except Exception as e:
        log(f'ADB截图兜底也失败: {e}', 'ERROR')

    return None


def _image_to_base64(img_path: str, max_side: int = 640, quality: int = 60) -> Optional[str]:
    """
    图片文件转 base64 data URL。
    大幅减小分辨率以减少 API 传输时间：默认 640px + JPEG质量60。
    """
    try:
        img = Image.open(img_path)
        # 如果图片模式不是RGB，转RGB（避免PNG RGBA模式）
        if img.mode in ('RGBA', 'P', 'LA'):
            img = img.convert('RGB')
        w, h = img.size
        if max(w, h) > max_side:
            ratio = max_side / max(w, h)
            img = img.resize((int(w * ratio), int(h * ratio)), Image.LANCZOS)
        buf = io.BytesIO()
        img.save(buf, format='JPEG', quality=quality, optimize=True)
        b64 = base64.b64encode(buf.getvalue()).decode('ascii')
        return f'data:image/jpeg;base64,{b64}'
    except Exception as e:
        log(f'图片编码失败: {e}', 'ERROR')
        return None


# ══════════════════════════════════════════════════════════════
# API 调用
# ══════════════════════════════════════════════════════════════

def _resolve_model(model_name: Optional[str] = None) -> dict:
    """按模型名称获取配置，未指定则用 DEFAULT_MODEL。"""
    name = model_name or DEFAULT_MODEL
    cfg = MODELS.get(name)
    if not cfg:
        raise ValueError(f'未知模型: {name}，可用: {list(MODELS.keys())}')
    if not cfg.get('api_key'):
        raise ValueError(f'模型 "{name}" 未配置 api_key，请在 config.py 的 MODELS 中设置')
    return {**cfg, 'name': name}


def _check_vision_support(model_name: Optional[str], has_image: bool = False) -> Optional[str]:
    """检查模型是否支持视觉；不支持则返回替代模型名（默认 glm-4v-flash）。"""
    name = model_name or DEFAULT_MODEL
    cfg = MODELS.get(name, {})
    if has_image and not cfg.get('supports_vision', False):
        fallback = 'glm-4v-flash'
        log(f'[AI] {name} 不支持图片输入，自动切换到 {fallback}', 'WARN')
        return fallback
    return None


def _call_model_api(payload: dict, model_name: Optional[str] = None,
                    max_retries: int = 2, timeout: int = 60,
                    debug: bool = False) -> Optional[dict]:
    """
    调用任意模型 API，带重试，返回 {content, raw, elapsed_ms, model}
    根据 model_name 从 MODELS 注册表自动选择后端。
    若 payload 含图片但模型不支持视觉，自动 fallback 到 glm-4v-flash。
    """
    # ── 图片支持检测 → 自动 fallback ──
    has_image = any(
        c.get('type') == 'image_url'
        for m in payload.get('messages', [])
        if isinstance(m.get('content'), list)
        for c in m['content']
    )
    if has_image:
        fallback = _check_vision_support(model_name, has_image=True)
        if fallback:
            model_name = fallback

    cfg = _resolve_model(model_name)
    url = cfg['api_url']
    key = cfg['api_key']
    model_name = cfg['name']

    # 填充 payload 中的 model 字段（请求体内也需要）
    body_payload = dict(payload)
    body_payload['model'] = body_payload.get('model', model_name)

    pool = _get_http_pool()
    body = json.dumps(body_payload).encode('utf-8')
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Bearer {key}',
        'Connection': 'keep-alive',
    }

    for attempt in range(max_retries + 1):
        try:
            t0 = time.time()
            if pool:
                resp = pool.request('POST', url, body=body, headers=headers, timeout=timeout)
                text = resp.data.decode('utf-8')
                if resp.status != 200:
                    raise Exception(f'HTTP {resp.status}: {text[:200]}')
            else:
                import urllib.request
                req = urllib.request.Request(url, data=body, headers=headers, method='POST')
                resp = urllib.request.urlopen(req, timeout=timeout)
                text = resp.read().decode('utf-8')

            elapsed = (time.time() - t0) * 1000
            data = json.loads(text)
            msg = data['choices'][0]['message']
            # 兼容不同模型响应格式：GLM 用 content，LongCat 用 reasoning_content
            content = msg.get('content') or msg.get('reasoning_content', '')
            model_resp = data.get('model', model_name)
            if debug:
                log(f'[DEBUG] model={model_resp} content_len={len(content)} content_start={content[:150]!r}')
            return {'content': content, 'raw': data, 'elapsed_ms': elapsed, 'model': model_resp}

        except Exception as e:
            if attempt < max_retries:
                log(f'API retry {attempt+1}/{max_retries} [{model_name}]: {e}', 'WARN')
                time.sleep(2 ** attempt)
            else:

                log(f'API failed [{model_name}]: {e}', 'ERROR')
                return None


def _build_vision_payload(prompt: str, img_b64: str, temperature: float = 0.1,
                          max_tokens: int = 300, model_name: Optional[str] = None) -> dict:
    cfg = _resolve_model(model_name)
    return {
        'model': cfg['name'],
        'messages': [{
            'role': 'user',
            'content': [
                {'type': 'text', 'text': prompt},
                {'type': 'image_url', 'image_url': {'url': img_b64}},
            ],
        }],
        'temperature': temperature,
        'max_tokens': max_tokens,
    }


# ══════════════════════════════════════════════════════════════
# 布尔答案解析
# ══════════════════════════════════════════════════════════════

# 参考 ccontrol_ai_service 的真假值列表
_LABEL_TRUE = [
    "true", "yes", "是", "是的", "对", "正确", "真", "真的",
    "有", "存在", "看到", "看得到", "能看到", "可以看到",
    "显示", "显示了", "出现", "出现了",
    "可以", "能", "可以的", "是的，",
]
_LABEL_FALSE = [
    "false", "no", "否", "不是", "不对", "错误", "假", "假的",
    "无", "没有", "不存在", "看不到", "没看到", "看不见",
    "未显示", "没显示", "没出现", "不可见", "未出现",
    "不能", "不可以",
]

# JSON 结果提取 pattern
_JSON_RESULT_PATTERN = re.compile(
    r'\{[^{}]*"result"\s*:\s*(true|false)[^{}]*\}',
    re.IGNORECASE,
)


def _parse_bool_answer(content: str) -> bool:
    """
    解析 AI 返回的布尔答案。
    优先级：JSON {"result": true/false} > 文本真假值匹配
    """
    # 1) 尝试解析 JSON
    m = _JSON_RESULT_PATTERN.search(content)
    if m:
        return m.group(1).lower() == 'true'

    normalized = content.lower().strip()

    # 2) 假值先匹配（防止假值包含真值词）
    for label in _LABEL_FALSE:
        if label.lower() in normalized:
            return False

    # 3) 真值匹配
    for label in _LABEL_TRUE:
        if label.lower() in normalized:
            return True

    # 4) 兜底：检查开头
    first_word = normalized.split()[0].rstrip('.,;!?。，；！？')
    if first_word in ('true', 'yes', '是', '是的', '对', 'true.'):
        return True
    if first_word in ('false', 'no', '否', '不是', 'false.'):
        return False

    # 5) 实在无法判断 → 抛异常（和 ccontrol 行为一致）
    raise ValueError(f'无法从AI响应中解析布尔值: {content[:200]}')


# ══════════════════════════════════════════════════════════════
# VQA Prompt 提示词模板
# ══════════════════════════════════════════════════════════════

_VQA_SYSTEM_PROMPT = (
    "你是一个电视大屏（Android TV）UI 测试工程师。已知在大屏电视上，当某个模板的坑位/海报被焦点选中时坑位的周围有明显白色实线 或者被选中的坑位被放大一点  \n"
    "注意 如果焦点是在频道导航栏上 那么被选中的频道会有明显的蓝色背景，并且当焦点在导航栏(标签栏)时 焦点框不会出现在其他坑位上 \n"
    "请根据提供的电视屏幕截图，判断用户给出的断言是否成立。\n"
    "只回答「是」或「不是」，不要解释。"
)

_VQA_OPEN_SYSTEM_PROMPT = (
    "你是一个电视大屏（Android TV）UI 测试工程师。 已知在大屏电视上，当某个模板的坑位/海报被焦点选中时坑位的周围有明显白色实线 或者被选中的坑位被放大一点 。\n"
    "注意 如果焦点是在频道导航栏上 那么被选中的频道会有明显的浅蓝色背景，并且当焦点在导航栏(标签栏)时 焦点框不会出现在其他坑位上 \n"
    "请根据提供的电视屏幕截图，回答用户的问题。"
    "描述电视界面的内容、布局、状态等。"
)


def _build_vqa_prompt(question: str, system_prompt: Optional[str] = None) -> str:
    """构建 VQA 问题 prompt"""
    sp = system_prompt or _VQA_SYSTEM_PROMPT
    return f"{sp}\n\n断言：{question}\n\n请回答「是」或「不是」。"


def _parse_json_array(content: str) -> List[Dict[str, Any]]:
    """从 AI 返回文本中提取 JSON 数组或多行 JSON 对象（支持截断修复）"""
    # 去除 markdown 代码块
    content = re.sub(r'^```(?:json)?\s*', '', content.strip())
    content = re.sub(r'\s*```$', '', content.strip())

    # 尝试直接解析整个响应为 JSON 数组
    try:
        arr = json.loads(content)
        if isinstance(arr, list):
            return arr
        if isinstance(arr, dict):
            return [arr]
    except json.JSONDecodeError:
        pass

    # 提取第一个 JSON 数组 [...]
    m = re.search(r'\[(.+)\]', content, re.DOTALL)
    if m:
        try:
            arr = json.loads('[' + m.group(1) + ']')
            if isinstance(arr, list):
                return arr
        except json.JSONDecodeError:
            pass

    # ── 逐行解析 {"...} 格式 ──
    # 支持两种：传统 JSON 数组项 或 独立 JSON 对象行
    items: List[Dict[str, Any]] = []
    for line in content.split('\n'):
        line = line.strip().rstrip(',')
        if not line.startswith('{') or not line.endswith('}'):
            continue
        try:
            obj = json.loads(line)
            if isinstance(obj, dict):
                items.append(obj)
        except json.JSONDecodeError:
            continue

    if items:
        if len(items) < content.count('{'):
            log(f'[JSON] 截断修复：解析出 {len(items)}/{content.count("{")} 项', 'WARN')
        return items

    log(f'无法解析 JSON 数组: {content[:200]}', 'WARN')
    return []


def _calculate_similarity(img_a: Image.Image, img_b: Image.Image) -> float:
    """计算两张图片的相似度（pHash + SSIM 综合）"""
    import tempfile

    # 统一尺寸为 256x256 加速计算
    size = (256, 256)
    a = img_a.convert('RGB').resize(size, Image.LANCZOS)
    b = img_b.convert('RGB').resize(size, Image.LANCZOS)

    # ── 感知哈希 (pHash) ──
    phash_score = _phash_similarity(a, b)

    # ── 结构相似度 (SSIM) 简化版 ──
    ssim_score = _ssim_simple(a, b)

    # 综合评分（pHash 权重 0.4，SSIM 权重 0.6）
    combined = phash_score * 0.4 + ssim_score * 0.6
    return min(max(combined, 0.0), 1.0)


def _phash_similarity(img_a: Image.Image, img_b: Image.Image) -> float:
    """感知哈希相似度：差异越小越相似"""
    import numpy as np
    # 转灰度 → 缩小到 8x8 → DCT → 取左上 8x8 → 比较
    a_gray = img_a.convert('L').resize((32, 32), Image.LANCZOS)
    b_gray = img_b.convert('L').resize((32, 32), Image.LANCZOS)

    a_arr = np.array(a_gray, dtype=np.float64)
    b_arr = np.array(b_gray, dtype=np.float64)

    # 简化版：直接比较 8x8 块的均值哈希
    small_a = np.array(img_a.convert('L').resize((16, 16), Image.LANCZOS), dtype=np.float64)
    small_b = np.array(img_b.convert('L').resize((16, 16), Image.LANCZOS), dtype=np.float64)

    mean_a = small_a.mean()
    mean_b = small_b.mean()

    hash_a = (small_a > mean_a).flatten()
    hash_b = (small_b > mean_b).flatten()

    diff = np.sum(hash_a != hash_b)
    return 1.0 - (diff / len(hash_a))


def _ssim_simple(img_a: Image.Image, img_b: Image.Image) -> float:
    """简化 SSIM：基于像素均值、方差、协方差"""
    import numpy as np
    a_arr = np.array(img_a.convert('L'), dtype=np.float64)
    b_arr = np.array(img_b.convert('L'), dtype=np.float64)

    mu_a = a_arr.mean()
    mu_b = b_arr.mean()
    sigma_a = a_arr.var()
    sigma_b = b_arr.var()
    sigma_ab = np.mean((a_arr - mu_a) * (b_arr - mu_b))

    C1 = (0.01 * 255) ** 2
    C2 = (0.03 * 255) ** 2

    num = (2 * mu_a * mu_b + C1) * (2 * sigma_ab + C2)
    den = (mu_a ** 2 + mu_b ** 2 + C1) * (sigma_a + sigma_b + C2)

    return num / den if den > 0 else 0.0


def _modify_payload_for_thinking(payload: dict, model_name: Optional[str] = None) -> dict:
    """如果模型配置支持 Thinking 模式，追加 thinking 参数。"""
    cfg = _resolve_model(model_name)
    # 只有 agnes 系列支持 thinking
    if 'agnes' in cfg.get('name', '').lower():
        out = dict(payload)
        out['thinking'] = {'type': 'enabled', 'budget_tokens': 4096}
        return out
    return payload


# ══════════════════════════════════════════════════════════════
# AIService — 核心类
# ══════════════════════════════════════════════════════════════

def _baidu_ocr_general(img_b64):
    """Baidu OCR general endpoint - returns words with location coordinates."""
    urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
    token_url = (
        'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials'
        '&client_id=Pwc99vIN6GLCzybdSzQyilpp'
        '&client_secret=SDFC5WHZodKYo7jP51UG7w1v2QFQW66b'
    )
    try:
        req = requests.get(token_url, headers={'Content-Type': 'application/json; charset=UTF-8'}, verify=False, timeout=10)
        rec = json.loads(req.text)
        access_token = rec.get('access_token')
        if not access_token:
            log(f'[BAIDU_OCR] token failed: {rec}', 'WARN')
            return None
    except Exception as e:
        log(f'[BAIDU_OCR] token exception: {e}', 'WARN')
        return None
    try:
        general_url = 'https://aip.baidubce.com/rest/2.0/ocr/v1/general'
        data = {'image': img_b64, 'access_token': access_token}
        req = requests.post(general_url, data=data, headers={'Content-Type': 'application/x-www-form-urlencoded'}, verify=False, timeout=20)
        result = json.loads(req.text)
        if 'error_code' in result:
            log(f'[BAIDU_OCR] API error: {result}', 'WARN')
            return None
        return result.get('words_result', [])
    except Exception as e:
        log(f'[BAIDU_OCR] recognize exception: {e}', 'WARN')
        return None



class AIService:
    """AI 视觉问答服务（单例模式）"""

    _instance: Optional['AIService'] = None

    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance._initialized = False
        return cls._instance

    def __init__(self, adb_device: Optional[str] = None):
        if self._initialized:
            return
        self._adb_device = adb_device
        self._initialized = True

    # ── 主接口 ──────────────────────────────────────────────

    def screenshot(self, image: Optional[str] = None) -> str:
        """获取截图：传入指定路径则返回，否则自动截取"""
        if image:
            return image
        return _auto_screenshot()

    def vqa(self, question: str, *,
            image: Optional[str] = None,
            system_prompt: Optional[str] = None,
            timeout: int = 60,
            model: Optional[str] = None,
            mark_focus: bool = False,
            debug: bool = True) -> bool:
        """
        视觉问答（布尔型）：自动截图 → 发给视觉模型 → 返回 True/False

        参数：
          question: 断言问题，如 "当前焦点在首屏4横图通栏模板的第一个海报上吗？"
          image: 可选指定截图路径；不传则自动截取
          system_prompt: 自定义系统提示词
          timeout: API 超时秒数
          mark_focus (bool): 是否在发送给 AI 的图片上标记焦点框（绿色）。默认 False。

        返回：
          bool — True 表示断言成立，False 表示不成立

        示例：
          ai = AIService()
          if ai.vqa("当前焦点在首屏4横图通栏模板的第一个海报上吗？"):
              print("焦点已到位")
          # 带焦点标记
          if ai.vqa("当前焦点在首屏4横图通栏模板上吗？", mark_focus=True):
              print("焦点已到位")
        """
        # 获取截图
        img_path = image or self.screenshot()
        if not img_path:
            raise RuntimeError("VQA 失败：无法获取截图")

        # ── 标记焦点框（可选） ──
        if mark_focus:
            try:
                from lib.focus_checker import get_focus_info
                from lib.focus_detector import draw_focus_mark, _parse_bounds
                info = get_focus_info()
                if info.get('has_focus') and info.get('bounds'):
                    focus_rect = _parse_bounds(info['bounds'])
                    if focus_rect:
                        marked = draw_focus_mark(
                            img_path, focus_rect,
                            out_dir=os.path.dirname(img_path),
                        )
                        if marked:
                            img_path = marked
                            log(f'[FOCUS] 焦点标记图: {img_path}', 'FILE')
            except Exception as e:
                log(f'mark_focus 标记焦点框失败: {e}', 'WARN')

        img_b64 = _image_to_base64(img_path)
        if not img_b64:
            raise RuntimeError("VQA 失败：图片编码失败")

        # 构建 prompt
        prompt = _build_vqa_prompt(question, system_prompt)
        log(f'[VQA] 问题: {question}', 'AI')
        log(f'[VQA] 发送图片: {img_path}', 'FILE')
        payload = _build_vision_payload(prompt, img_b64, temperature=0.1, max_tokens=50, model_name=model)

        # 调用 API
        # 检查图片支持 → 自动 fallback
        fallback = _check_vision_support(model, has_image=True)
        if fallback:
            model = fallback
        result = _call_model_api(payload, model_name=model, timeout=timeout, debug=debug)
        if not result:
            raise RuntimeError("VQA 失败：API 调用失败")
        content = result['content']
        elapsed = result['elapsed_ms']
        _m = result.get('model', model or DEFAULT_MODEL)
        log(f'[VQA] {elapsed:.0f}ms [{_m}] → {content[:200]}', 'AI')
        if debug:
            log(f'[VQA] 完整内容: {content}', 'AI')

        return _parse_bool_answer(content)

    def ask(self, question: str, *,
            image: Optional[str] = None,
            system_prompt: Optional[str] = None,
            temperature: float = 0.2,
            template_name: str = "",
            check_index: int = 0,
            total_checks: int = 0,
            max_tokens: int = 1024,
            timeout: int = 60,
            verbose: bool = True,
            model: Optional[str] = None,
            mark_focus: bool = False,
            debug: bool = False) -> str:  # 输出ai完整内容
        """
开放式视觉问答：自动截图 → 发给视觉模型 → 返回文本回答

参数：
    question (str): 任意问题
    image (Optional[str]): 可选指定截图路径；不传则自动截取
    system_prompt (Optional[str]): 自定义系统提示词
    temperature (float): 回答随机程度，默认 0.2
    template_name (str): 当前检查的模板名称，用于日志美化（默认空字符串）
    check_index (int): 当前检查项序号（从1开始），用于日志美化（默认0）
    total_checks (int): 当前模板总检查项数量，用于日志美化（默认0）
    max_tokens (int): 最大输出长度，默认 1000
    timeout (int): API 超时秒数，默认 60
    verbose (bool): 是否打印详细的交互日志（问题、图片、耗时、回复等），默认 True
    mark_focus (bool): 是否在发送给 AI 的图片上标记焦点框。默认 False。

返回：
    str — AI 的文本回答

示例：
    ai = AIService()
    # 自动截图 + 标记焦点框 → 发给 AI
    result = ai.ask("当前焦点在哪个模板上？", mark_focus=True)

    # 手动传图，不带焦点标记
    result = ai.ask("布局是否正常？", image=crop_img)
"""
        img_path = image or self.screenshot()
        if not img_path:
            raise RuntimeError("ask 失败：无法获取截图")

        # ── 标记焦点框（可选） ──
        if mark_focus:
            try:
                from lib.focus_checker import get_focus_info
                from lib.focus_detector import draw_focus_mark, _parse_bounds
                info = get_focus_info()
                if info.get('has_focus') and info.get('bounds'):
                    focus_rect = _parse_bounds(info['bounds'])
                    if focus_rect:
                        marked = draw_focus_mark(
                            img_path, focus_rect,
                            template_name=template_name,
                            out_dir=os.path.dirname(img_path),
                        )
                        if marked:
                            img_path = marked
                            log(f'[FOCUS] 焦点标记图: {img_path}', 'FILE')
            except Exception as e:
                log(f'mark_focus 标记焦点框失败: {e}', 'WARN')

        # ── 图片转 base64 ──
        img_b64 = _image_to_base64(img_path)
        if not img_b64:
            raise RuntimeError("ask 失败：图片编码失败")

        sp = system_prompt or _VQA_OPEN_SYSTEM_PROMPT
        payload = {
            'model': model or DEFAULT_MODEL,
            'messages': [{
                'role': 'user',
                'content': [
                    {'type': 'text', 'text': f"{sp}\n\n{question}"},
                    {'type': 'image_url', 'image_url': {'url': img_b64}},
                ],
            }],
            'temperature': temperature,
            'max_tokens': max_tokens,
        }
        # 调用 API
        t0 = time.time()
        # 检查图片支持 → 自动 fallback
        fallback = _check_vision_support(model, has_image=True)
        if fallback:
            model = fallback
        result = _call_model_api(payload, model_name=model, timeout=timeout, debug=debug)
        elapsed = (time.time() - t0) * 1000

        if not result:
            raise RuntimeError("ask 失败：API 调用失败")

        content = result['content']
        _m = result.get('model', model or DEFAULT_MODEL)

        # ---------- 结果打印 ----------
        if verbose:
            log(f'[ASK] 发送图片: {img_path}', 'FILE')
            log(f'[ASK] ⏱️  {elapsed:.0f}ms  [{_m}]', 'AI')
            log('─' * 50, 'AI')
        if debug:
            log(f'[ASK] 完整回答: {content}', 'AI')
        return content

    def ask_focus(self, question: str, *,
                  image: Optional[str] = None,
                  system_prompt: Optional[str] = None,
                  mark_focus: bool = True,
                  temperature: float = 0.2,
                  max_tokens: int = 1024,
                  timeout: int = 60,
                  verbose: bool = True,
                  model: Optional[str] = None) -> str:
        """
        焦点框感知问答：先解析 XML 找到焦点位置和模板名，
        再将焦点信息注入 system_prompt，然后发给 AI 分析。

        适用场景：
          - "当前焦点在哪个模板上？"
          - "当前焦点所在模板的布局正常吗？"
          - "焦点在左起第几张卡片上？"
          - "焦点附近有没有角标？"

        参数：
          question (str): 关于焦点位置/内容的问题
          image (Optional[str]): 可选指定截图路径；不传则自动截取
          system_prompt (Optional[str]): 自定义系统提示词
          mark_focus (bool): 是否在图片上标记焦点框，默认 True
          temperature (float): 回答随机程度
          max_tokens (int): 最大输出长度
          timeout (int): API 超时秒数
          verbose (bool): 是否打印详细日志
          model (Optional[str]): 模型名称

        返回：
          str — AI 的文本回答（已注入焦点上下文）

        示例：
          # 问焦点所在模板
          ai.ask_focus("当前焦点在哪个模板上？")

          # 问焦点所在坑位
          ai.ask_focus("焦点在左起第几张？")

          # 带自定义 system_prompt
          ai.ask_focus("焦点所在模板排版正常吗？",
                      system_prompt="你是一个大屏UI测试专家...")
        """
        img_path = image or self.screenshot()
        if not img_path:
            raise RuntimeError("ask_focus 失败：无法获取截图")

        # ── 1. 解析 XML 找焦点 ──
        focus_context = ''
        try:
            from lib.focus_detector import (
                find_focus_from_xml, _find_template_title_for_focus,
            )
            from lib.adb_utils import dump_uiautomator

            xml_path = dump_uiautomator(os.path.dirname(img_path))
            if xml_path and os.path.exists(xml_path):
                # 找焦点框
                result = find_focus_from_xml(img_path, blocks=[], xml_path=xml_path)
                if result.get('has_focus') and result.get('focus_rect'):
                    focus_rect = result['focus_rect']

                    # 找模板标题
                    template_title = _find_template_title_for_focus(xml_path, focus_rect)

                    # 构建焦点上下文
                    focus_rect_str = f"[{focus_rect[0]},{focus_rect[1]},{focus_rect[2]},{focus_rect[3]}]"
                    if template_title:
                        focus_context = f"\n\n[焦点信息] 当前焦点位于「{template_title}」区域，坐标 {focus_rect_str}。回答时请基于此模板上下文。"
                    else:
                        focus_context = f"\n\n[焦点信息] 当前焦点坐标 {focus_rect_str}。"

                    log(f'[focus] {focus_context.strip()}', 'INFO')

                    # 画绿框
                    if mark_focus:
                        from lib.focus_detector import draw_focus_mark
                        template_name = template_title or ''
                        card_pos = result.get('card_pos', '')
                        marked = draw_focus_mark(img_path, focus_rect,
                                                template_name, card_pos,
                                                os.path.dirname(img_path))
                        if marked:
                            img_path = marked
                            log(f'[focus] 标记图: {img_path}', 'FILE')
                else:
                    log('[focus] XML 中未找到 focused=true 节点', 'WARN')
        except Exception as e:
            log(f'[focus] 焦点解析失败，降级普通 ask: {e}', 'WARN')

        # ── 2. 发送图片 + 焦点上下文 ──
        img_b64 = _image_to_base64(img_path)
        if not img_b64:
            raise RuntimeError("ask_focus 失败：图片编码失败")

        sp = system_prompt or ''
        sp = sp + focus_context if sp else focus_context.strip()
        sp = sp or _VQA_OPEN_SYSTEM_PROMPT

        payload = {
            'model': model or DEFAULT_MODEL,
            'messages': [{
                'role': 'user',
                'content': [
                    {'type': 'text', 'text': f"{sp}\n\n{question}"},
                    {'type': 'image_url', 'image_url': {'url': img_b64}},
                ],
            }],
            'temperature': temperature,
            'max_tokens': max_tokens,
        }
        # 调用 API
        t0 = time.time()
        result = _call_model_api(payload, model_name=model, timeout=timeout)
        elapsed = (time.time() - t0) * 1000

        if not result:
            raise RuntimeError("ask_focus 失败：API 调用失败")

        content = result['content']
        _m = result.get('model', model or DEFAULT_MODEL)

        # ── 3. 打印结果 ──
        if verbose:
            log(f'[focus] 发送图片: {img_path}', 'FILE')
            log(f'[focus] ⏱️  {elapsed:.0f}ms  [{_m}]', 'AI')
            log('─' * 50, 'AI')
        return content

    def generate_checkpoints(self, image: str, *,
                              channel_hint: str = "",
                              system_prompt: Optional[str] = None,
                              temperature: float = 0.2,
                              max_tokens: int = 1000,
                              timeout: int = 60,
                              verbose: bool = True) -> List[Dict[str, str]]:
        """
        根据传入的模板裁剪图，AI 分析布局并生成检查点。

        参数：
          image (str): 模板裁剪图路径（建议传入焦点所在模板的裁剪图）
          channel_hint (str): 频道名提示，辅助 AI 理解上下文（如 "直播"、"精选"）
          system_prompt (Optional[str]): 自定义系统提示词（不传则用内置）
          temperature (float): 生成随机性，默认 0.2
          max_tokens (int): 最大输出 token，默认 2000
          timeout (int): API 超时秒数
          verbose (bool): 是否打印详细日志

        返回：
          List[Dict[str, str]] — 检查点列表
          每项格式：{"名称": "排版正常", "说明": "模板内各卡片无重叠无错位"}

        示例：
          checkpoints = ai.generate_checkpoints(r"D:\screenshots\clip_01.png")
          # → [{"名称": "坑位海报加载", "说明": "6个竖图海报正常显示，无黑图"}, ...]
        """
        if not image or not os.path.exists(image):
            log('[GENERATE] 图片路径无效', 'ERROR')
            return []

        img_b64 = _image_to_base64(image)
        if not img_b64:
            log('[GENERATE] 图片编码失败', 'ERROR')
            return []

        if system_prompt is None:
            channel_context = f"频道是{channel_hint}，" if channel_hint else ""
            system_prompt = (
                "你是一个电视大屏（Android TV）UI 测试工程师，"
                f"当前是在{channel_context}频道下 你要负责检查 IPTV 大屏应用的模板渲染效果。\n\n"
                "请根据提供的模板裁剪图，分析并生成该模板的检查点列表。\n\n"
                "## 输出格式\n"
                '输出一个 JSON 数组，每项包含：\n'
                '  {"名称": "检查项名称", "说明": "具体的检查内容和判断标准"}\n\n'
                "## 检查项类型（每类至少一条）\n"
                '1. **排版检查**：坑位布局是否符合预期（如「左侧4个竖图、右侧3个竖图」），'
                '   要求：明确写出布局结构描述，方便后续检查AI按图比对\n'
                "2. **海报检查**：每个坑位的海报是否正常加载，无黑图/灰图\n"
                "3. **文本检查**：坑位下方文字标签是否有乱码/缺失\n"
                "4. **焦点响应**：描述该模板中焦点选中时的预期行为（如放大、白边框、角标）\n"
                "5. **特殊元素**：VIP角标、播放图标、默认占位图等特殊标记\n"
                "6. **边缘裁切**：检查海报是否被异常裁切、是否溢出模板边界\n\n"
                "## 原则\n"
                "- 每项检查必须是**可视觉验证的**（截图上能看到）\n"
                '- 说明要具体（写清楚"N个坑位"、"左侧/右侧"），'
                '   不要写"布局正常"这种模糊描述\n'
                "- 生成 4~8 条检查项\n"
                "- 不要输出除 JSON 数组以外的任何文字"
            )

        payload = {
            'model': DEFAULT_MODEL,
            'messages': [{
                'role': 'user',
                'content': [
                    {'type': 'text', 'text': system_prompt},
                    {'type': 'image_url', 'image_url': {'url': img_b64}},
                ],
            }],
            'temperature': temperature,
            'max_tokens': max_tokens,
        }
        t0 = time.time()
        result = _call_model_api(payload, model_name=None, timeout=timeout)
        elapsed = (time.time() - t0) * 1000

        if not result:
            raise RuntimeError("generate_checkpoints 失败：API 调用失败")

        content = result['content']
        _m = result.get('model', DEFAULT_MODEL)

        if verbose:
            log(f'[GENERATE] ⏱️ {elapsed:.0f}ms [{_m}]', 'AI')
            log(f'[GENERATE] 生成结果:\n{content[:500]}', 'AI')

        # 解析 JSON 数组
        checkpoints = _parse_json_array(content)
        if not checkpoints:
            log('[GENERATE] 未解析到检查项', 'WARN')
            return []

        log(f'[GENERATE] ✅ 生成 {len(checkpoints)} 条检查项', 'OK')
        return checkpoints

    def auto_check(self, image: str, *,
                   channel_hint: str = "",
                   checks: Optional[List[Dict[str, str]]] = None,
                   timeout: int = 30,
                   verbose: bool = True) -> dict:
        """
        自动检查模板：先调用 generate_checkpoints() 生成检查项，
        再逐条调用 VQA 检查，返回汇总结果。

        参数：
          image (str): 模板裁剪图路径
          channel_hint (str): 频道名提示（传了辅助 AI 理解）
          checks (Optional[List]): 已有检查项时不重新生成，直接用传入的
          timeout (int): 每条检查的 API 超时
          verbose (bool): 是否打印详细日志

        返回：
          {
            '生成检查': list,  # 生成的检查项
            '通过': int,
            '失败': int,
            '明细': [{'名称': str, '说明': str, '结果': bool}],
            '全部通过': bool,
          }

        示例：
          # 自动生成 + 自动检查
          result = ai.auto_check(r"D:\screenshots\clip_01.png", channel_hint="直播")

          # 用已有检查项直接跑
          result = ai.auto_check(img, checks=[{"名称":"排版","说明":"无重叠"}])
        """
        # 1. 获取检查项
        if checks is None:
            log('[auto_check] 正在生成检查项...', 'STEP')
            checks = self.generate_checkpoints(
                image, channel_hint=channel_hint, verbose=verbose)
            if not checks:
                log('[auto_check] 无法生成检查项，退出', 'ERROR')
                return {
                    '生成检查': [], '通过': 0, '失败': 0,
                    '明细': [], '全部通过': False,
                }
        else:
            log(f'[auto_check] 使用传入的 {len(checks)} 条检查项', 'STEP')

        # 2. 逐条检查
        details = []
        passed = 0
        failed = 0

        for c in checks:
            name = c.get('名称', '')
            desc = c.get('说明', name)

            log(f'[auto_check] ↳ {name}: {desc[:40]}', 'CHECK')
            ok = self.vqa(desc, image=image, timeout=timeout)
            if ok:
                log(f'  ✓ {name}', 'OK')
                passed += 1
            else:
                log(f'  ✗ {name}', 'WARN')
                failed += 1
            details.append({'名称': name, '说明': desc, '结果': ok})

        all_ok = failed == 0
        log(f'[auto_check] 完成: {passed}通过 / {failed}失败',
            'DONE' if all_ok else 'WARN')

        return {
            '生成检查': checks,
            '通过': passed,
            '失败': failed,
            '明细': details,
            '全部通过': all_ok,
        }

    def generate_checkpoints_for_focus(self, *,
                                        image: Optional[str] = None,
                                        channel_hint: str = "",
                                        out_dir: str = None,
                                        timeout: int = 60,
                                        verbose: bool = True) -> dict:
        """
        自动找焦点 → 提取焦点所在区域 → 裁剪 → 生成检查项。

        复用现有模块：
          - template_region_extractor.extract_template_regions() 提取所有模板区域
          - focus_detector.find_focus_from_xml() 找焦点
          - PIL 裁剪找焦点所在区域

        参数：
          image (Optional[str]): 指定截图路径；不传则自动截取
          channel_hint (str): 频道名提示（如 "直播"）
          out_dir (str): 裁剪图输出目录（默认截图同目录）n          timeout (int): API 超时
          verbose (bool): 是否打印详细日志

        返回：
          {
            'crop_path': str,          # 裁剪图路径
            'template_title': str,     # 模板标题
            'focus_rect': [x,y,w,h],   # 焦点框
            'template_bounds': dict,   # 模板边界
            'checkpoints': list,       # 生成的检查项
          }
          失败返回 {'error': str}

        示例：
          result = ai.generate_checkpoints_for_focus(channel_hint="直播")
          # → 自动找焦点、裁剪模板图、生成检查项
        """
        import xml.etree.ElementTree as ET
        from lib.focus_detector import find_focus_from_xml, _parse_bounds
        from lib.adb_utils import dump_uiautomator
        from lib.template_region_extractor import extract_template_regions

        img_path = image or self.screenshot()
        if not img_path:
            return {'error': '无法获取截图'}

        # 1. dump XML
        xml_path = dump_uiautomator(out_dir or os.path.dirname(img_path))
        if not xml_path or not os.path.exists(xml_path):
            return {'error': 'XML dump 失败'}

        # 2. 找焦点
        focus_result = find_focus_from_xml(img_path, blocks=[], xml_path=xml_path)
        if not focus_result.get('has_focus') or not focus_result.get('focus_rect'):
            return {'error': '未找到 focused=true 节点'}
        focus_rect = focus_result['focus_rect']
        fx, fy, fw, fh = focus_rect
        focus_center_y = fy + fh // 2

        # 3. 提取所有模板区域
        try:
            with open(xml_path, 'r', encoding='utf-8') as f:
                raw = f.read()
            raw = re.sub(r'\<\s+(\w)', r'<\1', raw)
            raw = re.sub(r'\<\s*/(\w)', r'</\1', raw)
            raw = re.sub(r'(\w)\s*-\s*(\w)', r'\1-\2', raw)
            raw = re.sub(r'\<\?xml[^>]*\?>', '<?xml version="1.0" encoding="utf-8"?>', raw)
            root = ET.fromstring(raw)
            regions = extract_template_regions(root)
        except Exception as e:
            return {'error': f'XML 解析失败: {e}'}

        if not regions:
            return {'error': '未提取到任何模板区域'}

        # 4. 找焦点所在区域（focus_center_y 在 [y1, y2) 内）
        matched_region = None
        for r in regions:
            if r['y1'] <= focus_center_y < r['y2']:
                matched_region = r
                break
        if not matched_region:
            # fallback: 找最近的区域
            matched_region = min(regions, key=lambda r: abs(r['y1'] - focus_center_y))

        template_title = matched_region['name']
        log(f'[checkpoints_for_focus] 焦点在模板: {template_title}', 'OK')

        # 5. 裁剪
        try:
            img = Image.open(img_path)
            w, h = img.size
            left = max(0, matched_region['x1'] - 3)
            top = max(0, matched_region['y1'] - 3)
            right = min(w, matched_region['x2'] + 3)
            bottom = min(h, matched_region['y2'] + 10)
            cropped = img.crop((left, top, right, bottom))
        except Exception as e:
            return {'error': f'裁剪失败: {e}'}

        if not out_dir:
            out_dir = os.path.dirname(img_path)
        os.makedirs(out_dir, exist_ok=True)
        ts = time.strftime('%Y%m%d_%H%M%S')
        safe_title = re.sub(r'[^\w\u4e00-\u9fff]+', '_', template_title)[:30]
        crop_path = os.path.join(out_dir, f'focus_crop_{safe_title}_{ts}.png')
        cropped.save(crop_path)

        log(f'[checkpoints_for_focus] 裁剪完成: {crop_path} ({cropped.size[0]}x{cropped.size[1]})', 'OK')

        # 6. 生成检查项
        checkpoints = self.generate_checkpoints(
            crop_path,
            channel_hint=channel_hint,
            timeout=timeout,
            verbose=verbose,
        )

        return {
            'crop_path': crop_path,
            'template_title': template_title,
            'focus_rect': focus_rect,
            'template_bounds': {
                'x_start': matched_region['x1'],
                'y_start': matched_region['y1'],
                'x_end': matched_region['x2'],
                'y_end': matched_region['y2'],
            },
            'checkpoints': checkpoints,
        }

    def ask_text(self, prompt: str, *,
                 system_prompt: Optional[str] = None,
                 temperature: float = 0.3,
                 max_tokens: int = 4096,
                 timeout: int = 120,
                 verbose: bool = True,
                 model: Optional[str] = None) -> Optional[str]:
        """
        纯文本问答（不传图片）。适用于 Thinking 模型（Agnes）等非视觉模型。

        参数：
          prompt: 用户问题/提示
          system_prompt: 系统提示词
          temperature: 回答随机程度
          max_tokens: 最大输出 token
          timeout: API 超时
          verbose: 是否打印日志
          model: 模型名称（如 'agnes-2.0-flash'）

        返回：
          str — AI 回答，或 None（失败时）
        """
        cfg = _resolve_model(model)
        payload = {
            'model': cfg['name'],
            'messages': [
                {'role': 'system', 'content': system_prompt or ''},
                {'role': 'user', 'content': prompt},
            ],
            'temperature': temperature,
            'max_tokens': max_tokens,
        }
        # 如果模型配置了 thinking 参数，追加
        payload_cfg = _modify_payload_for_thinking(payload, model)

        result = _call_model_api(payload_cfg, model_name=model, timeout=timeout)
        if not result:
            return None

        content = result['content']
        if verbose:
            _m = result.get('model', model or DEFAULT_MODEL)
            log(f'[{_m}] {result["elapsed_ms"]:.0f}ms', 'AI')
        return content


    # ── OCR 文字识别 ──────────────────────────────────────────

    def ocr(self, *, image: Optional[str] = None,
            filter_text: Optional[str] = None,
            filter_pattern: Optional[str] = None,
            flag_case_sensitive: bool = False,
            with_coords: bool = False,
            timeout: int = 60,
            model: Optional[str] = None) -> List[str]:
        """
        OCR 文字识别：截图 → GLM-4V 提取所有可见文字。

        参数:
          image: 可选截图路径；不传自动截取
          filter_text: 筛选包含此文本的结果
          filter_pattern: 筛选匹配此正则的结果
          flag_case_sensitive: 是否区分大小写（默认不区分）
          with_coords: 是否返回坐标格式（默认 False，仅返回文字列表）
          timeout: API 超时

        返回:
          with_coords=False: ['文字1', '文字2', ...]
          with_coords=True:  [{'text': '文字', 'x': 100, 'y': 200, 'w': 300, 'h': 50}, ...]

        示例:
          ai.ocr()                      # ['中国IPTV', '精选', '电视剧', ...]
          ai.ocr(filter_text='模板')     # ['首屏4横图通栏模板', ...]
          ai.ocr(with_coords=True)      # [{'text':'文字','x':100,...}, ...]
        """
        img_path = image or self.screenshot()
        if not img_path:
            raise RuntimeError("OCR 失败：无法获取截图")

        img_b64 = _image_to_base64(img_path)
        if not img_b64:
            raise RuntimeError("OCR 失败：图片编码失败")

        if with_coords:
            prompt = (
                "你是电视大屏 UI 文字识别专家。请识别截图中所有可见的文字（包括标题、角标、按钮、卡片文字等），按从上到下、从左到右排序。\n"
                "一行一个 JSON，不要换行缩进：\n"
                '{"text":"文字","x":100,"y":50,"w":200,"h":40}\n'
                "...每行一个对象，行尾不要逗号。不要 Markdown 代码块。"
            )
        else:
            prompt = (
                "你是电视大屏 UI 文字识别专家。请识别截图中所有可见的文字（包括标题、角标、按钮、卡片文字等），按从上到下、从左到右排序。\n"
                "一行一个文字，不要序号、不要引号、不要 Markdown 代码块：\n"
                "中国IPTV-湖南\n"
                "二级菜单\n"
                "全部\n"
                "直播\n"
                "..."
            )

        log(f'[OCR] 识别截图中所有文字{"（含坐标）" if with_coords else ""}', 'AI')

        # 默认模型：with_coords=False 用 LongCat（文本），True 用 GLM-4.6V（更高 token 限制）
        effective_model = model or ('glm-4.6v-flash' if with_coords else None)
        effective_max_tokens = 4096 if with_coords else 1024

        payload = _build_vision_payload(prompt, img_b64, temperature=0.1, max_tokens=effective_max_tokens, model_name=effective_model)
        result = _call_model_api(payload, model_name=effective_model, timeout=timeout)
        if not result:
            raise RuntimeError("OCR 失败：API 调用失败")

        content = result['content']
        elapsed = result['elapsed_ms']
        _m = result.get('model', effective_model or DEFAULT_MODEL)
        log(f'[OCR] {elapsed:.0f}ms [{_m}] → {content[:150]}...', 'AI')

        if with_coords:
            # 解析 JSON 数组（含坐标）
            items = _parse_json_array(content)
        else:
            # 解析纯文字列表（每行一个）
            items = [line.strip() for line in content.split('\n') if line.strip()]

        # 应用筛选
        if filter_text:
            txt = filter_text.lower() if not flag_case_sensitive else filter_text
            if with_coords:
                items = [
                    it for it in items
                    if isinstance(it, dict) and (txt in (it.get('text', '').lower() if not flag_case_sensitive else it.get('text', '')))
                ]
            else:
                items = [
                    it for it in items
                    if isinstance(it, str) and (txt in (it.lower() if not flag_case_sensitive else it))
                ]
        if filter_pattern:
            flags = 0 if flag_case_sensitive else re.IGNORECASE
            pat = re.compile(filter_pattern, flags)
            if with_coords:
                items = [it for it in items if isinstance(it, dict) and pat.search(it.get('text', ''))]
            else:
                items = [it for it in items if isinstance(it, str) and pat.search(it)]

        return items  # type: ignore[return-value]
    def ocr_text(self, *, image: Optional[str] = None, timeout: int = 60) -> List[str]:
        """OCR 返回纯文字列表（不含坐标）。便捷方法。"""
        return self.ocr(image=image, timeout=timeout)

    def ocr_exists(self, text: str, *, image: Optional[str] = None,
                   flag_case_sensitive: bool = False, timeout: int = 60) -> bool:
        """
        判断截图中是否包含指定文字。
        使用 VQA 直接问答，无需全量 OCR，秒回。

        示例：
          ai.ocr_exists('首屏4横图通栏模板')  # → True/False
        """
        img_path = image or self.screenshot()
        if not img_path:
            return False
        q = f"截图中是否包含文字「{text}」？只回答是或不是，不要解释。"
        return self.vqa(q, image=img_path, timeout=timeout)


    def ocr_find(self, text, *, image=None, flag_case_sensitive=False, timeout=60):
        """Find text position using Baidu OCR general endpoint.
        
        匹配逻辑：
        1. 精确匹配优先
        2. 相似度匹配（SequenceMatcher，阈值 0.5）
        3. 返回最佳匹配的坑位中心坐标
        """
        import difflib
        img_path = image or self.screenshot()
        if not img_path:
            return None
        log(f'[OCR_FIND] 查找: {text}', 'AI')
        try:
            with open(img_path, 'rb') as f:
                img_b64 = base64.b64encode(f.read()).decode()
        except IOError as e:
            log(f'[OCR_FIND] read failed: {e}', 'WARN')
            return None
        words = _baidu_ocr_general(img_b64)
        if not words:
            log('[OCR_FIND] no result', 'WARN')
            return None
        
        text_clean = text.strip()
        text_norm = text_clean.lower().replace('·', ' ').replace(' ', '')
        
        candidates = []
        for item in words:
            word = item.get('words', '').strip()
            word_norm = word.lower().replace('·', ' ').replace(' ', '')
            if not word_norm:
                continue
            # 计算相似度
            ratio = difflib.SequenceMatcher(None, text_norm, word_norm).ratio()
            # 包含关系加分
            if text_norm in word_norm or word_norm in text_norm:
                ratio = max(ratio, 0.8)
            candidates.append((ratio, item))
        
        if not candidates:
            log('[OCR_FIND] no candidates', 'WARN')
            return None
        
        # 按相似度排序，取最高分
        candidates.sort(key=lambda x: x[0], reverse=True)
        best_ratio, best_item = candidates[0]
        
        # 打印所有候选（调试用）
        log(f'[OCR_FIND] 目标: "{text_clean}" 识别到 {len(candidates)} 个候选:', 'AI')
        for ratio, item in candidates[:5]:
            loc = item.get('location', {})
            log(f'  [{ratio:.2f}] "{item.get("words","")}" at ({loc.get("left",0)},{loc.get("top",0)})', 'AI')
        
        if best_ratio < 0.4:
            log(f'[OCR_FIND] 最佳匹配相似度太低: {best_ratio:.2f}', 'WARN')
            return None
        
        loc = best_item.get('location', {})
        left = loc.get('left', 0)
        top = loc.get('top', 0)
        width = loc.get('width', 0)
        height = loc.get('height', 0)
        cx = left + width // 2
        cy = top + height // 2
        result = {'cx': cx, 'cy': cy, 'text': best_item['words']}
        log(f'[OCR_FIND] ✅ ({cx},{cy}) "{best_item["words"]}" (相似度 {best_ratio:.2f})', 'AI')
        return result


    def ocr_find_regex(self, pattern, *, image=None, flag_case_sensitive=False, timeout=60):
        """Regex match first text using Baidu OCR general endpoint."""
        img_path = image or self.screenshot()
        if not img_path:
            return None
        log(f'[OCR_FIND_REGEX] regex: /{pattern}/', 'AI')
        try:
            with open(img_path, 'rb') as f:
                img_b64 = base64.b64encode(f.read()).decode()
        except IOError as e:
            log(f'[OCR_FIND_REGEX] read failed: {e}', 'WARN')
            return None
        words = _baidu_ocr_general(img_b64)
        if not words:
            log('[OCR_FIND_REGEX] no result', 'WARN')
            return None
        flags = 0 if flag_case_sensitive else re.IGNORECASE
        for item in words:
            word = item.get('words', '')
            if re.search(pattern, word, flags):
                loc = item.get('location', {})
                left = loc.get('left', 0)
                top = loc.get('top', 0)
                width = loc.get('width', 0)
                height = loc.get('height', 0)
                cx = left + width // 2
                cy = top + height // 2
                return {'cx': cx, 'cy': cy, 'text': word}
        log(f'[OCR_FIND_REGEX] not matched: /{pattern}/', 'WARN')
        return None


    # ── 图片相似度对比 ──────────────────────────────────────

    def compare_images(self, image1: str, image2: str) -> float:
        """
        对比两张图片的相似度（本地计算，不调用 API）。
        使用感知哈希(pHash) + 结构相似度(SSIM) 综合评分。

        参数：
          image1: 第一张图片路径（或已有的 PIL.Image）
          image2: 第二张图片路径

        返回：
          float — 相似度 0.0~1.0，1.0 表示完全相同

        示例：
          score = ai.compare_images('crop_a.png', 'crop_b.png')
          if score >= 0.85:
              print('两张图基本一致')
        """
        img_a = Image.open(image1) if isinstance(image1, str) else image1
        img_b = Image.open(image2) if isinstance(image2, str) else image2
        return _calculate_similarity(img_a, img_b)

    def is_similar(self, image1: str, image2: str, threshold: float = 0.85) -> bool:
        """
        判断两张图是否相似（threshold 默认 0.85）。

        示例：
          if ai.is_similar('before.png', 'after.png'):
              print('页面没有变化')
        """
        score = self.compare_images(image1, image2)
        log(f'[CMP] 相似度: {score:.4f} (阈值{threshold})', 'AI')
        return score >= threshold

    def compare_images_batch(self, pairs: List[tuple], threshold: float = 0.85) -> List[float]:
        """
        批量图片对比。

        参数：
          pairs: [(img1, img2), ...] 图对列表
          threshold: 不参与计算，仅用于日志

        返回：
          [score1, score2, ...]
        """
        results = []
        for i, (a, b) in enumerate(pairs):
            score = self.compare_images(a, b)
            results.append(score)
            log(f'[CMP] [{i+1}/{len(pairs)}] 相似度: {score:.4f}', 'AI')
        return results

    # ── 便捷方法 ──────────────────────────────────────────────

    def check_focus(self, template_name: str, card_index: int = 0,
                    *, image: Optional[str] = None) -> bool:
        """
        焦点检测快捷方法：判断焦点框是否在指定模板的指定卡片上

        card_index: 0=第一张卡片（最左/最上），1=第二张...
        """
        card_desc = _card_desc(card_index)
        return self.vqa(
            f"当前焦点框（高亮边框/放大效果）是否在「{template_name}」的{card_desc}上？",
            image=image,
        )

    def count_templates(self, *, image: Optional[str] = None) -> str:
        """描述屏幕上所有模板"""
        return self.ask(
            "请描述当前电视屏幕上可见的所有模板区块（每个区块的模板名称和卡片数量）。"
            "按从上到下的顺序列出。",
            image=image,
        )

    # ── 模板提示词快捷方法 ──

    # ── 全局上下文（注册后 vqa_template 可不传 builder） ──

    def load_context(self, builder, clips_dir: str = ""):
        """
        注册上下文，后续 vqa_template / ask_template 可不传 builder。

        参数：
          builder: TemplatePromptBuilder 实例（已 load 过的）
          clips_dir: 裁剪图目录（如 screenshots/直播_clips）
        """
        self._ctx_builder = builder
        self._ctx_clips_dir = clips_dir
        return self

    def clear_context(self):
        """清除上下文"""
        self._ctx_builder = None
        self._ctx_clips_dir = None

    def _find_crop_by_template(self, template_name: str) -> Optional[str]:
        """在 clips_dir 中找模板名对应的裁剪图"""
        if not self._ctx_clips_dir or not os.path.isdir(self._ctx_clips_dir):
            return None
        safe_name = template_name.replace('/', '_').replace('\\', '_').replace(' ', '_')
        # 精确匹配：文件名含模板名
        for f in os.listdir(self._ctx_clips_dir):
            if not f.endswith('.png'):
                continue
            # 去掉频道前缀匹配模板名
            name_part = f.split('_', 1)[-1] if '_' in f else f
            name_part = os.path.splitext(name_part)[0]
            if name_part == safe_name or safe_name in name_part or name_part in safe_name:
                return os.path.join(self._ctx_clips_dir, f)
        return None

    def ask_template(self, question: str, builder=None, template_name: str = "",
                     *, image: Optional[str] = None,
                     temperature: float = 0.2, max_tokens: int = 1000,
                     timeout: int = 60) -> str:
        """
        使用模板专属提示词的 ask()。

        参数：
          question: 问题
          builder: TemplatePromptBuilder 实例或模板名字符串
          template_name: 目标模板名
          image: 截图路径，不传则从上下文裁剪目录自动匹配

        示例：
          # 一句话
          ai.ask_template("描述模板", "直播居中模版新")

          # 传统
          ai.ask_template("描述模板", builder, "直播居中模版新")
        """
        if isinstance(builder, str):
            template_name = builder
            builder = None
        b = builder or getattr(self, '_ctx_builder', None)
        if not b:
            log('[AI] ask_template 缺少 builder，请传 builder 或先调 load_context()', 'WARN')
            return ''
        sp = b.build_for_template(template_name)
        if not image and template_name:
            image = self._find_crop_by_template(template_name)
        return self.ask(question, image=image, system_prompt=sp,
                        temperature=temperature, max_tokens=max_tokens, timeout=timeout)

    def vqa_template(self, question: str, builder=None, template_name: str = "",
                     *, image: Optional[str] = None, timeout: int = 60) -> bool:
        """
        使用模板专属提示词的 vqa()，自动找裁剪图。

        参数：
          question: 问题
          builder: TemplatePromptBuilder 实例或模板名字符串
                    传字符串时自动视为 template_name，builder 回退到已注册上下文
          template_name: 模板名
          image: 截图路径，不传则从上下文裁剪目录自动匹配

        示例：
          # ✅ 一句话（推荐）：builder 位置参数直接传模板名字符串
          ai.vqa_template("海报正常吗？", "直播居中模版新")

          # ✅ 旧写法：builder + template_name 分开传
          ai.vqa_template("海报正常吗？", builder, "直播居中模版新")

          # ✅ 先注册上下文，builder 自动用上下文
          ai.load_context(builder, "screenshots/直播_clips")
          ai.vqa_template("海报正常吗？", template_name="直播居中模版新")
        """
        # 兼容：builder 位置参数收到字符串时当作 template_name
        if isinstance(builder, str):
            template_name = builder
            builder = None

        b = builder or getattr(self, '_ctx_builder', None)
        if not b:
            log('[AI] vqa_template 缺少 builder，请传 builder 或先调 load_context()', 'WARN')
            return False
        sp = b.build_compact(template_name)
        if not image and template_name:
            image = self._find_crop_by_template(template_name)
        return self.vqa(question, image=image, system_prompt=sp, timeout=timeout)

    def ask_channel(self, question: str, builder=None,
                    *, image: Optional[str] = None,
                    temperature: float = 0.2, max_tokens: int = 1000,
                    timeout: int = 60) -> str:
        """
        使用频道全量模板提示词的 ask()。

        示例：
          result = ai.ask_channel("分析整个页面", builder)
        """
        sp = builder.build_for_channel()
        return self.ask(question, image=image, system_prompt=sp,
                        temperature=temperature, max_tokens=max_tokens, timeout=timeout)

    def check_template(self, template_name: str = "",
                       *, image: Optional[str] = None,
                       builder=None,
                       timeout: int = 30) -> dict:
        """
        自动检查指定模板的公共检查项 + 专属检查项。

        从 checkpoints.json 读取所有检查点，逐条调用 VQA，
        返回 {'通过': int, '失败': int, '明细': [{'名称','说明','结果'}, ...], '全部通过': bool}

        示例：
          # 一句话（需先注册上下文）
          result = ai.check_template("直播居中模版新")

          # 指定 builder
          result = ai.check_template("直播居中模版新", builder=builder)

          # 查看结果
          print(f"通过 {result['通过']}/{result['通过']+result['失败']}")
          assert result['全部通过'], "有检查项失败"
        """
        b = builder or getattr(self, '_ctx_builder', None)
        if not b:
            log('[AI] check_template 缺少 builder，请传 builder 或先调 load_context()', 'WARN')
            return {'通过': 0, '失败': 0, '明细': [], '全部通过': False}

        cp = b.get_checkpoint(template_name)
        if not cp:
            log(f'[AI] 未找到模板「{template_name}」的 checkpoints', 'WARN')
            sp = b.build_compact(template_name)
            # 只有公共检查
            checkpoint_data = _load_checkpoints()
            if not checkpoint_data:
                return {'通过': 0, '失败': 0, '明细': [], '全部通过': False}
            checks = checkpoint_data.get('公共检查', [])
            log(f'[AI] 对模板「{template_name}」执行 {len(checks)} 条公共检查', 'STEP')
        else:
            sp = b.build_compact(template_name)
            checkpoint_data = _load_checkpoints()
            public_checks = checkpoint_data.get('公共检查', []) if checkpoint_data else []
            extra_checks = cp.get('专属检查', [])
            checks = public_checks + extra_checks
            log(f'[AI] 对模板「{template_name}」执行 {len(public_checks)} 条公共检查 + {len(extra_checks)} 条专属检查', 'STEP')

        if not image and template_name:
            image = self._find_crop_by_template(template_name)
        if not image:
            log('[AI] check_template 无截图，跳过', 'WARN')
            return {'通过': 0, '失败': 0, '明细': [], '全部通过': False}

        log(f'[AI] 裁剪图: {image}', 'FILE')

        details = []
        passed = 0
        failed = 0

        # 跳过「结果返回说明」这个检查项（它不是真正的问题）
        skip_names = {'结果返回说明'}

        for c in checks:
            name = c.get('名称', '')
            desc = c.get('说明', name)
            if name in skip_names:
                continue

            log(f'[AI]   ↳ 检查: {name}', 'CHECK')
            ok = self.vqa(desc, image=image, system_prompt=sp, timeout=timeout)
            if ok:
                log(f'    ✓ {name}', 'OK')
                passed += 1
            else:
                log(f'    ✗ {name}', 'WARN')
                failed += 1

            details.append({
                '名称': name,
                '说明': desc,
                '结果': ok,
            })

        all_ok = failed == 0
        log(f'[AI] 检查完成: {passed}通过 / {failed}失败', 'DONE' if all_ok else 'WARN')

        return {
            '通过': passed,
            '失败': failed,
            '明细': details,
            '全部通过': all_ok,
        }


def _card_desc(index: int) -> str:
    """卡片索引 → 中文描述"""
    mapping = {0: '第一张卡片', 1: '第二张卡片', 2: '第三张卡片',
               3: '第四张卡片', 4: '第五张卡片', -1: '最后一张卡片'}
    return mapping.get(index, f'第{index+1}张卡片')


# ══════════════════════════════════════════════════════════════
# 模块级单例（推荐用法）
# ══════════════════════════════════════════════════════════════

ai = AIService()
"""全局 AI 服务实例，直接使用:
   from ai_service import ai
   result = ai.vqa("问题")
"""


# ══════════════════════════════════════════════════════════════
# 命令行测试入口
# ══════════════════════════════════════════════════════════════

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("用法:")
        print("  python ai_service.py vqa '当前焦点在首屏4横图通栏模板上吗？'")
        print("  python ai_service.py ask '描述屏幕上所有模板'")
        print("  python ai_service.py check_focus '首屏4横图通栏模板' 0")
        sys.exit(1)

    cmd = sys.argv[1]

    if cmd == 'vqa':
        q = sys.argv[2] if len(sys.argv) > 2 else "屏幕上有内容显示吗？"
        try:
            result = ai.vqa(q)
            print(f"✅ 结果: {result}" if result else f"❌ 结果: {result}")
        except Exception as e:
            print(f"错误: {e}")

    elif cmd == 'ask':
        q = sys.argv[2] if len(sys.argv) > 2 else "描述当前屏幕上的内容"
        try:
            result = ai.ask(q)
            print(f"回答:\n{result}")
        except Exception as e:
            print(f"错误: {e}")

    elif cmd == 'check_focus':
        tname = sys.argv[2] if len(sys.argv) > 2 else '首屏4横图通栏模板'
        cidx = int(sys.argv[3]) if len(sys.argv) > 3 else 0
        try:
            result = ai.check_focus(tname, cidx)
            print(f"✅ 焦点在 '{tname}' 的{_card_desc(cidx)}" if result
                  else f"❌ 焦点不在 '{tname}' 的{_card_desc(cidx)}")
        except Exception as e:
            print(f"错误: {e}")

    else:
        print(f"未知命令: {cmd}")
        print("支持: vqa / ask / check_focus")
