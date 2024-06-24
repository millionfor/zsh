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


# pm2
pm2s() {
  name=${1:-test}
  pm2 start npm --name $name -- run start --max-restarts 10 --min-uptime 2000
}

pm2del() {
  name=${1:-test}
  pm2 delete $name
}

pm2rs() {
  name=${1:-test}
  pm2 restart $name
}

pm2log() {
  lines=${1:-100}
  pm2 logs --lines $lines
}
