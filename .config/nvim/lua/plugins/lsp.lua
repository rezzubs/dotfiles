return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.lsp.enable("rust_analyzer")

        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                    },
                },
            },
        })

    end
}
