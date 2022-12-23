require('zen-mode').setup {
    window = {
        backdrop = 1,
        width = .75,
    },
    plugins = {
        twilight = { enabled = true },
    }
}

vim.keymap.set('n', '<leader>z', [[<cmd>ZenMode<CR>]], { noremap = true, silent = true })
