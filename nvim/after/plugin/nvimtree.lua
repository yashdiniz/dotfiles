-- https://github.com/yashdiniz/dotfiles/blob/main/nvim_old/lua/plugins/configs/nvimtree.lua
local nvimtree = require("nvim-tree")

local options = {
  filters = {
    dotfiles = false,
    exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
  },
  disable_netrw = true,
  -- ignore_ft_on_setup = { "alpha" },
  hijack_cursor = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    adaptive_size = true,
    width = 25,
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 400,
  },
  renderer = {
    icons = {
      git_placement = "before",
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "U✗", -- "✗",
          staged = "A✓", -- "✓",
          unmerged = "",
          renamed = "R➜", -- "➜",
          untracked = "U★", -- "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = {
      "Makefile", "makefile", "MAKEFILE",
      "README.md", "readme.md", "LICENSE", "license", "License",
      -- "TODO.txt", "todo.txt", "Todo.txt", "TODO.md", "todo.md", "Todo.md",
      -- "INSTALL.md", "install.md", "CHANGELOG.md", "changelog.md",
      -- "CONTRIBUTING.md", "contributing.md", "CODE_OF_CONDUCT.md", "code_of_conduct.md",
      -- "SECURITY.md", "security.md", "CODEOWNERS", "codeowners",
      -- "PULL_REQUEST_TEMPLATE.md", "pull_request_template.md", "ISSUE_TEMPLATE.md", "issue_template.md",
      ".gitconfig", ".gitignore", ".gitmodules", ".gitattributes",
      "package.json", "package-lock.json", "yarn.lock",
      "go.mod", "go.sum",
      "Cargo.toml", "Cargo.lock",
      "requirements.txt", "requirements-dev.txt", "requirements-test.txt",
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
}

vim.g.nvimtree_side = options.view.side

local wk = require('which-key')
wk.add({
  { '<c-n>',     [[<cmd>NvimTreeToggle<cr>]],  desc = 'Toggle NvimTree' },
  { '<leader>f', [[<cmd>NvimTreeFocus<cr>]],   desc = '[f]ocus NvimTree' },
  { '<leader>r', [[<cmd>NvimTreeRefresh<cr>]], desc = '[r]efresh NvimTree' },
})
nvimtree.setup(options)
