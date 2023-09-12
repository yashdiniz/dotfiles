local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_firsttime = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_firsttime = true
  vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- telescope.nvim
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use {
    'nanotee/zoxide.vim',
    requires = {
      'junegunn/fzf.vim',
    }
  }

  -- colorscheme onedark
  use {
    'navarasu/onedark.nvim',
    as = 'onedark',
  }

  -- nvim-dap
  use {
    'rcarriga/nvim-dap-ui',
    requires = {
      { 'mfussenegger/nvim-dap' },
    },
  }

  -- treesitter and playground
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end
  }
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use('nvim-treesitter/playground')

  use('mbbill/undotree')
  use('lewis6991/gitsigns.nvim')
  use('lewis6991/impatient.nvim')
  use('tpope/vim-fugitive')
  use {
    'tpope/vim-rhubarb',
    after = 'vim-fugitive'
  }
  use('lukas-reineke/indent-blankline.nvim') -- indentation guides
  use('numtoStr/Comment.nvim')               -- tool to use "gc" to comment visual regions
  use('tpope/vim-sleuth')                    -- smartly detect tabstop and shiftwidth

  -- lsp-zero reduces a lot of the boilerplate for LSP autocomplete
  use {
    'VonHeikemen/lsp-zero.nvim',
    as = 'lsp-zero',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lua' },
      {
        'windwp/nvim-autopairs',
        config = function()
          require('nvim-autopairs').setup()
        end
      },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      -- {'rafamadriz/friendly-snippets'},
      { 'honza/vim-snippets' },
    }
  }

  -- rust
  use {
    'rust-lang/rust.vim',
    after = 'lsp-zero'
  }

  -- rescript
  use {
    'rescript-lang/vim-rescript',
  }

  -- flutter
  use {
    'akinsho/flutter-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
      'dart-lang/dart-vim-plugin',
    },
  }

  -- thePrimeagen's harpoon
  use('theprimeagen/harpoon')

  -- fancier statusline
  use('nvim-lualine/lualine.nvim')

  -- file managing , picker etc
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { "nvim-tree/nvim-web-devicons" },
  }

  use {
    'folke/zen-mode.nvim',
    requires = { 'folke/twilight.nvim' },
  }

  -- GPT
  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })
  -- copilot!
  -- use {
  --   'zbirenbaum/copilot.lua',
  --   as = 'copilot',
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   config = function()
  --     require('copilot').setup {
  --       suggestion = {
  --         auto_trigger = true,
  --         keymap = {
  --           accept = '<C-j>',
  --         }
  --       }
  --     }
  --   end
  -- }
  -- use {
  --   'zbirenbaum/copilot-cmp',
  --   after = { 'copilot.lua' },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- }
end)

-- run PackerSync on first time install
if is_firsttime then
  require('packer').sync()
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
