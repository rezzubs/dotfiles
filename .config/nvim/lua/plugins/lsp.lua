return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.enable("rust_analyzer")
		vim.lsp.enable("nixd")
		vim.lsp.enable("pyright")
		vim.lsp.enable("ruff")
		vim.lsp.enable("luals")

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					check = {
						command = "clippy",
					},
				},
			},
		})
	end,
}
