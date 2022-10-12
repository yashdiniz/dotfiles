return {
  -- vim-fugitive stuff
  ["tpope/vim-fugitive"] = {},
  ["tpope/vim-rhubarb"] = {
    after="vim-fugitive",
  },

  -- Language server and setup
  ["williamboman/mason.nvim"] = {
    override_options = {
          ensure_installed = { "dockerls", "gopls", "graphql" }
      }
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.null-ls"
      end,
  },

  -- go stuff
  ["fatih/vim-go"] = {
    after = "nvim-lspconfig",
    run = ':GoInstallBinaries'
  },

  -- rust stuff
  ["rust-lang/rust.vim"] = {
    after = "nvim-lspconfig",
  },

  -- Debugging
  ["mfussenegger/nvim-dap"] = {},
  ["rcarriga/nvim-dap-ui"] = {
    after = "nvim-dap"
  },
  ["leoluz/nvim-dap-go"] = {
    after = "nvim-dap"
  },
  ["theHamsta/nvim-dap-virtual-text"] = {
    after = "nvim-dap"
  },

  -- copilot
  ["github/copilot.vim"] = {
    config = function()
      vim.g.copilot_no_tab_map = true
    end
  },
}
