local f = require('flash')
local wk = require('which-key')
wk.register {
    ["<leader>"] = {
        s = { f.jump, "Flash", mode = { "n", "x", "o" } },
        S = { f.treesitter, "Flash Treesitter", mode = { "n", "x", "o" } },
        r = { f.remote, "Remote Flash", mode = "o" },
        R = { f.treesitter_search, "Treesitter Search", mode = { "o", "x" } },
    },
    ['<c-s>'] = { f.toggle, "Toggle Flash Search", mode = { "c" } },
}
