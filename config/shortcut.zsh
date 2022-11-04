
alias vim='LC_ALL=en_GB.utf-8 nvim'

alias n='LC_ALL=en_GB.utf-8 nvim'

alias g='git'

alias y='yarn'

alias myip='curl ipinfo.io/ip'

alias focusfix='printf "\e[?1004l"'

# sublint 打开文件
alias sub="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# vscode 打开文件
alias vs="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# 进入工作目录
ws() {
  cd ~/workspace
}

gg() {
  if [[ ! -z "$1" ]]; then
    if [[ "$1" == "." ]]; then
      eval "open ."
    elif [[ "$1" == "h" ]]; then
      eval "cd ~/WebstormProjects/hydee-perject"
    elif [[ "$1" == "n" ]]; then
      eval "cd ~/WebstormProjects/hydee-perject/npm"
    elif [[ "$1" == "hss" ]]; then
      eval "cd ~/WebstormProjects/hydee-perject/npm/hss-modules"
    elif [[ "$1" == "hss" ]]; then
      eval "cd ~/WebstormProjects/hydee-perject/npm/hss-modules"
    elif [[ "$1" == "app" ]]; then
      eval "cd ~/WebstormProjects/hydee-perject/hydee-merchant-manage/app"
    else
      cd ~/WebstormProjects/$1
    fi
  else
    cd ~/WebstormProjects
  fi
}

# 打开具体文档（vim|php|mysql|docker）
doc() {
  [[ ! -z "$1" ]] && name=$1 || name=vim
  vim ~/.config/docs/$name-doc.md
}

# https://github.com/jesseduffield/lazygit
lg() {
  export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

  lazygit "$@"

  if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
    cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
    rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
  fi
}

# {c} 压缩
cx() {
  tar -cvf $1.tar *$2
}

# 压缩gz
cgz() {
  tar -czf $1.tar.gz *$2
}

# 压缩bz2
cbz2() {
  tar -cjf $1.tar.bz2 *$2
}

# 解压
ex() {
  if [[ -z “$1” ]]; then
    print -P “usage: \e[1
    36mex\e[1
    0m < filename > ”
    print -P ” Extract the file specified based on the extension”
  elif [[ -f $1 ]]; then
    case $1 in
      *.tar) tar xvf $1 ;;
      *.tbz2) tar xvf $1 ;;
      *.tgz) tar xvf $1 ;;
      *.tar.bz2) tar xvf $1 ;;
      *.tar.gz) tar xvf $1 ;;
      *.tar.xz) tar xvf $1 ;;
      *.tar.Z) tar xvf $1 ;;
      *.bz2) bunzip2v $1 ;;
      *.rar) rar x $1 ;;
      *.gz) gunzip $1 ;;
      *.zip) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.xz) xz -d $1 ;;
      *.lzo) lzo -dv $1 ;;
      *.7z) 7z x $1 ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo “‘$1’ is not a valid file”
  fi
}


# 获取ip地址
ip() {
  # networksetup -setmanualwithdhcprouter WI-FI 192.168.0.66
  ifconfig | grep 'inet ' | awk '{if($2!="127.0.0.1")print $2}'
}

# 打开单窗口
it() {
  itermocil --here $1
}
# 打开多窗口
its() {
  for i in $*; do
    if [ $i = $1 ]; then
      itermocil --here $i
    else
      itermocil $i
    fi
  done
}

# 进入nvim
gv() {
  cd ~/.config/nvim && vim
}

# h
s() {
  ssh -R 2489:127.0.0.1:2489 $1
}

# 删除仍回收站

export TRASH=~/.Trash
rm() {
  for f in $*;
  do
    dir=$TRASH/$(date '+%Y%m%d-%H%M')
    target=$dir/${f##*/}
    mkdir -p $dir
    [ -f $f ] && mv $f $target;
    [ -d $f ] && mv $f $target;
  done
}

