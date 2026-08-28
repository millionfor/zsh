# ⚡ Modern Zsh Configuration Framework

一个模块化、轻量级、跨平台的 Zsh 配置环境，针对 **macOS** 与 **Debian 12 / Ubuntu** 进行了深度优化与环境隔离。

---

## 🚀 快速开始 / 一键安装

### 方式 1：在线一键安装（推荐）

直接在终端执行以下指令即可自动完成依赖安装、环境配置与 Shell 切换：

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/millionfor/zsh/main/install.sh)"
```

### 方式 2：本地克隆安装

克隆仓库到本地并执行一键安装脚本：

```bash
git clone https://github.com/millionfor/zsh.git ~/.config/zsh
cd ~/.config/zsh
./install.sh
```

> **提示**：安装完成后，执行 `exec zsh` 或重启终端即可立即体验。

---

## 🔒 个人私有配置与密钥管理 (`QuanQuan.rc`)

为了彻底杜绝个人 API Key、Token 及私有环境变量在 Git 提交中意外泄露：

- 安装时会自动在项目根目录下创建 **`~/.config/zsh/QuanQuan.rc`**。
- 该文件已被严格写入 `.gitignore`，**永远不会被 Git 提交或上传**。
- 每次启动 Zsh 时，`init.zsh` 都会自动检测并加载 `QuanQuan.rc`。

### 如何配置？
安装完成后，直接编辑 `QuanQuan.rc`：

```bash
vim ~/.config/zsh/QuanQuan.rc
```

填入您的私有密钥和环境变量即可（修改后执行 `exec zsh` 生效）：

```bash
# AI API Keys
export OPENAI_API_KEY="sk-..."
export OPENAI_BASE_URL="https://api.openai.com/v1"
export DEEPSEEK_API_KEY="sk-..."
export ANTHROPIC_API_KEY="sk-..."
export ANTHROPIC_BASE_URL="https://api-slb.micuapi.ai"

# Git Tokens
export GITHUB_TOKEN="github_pat_..."
export GITLAB_TOKEN="glpat-..."

# 本地个性化环境变量
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"
```

---

## 📂 模块化目录架构

针对 macOS 和 Linux 进行了明确的独立分离，确保配置干净高效，互不干扰：

```
.config/zsh/
├── install.sh                  # 跨平台一键安装脚本 (macOS / Debian 12)
├── init.zsh                    # 核心启动入口 (平台探测与自适应加载)
├── QuanQuan.rc.example         # 私密配置模板参考
├── QuanQuan.rc                 # [本地生成] 个人私密配置 (已加入 .gitignore，永不上传)
├── .gitignore                  # Git 忽略规则
├── README.md                   # 说明文档
├── config/
│   ├── alias.zsh               # 通用快捷别名与函数 (跨平台)
│   ├── docker.zsh              # Docker 快捷指令
│   ├── exports.zsh             # 通用环境变量与色彩定义
│   ├── fzf.zsh                 # FZF 模糊搜索与 fzf-tab 补全配置
│   ├── git.zsh                 # Git 快捷操作与美化日志
│   ├── h.zsh                   # 交互式帮助菜单 (h, h zsh, h git...)
│   ├── hook.zsh                # 终端标题与工作目录 Hook
│   ├── omz.zsh                 # 核心插件加载器
│   ├── pm2.zsh                 # PM2 进程管理快捷指令
│   ├── port-tool.zsh           # 跨平台端口查看与智能杀死工具
│   ├── ssh.zsh                 # SSH 快捷连接别名
│   ├── volta.zsh               # Volta Node.js 版本管理封装
│   │
│   ├── macos/                  # 🍎 macOS 专属配置 (仅在 macOS 下加载)
│   │   ├── alias.zsh           # macOS 应用快捷方式、代理切换、DNS刷新、剪贴板
│   │   ├── iterm2.zsh          # iTerm2 与 AppleScript 自动化窗口控制
│   │   ├── workspace.zsh       # macOS 个人工作区与路径快捷跳转
│   │   └── env.zsh             # Homebrew 与 macOS 环境变量
│   │
│   └── linux/                  # 🐧 Linux / Debian 专属配置 (仅在 Linux 下加载)
│       ├── alias.zsh           # Debian 常用目录、APT 快捷指令、Systemd 别名
│       └── env.zsh             # Linux PATH 与默认编辑器设置
│
├── lib/
│   ├── file_preview.sh         # FZF 文件预览处理脚本 (兼容 eza/exa/bat/batcat)
│   └── omz.sh                  # Oh-My-Zsh 核心精简库
│
├── plugins/                    # 内置高性能插件集
│   ├── extract/                # 通用一键智能解压插件
│   ├── fzf-tab/                # Tab 补全菜单替换为 FZF
│   ├── fzf-sshscp-example/     # FZF 交互式 SSH/SCP 连接选择器
│   ├── z.lua/                  # 高性能智能目录跳转
│   ├── zsh-autosuggestions/    # 历史命令自动补全建议
│   └── zsh-syntax-highlighting/# 终端命令实时语法高亮
│
└── themes/
    ├── default.zsh-theme       # 跨平台自适应主题 (动态识别 macOS / Debian)
    └── macOSM4.zsh-theme       # macOS 专属定制主题
```

---

## ✨ 核心特性

### 1. 跨平台自适应与深度隔离
- **macOS**：自动加载 `config/macos/` 下的所有配置，包含 iTerm2 自动化脚本（`t`, `tt`, `qsm`, `vuec`）、Sublime/VSCode 打开、macOS 代理切换、`cldns`、`macc` 等。
- **Debian 12 / Linux**：自动加载 `config/linux/`，包含 APT 别名（`update`, `install`）、Systemd 服务管理（`sc-status`, `sc-restart`）、`qq` 等。
- 自动适配工具差异：Debian 下的 `batcat` / `fdfind` 与 macOS 下的 `bat` / `fd` 自动映射与无缝回退。

### 2. 交互式帮助菜单 (`h`)
随时在终端输入 `h` 查看分类快捷键指南：
- `h` - 显示所有快捷键
- `h zsh` - 查看 Zsh 快捷键
- `h git` - 查看 Git 别名与快捷指令
- `h docker` - 查看 Docker 容器与镜像快捷指令
- `h nvim` - 查看 Neovim 快捷键

### 3. 智能端口管理 (`port`)
支持 macOS 与 Linux 的跨平台端口管理：
```bash
port list       # 列出所有监听端口与服务路径
port list 3000  # 查看特定端口占用
port find node  # 根据进程关键字查找端口
port kill 3000  # 智能杀死占用 3000 端口的进程或指定 PID
```

### 4. 强大的插件集成
1. **z.lua**：按使用频率快速跳转目录（例如 `z zsh` 直接跳到 `~/.config/zsh`）。
2. **extract**：一键智能解压任意压缩包（支持 zip, tar.gz, bz2, 7z, deb 等）：`ex archive.tar.gz` 或 `x file.zip`。
3. **fzf-tab**：按下 `<Tab>` 时自动展开 fzf 交互式菜单并支持文件内容/进程状态实时预览。
4. **zsh-autosuggestions**：自动给出灰色历史建议，按 `→` 键即可应用。
5. **zsh-syntax-highlighting**：正确的命令绿色高亮，错误命令红色标记。
6. **fzf-ssh**：输入 `ssh` 或 `scp` 时，自动解析 `~/.ssh/config` 并提供交互式菜单选择。

---

## 🛠️ 常用别名速查

### 通用别名
| 指令 | 说明 | 示例 / 说明 |
| :--- | :--- | :--- |
| `r <file/dir>` | 安全删除（目录时确认，单文件提示） | `r my_folder` |
| `du` | 按大小排序显示当前目录下所有文件夹 | `du` |
| `ds` | 按大小升序查看所有文件与目录 | `ds` |
| `dh` | 查看当前目录下第一层目录占用 | `dh` |
| `ip` | 快速获取本机当前内网/外网 IP 地址 | `ip` |
| `gl <url>` | 克隆 Git 仓库并自动 `cd` 进入该目录 | `gl https://github.com/...` |
| `lg` | 打开 Lazygit 并在退出时自动留在最后浏览的目录 | `lg` |
| `ff` | 打印 Fastfetch 系统信息 | `ff` |

### Docker 指令
| 指令 | 说明 |
| :--- | :--- |
| `db <name>` | 编译 Docker 镜像 |
| `dr <name> <port> <image>` | 运行 Docker 容器并开启自启 |
| `di` / `dps` | 查看镜像列表 / 查看运行中的容器 |
| `drm <container>` / `drma` | 删除单个容器 / 删除所有容器 |
| `drmi <image>` | 删除指定镜像 |
| `dl <container> [lines]` | 实时查看容器日志 (默认 500 行) |
| `dep <container>` | 进入正在运行的容器 `/bin/bash` |
| `dc [env] [scale]` | 启动 docker-compose 服务 |

### macOS 专属指令 (在 macOS 自动生效)
| 指令 | 说明 |
| :--- | :--- |
| `pwd` | 获取当前绝对路径并**自动复制到剪贴板** |
| `des` | 自动获取 Finder 当前打开的目录并在终端进入 |
| `sub <file>` / `vs <dir>` | 使用 Sublime Text / VSCode 打开 |
| `sproxy` / `uproxy` | 快速开启 / 关闭 Socks5 终端代理并测试 IP |
| `cldns` | 刷新 macOS 系统 DNS 缓存 |
| `macc` | 一键清理 npm / yarn / pnpm 与废纸篓缓存 |
| `t` / `tt` | iTerm2 新建标签页 / 窗口 |
| `a` / `aw` / `ad` / `ade` | 快速跳转至 Workspace / Downloads / Desktop |

---

## 📄 开源许可

本项目基于 MIT 协议开源。
