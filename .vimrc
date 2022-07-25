" Author: Yash Diniz 

" Setting up requirements for Vundle.
" filetype off	" temporarily turn off filetype
" set rtp+=~/.config/nvim/bundle/Vundle.vim

call plug#begin()

" Plug 'VundleVim/Vundle.vim'	" https://github.com/gmarik/vundle

" make vim look good
Plug 'vim-airline/vim-airline'

" Working with Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Other text editing features (syntax highlighting, delimiter, comment toggling)
Plug 'Raimondi/delimitMate'     " Automatic delimiter
Plug 'mbbill/undotree'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-commentary'
Plug 'elixir-lang/vim-elixir'

" fzf!
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" tmux
" Plug 'kien/ctrlp.vim'			        " Fuzzy find(using C-p for fuzzy file search)
Plug 'christoomey/vim-tmux-navigator'

" language extensions
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'rust-lang/rust.vim'

" linters
Plug 'dense-analysis/ale'

" autocomplete
" Plug 'Shougo/deoplete.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" GitHub copilot
Plug 'github/copilot.vim'

call plug#end()

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
set colorcolumn=120	" highlight column for right margin awareness
set cmdheight=3		" Give more height for command output space
set laststatus=2	" Always show statusbar

set autoread        " automatically reflect changes if file updates externally

" no need of backups since we have git
set nobackup
set nowritebackup
set noswapfile		" we have >4G RAM anyway

" reducing updatetime to reduce latency for a better UX
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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
nnoremap <leader>f :Rg<CR>

" Open netRW with ,-t
nnoremap <leader>t :Explore<CR>

" --- fatih/vim-go settings
" Get the Go definition
nnoremap <leader>d :GoDef<CR>
" Get the Go declaration
nnoremap <leader>D :GoDecls<CR>

" --- mbbill/undotree settings
" Setup ,u for showing undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" --- tpope/vim-commentary settings
" Toggle comments on <C-/>
nmap <C-/> :CommentaryLine<CR>

" When in diff mode (nvim -d)
" https://gist.github.com/karenyyng/f19ff75c60f18b4b8149?permalink_comment_id=2123915#gistcomment-2123915
if &diff
    map <leader>1 :diffget LOCAL<CR>
    map <leader>2 :diffget BASE<CR>
    map <leader>3 :diffget REMOTE<CR>
endif

" --- github/copilot.vim settings
" Preventing the default tab behaviour to allow for coc to work its autocomplete functionality.
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" --- neoclide/coc.nvim settings
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" --- dense-analysis/ale
let g:ale_linters = {'rust': ['analyzer']}

" --- neoclide/coc.nvim
let g:coc_node_path = '/usr/bin/node'

" --- Shougo/deoplete.nvim
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('omni_patterns', { 
"             \    'go': '[^. *\t]\.\w*',
"             \ })

" --- fatih/vim-go
" https://github.com/golang/tools/blob/master/gopls/doc/vim.md
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_auto_sameids = 1

" --- vim-airline/vim-airline
let g:airline_detect_paste = 1	" Show PASTE if in paste mode
let g:airline#extensions#tabline#enabled = 1	" Show airline for tabs too
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

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

