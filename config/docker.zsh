#!/bin/bash
# vim: set ft=sh fdm=manual ts=2 sw=2 sts=2 tw=85 et:

# =======================================================
# Description:     
# Filename:        docker.sh
# Author           QuanQuan <millionfor@apache.org>
# Last Modified    Tue, Apr 30, 2024 14:55
# GistID           %Gist_ID%
# GistURL          https://gist.github.com/millionfor/%Gist_ID%
# =======================================================

# 编译成镜像
db() {
  local name="$1"
  shift 1
  local env_args=()
  while [[ "$#" -gt 0 ]]; do
    env_args+=("--build-arg" "$1")
    shift
  done
  docker build "${env_args[@]}" --network=host -t $name .
}

# 根据镜像运行容器
# dr 名称 端口 镜像名 PORT=3100 ENV_TYPE=wx CONNECTION_SETTING=xxxxx CHANNEL=xxxx CONNECT=xxxx
dr() {
  local name="$1"
  local port="$2"
  local image="$3"
  shift 3
  local env_args=()
  while [[ "$#" -gt 0 ]]; do
    env_args+=("--env" "$1")
    shift
  done
  docker run --name="$name" --restart=always ${env_args[@]} --network=host -p "$port:$port" -d $image
}

# 获取镜像列表
di() {
  docker images
}

# 获取镜像列表
dp() {
  docker ps
}


# 删除单个镜像
drmi() {
  docker rmi $1 -f
}

# 删除单个容器
drm() {
  docker rm $1 -f
}

# 删除所有容器
drma() {
  docker rm $(docker ps -aq)
}

# 停止容器运行
dt() {
  docker stop $1
}

# 查看实时日志
dl() {
  docker logs --tail ${2:-500} -f $1
}

# 进入容器
dep() {
  docker exec -it $1 /bin/bash
}

dei() {
  docker run -it $1 /bin/bash
}

drs() {
  docker restart $1
}

# docker ---------------------
alias focusfix='printf "\e[?1004l"'


# docker-compose 启动
dc() {
  _dc_file=docker-compose.yml
  _dc_env=$1
  _dc_num=$2

  if [ -z "$1" ]; then
    _dc_file=docker-compose.yml
    _dc_env=""
  else
    _dc_file=docker-compose.$1.yml
  fi

  if [ -z "$2" ]; then
    _dc_num="1"
  fi

  if [ -n "$1" ] && [ -n "$2" ]; then
    docker-compose -f ${_dc_file} up -d --scale ${_dc_env}=${_dc_num}
  fi
}

