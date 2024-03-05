return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for install instructions
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Pretty icons
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		Nmap("<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		Nmap("<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		Nmap("<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		Nmap("<leader>ft", builtin.builtin, { desc = "[F]ind [T]elescope builtin" })
		Nmap("<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		Nmap("<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		Nmap("<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecent Files" })
		Nmap("<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })

		-- Slightly advanced example of overriding default behavior and theme
		Nmap("<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		Nmap("<leader>f/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[F]ind [/] in Open Files" })

		-- Shortcut for searching your neovim configuration files
		Nmap("<leader>fc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[F]ind [C]onfig files" })
	end,
}
