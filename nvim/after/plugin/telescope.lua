-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- https://github.com/nvim-telescope/telescope.nvim#usage
local builtin = require('telescope.builtin')

local wk = require('which-key')
wk.add({
  { '<leader>?',       builtin.oldfiles, desc = '[?] Find recently opened files' },
  { '<leader><space>', builtin.buffers,  desc = '[ ] Find existing buffers' },
  {
    '<leader>/',
    function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end,
    desc = '[/] Fuzzily search in current buffer'
  },

  { '<leader>s',  group = 'Search' },
  { '<leader>sf', builtin.find_files,  desc = '[s]earch [f]iles' },
  { '<leader>sh', builtin.help_tags,   desc = '[s]earch [h]elp' },
  { '<leader>sw', builtin.grep_string, desc = '[s]earch current [w]ord' },
  { '<leader>sg', builtin.live_grep,   desc = '[s]earch by [g]rep' },
  { '<leader>sd', builtin.diagnostics, desc = '[s]earch [d]iagnostics' },
})
