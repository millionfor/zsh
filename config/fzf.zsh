#!/usr/bin/env zsh
# =======================================================
# FZF 与 FZF-Tab 智能补全与预览配置
# =======================================================

# 动态探测 bat / batcat
if command -v bat &>/dev/null; then
  _BAT_PREVIEW="bat -p --color=always {}"
elif command -v batcat &>/dev/null; then
  _BAT_PREVIEW="batcat -p --color=always {}"
else
  _BAT_PREVIEW="cat {}"
fi

# 动态探测 fd / fdfind
if command -v fd &>/dev/null; then
  _FD_CMD="fd"
elif command -v fdfind &>/dev/null; then
  _FD_CMD="fdfind"
else
  _FD_CMD="find"
fi

alias fzf="fzf --preview \"$_BAT_PREVIEW | head -100\" --height 40%"

export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --history=${ZSH_CACHE_DIR:-$HOME/.config/zsh/cache}/fzfhistory"

if [[ "$_FD_CMD" != "find" ]]; then
  export FZF_DEFAULT_COMMAND="$_FD_CMD --hidden --exclude={.git,.idea,.vscode,.sass-cache,node_modules,dist,vendor,cache} --type f"
else
  export FZF_DEFAULT_COMMAND="find . -type f"
fi

export FZF_PREVIEW_COMMAND="bash ${ZSH:-$HOME/.config/zsh}/lib/file_preview.sh {}"

# ----------------- fzf-tab 补全样式定制 -----------------
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff --color=always $word'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'git show --color=always $word'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview '[ -f "$realpath" ] && git diff --color=always $word || git log --color=always $word'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'

export LESSOPEN="| bash ${ZSH:-$HOME/.config/zsh}/lib/file_preview.sh %s"
