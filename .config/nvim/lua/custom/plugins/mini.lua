return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()
		require("mini.comment").setup()
		require("mini.pairs").setup()
		require("mini.notify").setup()
        require("mini.cursorword").setup()
	end,
}
