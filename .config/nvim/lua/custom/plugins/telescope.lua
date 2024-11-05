return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		{ "folke/todo-comments.nvim", opts = {} },
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Search Files" })
		vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find existing buffers" })
		vim.keymap.set("n", "<leader>st", ":TodoTelescope<return>", { desc = "Search Todos" })
		vim.keymap.set("n", "<leader>sT", builtin.builtin, { desc = "Search Telescope Builtins" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
		vim.keymap.set("n", "<leader>sc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Search Neovim Config" })
	end,
}
