require("nvim-treesitter.configs").setup {
    auto_install = true,

    highlight = {
        enable = true,
    },

    indent = {
        enable = true,
    }
}

vim.opt.foldmethod = "expr"
vim.foldexpr = "nvim_treesitter#foldexpr()"
