#!/usr/bin/env zsh
# =======================================================
# 通用别名与实用函数 (macOS & Linux 通用)
# =======================================================

# ----------------- 核心文件与系统操作 -----------------
# 自定义安全删除功能并确认目录
r() {
  for arg in "$@"; do
    if [ -d "$arg" ]; then
      read "choice?Do you really want to delete $arg and its contents? [Y/N] "
      case "$choice" in
        [yY]) rm -rf "$arg" ;;
        [nN]) continue ;;
        *) echo "Invalid choice. Aborting." && return ;;
      esac
    else
      rm -i "$arg"
    fi
  done
}

# 查看目录下文件夹大小按照大小排序
alias du='du -sh * 2>/dev/null | sort -hr'

# 查看当前目录文件/文件夹大小
alias ds='du -sh * 2>/dev/null | sort -h'

# 查看一层目录大小 (兼容 macOS 与 Linux)
dh() {
  du -h -d 1 2>/dev/null || du -h --max-depth=1 2>/dev/null
}

# 获取本机 IP 地址 (兼容 macOS 与 Linux)
ip() {
  if [[ "$(uname)" == "Darwin" ]]; then
    ifconfig 2>/dev/null | grep 'inet ' | awk '{if($2!="127.0.0.1")print $2}'
  else
    local _ip
    _ip=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $7}')
    if [[ -n "$_ip" ]]; then
      echo "$_ip"
    else
      hostname -I 2>/dev/null | awk '{print $1}'
    fi
  fi
}

# 查找文件
f() {
  find "$1" -type f -name "*$2*"
}

# ----------------- 编辑器 -----------------
if command -v nvim &>/dev/null; then
  alias vim='nvim'
fi

# 进入 nvim 配置目录
gv() {
  cd ~/.config/nvim 2>/dev/null && ${EDITOR:-vim}
}

# 进入 zsh 配置目录
gz() {
  cd "${ZSH:-~/.config/zsh}" && ${EDITOR:-vim}
}

# ----------------- Git -----------------
alias g='git'
alias gc='git rm -r --cached .'

# git clone 并直接进入目录
gl() {
  if [ -z "$1" ]; then
    echo "Usage: gl <git-repo-url>"
    return 1
  fi
  local repo_url="$1"
  local repo_name
  repo_name=$(basename "$repo_url" .git)
  git clone "$repo_url" && cd "$repo_name" || return 1
}

# Lazygit 集成
lg() {
  if command -v lazygit &>/dev/null; then
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
    lazygit "$@"
    if [ -f "$LAZYGIT_NEW_DIR_FILE" ]; then
      cd "$(cat "$LAZYGIT_NEW_DIR_FILE")"
      rm -f "$LAZYGIT_NEW_DIR_FILE" > /dev/null
    fi
  else
    echo "lazygit is not installed."
  fi
}

# ----------------- Node / NPM / Yarn -----------------
# Yarn
alias y='yarn'
alias yi='yarn install'
alias ys='yarn start'
alias yy='yarn install && yarn start'
alias yc='yarn cache clean'

# NPM
alias ni='npm install'
alias ns='npm run start'
alias nd='npm run dev'
alias nn='npm install && npm run start'
alias nc='npm cache clean --force'
alias npp='npm publish --access public'

# NPM 卸载包
nu() {
  npm unpublish "$1" --force
}

# ----------------- 压缩与解压 -----------------
# tar 压缩
cx() {
  tar -cvf "$1.tar" *"$2"
}

# tar.gz 压缩
cgz() {
  tar -czf "$1.tar.gz" *"$2"
}

# tar.bz2 压缩
cbz2() {
  tar -cjf "$1.tar.bz2" *"$2"
}

# 智能解压 (优先使用 extract 插件)
ex() {
  if typeset -f extract >/dev/null; then
    extract "$@"
  else
    if [[ -z "$1" ]]; then
      echo "Usage: ex <filename>"
      return 1
    elif [[ -f "$1" ]]; then
      case "$1" in
        *.tar)      tar xvf "$1" ;;
        *.tbz2|*.tar.bz2) tar xvjf "$1" ;;
        *.tgz|*.tar.gz)   tar xvzf "$1" ;;
        *.tar.xz)   tar xvJf "$1" ;;
        *.bz2)      bunzip2 "$1" ;;
        *.rar)      unrar x "$1" ;;
        *.gz)       gunzip "$1" ;;
        *.zip)      unzip "$1" ;;
        *.Z)        uncompress "$1" ;;
        *.7z)       7z x "$1" ;;
        *)          echo "'$1' cannot be extracted via ex()" ;;
      esac
    else
      echo "'$1' is not a valid file"
    fi
  fi
}

# ----------------- 其他工具 -----------------
# fastfetch
alias ff="fastfetch"

# 生成 SSH 密钥
sshkey() {
  ssh-keygen -t rsa -b 4096 -C "$1"
}

# Curl POST JSON
cpost() {
  curl -X POST -H "Content-Type: application/json" -d "$1" "$2"
}

# SSH 远程端口转发
s() {
  ssh -R 2489:127.0.0.1:2489 "$1"
}

# 打印终端 256 颜色测试
color() {
  local -a colors
  for i in {000..255}; do
    colors+=("%F{$i}$i%f")
  done
  print -cP $colors
}
