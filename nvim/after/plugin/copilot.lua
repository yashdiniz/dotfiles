-- use <C-j>
-- can't use in normal mode since the function only works in insert mode
vim.keymap.set('i', '<C-j>', [[copilot#Accept('')]], { silent = true, expr = true, script = true })
-- remove the default keymap to tab
vim.g.copilot_no_tab_map = true
