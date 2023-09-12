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
wk.register({
  ['<leader>'] = {
    ['?'] = { builtin.oldfiles, '[?] Find recently opened files' },
    ['<space>'] = { builtin.buffers, '[ ] Find existing buffers' },
    ['/'] = { function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, '[/] Fuzzily search in current buffer' },

    s = {
      name = 'Search',
      f = { builtin.find_files, '[s]earch [f]iles' },
      h = { builtin.help_tags, '[s]earch [h]elp' },
      w = { builtin.grep_string, '[s]earch current [w]ord' },
      g = { builtin.live_grep, '[s]earch by [g]rep' },
      d = { builtin.diagnostics, '[s]earch [d]iagnostics' },
    }
  },
})
