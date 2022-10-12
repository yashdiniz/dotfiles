local M = {}

M.vimFugitive = {
  c = {
    ["ga"] = {"<cmd>Git add <C-r><C-g><CR>", "Git add. Stage files"},
    ["gc"] = {"<cmd>Git commit -S<CR>", "Git signed commit."},
    ["gd"] = {"<cmd>Git diff<CR>", "Show Git diff."}
  }
}

M.general = {
  n = {
    [";"] = {":", "enter cmdline", opts={nowait=true}},
    [":"] = {":!", "enter shell command", opts={nowait=true}}
  },

  v = {
    [";"] = {":", "enter cmdline", opts={nowait=true}},
    [":"] = {":!", "enter shell command", opts={nowait=true}}
  }
}

return M
