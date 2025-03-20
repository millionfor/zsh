function echo_path() {
  # 获取当前输入法
  current_input_method=$(/opt/homebrew/bin/im-select)

  # 判断当前输入法是否是 ABC
  if [[ "$current_input_method" != "com.apple.keylayout.ABC" ]]; then
    # 如果不是 ABC，切换到 ABC 输入法
    /opt/homebrew/bin/im-select com.apple.keylayout.ABC
  fi

  # 执行回车键的默认行为
  zle accept-line
}

# 将 echo_path 函数注册为 ZLE 小部件
zle -N echo_path

# 将 echo_path 绑定到回车键
bindkey '^M' echo_path
