return{
   {
      "lervag/vimtex",
      lazy = false,     -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "zathura"
      end
    },
    'dylanaraps/wal.vim', -- Wal colorscheme
    'Eandrju/cellular-automaton.nvim', -- Generate a cellular automaton from buffer
    'hrsh7th/cmp-buffer', -- Source for buffer words
    'hrsh7th/cmp-cmdline', -- Source for vim's cmdline
    'hrsh7th/cmp-nvim-lsp', -- Source for built-in lsp
    'hrsh7th/cmp-path', -- Source for filesystem paths
    'hrsh7th/nvim-cmp', -- Completion engine
    'jiangmiao/auto-pairs', -- Insert surroundings in pairs
    'junegunn/goyo.vim', -- Distraction free writing
    'kdheepak/cmp-latex-symbols', -- Add latex symbol support
    'neovim/nvim-lspconfig', -- Default lsp config
    'nvim-tree/nvim-tree.lua',  -- File explorer
    'preservim/tagbar', -- Browse the tags of current file
    'tpope/vim-surround', -- Modify surrounding pairs
    'vim-airline/vim-airline', -- Status/tabline
    'vimwiki/vimwiki', -- Personal wiki for Vim
    { 'RRethy/vim-hexokinase', build = { 'make hexokinase' } }, -- Display colours in a file
    { 'ShaiberAlon/snakemake-vim', rtp = 'misc/vim/'}, --syntax highlighting for Snakemake
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        config = function ()
          local configs = require("nvim-treesitter.configs")
          configs.setup({
              ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "html", "python" },
              sync_install = false,
              highlight = { enable = true },
              indent = { enable = true },
            })
        end
}, -- Use the tree-sitter interface
    -- Color Schemes
    'cocopon/iceberg.vim',
    'wuelnerdotexe/vim-enfocado',
    'olivercederborg/poimandres.nvim',
    'rose-pine/neovim',
    'folke/tokyonight.nvim',
    'ray-x/aurora',
    'rebelot/kanagawa.nvim',
    'neanias/everforest-nvim',
    -- Local Plugins
    { dir = '~/.config/nvim/plugins/f9', dev = true },
    -- { dir = '~/.config/nvim/plugins/setcolors', dev = true },
}
