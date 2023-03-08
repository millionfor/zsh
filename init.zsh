export ZSH=~/.config/zsh
source $ZSH/config/shortcut.zsh
source $ZSH/config/exports.zsh
export OMZ=$(cd $(dirname $0);pwd)
source $OMZ/config/git.zsh
source $OMZ/config/omz.zsh
source $OMZ/config/fzf.zsh
# source $OMZ/config/hook.zsh
source $OMZ/themes/simple.zsh-theme

# export _OMZ_APPLY_CHPWD_HOOK=true

source $ZSH/config/simple.zsh-theme


