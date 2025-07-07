va() {
  if [ "$#" -eq 0 ]; then
    va list all
  elif [ "$1" = "-h" ] || [ "$1" = "-help" ]; then
    echo "Volta Usage:"
    echo "  va list all                  查看当前 Volta 已安装的所有内容"
    echo "  va install node@14.17.1      安装指定版本的 node"
    echo "  va install node@14           Volta 会选择 node14 中最新稳定的或合适的版本匹配你的请求"
    echo "  va install node              安装 node 最新的 LTS（最新稳定的版本）"
    echo "  va install npm               Volta 安装 npm 包管理器；选择 node 的默认版本运行"
    echo "  va install yarn              Volta 安装 yarn 包管理器；选择 node 的默认版本运行"
    echo "  va pin node@14.17.1          固定 node 版本到 package.json 中"
    echo "  va uninstall [FLAGS] <tool>  删除使用 Volta install 安装的任何全局软件包"
  else
    volta "$@"
  fi
}
