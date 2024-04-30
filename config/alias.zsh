#!/bin/bash
# vim: set ft=sh fdm=manual ts=2 sw=2 sts=2 tw=85 et:

# =======================================================
# Description:     
# Filename:        alias.sh
# Author           QuanQuan <millionfor@apache.org>
# Last Modified    Tue, Apr 30, 2024 14:55
# GistID           %Gist_ID%
# GistURL          https://gist.github.com/millionfor/%Gist_ID%
# =======================================================


# nvim ---------------------
alias nvim='LC_ALL=en_GB.utf-8 nvim'
alias vim='nvim'

# git ---------------------
alias g='git'
# git清除缓存
alias gc='git rm -r --cached .'

# yarn ---------------------
alias y='yarn'
alias yi='yarn install'
alias ys='yarn start'
alias yy='yarn install && yarn start'
alias yc="yarn cache clean"

# npm ---------------------
alias ni='npm install'
alias ns='npm run start'
alias nn='npm install && npm run start'
alias nc="npm cache clean --force"
alias np="npm publish --access public"
# npm卸载包
nu() {
  npm unpublish $1 --force
}

# 其他 ---------------------

# 查找文件
fd() {
  find $1 -type f -name "*$2*"
}

# 注册ssh
sshkey() {
  ssh-keygen -t rsa -C "$1"
}
# curl post json
cpost() {
  curl -X POST -H "Content-Type: application/json" -d $1 $2
}

# {c} 压缩
cx() {
  tar -cvf $1.tar *$2
}

# 压缩gz
cgz() {
  tar -czf $1.tar.gz *$2
}

# 压缩bz2
cbz2() {
  tar -cjf $1.tar.bz2 *$2
}

# 解压
ex() {
  if [[ -z “$1” ]]; then
    print -P “usage: \e[1
    36mex\e[1
    0m < filename > ”
    print -P ” Extract the file specified based on the extension”
  elif [[ -f $1 ]]; then
    case $1 in
      *.tar) tar xvf $1 ;;
      *.tbz2) tar xvf $1 ;;
      *.tgz) tar xvf $1 ;;
      *.tar.bz2) tar xvf $1 ;;
      *.tar.gz) tar xvf $1 ;;
      *.tar.xz) tar xvf $1 ;;
      *.tar.Z) tar xvf $1 ;;
      *.bz2) bunzip2v $1 ;;
      *.rar) rar x $1 ;;
      *.gz) gunzip $1 ;;
      *.zip) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.xz) xz -d $1 ;;
      *.lzo) lzo -dv $1 ;;
      *.7z) 7z x $1 ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo “‘$1’ is not a valid file”
  fi
}

# 获取ip地址
ip() {
  # networksetup -setmanualwithdhcprouter WI-FI 192.168.0.66
  ifconfig | grep 'inet ' | awk '{if($2!="127.0.0.1")print $2}'
}

# 查看大小
dh() {
  du -h -d 1
}

# 进入nvim
gv() {
  cd ~/.config/nvim && vim
}

# 进入nvim
gz() {
  cd ~/.config/zsh && vim
}


# https://github.com/jesseduffield/lazygit
lg() {
  export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

  lazygit "$@"

  if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
    cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
    rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
  fi
}

# h
s() {
  ssh -R 2489:127.0.0.1:2489 $1
}
# 获取颜色
color() {
  local -a colors
  for i in {000..255}; do
      colors+=("%F{$i}$i%f")
  done
  print -cP $colors
}

