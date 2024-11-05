local function set_indent(pattern, num_spaces)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = pattern,
		callback = function()
			vim.opt_local.shiftwidth = num_spaces
			vim.opt_local.tabstop = num_spaces
		end,
	})
end

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

set_indent("html", 2)
set_indent("gleam", 2)
