return {
	"danymat/neogen",
	config = function()
		require("neogen").setup({})
		vim.keymap.set("n", "<leader>cn", ":Neogen<return>", { desc = "Neogen" })
	end,
}
