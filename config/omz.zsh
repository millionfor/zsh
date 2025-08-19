export ZSH=~/.config/zsh

source $ZSH/lib/omz.sh
source $ZSH/plugins/z.lua/z.lua.plugin.zsh
source $ZSH/plugins/extract/extract.plugin.zsh
# fzf-tab
source $ZSH/plugins/fzf-tab/fzf-tab.zsh
# 自动补全
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# 语法高亮
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias scp=$ZSH/plugins/fzf-sshscp-example/scp.sh
alias ssh=$ZSH/plugins/fzf-sshscp-example/ssh.sh

# alias scp=/Users/millionfor/Workspace/g/fzf-sshscp-example/scp.sh
# alias ssh=/Users/millionfor/Workspace/g/fzf-sshscp-example/ssh.sh

