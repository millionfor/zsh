
# 新建窗口
t() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "t" using command down'
}

# 快捷创建qsm服务目录
qsm() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "q" using option down'
}

# vue-components
vuec() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "v" using option down'
}

# 主应用
app() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "p" using option down'
}


# subapps
subapps() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "u" using option down'
}

# workspace
ws() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "i" using option down'
}

# hydee workspace
hydee() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "h" using option down'
}

