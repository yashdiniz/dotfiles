-- First read our docs (completely) then check the example_config repo

local M = {}

M.ui = {
  theme = "onedark",
  transparency = true,
}

M.plugins = require "custom.plugins"
M.mappings = require "custom.mappings"
M.options = require "custom.options"

return M
