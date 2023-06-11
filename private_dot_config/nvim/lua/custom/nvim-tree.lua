vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

Kmap("n", "<leader>e", ":NvimTreeToggle<CR>")
