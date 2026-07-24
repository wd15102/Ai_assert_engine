# 公共方法 API 文档

> **位置**: `common_event/公共方法/公共方法.py`  
> **导入**: `from 公共方法.公共方法 import 公共方法`

---

## 快速示例

```python
from 公共方法 import 公共方法
from lib.ai_service import ai

k = 公共方法()
k.启动()  # 1. 启动 Appium Session
k.导航到频道("直播")  # 2. 导航到频道（自动加载测试桩）
k.逐模板裁剪()  # 3. 逐模板截图裁剪

# 4. AI 验证
k.验证排版()  # 排版正常？
k.验证海报正常()  # 海报已加载？
k.验证文字无乱码()  # 文字无乱码？

# 5. 或直接用 ai 单例问任意问题
re = ai.vqa_template("左侧6个坑位海报都正常吗？", "直播居中模版新")

k.关闭()  # 6. 关闭 Session
```

---

## 一、Session 管理

### `启动() -> 公共方法`
启动 Appium Session（自动链式返回）。
```python
k.启动()
k.启动().导航到频道("直播")   # 链式调用
```

### `关闭()`
关闭 Appium Session。
```python
k.关闭()
```

---

## 二、导航关键字

### `复位到首页(wait=1.5) -> 公共方法`
HOME 键两次回到推荐频道。
```python
k.复位到首页()      # 回到推荐频道
k.复位到首页(2.0)   # 自定义等待时间
```

### `导航到频道(title: str) -> 公共方法`
从当前频道导航到指定频道，**自动加载匹配的测试桩**。
```python
k.导航到频道("直播")
k.导航到频道("精选")
k.导航到频道("电视剧")
```
> 内部自动调 `stub.find_channel_stub` 匹配测试桩，`TemplatePromptBuilder` 通过 `ai.load_context(builder)` 注入 ai 单例。

---

## 三、测试桩关键字

### `加载测试桩(channel: dict) -> 公共方法`
手动加载频道测试桩（channel 来自 `stub.get_channel_list()`）。
```python
from lib import stub_parser as stub
channels = stub.get_channel_list()
k.加载测试桩(channels[0])
```

### `配置测试桩(stub_path: str) -> 公共方法`
直接指定测试桩 JSON 文件路径加载。
```python
k.配置测试桩("测试桩/GetInitMetaData_直播频道.json")
```

---

## 四、裁剪关键字

### `逐模板裁剪(channel_title: str = "") -> 公共方法`
逐模板截图 + 裁剪，结果缓存到 `self._blocks`。  
**之后 `ai.vqa_template` 会自动从裁剪目录匹配图片。**
```python
k.逐模板裁剪()          # 自动用已加载的频道名
k.逐模板裁剪("直播")    # 或手动指定频道名
```

### `打印裁剪清单() -> 公共方法`
打印所有裁剪图的路径、坐标、卡片数。
```python
k.打印裁剪清单()
# 输出：
# Block#0 (Y=41-343, 4卡片): 直播_首屏4横图通栏模板.png (128KB)
# Block#1 (Y=403-840, 6卡片): 直播_3.18首屏4横图通栏模板.png (256KB)
```

---

## 五、AI 验证关键字

所有验证方法都支持两种定位方式：
- `template_name` — 按模板名称精确匹配
- `block_index` — 按裁剪块索引（0 起）

不传则使用最后一个裁剪块。

### `验证排版(template_name="", block_index=None) -> bool`
排版正常 + 海报完整 + 文字无乱码？三者合一检查。
```python
k.验证排版("直播居中模版新")          # 按模板名
k.验证排版(block_index=0)             # 按索引
k.验证排版()                           # 最后一个块
```

### `验证海报正常(template_name="", block_index=None) -> bool`
所有海报已加载，无白块灰块。
```python
k.验证海报正常("首屏4横图通栏模板")
```

### `验证文字无乱码(template_name="", block_index=None) -> bool`
标题/描述文字显示完整，无乱码方框问号。
```python
k.验证文字无乱码(block_index=0)
```

### `验证焦点到位(template_name="", block_index=None) -> bool`
焦点框是否在该模板的第一个卡片上。
```python
k.验证焦点到位("直播居中模版新")
```

### `详细分析异常(template_name="", block_index=None) -> str`
列出截图与预期不符的所有异常点，**返回文字描述**（非 bool）。
```python
detail = k.详细分析异常("首屏4横图通栏模板")
print(detail)  # '图片左侧第二张海报为黑色加载失败...'
```

### `通用视觉问答(question: str, block_index=None) -> str`
对裁剪图提任意问题，**返回文字回答**。
```python
resp = k.通用视觉问答("描述这个模板的布局")
```

### `裸问AI(question: str, block_index=None) -> bool`
纯 VQA 问答，问任意 yes/no 问题，**返回 bool**。
```python
ok = k.裸问AI("顶部是否有导航菜单？")
```

---

## 六、按键关键字

### `按键(key: str, times=1, wait=0.5) -> 公共方法`
模拟遥控器按键。
```python
k.按键("down", times=7)       # 向下按7次
k.按键("up")                  # 向上
k.按键("left")                # 向左
k.按键("right")               # 向右
k.按键("enter")               # 确认
k.按键("ok")                  # 同 enter
k.按键("back")                # 返回
k.按键("home")                # 主页
k.按键("menu")                # 菜单
# 也支持 Android keycode: k.按键("KEYCODE_MEDIA_PLAY")
```

---

## 七、属性

| 属性 | 类型 | 说明 |
|------|------|------|
| `k.blocks` | `list[dict]` | 裁剪结果列表，每个 dict 含 `crop_path`, `y_start`, `y_end`, `sort`, `card_count` |
| `k.模板数` | `int` | 当前频道测试桩中的模板数量 |
| `k.裁剪块数` | `int` | 已成功裁剪到的块数量（裁剪后可用） |

```python
if k.裁剪块数 > 0:
    print(f"共裁剪到 {k.裁剪块数} 个模板，测试桩有 {k.模板数} 个模板")
```

---

## 八、配合 ai 单例（推荐用法）

`ai` 是全局单例，**不依赖 公共方法**，可以直接在用例中调用。

```python
from lib.ai_service import ai

# 前提：已调过 k.导航到频道("直播") + k.逐模板裁剪("直播")
# 这两步自动把 builder + 裁剪目录注册到了 ai 上下文

# ✅ 一句话问模板
re = ai.vqa_template("左右两侧海报是否加载正常？", "直播居中模版新")

# ✅ 多问几个不同的点
re1 = ai.vqa_template("中间区域显示直播画面或'正在播放CCTV1'标识吗？", "直播居中模版新")
re2 = ai.vqa_template("所有海报都已正常加载？没有白块灰块？", "直播居中模版新")

# ✅ 开放式回答
desc = ai.ask_template("描述这个模板的布局和卡片内容", "直播居中模版新")
```

### `ai.vqa_template` 支持三种传参方式

```python
# 1. 一句话（推荐）
ai.vqa_template("海报正常吗？", "直播居中模版新")

# 2. 传统：builder + template_name 分开
ai.vqa_template("海报正常吗？", builder, "直播居中模版新")

# 3. 只传关键字（需先注册上下文）
ai.vqa_template("海报正常吗？", template_name="直播居中模版新")
```

### `ai` 单例其他方法

| 方法 | 说明 |
|------|------|
| `ai.vqa("问题")` | 自动截图 → bool |
| `ai.vqa("问题", image="路径")` | 指定截图 → bool |
| `ai.ask("问题")` | 自动截图 → 文字回答 |
| `ai.vqa_batch(["q1","q2"])` | 一张图问多个问题 → [bool, bool] |
| `ai.ocr(image="路径")` | OCR 识别 → 文字+坐标列表 |
| `ai.ocr_exists("文字")` | 检查文字是否存在 → bool |
| `ai.compare_images("图1","图2")` | 相似度 0~1 |
| `ai.is_similar("图1","图2", threshold=0.85)` | 是否相似 → bool |
| `ai.load_context(builder, clips_dir="")` | 注册上下文（公共方法自动做，一般不手动调） |

---

## 九、完整用例模板

```python
# testsuites/test_直播频道.py

from 公共方法 import 公共方法
from lib.ai_service import ai
from lib.logger import log


def test_直播频道_所有模块排版正常():
    k = 公共方法()
    try:
        k.启动()
        k.导航到频道("直播")
        k.逐模板裁剪()

        # 方式 A：用公共方法的验证关键字
        assert k.验证排版(block_index=0)
        assert k.验证海报正常(block_index=0)

        # 方式 B：直接用 ai 单例
        assert ai.vqa_template("左右两侧海报正常？", "直播居中模版新")

        log("测试通过", "DONE")
    except AssertionError as e:
        log(f"测试失败: {e}", "ERROR")
        raise
    finally:
        k.关闭()
```
