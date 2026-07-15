#!/bin/bash
# vim: set ft=sh fdm=manual ts=2 sw=2 sts=2 tw=85 et:

# =======================================================
# Description:     
# Filename:        mac-alias.sh
# Author           QuanQuan <millionfor@apache.org>
# Last Modified    Tue, Apr 30, 2024 14:55
# GistID           %Gist_ID%
# GistURL          https://gist.github.com/millionfor/%Gist_ID%
# =======================================================

# sublint 打开文件
alias sub="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# vscode 打开文件
alias vs="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# 设置代理
alias sproxy="export ALL_PROXY=socks5://127.0.0.1:2080; echo -e '=> 开启代理 \c'; eval 'curl cip.cc'" 
# 取消代理
alias uproxy="unset ALL_PROXY; echo -e '=> 关闭代理 \c'; eval 'curl cip.cc'"
# 测试代理
alias tproxy="curl cip.cc"

# 设置http代理
alias sproxy_http="export http_proxy=http://127.0.0.1:1082;export https_proxy=http://127.0.0.1:1082; echo -e '=> 开启代理 \c'; eval 'curl cip.cc'" 
# 取消http代理
alias uproxy_http="unset http_proxy https_proxy; echo -e '=> 关闭代理 \c'; eval 'curl cip.cc'"

alias np="~/.config/bash/git-release-npm.sh"

nu() {
  npm unpublish "$1" --force
}

# 进入工作目录
a() {
  eval "cd ~/Workspace"
}

# 打开当前目录
a.() {
  eval "open ."
}

# 进入工作目录
aw() {
  cd /Users/millionfor/Workspace
}

# 进入工作目录
ws() {
  cd ~/
}

# 进入测试目录
at() {
  cd /Users/millionfor/Workspace/test
}

# 进入下载目录
ad() {
  cd ~/Downloads
}

# 进入桌面目录
ade() {
  cd ~/Desktop
}

# 进入npm
wnpm() {
  cd ~/Workspace/npm
}

wqsm() {
  cd ~/Workspace/qsm
}

wbo() {
  cd ~/Workspace/boilerplates
}

wws() {
  cd ~/Workspace/ws
}

# 进入synology cloud
syn() {
  cd /Users/millionfor/Library/CloudStorage/SynologyDrive-Quan
}

ww() {
  cd ~/Workspace
}

# 进入hydee项目目录
ah() { eval "cd ~/Workspace/hd" }

# 进入hss目录
ahss() { 
  eval "cd ~/Workspace/hd/hss-module" 
}

des()
{
    curFinderDir=`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`
    echo "\033[31m$curFinderDir\033[0m"
    cd $curFinderDir
}

# 打开具体文档（vim|php|mysql|docker）
doc() {
  [[ ! -z "$1" ]] && name=$1 || name=vim
  vim ~/.config/docs/$name-doc.md
}

# 打开单窗口
it() {
  local project_dir=${2:-$(pwd)}

  if grep -q "^alias CD_HD_PROJECT_PATH=" ~/.zshrc; then
    sed -i '' "s|^alias CD_HD_PROJECT_PATH=.*|alias CD_HD_PROJECT_PATH='cd $project_dir'|" ~/.zshrc
  else
    echo "alias CD_HD_PROJECT_PATH='cd $project_dir'" >> ~/.zshrc
  fi

  source ~/.zshrc

  itermocil --here $1
}


# 打开多窗口
its() {
  for i in $*; do
    if [ $i = $1 ]; then
      itermocil --here $i
    else
      itermocil $i
    fi
  done
}

# config 目录
cf() {
  cd ~/.config
}

# 清除缓存
macc() {
  echo "=> 清除{yarn}缓存..."
  yarn cache clean
  echo "\n=> 清除{npm}缓存..."
  npm cache clean --force
  echo "\n=> 清除{pnpm}缓存..."
  pnpm store prune
  echo "\n=> 清除{废纸篓}..."
  sudo rm -rf "~/.Trash/*"
}

# 清除DNS缓存
cldns () {
  sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder
}

pwd() {
  command pwd | tee /dev/tty | pbcopy
}

ar() {
  eval "cd ~/.local/share/fcitx5/rime"
}

agt() {
  eval "cd ~/Workspace/g/gist"
}

alias ds='du -sh * 2>/dev/null | sort -h'

add-phrase() {
  if [ $# -lt 2 ]; then
    echo "Usage: add-phrase <code> <phrase...>"
    return 1
  fi
  local code=$1
  shift
  local phrase=$*
  printf "%s\t%s\n" "$phrase" "$code" >> ~/.local/share/fcitx5/rime/custom_phrase.txt
  echo "Added: ${phrase} -> ${code}"
  # 重启 Fcitx5 使配置立即生效
  killall Fcitx5 && open -a "/Library/Input Methods/Fcitx5.app"
  echo "Fcitx5 reloaded."
}

del-phrase() {
  if [ -z "$1" ]; then
    echo "Usage: del-phrase <code>"
    return 1
  fi
  local code=$1
  local target_file=~/.local/share/fcitx5/rime/custom_phrase.txt
  
  # 使用 awk 精确匹配第二列(编码)并排除，保留其他行
  awk -F'\t' -v c="$code" '$2 != c' "$target_file" > "${target_file}.tmp" && mv "${target_file}.tmp" "$target_file"
  
  echo "Deleted all phrases for code: ${code}"
  
  # 重启 Fcitx5 使配置立即生效
  killall Fcitx5 && open -a "/Library/Input Methods/Fcitx5.app"
  echo "Fcitx5 reloaded."
}
