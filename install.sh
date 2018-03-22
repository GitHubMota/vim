#!/bin/bash
echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
    sudo apt-get install -y vim vim-gnome ctags cscope xclip astyle python-setuptools python-dev git
elif which yum >/dev/null; then
    sudo yum install -y gcc vim git ctags cscope xclip astyle python-setuptools python-devel   
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags cscope git astyle
fi

sudo easy_install -ZU autopep8 
if [ ! -x /usr/local/bin/ctags ];then
    sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
fi

if [ ! -f "_vimrc" ] || [ ! -f "Tomorrow-Night-Eighties.vim" ];then
    echo "git clone _vimrc and Tomorrow-Night-Eighties.vim from github."
    rm -rf ./vim
    git clone https://github.com/GitHubMota/vim.git
    mv vim/_vimrc .
    mv vim/Tomorrow-Night-Eighties.vim .
fi

if [ -f ~/.vimrc ];then
    echo "move old .vimrc to .vimrc_old"
    mv ~/.vimrc ~/.vimrc_old
elif [ -L ~/.vimrc ];then
    echo "del old .vimrc link"
    rm ~/.vimrc
fi
ln -s $PWD/_vimrc ~/.vimrc

mkdir -p ~/.vim/colors
cp Tomorrow-Night-Eighties.vim ~/.vim/colors/

echo "ma6174正在努力为您安装bundle程序" > ma6174
echo "安装完毕将自动退出" >> ma6174
echo "请耐心等待" >> ma6174
vim ma6174 -c "PlugInstall" -c "q" -c "q"
rm ma6174
echo "安装完成"
