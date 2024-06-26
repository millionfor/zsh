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
alias sproxy="export ALL_PROXY=socks5://127.0.0.1:20170; echo -e '=> 开启代理 \c'; eval 'curl cip.cc'" 
# 取消代理
alias uproxy="unset ALL_PROXY; echo -e '=> 关闭代理 \c'; eval 'curl cip.cc'"
# 测试代理
alias tproxy="curl cip.cc"

# 进入工作目录
a() {
  eval "cd ~/WebstormProjects"
}

# 打开当前目录
a.() {
  eval "open ."
}

# 进入工作目录
aw() {
  cd ~/workspace
}

# 进入工作目录g目录
awg() {
  cd ~/workspace/g
}

# 进入工作目录g目录
gg() {
  cd ~/workspace/gg
}

# 进入测试目录
at() {
  cd ~/WebstormProjects/test
}


# 进入下载目录
ad() {
  cd ~/Downloads
}

# 进入桌面目录
ade() {
  cd ~/Desktop
}
des()
{
    curFinderDir=`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`
    echo "\033[31m$curFinderDir\033[0m"
    cd $curFinderDir
}


# 进入qsm
qsm() {
  cd ~/workspace/g/Qsm
}

# 进入qsm
wx() {
  cd ~/workspace/g/Qsm-wx-service
}


# 进入hydee项目目录
ah() { eval "cd ~/WebstormProjects/hydee-perject" }

# 进入npm目录
an() { eval "cd ~/WebstormProjects/hydee-perject/npm" }

# 进入hss目录
ahss() { 
  eval "cd ~/WebstormProjects/hydee-perject/npm/hss-modules" 
}

# 打开具体文档（vim|php|mysql|docker）
doc() {
  [[ ! -z "$1" ]] && name=$1 || name=vim
  vim ~/.config/docs/$name-doc.md
}

# 打开单窗口
it() {
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


