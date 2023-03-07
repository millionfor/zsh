export ZSH=~/.config/zsh
source $ZSH/config/zsh.zsh
source $ZSH/config/shortcut.zsh
source $ZSH/config/exports.zsh

export _OMZ_APPLY_CHPWD_HOOK=false

[ -f $ZSH/config/private.zsh ] && source $ZSH/config/private.zsh
source /Users/gongzijian/.config/zsh/omz/omz.zsh

source $ZSH/config/simple.zsh-theme


