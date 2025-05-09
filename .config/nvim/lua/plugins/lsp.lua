return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.enable("rust_analyzer")
		vim.lsp.enable("nixd")
		vim.lsp.enable("pyright")
		vim.lsp.enable("ruff")
		vim.lsp.enable("luals")
		vim.lsp.enable("zls")

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					check = {
						command = "clippy",
					},
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function()
				Nmap("]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end)
				Nmap("[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end)
			end,
		})
	end,
}
