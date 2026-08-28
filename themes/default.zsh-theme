# =======================================================
# 跨平台自适应主题 (macOS & Debian/Linux)
# =======================================================

_get_os_label() {
  if [[ -n "$PROMPT_HOST_LABEL" ]]; then
    echo "$PROMPT_HOST_LABEL"
  elif [[ "$(uname -s)" == "Darwin" ]]; then
    echo "macOS"
  elif [[ -f /etc/os-release ]]; then
    local id
    id=$(grep -E '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    case "$id" in
      debian) echo "Debian" ;;
      ubuntu) echo "Ubuntu" ;;
      arch)   echo "Arch" ;;
      alpine) echo "Alpine" ;;
      *)      echo "Linux" ;;
    esac
  else
    echo "Linux"
  fi
}

local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"
local os_tag="$(_get_os_label)"

PROMPT='${ret_status} ['${os_tag}'] %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
