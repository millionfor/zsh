# zsh

一个基于zsh的配置文件

Debian12 + zsh 

## Usage

### Zsh

```shell
# 更新系统包列表
sudo apt update

# 安装Zsh
sudo apt install zsh

# 查看当前使用的shell
echo $SHELL

# 更改当前用户的默认shell
chsh -s $(which zsh)

# 退出并重新登录，或者重新启动系统，以使更改生效

```

一旦安装完成，你可以通过编辑~/.zshrc文件来配置Zsh环境

### Oh My Zsh

```shell
# 安装oh-my-zsh插件管理器（可选）
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 安装插件

- fzf
```shell
sudo apt install fzf
```

- fd
```shell
On macOS: brew install fd
On Arch Linux: pacman -S fd
On Ubuntu: apt install fd-find && ln -s $(which fdfind) sudo ln -s /usr/bin/fdfind /usr/bin/fd
On Debian: sudo apt-get install fd-find && ln -s $(which fdfind) ~/.local/bin/fd
```

- bat (可选 更好的文本预览效果) 注意版本 0.12.1,其他版本可能无法正常使用
```shell
wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb

sudo dpkg -i bat_0.12.1_amd64.deb

sudo apt install bat

batcat

sudo ln -s /usr/bin/batcat /usr/bin/bat
```


- ag (可选 更好的搜索效果)
```shell
sudo apt-get install silversearcher-ag
```

- exa (可选 更好的目录预览效果)

```shell
sudo apt install exa
```


- fzf (可选 更好的目录预览效果)
```shell
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```


## PLUGINS

1. z.lua
    > `z keyword`  
    > 按使用频率跳转到keyword关联目录  
    > 例如 `z zsh` 可快速跳转到 `~/.config/zsh` 目录  

2. extract  
    > `extract xxx`  
    > extract一个压缩文件  
    > 可根据不同压缩文件类型进行解压 无需记忆长解压指令  

3. zsh-autosuggestions  
    > 输入命令时从history中找到最符合的命令  
    > \<right> 使用该 suggestion  

4. zsh-syntax-highlighting  
    > 高亮输入命令  

5. fzf-tab  
    > tab时使用fzf进行候选选择  

