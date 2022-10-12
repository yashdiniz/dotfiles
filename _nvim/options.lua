local o = vim.opt
local g = vim.g

g.mapleader = " "   -- using " " as <leader>

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
o.whichwrap:append "<>[]hl"
