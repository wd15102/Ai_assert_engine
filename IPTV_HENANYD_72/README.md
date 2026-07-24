# DP_AutoTest — 大屏/IPTV/OTT 自动化测试平台

> 芒果 TV 大屏端（IPTV / OTT / OS）端到端自动化测试项目，基于 **Robot Framework + Appium + Python**，通过 **ADB + 遥控器键码模拟** 控制机顶盒，覆盖 **功能测试、数据上报校验、Monkey 稳定性、Charles/MitmProxy 接口 Mock、OCR 图像识别** 等维度。

---

## 1. 项目用途

解决大屏端（机顶盒/智能电视）以下测试痛点：

| 痛点 | 本项目的方案 |
|------|------------|
| 遥控器交互无法用鼠标/触屏脚本化 | 基于 Appium `Press Keycode` 封装整套遥控器按键关键字 |
| 多厂商盒子型号碎片化（湖南电信/移动/联通/江西/云南/越南…） | 同一套用例，**多 project 并行**，靠 `config.py` 切换 |
| 数据上报正确性难以自动校验 | 通过 **MitmProxy + Charles** 拦截上报请求，对接自研数据校验平台 `check_server` |
| 稳定性 / 性能数据无人收集 | `info_collect` 后台线程持续采 CPU、内存、流量、Logcat |
| 重复执行需要产出报告并邮件推送 | Robot Framework `rebot` 合并 + 自动发邮件 + `mail.py` 渲染 |
| 焦点管理特殊（电视端无鼠标） | `AndroidTVFocus.py` 独立处理 D-Pad 焦点、扫一扫焦点、悬浮焦点 |

---

## 2. 功能模块

### 2.1 核心入口
- **`start.py`** — 多设备并行调度主入口（推荐用这个）
  - 自动发现 `adb` 设备 → 为每台设备随机分配 Appium/Proxy 端口 → 多进程跑用例 → 多线程合并 report → 发邮件
  - 支持 **失败用例重试、套件重试、进程超时监控**（防止 Robot 进程假死）
  - `Retry = N` 配置重试次数
- **`case_run.py`** — 旧版单设备入口（保留，向后兼容）

### 2.2 公共关键字库（`/遥控按键.robot`、`/系统方法.robot`）
- 完整封装 **遥控器所有按键**（上下左右/确认/返回/数字 0-9/红绿黄蓝/F1-F4/快进快退/暂停/搜索…）
- 封装数据上报校验（`获取校验结果`、`获取校验结果_不上报`、`获取校验结果_数量校验`）

### 2.3 业务模块（按运营商 × 版本号目录组织）

| 业务线 | 目录示例 | 说明 |
|--------|---------|------|
| 湖南电信 IPTV | `IPTV_HNDX` / `IPTV_HNDX_54` / `IPTV_HNDX_55` | 湖南电信各版本 |
| 湖南移动 IPTV | `IPTV_HNYD_60 ~ 68` | 湖南移动各迭代版本 |
| 湖南联通 IPTV | `IPTV_HNLT_64` | 湖南联通 |
| 江西 IPTV | `IPTV_JX_69 ~ 80` | 江西各版本 |
| 云南移动 | `IPTV_YNYD` | 云南移动 |
| J-HAPP | `IPTV_JHAPP` | 极简版 |
| 辽宁移动 | `LNYD` | 辽宁移动 |
| OS（自有系统） | `OS` | 芒果 TV OS 桌面 |
| OTT 业务 | `OTT_629 ~ OTT_703` | 芒果 TV OTT 大屏客户端各版本 |

每个业务目录下标准结构：

```
<项目名>/
├── 测试用例/        # Robot Framework .robot 用例集
│   ├── 功能测试/    # UI/业务功能
│   └── 数据上报/    # 数据埋点校验
├── 对象库/          # 页面元素定义（element.py / mock.py / getconfig.py / charlesconfig.py）
├── 测试桩/          # Mock 接口返回的 JSON 数据
├── 媒资巡检/        # 部分项目含（媒资类专项测试）
├── template/        # 模板
└── bak/             # 备份
```

### 2.4 TestLibrary（核心 Python 测试库）

| 模块 | 职责 |
|------|------|
| `AdbUtils.py` | ADB 封装（设备管理、截图、按键、日志、文件传输、App 安装/卸载） |
| `appium_server.py` | Appium Server 启停与端口管理 |
| `HttpProxy.py` | MitmProxy 拦截/HTTP 代理 |
| `charles.py` | Charles 代理集成（录制/回放/Map Local/Throttle） |
| `AndroidTVFocus.py` | 大屏焦点管理（专用） |
| `image_process.py` | OpenCV 图像识别（基于 OpenCV + PaddleOCR） |
| `paddleocr` | OCR 文字识别（用于截图后文字比对） |
| `auto_upgrade.py` | 自动化 OTA 升级测试（pkg_url 轮询） |
| `info_collect.py` | 性能/流量/Logcat 后台采集 |
| `ott_monkey.py` | OTT Monkey 稳定性测试 |
| `mail.py` | 测试报告邮件推送（带图表） |
| `models.py` / `connect_mysql.py` | SQLAlchemy + PyMySQL 设备库 |
| `IPTV/IPTV/` | Scrapy 爬虫：采集 IPTV 媒资/设备信息 |
| `RobotUpdate/` | 用例/结果自动上传（Gerrit 更新） |
| `log.py` / `utils.py` / `common.py` | 通用工具 |

### 2.5 测试类型（`config.py` 中 `test_type` 切换）
- `0` — 功能测试（默认）
- `1` — Monkey 稳定性
- `2` — 性能测试

---

## 3. 项目结构

```
DP_AutoTest/
├── start.py                # 多设备并行主入口（推荐）
├── case_run.py             # 单设备入口
├── config.py               # 全局配置（按 project 注释切换）
├── 系统方法.robot           # 公共关键字（数据校验、APP 启动…）
├── 遥控按键.robot           # 遥控器按键封装
├── venv/                   # Python 2.7 虚拟环境 ⚠️ 见下方环境说明
├── tools/windows/          # 自带 ADB（adb.exe + AdbWinApi.dll）
├── TestLibrary/            # 核心 Python 测试库
├── Package/                # 待测 APK 存放目录
├── Result/                 # 测试报告输出（按时间戳分目录）
├── IPTV_*/ OTT_*/ OS/      # 各业务线用例与对象库
├── .git/ .idea/            # 版本控制 / IDE 配置
└── all_log.txt appium.log  # 运行时日志
```

---

## 4. 核心配置（`config.py`）

切换 project 时只改 `config.py` 顶部的几行即可，文件里已经预置了 **湖南电信/湖南移动/湖南联通/江西/越南/OTT/OS** 7 套模板，按需取消注释。

**关键参数：**

```python
project = 'IPTV_HNYD_722'         # 业务线名（与目录名一致）
device_id = '192.168.43.1:5555'   # ADB 设备序列（可 IP:端口 / USB 序列号）
platform = 'LinuxUAndroid4.4.2...' # Appium 平台描述
app_package = 'com.hunantv.operator'
app_activity = 'com.fonsview.mangotv.MainActivity'
automationName = 'UiAutomator1'
http_proxy = '192.168.43.140:8888' # Charles/MitmProxy 代理
check_server = 'http://10.200.8.114:80'  # 数据校验服务
mock_server = 'http://10.1.172.175'      # Mock 服务
database = 'root:!%40%23123qwe@172.31.111.88:3306/devices'  # 设备库

# 自动化控制开关
auto_install = 0        # 0 不更新 / 1 全自动更新 / 2 指定 url 更新
test_type = 0           # 0 功能 / 1 monkey / 2 性能
Retry = 0               # 失败用例重试次数
run_time = 12           # 单次执行最长小时数
reconnet = 0            # 是否启动前重启连接设备
proxy_reset = 0         # 是否启动前重置代理数据
force_reboot = 0        # 是否强制重启盒子
force_home = 0          # 是否启动时强制回首页

# 邮件
mail_host = 'mx.mgpost.imgo.tv'
sender = 'autotest@mgpost.imgo.tv'
receivers = ['zhangzhuo@mgtv.com', 'chengyuan@mgtv.com']
```

---

## 5. 外部依赖

- **Android SDK / platform-tools**（自带于 `tools/windows/adb.exe`，可单独用）
- **Appium Server**（含 UiAutomator1/Uiautomator2 driver）
- **Charles** 或 **MitmProxy**（用于接口抓包与 Mock）
- **机顶盒/电视**（Android 4.4.2 ~ 8.1.0，主流厂商：M301A、B860AV、MGV2000、nunai-box、nunai_max 等）
- **数据校验服务**（`check_server`）和 **Mock 服务**（`mock_server`） — 内部平台
- **MySQL**（设备库）— 内网地址
- **邮件服务器** — `mx.mgpost.imgo.tv`

---

## 6. 典型执行流程

```bash
# 1. 激活虚拟环境
.\venv\Scripts\activate     # Win PowerShell
source venv/bin/activate    # Linux

# 2. 连接机顶盒（USB 或 ADB over TCP/IP）
adb connect 192.168.43.1:5555
adb devices

# 3. 编辑 config.py 选好 project，注释掉其它

# 4. 启动 Appium Server（也可让 start.py 自动启）
appium -p 4723

# 5. 运行测试
python start.py            # 多设备自动跑
# 或
python case_run.py <project> <case1,case2>   # 指定 project + 用例
```

---

## 7. 维护提示

1. **目录命名硬编码**：`config.py` 里的 `case_path` 默认指向 `E:\Users\admin\PycharmProjects\DP_AutoTest\...`，**移到新机器必须改成当前路径**（D 盘 / Linux 路径都要改）。
2. **`start.py` 末尾的 `main(...)` 会执行两次**：第一次全量跑，第二次基于上一次的 `output.xml` 跑失败用例（自动重试）。不需要可以删一行。
3. **`venv/` 是 Py2.7 残骸**：新机器请直接用 `requirements.txt` 重建。
4. **邮件密码是明文**：`mail_pass = '43zzERmMqk3LQvY'` 直接写在 `config.py` 里，注意保密。
5. **`TestLibrary/connect_mysql.py` 含内网数据库密码**，不要外发。
6. **大文件**：根目录有 `all_log.txt`（30MB+）、`appium_4723.log`（10MB+）等历史日志，记得定期清空。

---

## 8. License

内部项目，版权归芒果 TV 所有。
