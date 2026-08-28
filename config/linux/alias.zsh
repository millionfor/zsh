#!/usr/bin/env zsh
# =======================================================
# Linux / Debian 12 专属别名与实用工具
# =======================================================

# 进入工作/常用目录
qq() {
  cd ~/quanquan 2>/dev/null || cd "$HOME"
}

# ----------------- 剪贴板适配 -----------------
pwd() {
  if command -v wl-copy &>/dev/null; then
    command pwd | tee /dev/tty | wl-copy
  elif command -v xclip &>/dev/null; then
    command pwd | tee /dev/tty | xclip -selection clipboard
  else
    command pwd
  fi
}

# ----------------- Debian / APT 快捷指令 -----------------
alias update="sudo apt update && sudo apt upgrade -y"
alias install="sudo apt install -y"
alias remove="sudo apt remove --purge -y"
alias autoremove="sudo apt autoremove -y && sudo apt clean"

# ----------------- Systemd / 服务管理快捷指令 -----------------
alias sc="sudo systemctl"
alias sc-status="systemctl status"
alias sc-start="sudo systemctl start"
alias sc-stop="sudo systemctl stop"
alias sc-restart="sudo systemctl restart"
alias sc-reload="sudo systemctl reload"
alias sc-enable="sudo systemctl enable"
alias sc-disable="sudo systemctl disable"
alias jlog="journalctl -u"
alias jlogf="journalctl -f -u"
