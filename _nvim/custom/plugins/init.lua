return {
  ["tpope/vim-fugitive"] = {},
  ["tpope/vim-rhubarb"] = {
    after="vim-fugitive",
  },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["fatih/vim-go"] = {
    run = ':GoInstallBinaries'
  },

  -- Override plugin config
  ["williamboman/mason.nvim"] = {
    override_options = {
          ensure_installed = { "dockerls", "gopls", "graphql" }
      }
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.null-ls"
      end,
  },

  ["github/copilot.vim"] = {},

  ["rust-lang/rust.vim"] = {},
}
