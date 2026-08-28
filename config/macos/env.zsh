#!/usr/bin/env zsh
# =======================================================
# macOS 环境变量与 PATH 配置
# =======================================================

# Homebrew 路径初始化 (Apple Silicon / Intel)
if [[ -d "/opt/homebrew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null)"
elif [[ -d "/usr/local/Homebrew" ]]; then
  eval "$(/usr/local/bin/brew shellenv 2>/dev/null)"
fi

# GNU 工具与 Homebrew 包路径增强
[[ -d "/opt/homebrew/opt/mysql-client/bin" ]] && export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# macOS 默认应用与环境变量
export BROWSER="open"
