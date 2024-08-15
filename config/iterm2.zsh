


# 新建窗口
t() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "t" using command down'
}

# 新建窗口
tt() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "t" using option down'
}

# ok 快捷创建qsm服务目录
qsm() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "q" using option down'
}

# ok vue-components
vuec() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "v" using option down'
}


# ok hydee workspace
hydee() {
  osascript -e 'tell application "iTerm" to activate'
  osascript -e 'tell application "System Events" to keystroke "h" using option down'
}

# ok ws
# ws() {
#   osascript -e 'tell application "iTerm" to activate'
#   osascript -e 'tell application "System Events" to keystroke "p" using option down'
# }
