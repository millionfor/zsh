#!/usr/bin/env zsh
# =======================================================
# macOS 专属别名与工具配置
# =======================================================

# ----------------- 应用快捷打开 -----------------
# Sublime Text
if [[ -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ]]; then
  alias sub="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
fi

# Visual Studio Code
if [[ -f "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]]; then
  alias vs="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
fi

# ----------------- 剪贴板增强 -----------------
# 获取当前路径并复制到剪贴板
pwd() {
  command pwd | tee /dev/tty | pbcopy
}

# ----------------- 代理快捷指令 -----------------
# Socks5 代理
alias sproxy="export ALL_PROXY=socks5://127.0.0.1:2080; echo -e '=> 开启代理 \c'; eval 'curl cip.cc'"
alias uproxy="unset ALL_PROXY; echo -e '=> 关闭代理 \c'; eval 'curl cip.cc'"
alias tproxy="curl cip.cc"

# HTTP 代理
alias sproxy_http="export http_proxy=http://127.0.0.1:1082; export https_proxy=http://127.0.0.1:1082; echo -e '=> 开启 HTTP 代理 \c'; eval 'curl cip.cc'"
alias uproxy_http="unset http_proxy https_proxy; echo -e '=> 关闭 HTTP 代理 \c'; eval 'curl cip.cc'"

# ----------------- 系统维护 -----------------
# 清理系统与包管理器缓存
macc() {
  echo "=> 清除 {yarn} 缓存..."
  command -v yarn &>/dev/null && yarn cache clean
  echo "\n=> 清除 {npm} 缓存..."
  command -v npm &>/dev/null && npm cache clean --force
  echo "\n=> 清除 {pnpm} 缓存..."
  command -v pnpm &>/dev/null && pnpm store prune
  echo "\n=> 清除 {废纸篓}..."
  rm -rf ~/.Trash/* 2>/dev/null
  echo "=> 清理完成!"
}

# 清除 macOS DNS 缓存
cldns() {
  sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder && echo "=> macOS DNS 缓存已刷新"
}

# 获取当前 Finder 所在目录并在终端跳转
des() {
  local curFinderDir
  curFinderDir=$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)' 2>/dev/null)
  if [[ -n "$curFinderDir" ]]; then
    echo "\033[32m$curFinderDir\033[0m"
    cd "$curFinderDir"
  else
    echo "Finder 未打开或无选中目录"
  fi
}

# 打开文档
doc() {
  local name="${1:-vim}"
  vim ~/.config/docs/"$name"-doc.md
}

# ----------------- Fcitx5 / Rime 词条管理 -----------------
add-phrase() {
  if [ $# -lt 2 ]; then
    echo "Usage: add-phrase <code> <phrase...>"
    return 1
  fi
  local code=$1
  shift
  local phrase=$*
  local target_file="$HOME/.local/share/fcitx5/rime/custom_phrase.txt"
  mkdir -p "$(dirname "$target_file")"
  printf "%s\t%s\n" "$phrase" "$code" >> "$target_file"
  echo "Added: ${phrase} -> ${code}"
  # 重启 Fcitx5 使配置立即生效
  killall Fcitx5 2>/dev/null && open -a "/Library/Input Methods/Fcitx5.app" 2>/dev/null
  echo "Fcitx5 reloaded."
}

del-phrase() {
  if [ -z "$1" ]; then
    echo "Usage: del-phrase <code>"
    return 1
  fi
  local code=$1
  local target_file="$HOME/.local/share/fcitx5/rime/custom_phrase.txt"
  if [[ ! -f "$target_file" ]]; then
    echo "Phrase file not found: $target_file"
    return 1
  fi
  awk -F'\t' -v c="$code" '$2 != c' "$target_file" > "${target_file}.tmp" && mv "${target_file}.tmp" "$target_file"
  echo "Deleted all phrases for code: ${code}"
  killall Fcitx5 2>/dev/null && open -a "/Library/Input Methods/Fcitx5.app" 2>/dev/null
  echo "Fcitx5 reloaded."
}
