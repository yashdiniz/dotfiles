local wk = require('which-key')
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

wk.add({
  { '<leader>p', '\"_dP',           desc = '[P]ut while maintaining current buffer',    mode = 'x' },
  { '<leader>d', '\"_d',            desc = '[D]elete while maintaining current buffer', mode = { 'n', 'v' } },
  { '<leader>y', '\"+y',            desc = '[Y]ank to system clipboard',                mode = { 'n', 'v' } },
  { '<leader>Y', '\"+Y',            desc = '[Y]ank line to system clipboard' },
  { '<leader>x', [[<cmd>bd<cr>]],   desc = 'Close a buffer' },

  { '<leader>g', group = 'gitsigns' },
  {
    '<leader>gd',
    [[<cmd>lua require('gitsigns').diffthis()<cr>]],
    desc = 'Enter [d]iff mode',
    mode = 'n'
  },
})

-- vim.keymap.set('n', '<C-h>', '<C-w>h')
-- vim.keymap.set('n', '<C-j>', '<C-w>j')
-- vim.keymap.set('n', '<C-k>', '<C-w>k')
-- vim.keymap.set('n', '<C-l>', '<C-w>l')

-- when in diff mode (nvim -d)
if vim.fn.has('diff') then
  -- http://vimcasts.org/episodes/fugitive-vim-resolving-merge-conflicts-with-vimdiff/
  -- :Gdiffsplit for three way merge,
  -- with dp as key binding to transfer the preferred hunk to working copy.
  -- Use [c or ]c to jump between hunks, and
  -- :only or :Gwrite[!] to finally show the working copy!
  vim.keymap.set('n', '<leader>h', [[<cmd>diffget //2 <CR>]])
  vim.keymap.set('n', '<leader>l', [[<cmd>diffget //3 <CR>]])
end
