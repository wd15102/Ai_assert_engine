# 新增 Project 适配指南（以 河南移动 为例）

> 目标：从无到有新建 `IPTV_HNYD_69`，能够跑通一套现有的功能测试。

---

## 🧭 整体流程

```
                             已有 IPTV_HNYD_68（湖南移动模板）
                                     ↓
    ┌──────────────────────────────────────────────────────────────┐
    │  第 1 步：搭骨架（目录 + config.py + element.py）             │
    │  第 2 步：验证连接（adb + Appium 能拉起 APP）                │
    │  第 3 步：对象库适配（调 element.py 的 resource-id）          │
    │  第 4 步：proxy 代理 + 测试桩（MitmProxy / Charles）         │
    │  第 5 步：跑一个完整的 Suite 验证全链路                       │
    └──────────────────────────────────────────────────────────────┘
```

---

## 第 1 步：搭骨架

### 1.1 创建目录

```bash
mkdir IPTV_HNYD_69
cd IPTV_HNYD_69
mkdir 对象库
mkdir 测试用例\功能测试
mkdir 测试用例\数据上报
mkdir 测试桩
mkdir template
mkdir bak
```

### 1.2 复制公共文件

**IPTV 的公共 key 在根目录**（跨 project 共享），不用复制：

```
DP_AutoTest/                    ← 已存在（不重复建）
├── 遥控按键.robot              ← 共享，不复制
├── 系统方法.robot              ← 共享，不复制
├── TestLibrary/                ← 共享，不复制
```

**每个 project 自己独有的**：

```
IPTV_HNYD_69/
├── 对象库/                     ← 从 IPTV_HNYD_68 复制后改
│   ├── 公共方法.robot
│   ├── 首页.robot
│   ├── 点播.robot
│   ├── 搜索.robot
│   ├── 详情页.robot
│   ├── 等待相关.robot
│   ├── …（其他页面对象）
├── element.py                  ← 核心！每个 project 不同（页面 ID）
├── mock.py                     ← 从 IPTV_HNYD_68 复制（接口 Mock 数据）
├── 测试桩/                     ← 复制（JSON mock 数据）
├── 测试用例/功能测试/           ← 从 IPTV_HNYD_68 复制（用例可直接复用）
├── 测试用例/数据上报/           ← 从 IPTV_HNYD_68 复制
└── template/                   ← 截图模板目录（每个盒子要重新截）
```

### 1.3 修改 element.py

这是**最关键的一步**。

`element.py` 里所有 `resource-id` 都基于 `app_package` 动态生成：

```python
from config import project
from config import app_package
from config import plugin_apk

# 根据 project 名称自动切换运营商逻辑（不用改这个部分）
platform_name = 'Telecom' if 'hndx' in project.lower() else \
                'liantong' if 'hnlt' in project.lower() else \
                'yidong'

app_package1 = app_package if plugin_apk==0 else app_package+'.plugin'

# ⚠️ 下面这些才是你需要实际调试的：
# 每个 XPath / resource-id，得拿 APP 的 layout dump 验证
```

**核心逻辑**：`config.py` 里的 `app_package` + `resource-id` 拼出完整 ID，**河南移动的 `app_package` 大概率是 `com.mangotv.hnyd` 或类似**。

如果你不知道河南移动盒子的 `app_package`，用这个命令查：

```bash
# 连上盒子后
adb shell pm list packages | findstr "mango\|hunantv\|mgtv\|mangotv"
```

### 1.4 修改 config.py

在 `D:\WorkCode\DP\DP_AutoTest\config.py` 里追加一组配置：

```python
# ======== 河南移动 IPTV_HNYD_69 ========
project = 'IPTV_HNYD_69'
device_id = '192.168.43.1:5555'     # 你的盒子 IP
platform = 'LinuxAndroid8.1.0'       # 盒子 Android 版本
app_package = 'com.mangotv.hnyd'     # ⚠️ 以实际查到的为准
app_activity = '.MainActivity'
automationName = 'UiAutomator2'       # Android 8+ 可以用 u2
http_proxy = '192.168.43.140:8888'   # 你电脑的 IP + Charles/MitmProxy 端口
proxy_port = '8888'

check_server = 'http://10.200.8.114:80'  # 校验服务（同上内网）
mock_server = 'http://10.1.172.175'      # Mock 服务
database = 'root:password@172.31.111.88:3306/devices'
```

```python
# 【关键】注释掉其他 project 的 case_path 配置，保留河南移动
case_path = [os.path.join(root_path, project, '测试用例', '功能测试')]
```

---

## 第 2 步：验证连接

在 `config.py` 只保留河南移动配置后：

### 2.1 ADB 连通

```bash
adb connect 192.168.43.1:5555   # 连接盒子
adb devices                     # 能看到设备即为 OK
adb shell dumpsys window windows | findstr "mCurrentFocus"   # 确认 APP 包名
```

### 2.2 拉起 APP

修改**公共方法.robot 里的 `启动应用`** 部分 —— 实际上不需要改，它已经用 `config.py` 的配置工作了。

直接跑一个最简单的用例验证：

```bash
python case_run.py IPTV_HNYD_69 case001
```

如果报 `element not found` → 说明 `element.py` 的 `resource-id` 和实际 APP 不匹配。

### 2.3 拿 Layout Dump 校准 resource-id

```bash
# 在盒子 APP 界面，用 uiautomator dump 拿到控件树
adb shell uiautomator dump /sdcard/ui.xml
adb pull /sdcard/ui.xml temp_hnyd_ui.xml
```

打开 `temp_hnyd_ui.xml` 看每个控件的 `resource-id`，和 `element.py` 里的对照修正。比如：

```xml
<node index="0" text="精选" resource-id="com.mangotv.hnyd:id/channel_tabs" ...>
```

那么 `element.py` 里 `导航栏 = app_package1 + ':id/channel_tabs'` 就是对的。如果盒子的 `app_package` 不一样 → 算出来 `com.other:id/channel_tabs` → 就找不到了，改成盒子的真实包名。

---

## 第 3 步：适配 element.py（最花时间）

### 3.1 准备工具

推荐安装 **Appium Inspector** 或直接用 **UiAutomator Viewer**（Android SDK 自带），连上盒子后逐页截图 + 看控件属性。

### 3.2 比对差异

拿 `element.py` 里出现的每个 ID 去 `ui.xml` 里搜一遍。典型的差异场景：

| 场景 | 湖南移动 | 河南移动怎么调 |
|------|---------|-------------|
| 包名不同 | `com.hunantv.yidong:id/xxx` | 改成 `com.mangotv.hnyd:id/xxx` |
| 首页导航栏 ID 不同 | `tab` / `channel_tabs` | 查 dump 改 |
| 搜索入口不同 | ImageView 含 `content-desc="搜索"` | 大多数一样（模板代码） |
| 播放器 UI 不同 | `player_view` / `video_view` | 查 dump 改 |
| 设置密码弹窗 | `请输入设置密码` 文本 | 查 dump |

### 3.3 懒人方案

河南移动和湖南移动大概率**同一套 Launcher UI**，最省力的办法是：

1. `adb shell dumpsys package com.mangotv.hnyd | findstr "versionName"` 记下版本
2. 看看有没有已经测试过的**其他省移动盒子**（比如 `IPTV_YNYD` 云南移动）
3. `element.py` 的 `platform_name = 'yidong'` 分支已经处理了运营商标识相关的逻辑差异
4. 实际跑起来，等报 `element not found` → 逐个修 ID

---

## 第 4 步：Proxy 代理 + 测试桩

### 4.1 Charles/MitmProxy 配置

**确认电脑和盒子在同一局域网**：

```bash
# 电脑 IP
ipconfig | findstr "IPv4"   # 记下 192.168.x.x

# 盒子设置代理（adb 远程设置）
adb shell settings put global http_proxy 192.168.43.140:8888
```

### 4.2 测试桩适配

- `mock.py`：从 `IPTV_HNYD_68` 复制（接口 Mock 数据是通用的）
- `测试桩/`：从 `IPTV_HNYD_68` 复制
- 如果有河南移动特有的接口（比如计费接口不同），需要新增测试桩

### 4.3 校验服务

河南移动的 CHECK_SERVER 接口域名和湖南移动同一套（内网），所以**确认 `config.py` 里的 `check_server` / `database` 能 ping 通即可**。

---

## 第 5 步：跑完整 Suite 验证

### 5.1 冒烟验证

选 3 个覆盖主要路径的用例：

```bash
# 1. 首页加载 + 导航
case_run.py IPTV_HNYD_69 case001,case005,case010

# 2. 点播播放 + 返回
# 从 OTT 找一个播放用例复制过来匹配 IPTV 路径

# 3. 数据上报（如果有校验服务）
case_run.py IPTV_HNYD_69 case001,case002 （数据上报目录的）
```

### 5.2 全量跑

```bash
python start.py
```

第一次全量预计会挂 **20%~50%**，每个挂的用例去看：

| 错误 | 原因 | 修什么 |
|------|------|--------|
| `Element not found` | resource-id 不匹配 | 修 `element.py` |
| `图片校验失败` | 模板图不对（分辨率/UI 不同） | 重新截图放 `template/` |
| `校验服务接口返回错误` | `check_server` 不可达 | 确认网络 |
| `TimeoutException` | APP 加载慢或弹窗盖住了 | 调大 `wait until page contains element` 的超时 |
| `校验结果 条数错误` | 数据上报没命中 | 确认代理和校验服务器 |

几个常见坑：

- **弹窗覆盖**：盒子首次启动可能有「用户协议」「青少年模式」「升级弹窗」，`公共方法.robot` 的 `启动应用` 已经处理了「同意」按钮，但省份定制版弹窗内容不同时需加 handler
- **焦点位置差异**：每个盒子的 D-Pad 导航列数不同（如 3 列 vs 6 列），`按次数下移 N` 可能移到不对的地方，需调用例里的次数

### 5.3 模板截图

`校验元素图片是否正确` 断言需要 `template/xxx.png`：

```bash
# 手动在盒子上操作到目标界面
# 用 Appium 截图
# 用 Python 脚本裁剪出元素区域，另存为 template/{name}.png
# 也可以通过 image_process.py 里的自动更新逻辑（在 check_image_similarity 里开启）
```

---

## 🎯 产出物清单

```
IPTV_HNYD_69/
├── 对象库/
│   ├── 公共方法.robot    ← 从 HNYD_68 复制（一般不需要改）
│   ├── 首页.robot        ← 从 HNYD_68 复制
│   ├── 点播.robot        ← 从 HNYD_68 复制
│   ├── 搜索.robot        ← 从 HNYD_68 复制
│   ├── 详情页.robot      ← 从 HNYD_68 复制
│   └── 等待相关.robot    ← 从 HNYD_68 复制
├── 测试用例/
│   ├── 功能测试/         ← 从 HNYD_68 复制
│   └── 数据上报/         ← 从 HNYD_68 复制
├── 测试桩/               ← 从 HNYD_68 复制
├── template/             ← ✨ 新建，放截图模板
├── element.py            ← ✨ 新建，资源 ID 定义
└── mock.py               ← 从 HNYD_68 复制

config.py                 ← 添加 IPTV_HNYD_69 配置段
```

---

## ⏱ 预估时间

| 步骤 | 新手 | 熟悉后 |
|------|------|--------|
| 搭骨架 | 15 min | 3 min |
| element.py 适配 | 2-4 h | 30 min |
| 冒烟通过 | 2-4 h | 1 h |
| 全量 70% pass | 1-2 d | 半天 |
| template 截图补齐 | 半天-1天 | 2 h |
| **总计** | **3-5 天** | **1 天** |
