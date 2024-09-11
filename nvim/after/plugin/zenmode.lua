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
wk.add({
    { '<leader>z', [[<cmd>ZenMode<CR>]], desc = 'Toggle Zenmode', remap = false, silent = true },
})
