#!/usr/bin/env zsh
# =======================================================
# macOS iTerm2 & AppleScript 自动化配置
# =======================================================

# 新建 iTerm 标签页
t() {
  osascript -e 'tell application "iTerm" to activate' \
            -e 'tell application "System Events" to keystroke "t" using command down' 2>/dev/null
}

# 新建 iTerm 分屏 / 窗口
tt() {
  osascript -e 'tell application "iTerm" to activate' \
            -e 'tell application "System Events" to keystroke "t" using option down' 2>/dev/null
}

# 快捷创建 qsm 服务目录
qsm() {
  osascript -e 'tell application "iTerm" to activate' \
            -e 'tell application "System Events" to keystroke "q" using option down' 2>/dev/null
}

# 快捷 vue-components
vuec() {
  osascript -e 'tell application "iTerm" to activate' \
            -e 'tell application "System Events" to keystroke "v" using option down' 2>/dev/null
}

# 快捷 hydee workspace
hydee() {
  osascript -e 'tell application "iTerm" to activate' \
            -e 'tell application "System Events" to keystroke "h" using option down' 2>/dev/null
}

# itermocil 单窗口布局
it() {
  local project_dir=${2:-$(pwd)}
  if grep -q "^alias CD_HD_PROJECT_PATH=" ~/.zshrc 2>/dev/null; then
    sed -i '' "s|^alias CD_HD_PROJECT_PATH=.*|alias CD_HD_PROJECT_PATH='cd $project_dir'|" ~/.zshrc
  else
    echo "alias CD_HD_PROJECT_PATH='cd $project_dir'" >> ~/.zshrc
  fi
  source ~/.zshrc 2>/dev/null
  command -v itermocil &>/dev/null && itermocil --here "$1"
}

# itermocil 多窗口布局
its() {
  for i in "$@"; do
    if [[ "$i" == "$1" ]]; then
      itermocil --here "$i"
    else
      itermocil "$i"
    fi
  done
}
