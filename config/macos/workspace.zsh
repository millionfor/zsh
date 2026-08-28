#!/usr/bin/env zsh
# =======================================================
# macOS 工作区与目录快捷跳转
# =======================================================

# 进入主工作目录
a() {
  cd ~/Workspace 2>/dev/null || cd "$HOME"
}

# 打开当前目录（Finder）
a.() {
  open .
}

# 进入 Workspace 目录
aw() {
  cd ~/Workspace
}

# 回到用户根目录
ws() {
  cd ~
}

# 进入测试目录
at() {
  cd ~/Workspace/test
}

# 进入下载目录
ad() {
  cd ~/Downloads
}

# 进入桌面目录
ade() {
  cd ~/Desktop
}

# 进入子项目目录
wnpm() { cd ~/Workspace/npm; }
wqsm() { cd ~/Workspace/qsm; }
wbo()  { cd ~/Workspace/boilerplates; }
wws()  { cd ~/Workspace/ws; }
ww()   { cd ~/Workspace; }
ah()   { cd ~/Workspace/hd; }
ahss() { cd ~/Workspace/hd/hss-module; }
agt()  { cd ~/Workspace/g/gist; }
ar()   { cd ~/.local/share/fcitx5/rime; }
cf()   { cd ~/.config; }

# 进入 Synology Cloud 云盘目录
syn() {
  local syn_dir="$HOME/Library/CloudStorage/SynologyDrive-Quan"
  if [[ -d "$syn_dir" ]]; then
    cd "$syn_dir"
  else
    echo "Directory not found: $syn_dir"
  fi
}
