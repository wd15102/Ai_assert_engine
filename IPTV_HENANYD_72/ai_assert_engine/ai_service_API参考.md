# AI Service API 调用参考

> 文件路径：`lib/ai_service.py`  
> 使用方式：`from lib.ai_service import ai`  
> 所有方法通过模块级单例 `ai` 调用。

---

## 📋 方法速查表

| 类别 | 方法 | 返回值 | 一句话说明 |
|------|------|--------|-----------|
| **视觉问答** | `ai.vqa()` | `bool` | 布尔断言：是/不是 |
| | `ai.ask()` | `str` | 开放式提问，返回文本 |
| **焦点感知** | `ai.ask_focus()` | `str` | 自动找焦点 → 注入焦点上下文 → 询问 |
| | `ai.generate_checkpoints_for_focus()` | `dict` | 自动找焦点 → 裁剪 → 生成检查项 |
| **全自动** | `ai.generate_checkpoints()` | `list` | 根据裁剪图自动生成检查项 |
| | `ai.auto_check()` | `dict` | 生成检查项 → 逐条检查 → 汇总 |
| | `ai.check_template()` | `dict` | 从 checkpoints.json 加载检查项 → 逐条检查 |
| **OCR** | `ai.ocr()` | `[dict]` | 全部文字 + 坐标 |
| | `ai.ocr_text()` | `[str]` | 纯文字列表 |
| | `ai.ocr_exists()` | `bool` | 判断是否包含指定文字 |
| | `ai.ocr_find()` | `dict` | 查找第一个匹配文字 + 中心坐标 |
| | `ai.ocr_find_regex()` | `dict` | 正则匹配第一个文字 + 中心坐标 |
| **图片对比** | `ai.compare_images()` | `float` | 相似度 0.0~1.0 |
| | `ai.is_similar()` | `bool` | 是否相似（默认阈值 0.85） |
| | `ai.compare_images_batch()` | `[float]` | 批量对比 |
| **纯文本** | `ai.ask_text()` | `str` | 纯文本推理（非视觉模型，如 agnes） |
| **模板上下文** | `ai.load_context()` | `self` | 注册 builder + 裁剪目录 |
| | `ai.clear_context()` | `None` | 清除上下文 |
| | `ai.ask_template()` | `str` | 使用模板专属提示词问问题 |
| | `ai.vqa_template()` | `bool` | 使用模板专属提示词做布尔判断 |
| | `ai.ask_channel()` | `str` | 使用频道全量提示词问问题 |
| **快捷方法** | `ai.check_focus()` | `bool` | 焦点是否在指定模板的指定卡片上 |
| | `ai.count_templates()` | `str` | 描述当前屏幕所有模板 |

---

## 1️⃣ 视觉问答

### ai.vqa() — 布尔断言

```python
from lib.ai_service import ai

result = ai.vqa("当前焦点在首屏4横图通栏模板上吗？")
print(result)  # → True / False

# 可选参数
result = ai.vqa("布局有重叠吗？",              # 问题
                image=r"D:\screenshots\page.png",  # 手动传图
                mark_focus=True,                    # 图上画焦点框
                model="glm-4v-flash",                # 指定模型
                timeout=60)
```

#### 🔄 调用流程（6步）

```
1. 获取截图
   └─ 有 image 参数 → 直接用
   └─ 无 image → _auto_screenshot()
                   ├─ 优先 adb_utils.screenshot()
                   └─ 兜底: adb shell screencap → pull → rm
   
2. 可选：标记焦点框 (mark_focus=True)
   └─ get_focus_info() 解析 XML 获取焦点 bounds
   └─ draw_focus_mark() 在截图上画框
   └─ 新截图路径 → 发给 AI 的那张图

3. 图片压缩 → base64
   └─ PIL.Image.open → 缩放至 max_side=640px
   └─ JPEG quality=60 → base64 data URL

4. 构建 payload
   └─ 模型配置从 MODELS 注册表获取 api_url + api_key
   └─ messages: [system_prompt, user(content=[text, image_url])]

5. 调用 API（带重试）
   └─ HTTP PoolManager Keep-Alive 复用连接
   └─ 失败 → 指数退避重试 (1s, 2s)
   └─ 成功 → 解析 choices[0].message.content

6. 解析布尔值（三级降级）
   └─ ① JSON {"result": true/false}
   └─ ② 假值关键词匹配（"没有"/"不是"/"false"...）
   └─ ③ 真值关键词匹配（"是"/"有"/"true"...）
   └─ ④ 首单词判断
   └─ ⑤ 都无法判断 → 抛 ValueError
```

#### 🔧 关键依赖

| 组件 | 文件 | 作用 |
|------|------|------|
| `_auto_screenshot()` | ai_service.py 内部 | ADB 截图（双策略降级） |
| `_image_to_base64()` | ai_service.py 内部 | 图片压缩 → base64 |
| `_get_http_pool()` | ai_service.py 内部 | urllib3 连接池 |
| `_resolve_model()` | ai_service.py 内部 | 从 MODELS 注册表取配置 |
| `_parse_bool_answer()` | ai_service.py 内部 | 三级降级布尔解析 |
| `get_focus_info()` | `lib/focus_checker.py` | XML 焦点检测 |
| `draw_focus_mark()` | `lib/focus_detector.py` | 画焦点框 |

**输出示例：**

```
[VQA] 问题: 当前焦点在首屏4横图通栏模板上吗？
[VQA] 发送图片: D:\...\screenshots\vqa_auto_20260716_183022.png
[VQA] 2534ms [glm-4v-flash] → 是
✅ 结果: True
```

---

### ai.ask() — 开放式问答

```python
result = ai.ask("描述当前屏幕上所有可见的模板")
print(result)

# 可选参数
result = ai.ask("当前焦点在哪个模板上？",
                mark_focus=True,            # 图上标记焦点框
                temperature=0.2,            # 随机程度
                max_tokens=1024,            # 最大输出长度
                verbose=True)               # 是否打印详细日志
```

#### 🔄 调用流程

```
1. 获取截图（与 vqa 相同：参数优先 → 自动截图 → 双策略降级）
2. 可选：标记焦点框（mark_focus=True 时 get_focus_info + draw_focus_mark）
3. 图片压缩 → base64（640px + JPEG quality=60）
4. 构建 payload
   └─ system_prompt = _VQA_OPEN_SYSTEM_PROMPT（含焦点行为描述）
   └─ 重要：告知 AI 大屏上的焦点表现（白色实线框 / 卡片放大 / 导航栏蓝色背景）
5. 调用 API（带重试）
6. 直接返回 content 文本（不做布尔解析）
```

#### vqa vs ask 对比

| | `vqa()` | `ask()` |
|---|---|---|
| 返回值 | `bool` | `str` |
| system_prompt | 强制置答模式："只回答「是」或「不是」" | 开放模式："描述电视界面的内容、布局、状态等" |
| max_tokens | 50（仅需"是/不是"） | 1024（需要完整描述） |
| AI 回复解析 | 三级降级布尔解析 | 直接返回原文本 |

**输出示例：**

```
[ASK] 发送图片: D:\...\screenshots\vqa_auto_20260716_183200.png
[ASK] ⏱️  3102ms  [glm-4v-flash]
──────────────────────────────────────────────────
从上到下依次是直播频道的5个模板：

1️⃣ 直播居中模版新：左栏6个竖图海报，中间直播播放窗口（显示"正在播放：CCTV-1"），右栏4个推荐坑位。

2️⃣ 首屏4横图通栏模板：4个横向推荐卡片，分别标注"回看"、"九屏同看"、"四屏同看"、"CCTV-6"。

3️⃣ 首屏4横图(播放角标)：4个VIP推荐卡片，每个有红色「影视会员」角标。

4️⃣ 底部通栏：包含「回到顶部」（蓝色高亮）和「搜索更多」按钮，以及版本信息。
```

---

## 2️⃣ 焦点感知

### ai.ask_focus() — 焦点框感知问答

```python
from lib.ai_service import ai

# 基础使用
result = ai.ask_focus("当前焦点在哪个模板上？")
print(result)
# → '当前焦点在「首屏4横图通栏模板」区域，位于左起第二张卡片'

# 问焦点附近元素
result = ai.ask_focus("焦点附近有没有角标？")
# → '有，焦点卡片的右上角有红色「影视会员」角标'
```

#### 🔄 调用流程

```
1. 获取截图
   └─ 有 image 参数 → 直接用
   └─ 无 → _auto_screenshot()

2. 解析 XML 找焦点 ← 这是核心差异
   ├─ dump_uiautomator() → 得到 XML 文件
   │   ├─ 降级链 D(Appium HTTP) → A(adb shell --compressed)
   │   │           → C(杀僵尸重试A) → E(uiautomator2库)
   │   └─ 带 time_budget 防卡死
   ├─ find_focus_from_xml(xml_path)
   │   ├─ 遍历 XML 找 focused="true" 的节点
   │   ├─ 取面积最大的父容器 bounds（确保包含完整卡片）
   │   └─ 返回 focus_rect [x, y, w, h]
   ├─ _find_template_title_for_focus(xml_path, focus_rect)
   │   └─ 通过焦点中心Y坐标匹配模板区域，反查模板标题
   └─ 构建焦点上下文字符串
       ├─ 有模板名 → "[焦点信息] 当前焦点位于「xxx」区域，坐标 [...]"
       └─ 无模板名 → "[焦点信息] 当前焦点坐标 [...]"

3. 可选：在截图上画焦点框（mark_focus=True，默认开启）
   └─ draw_focus_mark(img_path, focus_rect)

4. 图片压缩 → base64

5. 构建 payload
   └─ system_prompt = 自定义/system_prompt + focus_context / 内置
   └─ focus_context 注入到 AI 的输入中，让 AI 已知焦点位置

6. 调用 API → 返回文本回答
```

#### 与 ai.ask(mark_focus=True) 的区别

| | `ai.ask(mark_focus=True)` | `ai.ask_focus()` |
|---|---|---|
| 焦点信息 | 只在图上画绿框，AI 自己看 | 图上画绿框 + **文本注入**焦点上下文 |
| 文本注入 | ❌ AI 不知焦点在哪 | ✅ AI 已知「当前焦点位于 xxx 模板，坐标[..]」 |
| 模板名反查 | ❌ | ✅ 通过 XML 反查模板标题 |
| 精度 | AI 全靠看图猜 | AI 看图 + 看文本标注，双重确认 |

**输出示例：**

```
[focus] 当前焦点位于「首屏4横图(播放角标)」区域，坐标 [235, 520, 350, 350]。
[focus] 标记图: D:\...\screenshots\vqa_auto_20260716_183400_marked.png
[focus] ⏱️  2890ms  [glm-4v-flash]
──────────────────────────────────────────────────
当前焦点在「首屏4横图(播放角标)」模板上，位于左起第一张VIP推荐卡片。
卡片右上角有红色「影视会员」角标，右下角有蓝色圆形播放图标。
```

---

### ai.generate_checkpoints_for_focus() — 自动找焦点+裁剪+生成检查项

```python
from lib.ai_service import ai

result = ai.generate_checkpoints_for_focus(channel_hint="直播")
print(result['template_title'])    # 模板名
print(result['crop_path'])         # 裁剪图路径
print(result['checkpoints'])       # 检查项列表
```

#### 🔄 调用流程

```
1. 截图（同 vqa）
2. dump XML（同 ask_focus，走 D→A→C→E 降级链）
3. find_focus_from_xml → 获取焦点框 focus_rect [x,y,w,h]
   └─ 取焦点中心Y: focus_center_y = y + h // 2

4. extract_template_regions(root) → 从 XML 中提取所有模板区域
   └─ 遍历 RecyclerView 子节点，按 Y 坐标做分界
   └─ 返回 [{'name': '模板名', 'y1': 460, 'y2': 680, 'x1': 0, 'x2': 1920}, ...]

5. 找焦点所在区域
   └─ 遍历 regions：若 focus_center_y in [y1, y2)
   └─ 找到 → 取 matched_region
   └─ 没找到 → 找 Y 坐标最近的 region

6. PIL 裁剪
   └─ 以 matched_region 的 [x1-3, y1-3, x2+3, y2+10] 为裁剪矩形（+3/+10 留边距）
   └─ 保存为 focus_crop_{模板名}_{时间}.png

7. generate_checkpoints(crop_path)
   └─ 视觉模型分析裁剪图 → 自动生成 4~8 条检查项
   └─ 检查项类型：排版/海报/文本/焦点/特殊元素/边缘裁切

8. 返回完整结果 dict
```

**输出示例：**

```
[checkpoints_for_focus] 焦点在模板: 首屏4横图(播放角标)
[checkpoints_for_focus] 裁剪完成: D:\...\focus_crop_首屏4横图(播放角标)_20260716_183600.png (1920x200)
[GENERATE] ⏱️ 4500ms [glm-4v-flash]
[GENERATE] ✅ 生成 4 条检查项
```

---

## 3️⃣ 全自动检查

### ai.generate_checkpoints() — AI 自动生成检查项

```python
checks = ai.generate_checkpoints(r"D:\screenshots\clip_01.png",
                                  channel_hint="直播")
for c in checks:
    print(f"[{c['名称']}] {c['说明']}")
```

#### 🔄 调用流程

```
1. 检查图片路径是否有效
2. 图片压缩 → base64
3. 构建 system_prompt
   └─ 含频道上下文（"频道是直播"）
   └─ 含输出格式要求（JSON 数组，每项 {名称, 说明}）
   └─ 含检查项类型要求（排版/海报/文本/焦点/特殊元素/边缘裁切各至少一条）
   └─ 严禁输出除 JSON 以外的任何文字

4. 调用视觉模型 API
5. 解析 JSON 数组
   └─ 先尝试 json.loads 解析整个响应
   └─ 失败则正则提取第一个 [...] 数组
   └─ 仍未解析到 → 返回 []
6. 返回 List[Dict]，每项 {名称, 说明}
```

**输出示例：**

```
[GENERATE] ⏱️ 4200ms [glm-4v-flash]
[GENERATE] 生成结果:
[
  {"名称": "排版检查", "说明": "左侧6个竖图海报，中间播放窗口，右侧4个推荐坑位"},
  {"名称": "海报加载检查", "说明": "每个海报无黑图灰图，加载正常"},
  {"名称": "文本显示检查", "说明": "每个海报下方显示文字标签，无乱码"},
  {"名称": "右侧末尾坑位检查", "说明": "最后一个坑位显示默认图片有IPTV水印"}
]
[GENERATE] ✅ 生成 4 条检查项
```

---

### ai.auto_check() — 生成+检查一体化

```python
# 自动生成 + 自动检查
result = ai.auto_check(r"D:\screenshots\clip_01.png", channel_hint="直播")
print(f"通过 {result['通过']}/{result['通过'] + result['失败']}")

# 用已有检查项直接跑
result = ai.auto_check(img, checks=[{"名称": "排版", "说明": "布局无重叠"}])
```

#### 🔄 调用流程

```
1. 获取检查项
   └─ 有 checks 参数 → 直接用
   └─ 无 → 调 generate_checkpoints() 生成

2. 逐条 VQA 检查
   for each checkpoint:
     vqa(checkpoint['说明'], image=image)  ← 每项都调一次 AI
        ├─ 通过 → passed++
        └─ 不通过 → failed++

3. 汇总结果
   └─ 返回 {生成检查, 通过, 失败, 明细, 全部通过}
```

**输出示例：**

```
[auto_check] 正在生成检查项...
[GENERATE] ⏱️ 4200ms [glm-4v-flash] ✅ 生成 5 条检查项
[CHECK] ✓ 排版检查
[CHECK] ✓ 海报加载检查
[CHECK] ✗ 右侧末尾坑位检查
[auto_check] 完成: 4通过 / 1失败
```

---

### ai.check_template() — 从 checkpoints.json 逐条检查

```python
from engine.template_prompt_builder import TemplatePromptBuilder

# 前提：注册上下文
builder = TemplatePromptBuilder()
builder.load(r"D:\...\测试桩\GetInitMetaData_直播频道.json")
ai.load_context(builder, r"D:\...\screenshots\直播_clips")

# 一句话检查
result = ai.check_template("首屏4横图通栏模板")
print(f"通过 {result['通过']}/{result['通过'] + result['失败']}")
```

#### 🔄 调用流程

```
1. 获取 builder
   └─ 有 builder 参数 → 直接用
   └─ 无 → 取 self._ctx_builder（load_context 注册的）

2. get_checkpoint(template_name)
   └─ 从加载的测试桩 + checkpoints.json 中查找模板配置
   └─ 返回 {public_checks: [...], extra_checks: [...]} 或 None

3. 获取检查项列表
   └─ 有专属检查 → checks = public_checks + extra_checks
   └─ 无专属检查 → checks = public_checks 只跑公共检查

4. 获取裁剪图
   └─ 有 image 参数 → 直接用
   └─ 无 → _find_crop_by_template(template_name)
   └─      在 clips_dir 中按模板名匹配
   └─ 仍无 → 报错退出

5. 逐条 VQA（跳过"结果返回说明"）
   for each checkpoint:
     name = c['名称']
     desc = c['说明']
     result = vqa(desc, image, system_prompt=sp)
       ├─ ✅ → passed++
       └─ ❌ → failed++

6. 返回汇总 {通过, 失败, 全部通过, 明细}
```

**输出示例：**

```
[AI] 对模板「首屏4横图通栏模板」执行 5 条公共检查 + 4 条专属检查
[AI] 裁剪图: D:\...\screenshots\直播_clips\首屏4横图通栏模板.png
[CHECK] ✓ 排版正常
[CHECK] ✓ 坑位海报正常
[CHECK] ✓ 文本没有乱码
[CHECK] ✗ 坑位文本检查   ← 没找到"CCTV6"文本
[AI] 检查完成: 8通过 / 1失败
```

---

## 4️⃣ OCR 文字识别

### ai.ocr() — 全屏文字识别（含坐标）

```python
items = ai.ocr()
for item in items:
    print(f"[{item['x']},{item['y']}] {item['text']}")

items = ai.ocr(filter_text='首屏')       # 按文字筛选
items = ai.ocr(filter_pattern='版本\d.*')  # 按正则筛选
```

#### 🔄 调用流程

```
1. 获取截图（同 vqa：参数优先 → 自动截图降级链）
2. 图片压缩 → base64
3. 构建 OCR 专属 prompt
   └─ "你是电视大屏 UI 文字识别专家。识别截图中所有可见的文字……"
4. 调用视觉模型 API
5. 解析 JSON 数组
   └─ 同 generate_checkpoints 的 _parse_json_array
6. 应用筛选（filter_text / filter_pattern）
   └─ 不区分大小写（可配置 flag_case_sensitive）
7. 返回 [{'text', 'x', 'y', 'w', 'h'}, ...]
```

**输出示例：**

```
[OCR] 1160ms [glm-4v-flash]
[
  {"text": "精选", "x": 85, "y": 48, "w": 60, "h": 30},
  {"text": "首屏4横图通栏模板", "x": 50, "y": 310, "w": 300, "h": 36},
  {"text": "回看", "x": 120, "y": 410, "w": 50, "h": 28},
  {"text": "CCTV6", "x": 1100, "y": 410, "w": 70, "h": 28},
]
```

---

### ai.ocr_text() — 纯文字列表

```python
texts = ai.ocr_text()
print(texts)
# → ['精选', '首屏4横图通栏模板', '回看', 'CCTV6']

# 原理：调 ai.ocr() 后只提取 text 字段
# 即: [it.get('text', '') for it in self.ocr(image=image)]
```

---

### ai.ocr_exists() — 判断文字是否存在

```python
exists = ai.ocr_exists('首屏4横图通栏模板')   # → True / False

# 原理：调 ai.ocr(filter_text=text) 后判断 len(results) > 0
# 自身不调 API，复用 ocr() 的筛选功能
```

---

### ai.ocr_find() — 查找第一个匹配 + 中心坐标

```python
item = ai.ocr_find('电视剧')
if item:
    print(f"中心点: ({item['cx']}, {item['cy']})")   # 可直接用于点击
# → 中心点: (465, 78)

# 原理：
# 1. 调 ocr(filter_text=text) → results
# 2. 取 results[0]
# 3. 计算 cx = x + w//2, cy = y + h//2
# 4. 返回含 cx/cy 的 dict
```

---

### ai.ocr_find_regex() — 正则匹配第一个

```python
item = ai.ocr_find_regex('版本.*')

# 原理：同 ocr_find，但用 filter_pattern 而非 filter_text
# 即调 ai.ocr(filter_pattern=pattern)
```

---

## 5️⃣ 图片相似度对比

### ai.compare_images()

```python
score = ai.compare_images('before.png', 'after.png')
print(f"相似度: {score:.4f}")  # → 0.9218
```

#### 🔄 检测原理

```
本地计算，不调用任何 API！

1. 统一尺寸为 256x256 加速计算
2. pHash（感知哈希）— 权重 0.4
   └─ 灰度 → 缩至 16x16 → 算均值 → 与每位像素比较得 Hash 位
   └─ 汉明距离 → 归一化为 0-1
3. SSIM（结构相似度）— 权重 0.6
   └─ 计算灰度像素的均值 μ、方差 σ、协方差 σ_ab
   └─ SSIM = (2μ_aμ_b + C1)(2σ_ab + C2) / (μ_a²+μ_b²+C1)(σ_a+σ_b+C2)
4. 综合 = pHash * 0.4 + SSIM * 0.6
```

---

### ai.is_similar()

```python
if ai.is_similar('a.png', 'b.png', threshold=0.85):
    print("两张图基本一致")

# 原理：调 compare_images(score) >= threshold
```

---

### ai.compare_images_batch()

```python
pairs = [('a.png', 'b.png'), ('c.png', 'd.png')]
scores = ai.compare_images_batch(pairs)
# → [0.92, 0.78]

# 原理：for 循环调 compare_images
```

---

## 6️⃣ 纯文本推理

### ai.ask_text() — 非视觉模型文本问答

```python
analysis = ai.ask_text(
    "分析这个崩溃日志的根因", 
    model="agnes-2.5-flash",               # Thinking 模型
    system_prompt="你是一个Android崩溃分析专家",
    max_tokens=4096,
)
```

#### 🔄 调用流程

```
1. 解析模型配置（_resolve_model）
2. 构建 payload
   └─ messages: [system, user]  ← 无 image 字段

3. 如果模型是 agnes 系列，追加 thinking 参数
   └─ payload['thinking'] = {'type': 'enabled', 'budget_tokens': 4096}

4. 调用 API → 返回 content

5. 与视觉方法的关键区别
   ├─ 不需截图、不需图片压缩
   ├─ 不传 image_url
   ├─ system_prompt 独立于 user prompt
   └─ 支持 Thinking 模型的隐藏推理输出
```

**输出示例：**

```
[agnes-2.5-flash] 5380ms
崩溃根因：NullPointerException
堆栈：com.huawei.tvbox.MainActivity.onCreate(MainActivity.java:85)

推断：快捷入口的图片资源异步加载中，setImageBitmap(null) 触发 NPE。
修复建议：加载前判空，或在 XML 设置默认占位图。
```

---

## 7️⃣ 模板上下文

### ai.load_context() + ai.ask_template()

```python
from lib.ai_service import ai
from engine.template_prompt_builder import TemplatePromptBuilder

# 1. 注册上下文
builder = TemplatePromptBuilder()
builder.load(r"D:\...\测试桩\GetInitMetaData_直播频道.json")
ai.load_context(builder, r"D:\...\screenshots\直播_clips")

# 2. 一句话调用
result = ai.ask_template("描述这个模板的布局", "直播居中模版新")
print(result)
```

#### 🔄 调用流程

```
load_context():
  └─ ai._ctx_builder = builder      # 缓存 builder
  └─ ai._ctx_clips_dir = clips_dir  # 缓存裁剪目录

ask_template(question, template_name):
  1. 获取 builder（参数 / self._ctx_builder）
  2. 获取裁剪图
     ├─ 有 image 参数 → 直接用
     └─ 无 → _find_crop_by_template(template_name)
             └─ 在 clips_dir 中按模板名模糊匹配文件名
  3. 构建 system_prompt
     └─ builder.build_for_template(template_name)
     └─ 包含测试桩中模板的描述 + 历史检查点信息
  4. 调 ask() → 返回文本
```

---

### ai.vqa_template() — 模板上下文布尔判断

```python
# 一句话（推荐）
ok = ai.vqa_template("海报是否正常加载？", "首屏4横图通栏模板")
print(ok)  # → True

# 原理：与 ask_template 相同，但使用 vqa 而非 ask
# └─ builder.build_compact(template_name) → 构建精简提示词
# └─ vqa(question, image, system_prompt=sp) → 返回 bool
```

---

### ai.ask_channel() — 频道全量上下文

```python
result = ai.ask_channel("分析整个页面的布局", builder)

# 原理：
# └─ builder.build_for_channel() → 构建频道全量模板提示词
# └─ 包含所有模板的描述信息
# └─ 调 ask() → 返回文本
```

---

### ai.clear_context()

```python
ai.clear_context()
# 原理：将 _ctx_builder 和 _ctx_clips_dir 置为 None
```

---

## 8️⃣ 快捷方法

### ai.check_focus()

```python
result = ai.check_focus("首屏4横图通栏模板", card_index=0)
print(result)  # → True / False

# 原理：
# 1. card_desc = _card_desc(index) → "第一张卡片" / "第二张卡片" / ... 
# 2. 构建问题: f"当前焦点框是否在「{模板名}」的{第n张卡片}上？"
# 3. 调 vqa(question) → 返回 bool
# 本质是 vqa() 的便捷封装
```

---

### ai.count_templates()

```python
desc = ai.count_templates()
# → '1. 直播居中模版新（4个卡片）\n2. 首屏4横图通栏模板（4个卡片）\n3. 底部通栏（2个按钮）'

# 原理：调 ask("描述屏幕上所有模板区块和卡片数量，按从上到下列出")
```

---

## 9️⃣ 底层核心机制

### 截图降级链（_auto_screenshot）

```
1️⃣ adb_utils.screenshot(filename)
   ├─ 走 ADB 截图完整管道
   └─ 失败 → 兜底

2️⃣ adb shell screencap -p → pull → rm
   └─ 直接 adb 命令，不依赖 Python 库
```

### XML dump 降级链（dump_uiautomator）

```
D → Appium HTTP API page_source     ← 最稳定，不 fork 不 OOM
A → adb shell uiautomator dump --compressed  ← --compressed 减少内存
C → kill_stale_uiautomator + 5s冷却 + 重试A  ← 杀僵尸进程
E → uiautomator2 Python 库          ← 终极兜底

注：
  - kill_stale_uiautomator 逐行解析 ps，跳过 Appium 进程
  - 所有 shell 命令带 time_budget 参数防卡死
  - Appium session 自动扫描端口 4723-4730 并复用
```

### 图片压缩（_image_to_base64）

```
原始截图 (1920x1080, ~4MB PNG)
  → 缩放至 max_side=640px（长边640）
  → 转 JPEG quality=60
  → base64 (~200KB)
  → 最终传给 API 的 data URL
```

### API 调用（_call_model_api）

```
1. _resolve_model(model_name)
   └─ 从 MODELS 注册表读取: {api_url, api_key, name}
   └─ 未指定模型 → 用 DEFAULT_MODEL

2. urllib3 PoolManager Keep-Alive
   └─ maxsize=4, retries=0（重试手动控制）
   └─ 复用连接，避免每次 TLS 握手

3. 失败重试
   └─ 最多 2 次重试
   └─ 指数退避: 1s, 2s

4. 返回 {content, raw, elapsed_ms, model}
```

### 布尔值三级降级解析（_parse_bool_answer）

```
优先级 1️⃣ JSON 结构
  正则 \{... "result": true/false ...\}
  └─ 找到 → 直接返回 true/false

优先级 2️⃣ 假值关键词（先匹配假值，防假值包含真值词）
  没有 / 看不到 / 不存在 / false / no / 不是 ...
  └─ 匹配 → 返回 False

优先级 3️⃣ 真值关键词
  是 / 有 / 看到 / true / yes ...
  └─ 匹配 → 返回 True

优先级 4️⃣ 首单词判断
  "是"/"true"/"yes" → True
  "不是"/"false" → False

优先级 5️⃣ 全部失败 → 抛 ValueError
```

---

## 🔟 模型切换

| 模型名 | 类型 | 适用方法 |
|--------|------|---------|
| `"glm-4v-flash"` | 视觉+文本 | vqa / ask / ask_focus / OCR / check_template（默认） |
| `"LongCat-2.0"` | 视觉+文本 | 同上，可替代默认 |
| `"glm-4.7-flash"` | 纯文本 | ask_text（快速免费） |
| `"agnes-2.5-flash"` | 纯文本 Thinking | ask_text（深度推理） |

```python
ai.vqa("布局正常吗？", model="LongCat-2.0")
ai.ask_text("分析日志", model="agnes-2.5-flash")
```

---

## 1️⃣1️⃣ 命令行直接调用

```bash
py -3.9 -c "from lib.ai_service import ai; print(ai.vqa('屏幕有内容显示吗？'))"
py -3.9 -c "from lib.ai_service import ai; print(ai.ask('描述屏幕'))"
py -3.9 -c "from lib.ai_service import ai; print(ai.ocr_text())"
```

模块 CLI 入口：

```bash
py -3.9 -m lib.ai_service vqa "当前焦点在首屏4横图通栏模板上吗？"
py -3.9 -m lib.ai_service ask "描述屏幕上所有模板"
py -3.9 -m lib.ai_service check_focus "直播居中模版新" 0
```

---

## 1️⃣2️⃣ 参数速查

### vqa / vqa_template 参数

| 参数 | 类型 | 默认 | 说明 |
|------|------|------|------|
| `question` | `str` | **必填** | 布尔断言问题 |
| `image` | `str` | `None`（自动截图） | 截图路径 |
| `system_prompt` | `str` | `None`（内置） | 自定义系统提示词 |
| `timeout` | `int` | `60` | API 超时秒数 |
| `model` | `str` | `None`（默认模型） | 指定模型 |
| `mark_focus` | `bool` | `False` | 是否标记焦点框 |

### ask / ask_focus / ask_template 参数

| 参数 | 类型 | 默认 | 说明 |
|------|------|------|------|
| `question` | `str` | **必填** | 问题 |
| `image` | `str` | `None`（自动截图） | 截图路径 |
| `system_prompt` | `str` | `None`（内置） | 自定义提示词 |
| `temperature` | `float` | `0.2` | 回答随机性 |
| `max_tokens` | `int` | `1024` | 最大输出 token |
| `timeout` | `int` | `60` | API 超时 |
| `verbose` | `bool` | `True` | 是否打印日志 |
| `model` | `str` | `None` | 指定模型 |
| `mark_focus` | `bool` | `False` | 是否标记焦点框 |

### ocr 系列参数

| 参数 | 类型 | 默认 | 说明 |
|------|------|------|------|
| `image` | `str` | `None`（自动截图） | 截图路径 |
| `filter_text` | `str` | `None` | 筛选文本关键字 |
| `filter_pattern` | `str` | `None` | 筛选正则 |
| `flag_case_sensitive` | `bool` | `False` | 是否区分大小写 |
| `timeout` | `int` | `60` | API 超时 |

### 返回结构

```python
# check_template / auto_check
{
    '通过': int,
    '失败': int,
    '全部通过': bool,
    '明细': [{'名称': str, '说明': str, '结果': bool}],
}

# generate_checkpoints_for_focus
{
    'crop_path': str,          # 裁剪图路径
    'template_title': str,     # 模板标题
    'focus_rect': [x,y,w,h],   # 焦点框
    'template_bounds': dict,   # 模板边界
    'checkpoints': list,       # 检查项列表
}
# 失败时返回 {'error': '原因说明'}
```
