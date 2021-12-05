" Author: Yash Diniz <yashdiniz@gmail.com>
" https://blog.jez.io/vim-as-an-ide/
set nocompatible	" http://stackoverflow.com/questions/5845557/ddg#5845583 , apparently default now :)

" Setting up requirements for Vundle.
filetype off	" temporarily turn off filetype
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'	" https://github.com/gmarik/vundle

" Installing NERDtree to help me out!
Plugin 'scrooloose/nerdtree'		" https://github.com/scrooloose/nerdtree
Plugin 'jistr/vim-nerdtree-tabs'	" https://github.com/jistr/vim-nerdtree-tabs

" Making vim look good
Plugin 'vim-airline/vim-airline'	" 

" Working with Git
Plugin 'airblade/vim-gitgutter'		" 
Plugin 'tpope/vim-fugitive'		" 

" Other text editing features
Plugin 'Raimondi/delimitMate'		" Automatic delimiter

" tmux
Plugin 'christoomey/vim-tmux-navigator'	" 

call vundle#end()

filetype plugin indent on	" turn filetype back on

" General settings
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch
set colorcolumn=100	" highlight column 100 for right margin awareness
set laststatus=2	" Always show statusbar

" turning on syntax highlighting
syntax on

" setting up mouse input for vim
set mouse=a

" ----- Plugin Settings -----

" --- vim-airline/vim-airline
let g:airline_detect_paste=1	" Show PASTE if in paste mode
let g:airline#extensions#tabline#enabled = 1	" Show airline for tabs too

" --- jistr/vim-nerdtree-tabs
" Allow open/close NERDtree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
"  To have NERDtree open at startup
let g:nerdtree_tabs_open_on_console_startup = 1

" --- airblade/vim-gitgutter settings
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" --- Raimondi/delimitMate settings
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

