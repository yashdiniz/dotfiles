local copilot = require('copilot')

-- remove the default keymap to tab
-- vim.g.copilot_no_tab_map = true
-- use <C-j> instead
vim.keymap.set('i', '<C-j>', require('copilot.panel').accept)

copilot.setup()
