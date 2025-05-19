return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("tailwind-tools").setup()
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				local active_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
				for _, client in pairs(active_clients) do
					if client.name == "tailwindcss" then
						vim.cmd("TailwindSort")
						return
					end
				end
			end,
		})
	end,
}
