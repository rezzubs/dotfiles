return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
				end
				local telescope = require("telescope.builtin")

				map("gd", telescope.lsp_definitions, "Goto Definition")
				map("gD", vim.lsp.buf.declaration, "Goto Declaration")
				map("gr", telescope.lsp_references, "Goto References")
				map("gI", telescope.lsp_implementations, "Goto Implementation")
				map("gy", telescope.lsp_type_definitions, "Type Definition")
				map("<leader>cs", telescope.lsp_document_symbols, "Document Symbols")
				map("<leader>cS", telescope.lsp_dynamic_workspace_symbols, "Workspace Symbols")
				map("<leader>cr", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Toggle inlay hints
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>ci", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "Toggle Inlay Hints")
				end
			end,
		})

		if vim.g.have_nerd_font then
			local signs = { Error = "", Warn = "", Hint = "", Info = "" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
					},
				},
			},
			rust_analyzer = {
				settings = {
					check = { command = "clippy" },
				},
			},
			pyright = {
				settings = {
					python = {
						analysis = {
							diagnosticMode = "workspace",
						},
					},
				},
			},
			ruff = {},
		}

		for server, opts in pairs(servers) do
			opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
			require("lspconfig")[server].setup(opts)
		end
	end,
}
