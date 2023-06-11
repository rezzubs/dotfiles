require("bufferline").setup {
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            }
        }
    }
}

Kmap("n", "<S-h>", ":BufferLineCyclePrev<CR>")
Kmap("n", "<S-l>", ":BufferLineCycleNext<CR>")
Kmap("n", "<C-h>", ":BufferLineMovePrev<CR>")
Kmap("n", "<C-l>", ":BufferLineMoveNext<CR>")
