--  See `:help lua-guide-autocommands`

local function set_indent(pattern, num_spaces)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = pattern,
		callback = function()
			vim.opt_local.shiftwidth = num_spaces
			vim.opt_local.tabstop = num_spaces
		end,
	})
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

set_indent("html", 2)
