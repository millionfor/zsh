# =======================================================
# 跨平台自适应主题 (macOS & Debian/Linux)
# =======================================================

_get_prompt_tag() {
  # 1. 优先使用用户完全自定义的标签 (允许自定义括号、Emoji 等任意格式，如 "[⭕️ MacOS-M4]" 或 "⭕️ MacOS-M4")
  if [[ -n "$PROMPT_TAG" ]]; then
    echo "$PROMPT_TAG"
    return
  fi

  # 2. 读取 PROMPT_OS_NAME / PROMPT_NAME
  local name="${PROMPT_OS_NAME:-${PROMPT_NAME:-$PROMPT_HOST_LABEL}}"
  if [[ -n "$name" ]]; then
    # 如果用户配置中已经包含了括号（如 [xxx] 或 (xxx)），直接输出；否则默认加上 []
    if [[ "$name" == \[*\] || "$name" == \(*\) || "$name" == \{*\} ]]; then
      echo "$name"
    else
      echo "[$name]"
    fi
    return
  fi

  # 3. 默认根据操作系统动态识别
  local os="Linux"
  if [[ "$(uname -s)" == "Darwin" ]]; then
    os="macOS"
  elif [[ -f /etc/os-release ]]; then
    local id
    id=$(grep -E '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    case "$id" in
      debian) os="Debian" ;;
      ubuntu) os="Ubuntu" ;;
      arch)   os="Arch" ;;
      alpine) os="Alpine" ;;
      *)      os="Linux" ;;
    esac
  fi

  echo "[$os]"
}

PROMPT='%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%}) $(_get_prompt_tag) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
