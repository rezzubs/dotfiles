return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				undo = {},
			},
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						width = { padding = 0 },
						height = { padding = 0 },
						preview_width = 0.5,
					},
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "undo")

		-- :help telescope.builtin
		local builtin = require("telescope.builtin")
		Nmap("<leader>fh", builtin.help_tags, { desc = "Help" })
		Nmap("<leader>fk", builtin.keymaps, { desc = "Keymaps" })
		Nmap("<leader>ff", builtin.find_files, { desc = "Files" })
		Nmap("<leader>ft", builtin.builtin, { desc = "Telescope builtin" })
		Nmap("<leader>fg", builtin.live_grep, { desc = "Grep" })
		Nmap("<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
		Nmap("<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
		Nmap("<leader>fb", builtin.buffers, { desc = "Open buffers" })
		Nmap("<leader>u", "<cmd>Telescope undo<cr>", { desc = "Undo tree" })

		Nmap("<leader>fc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Config files" })
	end,
}
