vim.keymap.set('c', 'ga', "Git add ", { desc = '[G]it [a]dd'})
vim.keymap.set('c', 'gc', [[<cmd>Git commit -S<CR>]], { desc = '[G]it signed [c]ommit' })
