" Author: Yash Diniz 

" Setting up requirements for Vundle.
filetype off	" temporarily turn off filetype
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'	" https://github.com/gmarik/vundle

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
let g:mapleader=','

" enter command mode without needing to press shift+;
nnoremap ; :
vnoremap ; :
nnoremap : :!
vnoremap : :!
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

" --- fatih/vim-go settings
" Get the Go definition
nnoremap <Leader>d :GoDef<CR>
" Get the Go declaration
nnoremap <Leader>D :GoDecls<CR>

" --- mbbill/undotree settings
" Setup \u for showing undo tree
nmap <silent> <leader>u ;UndotreeToggle<CR>

" --- tpope/vim-commentary settings
" Toggle comments on <C-/>
nnoremap <C-/> ;Commentary<CR>

" When in diff mode (nvim -d)
" https://gist.github.com/karenyyng/f19ff75c60f18b4b8149?permalink_comment_id=2123915#gistcomment-2123915
if &diff
    map <leader>1 :diffget LOCAL<CR>
    map <leader>2 :diffget BASE<CR>
    map <leader>3 :diffget REMOTE<CR>
endif

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

" --- vim-airline/vim-airline
let g:airline_detect_paste=1	" Show PASTE if in paste mode
let g:airline#extensions#tabline#enabled = 1	" Show airline for tabs too

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

