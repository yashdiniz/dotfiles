#!/bin/bash
# This script helps me setup my personal configs on a new linux machine

# Install latest nodejs (required for coc.nvim)
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
    # Or use package manager, e.g.
    # sudo apt-get install nodejs
fi

# adding vim-Plug to neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# alacritty
git clone https://github.com/alacritty/alacritty.git alacritty_git/

# add files to the home directory
ln -s ~/linux-customizations/.bash_aliases ~/.bash_aliases
ln -s ~/linux-customizations/.tmux.conf ~/.tmux.conf

# add folders to the .config directory
mkdir -p ~/.config
ln -s ~/linux-customizations/alacritty ~/.config/alacritty
ln -s ~/linux-customizations/nvim ~/.config/nvim
