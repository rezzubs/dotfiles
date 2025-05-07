local nmap = function(keys, action)
	vim.keymap.set("n", keys, action, { noremap = true, silent = true })
end

nmap("<leader>e", "<cmd>Lexplore<return>")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "<Esc>", "<cmd>bd<CR>", { buffer = true, silent = true })
	end
})

nmap("<esc>", "<cmd>nohl<return>")
