-- https://youtu.be/w7i4amO_zaE?t=846
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>a', mark.add_file, { desc = '[A]dd file to harpoon' })
vim.keymap.set('n', '<leader>j', ui.toggle_quick_menu, { desc = '[j] Toggle harpoon quick menu' })

local wk = require('which-key')
wk.register({
    ['<leader>'] = {
        a = { mark.add_file, '[a]dd file to harpoon' },
        j = { mark.toggle_quick_menu, '[j] toggle harpoon quick menu' }
    }
})
