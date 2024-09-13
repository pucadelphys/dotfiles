return{
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    'hrsh7th/cmp-buffer', -- Source for buffer words
    'hrsh7th/cmp-cmdline', -- Source for vim's cmdline
    'hrsh7th/cmp-nvim-lsp', -- Source for built-in lsp
    'hrsh7th/cmp-path', -- Source for filesystem paths
    'hrsh7th/nvim-cmp', -- Completion engine
    'kdheepak/cmp-latex-symbols', -- Add latex symbol support
    'neovim/nvim-lspconfig', -- Default lsp config
    'R-nvim/cmp-r', -- Source for filesystem paths
    'williamboman/mason.nvim',
    { 'williamboman/mason-lspconfig.nvim',
        dependencies = { 'mason.nvim' },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright" }
            })
            require("lspconfig").lua_ls.setup{}
            require("lspconfig").pyright.setup{}
        end
    },
}
