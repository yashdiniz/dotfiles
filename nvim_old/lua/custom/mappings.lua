local M = {}

M.vimFugitive = {
  c = {
    ["ga"] = {"Git add ", "Git add. Stage files"},
    ["gc"] = {"<cmd>Git commit -S<CR>", "Git signed commit."},
    ["gd"] = {"<cmd>Git diff<CR>", "Show Git diff."}
  }
}

M.dap = {
  n = {
    ["<F1>"] = {"<cmd>lua require'dap'.continue()<CR>", "Debugger: Continue"},
    ["<F2>"] = {"<cmd>lua require'dap'.step_into()<CR>", "Debugger: Step into"},
    ["<F3>"] = {"<cmd>lua require'dap'.step_over()<CR>", "Debugger: Step over"},
    ["<F4>"] = {"<cmd>lua require'dap'.step_out()<CR>", "Debugger: Step out"},
    ["<leader>b"] = {"<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Debugger: Toggle breakpoint"},
    ["<leader>ui"] = {"<cmd>lua require 'dapui'.toggle()<CR>", "Debugger UI: Toggle UI"},
  }
}

M.copilot = {
  i = {
    ["<silent><script><expr><C-j>"] = {"copilot#Accept('<CR>')", "Copilot: Autocomplete accept"},
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
