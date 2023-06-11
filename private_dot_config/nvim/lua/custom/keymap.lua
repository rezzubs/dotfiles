
function Kmap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

Kmap("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
