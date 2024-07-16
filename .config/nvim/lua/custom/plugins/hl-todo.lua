return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup({})
		Nmap("<leader>fT", ":TodoTelescope<Return>")
	end,
}
