# 颜色封装函数
_color() {
  case "$1" in
    black)    echo '\033[0;30m' ;;
    red)      echo '\033[0;31m' ;;
    green)    echo '\033[0;32m' ;;
    yellow)   echo '\033[0;33m' ;;
    blue)     echo '\033[0;34m' ;;
    magenta)  echo '\033[0;35m' ;;
    cyan)     echo '\033[0;36m' ;;
    white)    echo '\033[0;37m' ;;
    orange)   echo '\033[38;2;255;127;0m' ;;
    *)        echo '\033[0m' ;;  # 默认返回重置颜色
  esac
}

# 生成分隔线函数
_gen_separator() {
  local color="$1"
  local icon="$2"
  local label="$3"
  local term_width=$(tput cols)
  term_width=$((term_width < 30 ? 30 : term_width))
  
  # 计算标签位置
  # local label_pos=$((term_width / 10))
  local label_pos=16
  local label_length=${#label}
  
  # 计算前后线段长度
  local pre_length=$((label_pos - 1))
  local post_length=$((term_width - label_pos - label_length - 6))  # 减去图标和空格
  
  # 生成线段
  local pre_line=$(printf '%.0s■' $(seq 1 $pre_length))
  local post_line=$(printf '%.0s■' $(seq 1 $post_length))
  
  echo -e "${color}${icon} ${pre_line} [${label}] ${post_line}${RESET}"
}

# Zsh 快捷键帮助
_zsh_help() {
  _gen_separator "$(_color green)" "🔋" "Zsh / C = Control, S = Shift"
  echo "  <Fn-Right>      -光标回到行末
  <Fn-Left>       -光标回到行首
  <ff>            -选中/取消当前光标所在单词
  <vv>            -选中当前
  <S-mm>          -翻译替换成中/英文
  <C-Right>       -向右跳一个单词
  <C-Left>        -向左跳一个单词
  <S-Up>          -向上选中
  <S-Down>        -向下选中
  <S-Left>        -向左选中
  <S-Right>       -向右选中"
}   
   
# Neovim 快捷键帮助 
_nvim_help() {
  _gen_separator "$(_color yellow)" "🎗️" "Neovim"
  echo "  y               -复制选中内容
  <leader>g       -全选内容
  ff              -在项目内搜索文本
  F1              -xxxx
  F2              -xxxx
  F3              -xxxx
  F4              -xxxx
  F5              -xxxx
  F6              -xxxx
  F7              -xxxx
  F8              -xxxx
  F9              -xxxx
  gd              -跳转到定义"
}

# Docker 快捷键帮助
_docker_help() {
  _gen_separator "$(_color blue)" "🐟" "Docker"
  echo "  db              -构建镜像                    | db 镜像名称 [构建参数...]
  dr              -运行容器                    | dr 容器名称 端口 镜像名 [环境变量...]
  di              -查看镜像列表
  dp              -查看运行中的容器
  drmi            -删除镜像                    | drmi 镜像名1 镜像名2...
  drm             -删除容器                    | drm 容器名1 容器名2...
  drma            -删除所有容器    
  dt              -停止容器                    | dt 容器名
  dl              -查看日志                    | dl 容器名 [行数] 默认显示500行
  dep             -进入运行中的容              | dep 容器名
  dei             -以交互模式运行新容器        | dei 镜像名
  drs             -重启容器                    | drs 容器名
  $(_color blue)DockerCompose$(_color reset)
  dc              -启动服务                    | dc [环境] [实例数量] 例：dc默认docker-compose.yml服务"
}

# Git 快捷键帮助
_git_help() {
  _gen_separator "$(_color magenta)" "🐙" "Git"
  echo "  📦$(_color magenta) 暂存区（Stash）相关$(_color reset)
     sl                -查看 stash 列表                             | git sl	
     sp                -恢复并删除最新的 stash                      | git sp	
     sa                -恢复最新的 stash 但不删除                   | git sa
     sai               -恢复指定的 stash                            | git sai 1
  📜$(_color magenta) 日志与历史查看$(_color reset)
     lgh               -查看当前分支的 reflog（高亮关键操作）       | git lgh	
     l                 -详细日志（含作者、时间、提交信息）          | git l	
     ll                -简洁日志（带文件变更统计）                  | git l	
     lg                -图形化彩色日志（分支拓扑、相对时间）        | git lg		
     lf                -仅显示当前分支的图形化日志                  | git lf			
     lp                -图形化日志 + 显示代码差异（-p）             | git lp
     shlog             -自定义格式日志（哈希、时间、提交者）        | git shlog	
     fshow             -查看某 commit 修改的文件列表                | git fshow <commit>	
     merged            -查看已合并到 main 的分支（排除 master/dev） | git merged <branch>	
     find              -搜索代码变更（-S 参数）                     | git find 'keyword'
  ✏️$(_color magenta) 提交与修复$(_color reset)
     st                -简洁版 git status（--porcelain）            | git st
     ci                -允许空提交消息的提交                        | git ci
     amend             -修正最近提交（自动暂存未跟踪文件）          | git amend
     ua                -暂存已修改文件并修正提交                    | git ua
     uf                -对指定 commit 生成 fixup 并自动 rebase      | git uf <commit>
     fixup             -类似 uf，直接指定目标 commit                | git fixup <commit>
     ca                -修正最近提交（commit --amend）              | git ca	
  🌿$(_color magenta) 分支与远程操作$(_color reset)
     br                -列出所有分支                                | git br
     co                -切换分支                                    | git co <branch>
     rmbranch          -删除本地 + 远程分支                         | git rmbranch <branch>
     rmtag             -删除本地 + 远程标签                         | git rmtag <tag>
     rp                -修剪远程已删除的分支                        | git rp
  🔍$(_color magenta) 差异与合并$(_color reset)
     df                -忽略空白变化的差异（diff -b）               | git df
     dt                -启动 difftool 查看差异                      | git dt
     cr                -cherry-pick 指定 commit                     | git cr <commit>
     rbc               -继续 rebase（rebase --continue）            | git rbc
  🔄$(_color magenta) 推送与拉取$(_color reset)
     pom               -推送到 origin/master                        | git pom
     pl                -带 rebase 的拉取（pull --rebase）           | git pl
     pushf             -安全强制推送（--force-with-lease）          | git pushf
     acp               -快速提交并推送（消息：fix: up）             | git acp
     acc               -快速提交并推送（消息：ci: up）              | git acc
  📂$(_color magenta) 文件操作$(_color reset)
     ls                -列出版本控制下的文件                        | git ls
     vim               -用 vim 打开某 commit 修改的文件             | git vim <commit>
     mate              -用 TextMate 打开某 commit 修改的文件        | git mate <commit>
     subl              -用 Sublime Text 打开某 commit 修改的文件    | git subl <commit>
  ⚙️$(_color magenta) 高级操作$(_color reset)
     up                -综合更新（清理、拉取、子模块同步）          | git up
     incoming          -查看远程新增的提交（FETCH_HEAD..HEAD）      | git incoming
     outgoing          -查看本地未推送的提交（HEAD..FETCH_HEAD）    | git outgoing
     init              -初始化仓库并提交所有文件                    | git init
     alias             -列出所有别名                                | git alias
     tgz               -打包 HEAD 为 latest.tgz                     | git tgz
     show              -rev-number                                  | git show-rev-number
  🚀 $(_color magenta) 特殊用途$(_color reset)
     release           -调用 git-release 工具                       | git release
     deploy            -调用 git-cli-deploy 工具                    | git deploy
  "
}

# 主帮助函数
h() {
  case "$1" in
    zsh)      _zsh_help ;;
    nvim|nv)  _nvim_help ;;
    dk|docker) _docker_help ;;
    g|git)    _git_help ;;
    "")
      # 如果没有参数，显示全部帮助
      _zsh_help
      _nvim_help
      _docker_help
      _git_help
      ;;
    *)
      echo -e "$(_color red)Error:$(_color reset) Unknown option '$1'"
      echo "Available options: zsh, nvim, docker, git"
      ;;
  esac
}

# 重置颜色
RESET='\033[0m'
