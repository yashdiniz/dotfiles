require('zen-mode').setup {
    window = {
        backdrop = 1,
        width = .75,
    },
    plugins = {
        twilight = { enabled = true },
    }
}

local wk = require('which-key')
wk.register({
    ['<leader>'] = {
        z = { [[<cmd>ZenMode<CR>]], "Toggle Zenmode", noremap = true, silent = true }
    }
})
