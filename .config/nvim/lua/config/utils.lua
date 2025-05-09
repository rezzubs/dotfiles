Nmap = function(keys, action)
	vim.keymap.set("n", keys, action, { noremap = true, silent = true })
end
