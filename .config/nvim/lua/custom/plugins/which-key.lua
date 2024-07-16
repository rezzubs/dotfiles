-- :help which-key.nvim

return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		local wk = require("which-key")
		wk.setup()

		wk.add({
			{ "<leader>c", group = "code" },
			{ "<leader>f", group = "find" },
		})
	end,
}
