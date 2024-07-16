-- GLOBAL KEYBINDINGS
-- :help vim.keymap.set()

-- Clear highligh after searching
Nmap("<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics
Nmap("[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic message" })
Nmap("]d", vim.diagnostic.goto_next, { desc = "Next diagnostic message" })
Nmap("<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  See `:help wincmd` for a list of all window commands
Nmap("<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
Nmap("<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
Nmap("<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
Nmap("<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set({ "n", "i", "c", "v" }, "<C-g>", "<Esc><Esc>")
