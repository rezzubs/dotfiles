return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },

	cmd = { "ConformInfo" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			nix = { "nixfmt" },
			lua = { "stylua" },
			html = { "prettierd" },
			htmldjango = { "prettierd" },
			css = { "prettierd" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = { timeout_ms = 500 },
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
