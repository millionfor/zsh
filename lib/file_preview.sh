#!/usr/bin/env bash
# =======================================================
# FZF 智能文件与目录预览脚本
# =======================================================

target="$1"
[[ ! -e "$target" ]] && echo "Not found: $target" && exit 0

# ----------------- 目录预览 -----------------
if [ -d "$target" ]; then
  if command -v eza &>/dev/null; then
    eza -1 --icons --color=always "$target" 2>/dev/null
  elif command -v exa &>/dev/null; then
    exa -1 --icons --color=always "$target" 2>/dev/null
  elif [[ "$(uname)" == "Darwin" ]]; then
    ls -1 -G "$target" 2>/dev/null
  else
    ls -1 --color=always "$target" 2>/dev/null
  fi
  exit 0
fi

# ----------------- 文件预览 -----------------
mime=$(file -bL --mime-type "$target" 2>/dev/null || echo "text/plain")
category=${mime%%/*}

if [ "$category" = "text" ] || [ "$mime" = "application/json" ] || [ "$mime" = "application/javascript" ] || [ "$mime" = "application/x-sh" ] || [ "$mime" = "application/xml" ]; then
  if command -v bat &>/dev/null; then
    bat -p --color=always "$target" 2>/dev/null | head -500
  elif command -v batcat &>/dev/null; then
    batcat -p --color=always "$target" 2>/dev/null | head -500
  else
    cat "$target" 2>/dev/null | head -500
  fi
elif [ "$category" = "image" ]; then
  if command -v imgcat &>/dev/null; then
    imgcat "$target"
  else
    echo "Image file: $target (MIME: $mime)"
  fi
else
  echo "$target is a $category file ($mime)"
fi
