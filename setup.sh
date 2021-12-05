# add .bash_aliases to the home directory, where it should be.
ln -s ~/linux-customizations/.bash_aliases ~/
# add .vimrc to the home directory, where it shoudld be.
#ln -s ~/linux-customizations/.vimrc ~/

# adding vundle to neovim
mkdir -p ~/.config/nvim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
cp ~/linux-customizations/.vimrc ~/.config/nvim/init.vim
