-- Set <space> as the leader key
-- :help mapleader
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

function Nmap(lhs, rhs, opts)
	vim.keymap.set("n", lhs, rhs, opts)
end

function Imap(lhs, rhs, opts)
	vim.keymap.set("i", lhs, rhs, opts)
end

require("custom.options")
require("custom.keymap")
require("custom.autocommands")

if vim.g.neovide then
	require("custom.neovide")
end

-- Bootstrap lazy.nvim
-- :help lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("custom.plugins")
