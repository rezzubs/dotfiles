-- GLOBAL KEYBINDINGS
--  :help vim.keymap.set()

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
Nmap("<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
Nmap("[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
Nmap("]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
Nmap("<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
Nmap("<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

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

-- Use emacs movement in insert/command mode.
vim.keymap.set({ "i", "c" }, "<C-f>", "<Right>")
vim.keymap.set({ "i", "c" }, "<C-b>", "<Left>")
vim.keymap.set({ "i", "c" }, "<C-n>", "<Down>")
vim.keymap.set({ "i", "c" }, "<C-p>", "<Up>")
vim.keymap.set({ "i", "c" }, "<M-b>", "<C-Left>")
vim.keymap.set({ "i", "c" }, "<M-f>", "<C-Right>")
vim.keymap.set("i", "<C-a>", "<Esc>0i")
vim.keymap.set("i", "<C-e>", "<Esc>$i")
vim.keymap.set({ "i", "c" }, "<C-d>", "<Esc>lxi")

Nmap("<leader>e", ":E<Return>", { desc = "netrw" })
Nmap("<leader>l", ":Lazy<Return>")
