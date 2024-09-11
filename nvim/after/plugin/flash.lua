local f = require('flash')
local wk = require('which-key')
wk.add({
    { '<leader>s', f.jump,              desc = 'Flash',               mode = { 'n', 'x', 'o' } },
    { '<leader>S', f.treesitter,        desc = 'Flash Treesitter',    mode = { 'n', 'x', 'o' } },
    { '<leader>r', f.remote,            desc = 'Remote Flash',        mode = 'o' },
    { '<leader>R', f.treesitter_search, desc = 'Treesitter Search',   mode = { 'o', 'x' } },
    { '<c-s>',     f.toggle,            desc = 'Toggle Flash Search', mode = { 'c' } },
})
