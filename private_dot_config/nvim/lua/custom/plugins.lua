-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Colors

    -- OneDark
    use "navarasu/onedark.nvim"

    -- Spaceduck
    use "pineapplegiant/spaceduck"

    -- Catppuccin
    use "catppuccin/nvim"

    -- LSP / Completion

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional
            {"hrsh7th/cmp-cmdline"},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- Lualine
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true}
    }

    -- Quality of life
    use { 'jdhao/better-escape.vim', event = 'InsertEnter'}
    use 'jiangmiao/auto-pairs'
    use "terrortylor/nvim-comment"
    use "tpope/vim-surround"
    use "scrooloose/nerdcommenter"

    -- NvimTree
    use {
        "nvim-tree/nvim-tree.lua",
        "nvim-tree/nvim-web-devicons"
    }
    
    -- GitSigns
    use {
      'lewis6991/gitsigns.nvim',
    }
    
    -- Rust QOL
    use "rust-lang/rust.vim"

    -- Bufferline
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

    -- Leap
    use { "ggandor/leap.nvim" }
    
    -- Indent Blankline
    use "lukas-reineke/indent-blankline.nvim"

    -- Check Bootstrap
    if is_bootstrap then
        require('packer').sync()
    end
    -- When we are bootstrapping a configuration, it doesn't
    -- make sense to execute the rest of the init.lua.
    --
    -- You'll need to restart nvim, and then it will work.
    if is_bootstrap then
        print '=================================='
        print '    Plugins are being installed'
        print '    Wait until Packer completes,'
        print '       then restart nvim'
        print '=================================='
        return
    end
end)
