#!/usr/bin/env bash
# ==============================================================================
# Zsh Configuration Cross-Platform One-Click Installer
# 支持系统: macOS (Apple Silicon / Intel) & Debian 12 / Ubuntu
# ==============================================================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# 默认配置
REPO_URL="${REPO_URL:-https://github.com/millionfor/zsh.git}"
TARGET_DIR="${HOME}/.config/zsh"
NON_INTERACTIVE=false

# 日志输出函数
info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1" >&2
}

banner() {
  echo -e "${CYAN}${BOLD}"
  echo "  ███████╗███████╗██╗  ██╗   ███████╗███████╗████████╗██╗   ██╗██████╗ "
  echo "  ╚══███╔╝██╔════╝██║  ██║   ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗"
  echo "    ███╔╝ ███████╗███████║   ███████╗█████╗     ██║   ██║   ██║██████╔╝"
  echo "   ███╔╝  ╚════██║██╔══██║   ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ "
  echo "  ███████╗███████║██║  ██║   ███████║███████╗   ██║   ╚██████╔╝██║     "
  echo "  ╚══════╝╚══════╝╚═╝  ╚═╝   ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     "
  echo -e "${NC}"
  echo -e "  ${PURPLE}Cross-Platform Zsh Config Installer (macOS & Debian 12)${NC}"
  echo "  ================================================================"
  echo ""
}

# 解析参数
parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -y|--yes|--non-interactive)
        NON_INTERACTIVE=true
        shift
        ;;
      -h|--help)
        echo "Usage: ./install.sh [options]"
        echo "Options:"
        echo "  -y, --yes, --non-interactive    Auto-confirm all prompts"
        echo "  -h, --help                      Show this help message"
        exit 0
        ;;
      *)
        shift
        ;;
    esac
  done
}

# 检测系统类型
detect_os() {
  OS="$(uname -s)"
  case "$OS" in
    Darwin)
      OS_NAME="macOS"
      ;;
    Linux)
      if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS_NAME="${NAME:-Linux}"
        DISTRO="${ID:-linux}"
      else
        OS_NAME="Linux"
        DISTRO="generic"
      fi
      ;;
    *)
      error "Unsupported Operating System: $OS"
      exit 1
      ;;
  esac
  info "检测到操作系统: ${BOLD}${OS_NAME}${NC}"
}

# 安装依赖 - macOS
install_deps_macos() {
  info "正在检查 macOS 依赖包..."

  if ! command -v brew &>/dev/null; then
    warn "未检测到 Homebrew包管理器。"
    if [[ "$NON_INTERACTIVE" == false ]]; then
      read -p "是否自动安装 Homebrew? (y/N): " choice
      case "$choice" in
        [yY][eE][sS]|[yY])
          info "正在安装 Homebrew..."
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
          if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
          fi
          ;;
        *)
          warn "跳过 Homebrew 安装，部分依赖可能需要手动安装。"
          ;;
      esac
    fi
  fi

  if command -v brew &>/dev/null; then
    local pkgs=(zsh git curl fzf fd bat eza lua fastfetch)
    info "正在通过 Homebrew 安装必要工具 (${pkgs[*]})..."
    for pkg in "${pkgs[@]}"; do
      if ! brew list "$pkg" &>/dev/null; then
        info "正在安装 $pkg..."
        brew install "$pkg" || warn "$pkg 安装失败，请稍后手动安装"
      else
        info "$pkg 已安装"
      fi
    done
    success "macOS 依赖检查与安装完成"
  fi
}

# 安装依赖 - Debian 12 / Ubuntu
install_deps_debian() {
  info "正在检查 Debian / Linux 依赖包..."

  # 检查 sudo 权限
  local SUDO=""
  if [[ $EUID -ne 0 ]]; then
    if command -v sudo &>/dev/null; then
      SUDO="sudo"
    else
      warn "当前非 root 用户且未找到 sudo，依赖安装可能会失败"
    fi
  fi

  info "正在更新 apt 软件包列表..."
  $SUDO apt-get update -y || warn "apt-get update 执行异常，继续尝试安装包..."

  local pkgs=(zsh git curl fzf fd-find bat lua5.3)
  info "正在安装基础软件包 (${pkgs[*]})..."
  $SUDO apt-get install -y "${pkgs[@]}" || warn "部分软件包安装可能失败"

  # 建立兼容软链接 (~/.local/bin)
  mkdir -p "${HOME}/.local/bin"

  # 1. fd-find -> fd
  if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    info "创建 fd 别名软链接: ~/.local/bin/fd -> $(which fdfind)"
    ln -sf "$(which fdfind)" "${HOME}/.local/bin/fd"
  fi

  # 2. batcat -> bat
  if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
    info "创建 bat 别名软链接: ~/.local/bin/bat -> $(which batcat)"
    ln -sf "$(which batcat)" "${HOME}/.local/bin/bat"
  fi

  # 尝试安装 eza (如果已有源或通过 gpg 安装)
  if ! command -v eza &>/dev/null; then
    if command -v exa &>/dev/null; then
      info "已安装 exa"
    else
      info "尝试通过 apt 安装 exa/eza (若可用)..."
      $SUDO apt-get install -y eza 2>/dev/null || $SUDO apt-get install -y exa 2>/dev/null || true
    fi
  fi

  success "Debian 依赖检查与软链接设置完成"
}

# 部署 Zsh 仓库配置
deploy_config() {
  info "正在配置 Zsh 仓库到 ${TARGET_DIR}..."

  local current_script_dir
  current_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  # 如果当前脚本已经在 target 目录
  if [[ "$current_script_dir" == "$TARGET_DIR" ]]; then
    info "检测到当前目录即为目标配置目录: ${TARGET_DIR}"
  elif [[ -f "${current_script_dir}/init.zsh" ]]; then
    # 本地克隆目录但不在 ~/.config/zsh
    if [[ -d "$TARGET_DIR" && ! -L "$TARGET_DIR" ]]; then
      local backup_dir="${TARGET_DIR}.bak.$(date +%Y%m%d%H%M%S)"
      warn "目标目录 ${TARGET_DIR} 已存在，正在备份到 ${backup_dir}..."
      mv "$TARGET_DIR" "$backup_dir"
    fi
    mkdir -p "$(dirname "$TARGET_DIR")"
    info "正在复制配置到 ${TARGET_DIR}..."
    cp -r "$current_script_dir" "$TARGET_DIR"
  else
    # 远程 curl 管道模式或独立脚本模式
    if [[ -d "$TARGET_DIR" ]]; then
      if [[ -d "${TARGET_DIR}/.git" ]]; then
        info "目标目录已是 Git 仓库，正在更新..."
        git -C "$TARGET_DIR" pull --rebase || warn "Git pull 失败，跳过拉取"
      else
        local backup_dir="${TARGET_DIR}.bak.$(date +%Y%m%d%H%M%S)"
        warn "目标目录已存在非 Git 内容，备份到 ${backup_dir}..."
        mv "$TARGET_DIR" "$backup_dir"
        info "正在从 ${REPO_URL} 克隆仓库..."
        mkdir -p "$(dirname "$TARGET_DIR")"
        git clone "$REPO_URL" "$TARGET_DIR"
      fi
    else
      info "正在从 ${REPO_URL} 克隆仓库到 ${TARGET_DIR}..."
      mkdir -p "$(dirname "$TARGET_DIR")"
      git clone "$REPO_URL" "$TARGET_DIR"
    fi
  fi

  # 初始化缓存目录
  mkdir -p "${TARGET_DIR}/cache"

  # 初始化个人个性化配置文件 ~/.zshrc_config
  if [[ ! -f "${HOME}/.zshrc_config" && -f "${TARGET_DIR}/config/local.zsh.example" ]]; then
    info "创建个人个性化私有配置文件: ~/.zshrc_config"
    cp "${TARGET_DIR}/config/local.zsh.example" "${HOME}/.zshrc_config"
  fi

  success "Zsh 配置目录部署完成"
}

# 配置 ~/.zshrc
setup_zshrc() {
  local zshrc="${HOME}/.zshrc"
  info "正在配置 ${zshrc}..."

  if [[ -f "$zshrc" ]]; then
    # 检查是否已包含 init.zsh
    if grep -q "config/zsh/init.zsh" "$zshrc" 2>/dev/null; then
      info "${zshrc} 已包含 zsh 配置引入，跳过写入"
      return 0
    fi
    local backup_zshrc="${zshrc}.bak.$(date +%Y%m%d%H%M%S)"
    info "备份现有 ${zshrc} 到 ${backup_zshrc}"
    cp "$zshrc" "$backup_zshrc"
  fi

  cat >> "$zshrc" << 'EOF'

# =======================================================
# Added by Zsh Config Framework
# =======================================================
export PATH="$HOME/.local/bin:$PATH"
[[ -f "$HOME/.config/zsh/init.zsh" ]] && source "$HOME/.config/zsh/init.zsh"
EOF

  success "${zshrc} 配置完成"
}

# 切换默认 Shell
switch_default_shell() {
  local zsh_path
  zsh_path="$(which zsh 2>/dev/null || true)"

  if [[ -z "$zsh_path" ]]; then
    warn "未找到 zsh 执行文件，请确认 zsh 是否已正确安装"
    return 0
  fi

  if [[ "$SHELL" == *"/zsh" ]]; then
    info "当前默认 Shell 已是 Zsh: $SHELL"
    return 0
  fi

  info "当前默认 Shell 为: $SHELL"

  if [[ "$NON_INTERACTIVE" == true ]]; then
    info "正在自动设置 Zsh 为默认 Shell..."
    chsh -s "$zsh_path" 2>/dev/null || warn "切换默认 Shell 失败，请手动运行: chsh -s $zsh_path"
  else
    read -p "是否将默认 Shell 更改为 Zsh ($zsh_path)? (Y/n): " choice
    case "$choice" in
      [nN][oO]|[nN])
        info "保持当前 Shell 不变。你可以稍后手动运行: chsh -s $zsh_path"
        ;;
      *)
        info "正在修改默认 Shell..."
        chsh -s "$zsh_path" || warn "修改失败，可能需要输入用户密码或手动执行: chsh -s $zsh_path"
        ;;
    esac
  fi
}

# 主程序入口
main() {
  parse_args "$@"
  banner
  detect_os

  case "$OS" in
    Darwin)
      install_deps_macos
      ;;
    Linux)
      install_deps_debian
      ;;
  esac

  deploy_config
  setup_zshrc
  switch_default_shell

  echo ""
  echo -e "${GREEN}${BOLD}================================================================${NC}"
  echo -e "${GREEN}${BOLD}             🎉 Zsh 配置环境一键安装完成!                       ${NC}"
  echo -e "${GREEN}${BOLD}================================================================${NC}"
  echo ""
  echo -e "  👉 立即生效配置:    ${CYAN}${BOLD}exec zsh${NC}"
  echo -e "  👉 个人私密配置:    ${CYAN}${BOLD}~/.zshrc_config${NC} (存放你的 API Key 与个性化变量)"
  echo -e "  👉 快捷帮助查看:    ${CYAN}${BOLD}h${NC} 或 ${CYAN}${BOLD}h zsh${NC} / ${CYAN}${BOLD}h git${NC} / ${CYAN}${BOLD}h docker${NC}"
  echo -e "  👉 端口管理工具:    ${CYAN}${BOLD}port list${NC} 或 ${CYAN}${BOLD}port kill <port/pid>${NC}"
  if [[ "$OS" == "Darwin" ]]; then
    echo -e "  👉 macOS 专属模块:   ${CYAN}${BOLD}${TARGET_DIR}/config/macos/${NC}"
  else
    echo -e "  👉 Linux 专属模块:   ${CYAN}${BOLD}${TARGET_DIR}/config/linux/${NC}"
  fi
  echo ""
}

main "$@"
