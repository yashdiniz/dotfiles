vim.keymap.set('c', 'ga', "Git add ", { desc = '[G]it [a]dd'})
vim.keymap.set('c', 'gc', [[<cmd>Git commit -S <CR>]], { desc = '[G]it signed [c]ommit' })
vim.keymap.set('c', 'gd', [[<cmd>Git diff <CR>]], { desc = '[G]it [d]iff' })
vim.keymap.set('c', 'gs', [[<cmd>Git status <CR>]], { desc = '[G]it [s]tatus' })
