local o = vim.opt
local c = vim.cmd
local g = vim.g

o.number = true
o.relativenumber = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.termguicolors = true
o.clipboard = "unnamedplus"
o.wrap = true
o.sidescrolloff = 5
o.autoindent = true
o.smartindent = true
o.hidden = true
o.splitbelow = true
o.splitright = true
o.incsearch = true
o.signcolumn = "yes"
o.scrolloff = 8

g.rustfmt_autosave = 1


-- Save and load folds
c([[autocmd BufWinLeave * silen! mkview]])
c([[autocmd BufWinEnter * silent! loadview]])

c([[set iskeyword+=-]])

-- Set colorscheme
c("colorscheme catppuccin-mocha")
