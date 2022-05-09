" Author: Yash Diniz 
" set nocompatible	" http://stackoverflow.com/questions/5845557/ddg#5845583 , apparently default now :)

" Setting up requirements for Vundle.
filetype off	" temporarily turn off filetype
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'	" https://github.com/gmarik/vundle

" Installing NERDtree to help me out!
" Plugin 'scrooloose/nerdtree'		" https://github.com/scrooloose/nerdtree
" Plugin 'jistr/vim-nerdtree-tabs'	" https://github.com/jistr/vim-nerdtree-tabs

" Making vim look good
Plugin 'vim-airline/vim-airline'	" https://github.com/vim-airline/vim-airline

" Working with Git
Plugin 'airblade/vim-gitgutter'		" shows line changed by adding symbol in gutter.
Plugin 'tpope/vim-fugitive'		    " git wrapper (https://github.com/tpope/vim-fugitive)

" Other text editing features
Plugin 'Raimondi/delimitMate'		" Automatic delimiter
Plugin 'mbbill/undotree'		    " 
Plugin 'tpope/vim-markdown'		    " Syntax completion and highlighting, markdown
Plugin 'tpope/vim-commentary'		" toggling comments

" syntax highlighting
Plugin 'elixir-lang/vim-elixir'         " using elixir

" setting up fzf for vim
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

" tmux
Plugin 'kien/ctrlp.vim'			        " Fuzzy find(using C-p for fuzzy file search)
Plugin 'christoomey/vim-tmux-navigator'	" 

" golang!
Plugin 'fatih/vim-go'               " https://github.com/fatih/vim-go

" GitHub copilot
Plugin 'github/copilot.vim'         " https://github.com/github/copilot.vim

call vundle#end()

filetype plugin indent on	" turn filetype back on

""""""""""""""""""""""""""
" --- General settings ---
""""""""""""""""""""""""""

set backspace=indent,eol,start  " pressing backspace will fix indent!
set ruler
set number
set showcmd
set incsearch
set hlsearch

set ai              " auto indent
set si              " smart indent

set expandtab		" use spaces instead of tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set smarttab		" uses tabstops for indentation (smart bksp for spaces as tabs)
set rnu			    " shows relative line number in the gutter
set noshowmode		" do not show INSERT, VISUAL, etc since vim-airline already does
set colorcolumn=100	" highlight column 100 for right margin awareness
set cmdheight=3		" Give more height for command output space
set laststatus=2	" Always show statusbar

set autoread        " automatically reflect changes if file updates externally

" no need of backups since we have git
set nobackup
set nowritebackup
set noswapfile		" we have >4G RAM anyway

" setting up mouse input for vim
set mouse=a

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

""""""""""""""""""""""""""""
" --- Custom Keybindings ---
""""""""""""""""""""""""""""

let mapleader=","   " setting comma as leader instead of \

" enter command mode without needing to press shift+;
nnoremap ; :
vnoremap ; :
" move vertically by visual line (don't skip wrapped lines) 
nnoremap j gj
nnoremap k gk

" search all files with ,-p (fzf.vim)
nnoremap <leader>p :Files<CR>

" search git commits with ,-c (fzf.vim)
nnoremap <leader>c :Commits<CR>

" search within files and code (using ripgrep) ,-f (fzf.vim)
nnoremap <Leader>f :Rg<CR>

" Open netRW with ,-t
nnoremap <Leader>t :Explore<CR>

" turning on syntax highlighting
" syntax on	" apparently default now :)

""""""""""""""""""""
" --- File types ---
""""""""""""""""""""

" recognize .md files as markdown files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" enable spell-checking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

"""""""""""""""""""""""""
" --- Plugin Settings ---
"""""""""""""""""""""""""

" using netrw (inbuilt) for interactive file tree
let g:netrw_liststyle = 3

" show hidden files
" let NERDTreeShowHidden=1

" --- vim-airline/vim-airline
let g:airline_detect_paste=1	" Show PASTE if in paste mode
let g:airline#extensions#tabline#enabled = 1	" Show airline for tabs too

" --- jistr/vim-nerdtree-tabs and nerdtree
" Allow open/close NERDtree Tabs with \t
" nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
"  To have NERDtree open at startup
" let g:nerdtree_tabs_open_on_console_startup = 1

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

" --- mbbill/undotree settings
" Setup \u for showing undo tree
nmap <silent> <leader>u :UndotreeToggle<CR>

" --- tpope/vim-commentary settings
" Toggle comments on <C-/>
nnoremap <C-/> :CommentaryLine<CR>
