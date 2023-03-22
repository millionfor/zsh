#! /usr/bin/env sh
mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
if [ -d "$1" ]; then
    exa -l --no-user --no-time --icons "$1" 2>/dev/null || ls --color=tty "$1" 2>/dev/null || ls -G "$1"
elif [ "$category" = text ]; then
    (bat -p --color=always "$1" || cat "$1") 2>/dev/null | head -500
elif [ "$category" = image ]; then
    imgcat "$1"
else 
    echo $1 is a $category file
fi
