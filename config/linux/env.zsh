#!/usr/bin/env zsh
# =======================================================
# Linux / Debian 12 环境变量与 PATH 配置
# =======================================================

# 用户本地 bin 目录优先级
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "/usr/local/bin" ]] && export PATH="/usr/local/bin:$PATH"

# 系统默认编辑器
if command -v nvim &>/dev/null; then
  export EDITOR="nvim"
elif command -v vim &>/dev/null; then
  export EDITOR="vim"
fi
