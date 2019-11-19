#!/bin/bash

rsync --exclude '.git/' --exclude '.pytest_cache' --exclude '.DS_Store' \
      --exclude 'README.md' \
      --exclude 'bootstrap.sh' --exclude 'bootstrap-servers.sh' \
      -avh --no-perms . $HOME

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

chmod +x $HOME/.bin/*

source $HOME/.bash_profile
