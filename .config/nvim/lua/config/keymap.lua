Nmap("<leader>e", "<cmd>Explore<return>")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "<Esc>", "<cmd>bd<CR>", { buffer = true, silent = true })
	end,
})

Nmap("<esc>", "<cmd>nohl<return>")
