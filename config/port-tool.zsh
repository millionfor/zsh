#!/usr/bin/env bash
# 最终版 port 工具（macOS + Linux 通用）

port() {
  local OS="$(uname)"

  # ----------- 彩色输出 -----------
  RED="\033[31m"
  GREEN="\033[32m"
  YELLOW="\033[33m"
  BLUE="\033[34m"
  RESET="\033[0m"

  # ----------- 帮助信息 -----------
  usage() {
    echo "📌 ${BLUE}端口管理工具 port${RESET}"
    echo
    echo "用法:"
    echo "  port list [port]       查看端口占用"
    echo "  port find <keyword>    搜索进程占用端口"
    echo "  port kill <port|pid>   智能 kill（支持端口或 PID）"
    echo
    echo "建议添加到 ~/.zshrc:"
    echo "  alias port='po'"
  }

  # ----------- 列出端口 -----------
  list_ports() {
    local port=$1
    echo -e "${BLUE}▶ 端口列表${RESET}"

    if [[ "$OS" == "Darwin" ]]; then
      # 打印表头
      printf "%-8s %-8s %-20s %s\n" "PORT" "PID" "SERVICE" "PATH"
      printf "%-8s %-8s %-20s %s\n" "--------" "--------" "--------------------" "----"

      local lsof_out
      if [[ -n "$port" ]]; then
        lsof_out=$(lsof -nP -iTCP:"$port" -sTCP:LISTEN 2>/dev/null)
      else
        lsof_out=$(lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null)
      fi

      # 跳过 lsof 的标题行，逐行解析
      echo "$lsof_out" | tail -n +2 | while read -r line; do
        local pid name addr
        pid=$(echo "$line" | awk '{print $2}')
        name=$(echo "$line" | awk '{print $1}')
        addr=$(echo "$line" | awk '{print $9}' | sed 's/.*://')   # 提取端口号
        local exe
        exe=$(ps -p "$pid" -o comm= 2>/dev/null || echo "?")
        # 尝试获取完整路径
        local fullpath
        fullpath=$(lsof -p "$pid" 2>/dev/null | awk '$4=="txt" && $5=="REG" {print $9; exit}')
        [[ -z "$fullpath" ]] && fullpath="$exe"
        printf "${GREEN}%-8s${RESET} %-8s ${YELLOW}%-20s${RESET} %s\n" "$addr" "$pid" "$name" "$fullpath"
      done
    else
      if [[ -n "$port" ]]; then
        ss -ltnp | grep ":$port"
      else
        ss -ltnp
      fi
    fi
  }

  # ----------- 按关键字搜索 -----------
  find_by_name() {
    local keyword=$1
    echo -e "${BLUE}▶ 搜索关键词:${RESET} $keyword"

    if [[ "$OS" == "Darwin" ]]; then
      lsof -nP -iTCP -sTCP:LISTEN | grep -i "$keyword" || true
    else
      ss -ltnp | grep -i "$keyword" || true
    fi
  }

  # ----------- 智能 kill（核心） -----------
  kill_smart() {
    local input=$1
    if [[ -z "$input" ]]; then
      echo -e "${RED}错误：请提供端口或 PID${RESET}"
      return
    fi

    local pid_by_port=""
    local pid_exists=""

    # ---------- 判断是否是端口 ----------
    if [[ "$OS" == "Darwin" ]]; then
      pid_by_port=$(lsof -nP -iTCP:"$input" -sTCP:LISTEN | awk 'NR==2{print $2}')
    else
      pid_by_port=$(ss -ltnp | grep ":$input" | sed -n 's/.*pid=\([0-9]\+\).*/\1/p' | head -n1)
    fi

    if [[ -n "$pid_by_port" ]]; then
      echo -e "${YELLOW}🔪 杀掉监听端口 $input 的进程 PID=$pid_by_port${RESET}"
      kill -9 "$pid_by_port" && echo -e "${GREEN}✔ 已杀掉 PID=$pid_by_port${RESET}"
      return
    fi

    # ---------- 判断是否是 PID ----------
    if ps -p "$input" > /dev/null 2>&1; then
      echo -e "${YELLOW}🔪 按 PID 杀掉进程 PID=$input${RESET}"
      kill -9 "$input" && echo -e "${GREEN}✔ 已杀掉 PID=$input${RESET}" \
                       || echo -e "${RED}✖ PID=$input 杀失败${RESET}"
      return
    fi

    # ---------- 都不是 ----------
    echo -e "${RED}⚠️ 未找到端口或 PID：$input${RESET}"
  }

  # ----------- 主入口 -----------
  local cmd=$1
  shift || true

  case "$cmd" in
    list) list_ports "$@" ;;
    find) find_by_name "$@" ;;
    kill) kill_smart "$@" ;;
    *) usage ;;
  esac
}
