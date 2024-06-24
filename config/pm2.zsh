#!/bin/bash
# vim: set ft=sh fdm=manual ts=2 sw=2 sts=2 tw=85 et:

# =======================================================
# Description:     
# Filename:        pm2.sh
# Author           QuanQuan <millionfor@apache.org>
# Last Modified    Tue, Apr 30, 2024 14:55
# GistID           %Gist_ID%
# GistURL          https://gist.github.com/millionfor/%Gist_ID%
# =======================================================


# 启动
p2s() {
  dir_name=$(basename "$(pwd)")
  name=${1:-$dir_name}
  pm2 start npm --name $name -- run start --max-restarts 10 
}

# 删除
p2d() {
  name=${1:-test}
  pm2 delete $name
}

# 重启
p2r() {
  name=${1:-test}
  pm2 restart $name
}

# 列表
p2l () {
  pm2 list
}

# 日志
p2lg() {
  lines=${1:-100}
  pm2 logs --lines $lines
}
