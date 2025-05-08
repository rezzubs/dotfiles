return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = { enabled = true },
	},
	keys = {
		{
			"<leader>pf",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>pb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>pg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>pc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"grr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "LSP references",
		},
		{
			"grs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP symbols",
		},
		{
			"grS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP workspace symbols",
		},
		{
			"grt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "LSP type definitions",
		},
		{
			"gri",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "LSP definitions",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "LSP definitions",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "LSP declarations",
		},
	},
}
