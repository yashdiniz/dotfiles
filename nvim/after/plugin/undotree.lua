local wk = require('which-key')
wk.register({
    ['<leader>'] = {
        u = { [[<cmd>UndotreeToggle<cr>]], "Toggle Undotree pane" }
    }
})
