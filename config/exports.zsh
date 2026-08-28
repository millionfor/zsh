#!/usr/bin/env zsh
# =======================================================
# 通用环境变量与 PATH 导出
# =======================================================

# ----------------- 核心基础 PATH 优先加载 -----------------
[[ -d "$HOME/.fzf/bin" ]]   && export PATH="$HOME/.fzf/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# macOS Homebrew 路径优先 (Apple Silicon & Intel)
[[ -d "/opt/homebrew/bin" ]] && export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
[[ -d "/usr/local/bin" ]]    && export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# 终端高亮与颜色配置
export LS_COLORS="di=0;35"
