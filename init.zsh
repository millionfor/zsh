#!/usr/bin/env zsh
# =======================================================
# Zsh 核心引导入口文件
# =======================================================

# 1. 基础路径与缓存初始化
export ZSH="${ZSH:-${0:A:h}}"
export OMZ="$ZSH"
export ZSH_CACHE_DIR="$ZSH/cache"
[[ ! -d "$ZSH_CACHE_DIR" ]] && mkdir -p "$ZSH_CACHE_DIR"

# 2. 加载通用基础配置
[[ -f "$ZSH/config/exports.zsh" ]]   && source "$ZSH/config/exports.zsh"
[[ -f "$ZSH/config/omz.zsh" ]]       && source "$ZSH/config/omz.zsh"
[[ -f "$ZSH/config/fzf.zsh" ]]       && source "$ZSH/config/fzf.zsh"
[[ -f "$ZSH/config/alias.zsh" ]]     && source "$ZSH/config/alias.zsh"
[[ -f "$ZSH/config/git.zsh" ]]       && source "$ZSH/config/git.zsh"
[[ -f "$ZSH/config/docker.zsh" ]]    && source "$ZSH/config/docker.zsh"
[[ -f "$ZSH/config/pm2.zsh" ]]       && source "$ZSH/config/pm2.zsh"
[[ -f "$ZSH/config/ssh.zsh" ]]       && source "$ZSH/config/ssh.zsh"
[[ -f "$ZSH/config/volta.zsh" ]]     && source "$ZSH/config/volta.zsh"
[[ -f "$ZSH/config/h.zsh" ]]         && source "$ZSH/config/h.zsh"
[[ -f "$ZSH/config/port-tool.zsh" ]] && source "$ZSH/config/port-tool.zsh"
[[ -f "$ZSH/config/hook.zsh" ]]      && source "$ZSH/config/hook.zsh"

# 3. 按操作系统平台加载专属模块 (macOS / Linux)
case "$(uname -s)" in
  Darwin)
    # 加载 macOS 专属配置
    if [[ -d "$ZSH/config/macos" ]]; then
      for config_file in "$ZSH"/config/macos/*.zsh(N); do
        [[ -f "$config_file" ]] && source "$config_file"
      done
    fi
    ;;
  Linux)
    # 加载 Linux / Debian 专属配置
    if [[ -d "$ZSH/config/linux" ]]; then
      for config_file in "$ZSH"/config/linux/*.zsh(N); do
        [[ -f "$config_file" ]] && source "$config_file"
      done
    fi
    ;;
esac

# 4. 加载主题
if [[ -n "$ZSH_THEME" && -f "$ZSH/themes/$ZSH_THEME.zsh-theme" ]]; then
  source "$ZSH/themes/$ZSH_THEME.zsh-theme"
elif [[ -f "$ZSH/themes/default.zsh-theme" ]]; then
  source "$ZSH/themes/default.zsh-theme"
elif [[ -d "$ZSH/themes" ]]; then
  for theme in "$ZSH"/themes/*.zsh-theme(N); do
    [[ -f "$theme" ]] && source "$theme" && break
  done
fi

# 5. 加载个人私有配置 (QuanQuan.rc)
# 位于项目根目录 $ZSH/QuanQuan.rc，已加入 .gitignore，用于存放私密 API Key、Token 与个性化环境变量
[[ -f "$ZSH/QuanQuan.rc" ]]      && source "$ZSH/QuanQuan.rc"
[[ -f "$ZSH/config/local.zsh" ]] && source "$ZSH/config/local.zsh"
[[ -f "$HOME/.zshrc_config" ]]   && source "$HOME/.zshrc_config"

return 0 2>/dev/null || true
