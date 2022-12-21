-- set <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- remap ; to :
vim.keymap.set({ 'n', 'v' }, ';', ':')

-- move blocks of highlighted code!
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- keep cursor in the middle as we jump around in files
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', 'n', "nzz")
vim.keymap.set('n', 'N', "Nzz")

-- replace while maintaining current buffer!
vim.keymap.set('x', '<leader>p', "\"_dP")

-- delete while maintaining curent buffer!
vim.keymap.set('n', '<leader>d', "\"_d")
vim.keymap.set('v', '<leader>d', "\"_d")

-- yank to system clipboard!
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")

-- when in diff mode (nvim -d)
if vim.fn.has('diff') then
  -- http://vimcasts.org/episodes/fugitive-vim-resolving-merge-conflicts-with-vimdiff/
  -- :Gdiffsplit for three way merge, 
  -- with dp as key binding to transfer the preferred hunk to working copy. 
  -- Use [c or ]c to jump between hunks, and
  -- :only or :Gwrite[!] to finally show the working copy!
  vim.keymap.set('n', '<leader>h', "<cmd>diffget //2<CR>")
  vim.keymap.set('n', '<leader>l', "<cmd>diffget //3<CR>")
end

-- vim.keymap.set('n', '<C-h>', '<C-w>h')
-- vim.keymap.set('n', '<C-j>', '<C-w>j')
-- vim.keymap.set('n', '<C-k>', '<C-w>k')
-- vim.keymap.set('n', '<C-l>', '<C-w>l')
