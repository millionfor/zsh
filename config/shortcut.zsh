
alias nvim='LC_ALL=en_GB.utf-8 nvim'

alias vim='nvim'

alias g='git'
# git清除缓存
alias gc='git rm -r --cached .'

alias y='yarn'
alias yi='yarn install'
alias ys='yarn start'
alias yy='yarn install && yarn start'
# yarn清除缓存
alias yc="yarn cache clean"

alias p='pnpm'
alias pi='pnpm install'
alias ps='pnpm start'
alias pp='pnpm install && pnpm start'

alias ni='npm install'
alias ns='npm run start'
alias nn='npm install && npm run start'
# npm清除缓存
alias nc="npm cache clean --force"
# npm发布包
alias np="npm publish --access public"
# npm卸载包
nu() {
  npm unpublish $1 --force
}

pm2s() {
  pm2 start npm --name $1 -- run start --max-restarts 10 --min-uptime 2000
}


alias focusfix='printf "\e[?1004l"'

# sublint 打开文件
alias sub="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# vscode 打开文件
alias vs="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# 设置代理
alias sproxy="export ALL_PROXY=socks5://127.0.0.1:20170; echo -e '=> 开启代理 \c'; eval 'curl myip.ipip.net'" 
# 取消代理
alias uproxy="unset ALL_PROXY; echo -e '=> 关闭代理 \c'; eval 'curl myip.ipip.net'"
# 测试代理
alias tproxy="curl cip.cc"

# 进入工作目录
a() {
  eval "cd ~/WebstormProjects"
}

# 打开当前目录
a.() {
  eval "open ."
}

# 进入工作目录
aw() {
  cd ~/workspace
}

# 进入工作目录g目录
awg() {
  cd ~/workspace/g
}


# 进入测试目录
at() {
  cd ~/WebstormProjects/test
}


# 进入下载目录
ad() {
  cd ~/Downloads
}

# 进入桌面目录
adt() {
  cd ~/Desktop
}


# 进入hydee项目目录
ah() { eval "cd ~/WebstormProjects/hydee-perject" }

# 进入npm目录
an() { eval "cd ~/WebstormProjects/hydee-perject/npm" }

# 进入hss目录
ahss() { 
  eval "cd ~/WebstormProjects/hydee-perject/npm/hss-modules" 
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

# 查看大小
dh() {
  du -h -d 1
}

# 进入nvim
gv() {
  cd ~/.config/nvim && vim
}

# 进入nvim
gz() {
  cd ~/.config/zsh && vim
}

# 进入config
config() {
  cd ~/.config
}


# h
s() {
  ssh -R 2489:127.0.0.1:2489 $1
}
# 获取颜色
color() {
    local -a colors
    for i in {000..255}; do
        colors+=("%F{$i}$i%f")
    done
    print -cP $colors
}

# 删除仍回收站
# export TRASH=~/.Trash
# rm() {
#   for f in $*;
#   do
#     dir=$TRASH/$(date '+%Y%m%d-%H%M')
#     target=$dir/${f##*/}
#     mkdir -p $dir
#     [ -f $f ] && mv $f $target;
#     [ -d $f ] && mv $f $target;
#   done
# }


