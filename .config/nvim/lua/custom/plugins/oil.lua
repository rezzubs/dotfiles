return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({})

		Nmap("-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
