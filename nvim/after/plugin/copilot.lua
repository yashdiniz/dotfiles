-- remove the default keymap to tab
vim.g.copilot_no_tab_map = true
-- use <C-j>
vim.keymap.set('i', '<C-j>', 'copilot#Accept("\n")', {silent = true, expr = true, script = true})
