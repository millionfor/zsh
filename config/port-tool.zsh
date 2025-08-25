#!/usr/bin/env bash
# port-tool.sh
# 在 Debian12 / macOS 下通用的端口管理工具 (bash 版)

set -e
OS="$(uname)"

usage() {
  echo "用法: port [命令] [参数]"
  echo "命令:"
  echo "  port list [port]    查看指定端口占用 (不带参数则列出所有监听端口)"
  echo "  port find <keyword> 根据进程名模糊搜索并显示相关端口"
  echo "  port kill <port>    杀掉占用该端口的进程"
  echo
  echo "提示: 在 ~/.bashrc 里加:"
  echo "  source ~/bin/port-tool.sh"
  echo
}

list_ports() {
  local port=$1
  if [[ "$OS" == "Darwin" ]]; then
    [[ -n "$port" ]] && lsof -nP -iTCP:"$port" -sTCP:LISTEN || lsof -nP -iTCP -sTCP:LISTEN
  else
    [[ -n "$port" ]] && ss -ltnp | grep ":$port" || ss -ltnp
  fi
}

find_by_name() {
  local keyword=$1
  if [[ "$OS" == "Darwin" ]]; then
    lsof -nP -iTCP -sTCP:LISTEN | grep -i "$keyword" || true
  else
    ss -ltnp | grep -i "$keyword" || true
  fi
}

kill_by_port() {
  local port=$1 pid
  if [[ "$OS" == "Darwin" ]]; then
    pid=$(lsof -nP -iTCP:"$port" -sTCP:LISTEN | awk 'NR==2{print $2}')
  else
    pid=$(ss -ltnp | grep ":$port" | awk -F',' '{print $2}' | awk -F'=' '{print $2}' | head -n1)
  fi
  [[ -n "$pid" ]] && { echo "杀掉进程 PID=$pid (端口 $port)"; kill -9 "$pid"; } || echo "未找到端口 $port 的进程"
}

port() {
  local cmd=$1; shift || true
  case "$cmd" in
    list) list_ports "$@" ;;
    find) find_by_name "$@" ;;
    kill) kill_by_port "$@" ;;
    *) usage ;;
  esac
}

