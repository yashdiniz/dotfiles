-- disable netrw (recommended: https://github.com/nvim-tree/nvim-tree.lua#setup)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.wo.number = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- disable vim backups, but maintain list of undos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- do not highlight all search items, instead only highlight when under cursor
vim.opt.hlsearch = false
vim.opt.incsearch = true
-- also ignore case while searching unless /C or capital letter in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- stop scrolling at less than 8 lines on display
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

vim.opt.colorcolumn = "120"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
