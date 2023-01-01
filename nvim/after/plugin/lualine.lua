-- treesitter statusline integration
local function statusline()
  return require('nvim-treesitter').statusline(90)
end

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_c = { 'filename', statusline },
  }
}
