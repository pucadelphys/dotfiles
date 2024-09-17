local tbl = {
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "zathura"
        end,
    },
    { "R-nvim/R.nvim", lazy = false },
    "Eandrju/cellular-automaton.nvim", -- Generate a cellular automaton from buffer
    "jiangmiao/auto-pairs", -- Insert surroundings in pairs
    "junegunn/goyo.vim", -- Distraction free writing
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim', { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
        config = function ()
            local telescope = require('telescope')
	    local actions = require('telescope.actions')
            telescope.setup{
                defaults = {
                    path_display = { "smart" },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_previous,
                            ["<C-k>"] = actions.move_selection_next,
                        }
                    }
                },
                pickers = {
                },
                extensions = {
                }
            }
            telescope.load_extension('fzf')
        end
    },
    { "nvim-tree/nvim-tree.lua",
    config = function ()
        require("nvim-tree").setup()
    end
}, -- File explorer
"preservim/tagbar", -- Browse the tags of current file
"tpope/vim-surround", -- Modify surrounding pairs
{
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                refresh = {
                    statusline = 10000,
                    tabline = 10000,
                    winbar = 10000,
                },
                theme = "pywal",
            },
            sections = {
                lualine_a = { "os.getenv('HOST_PS1')", "os.date('%a')" },
                lualine_b = { "mode" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        })
    end,
},
"vimwiki/vimwiki", -- Personal wiki for Vim
-- Color Schemes
"cocopon/iceberg.vim",
"wuelnerdotexe/vim-enfocado",
"olivercederborg/poimandres.nvim",
"rose-pine/neovim",
"folke/tokyonight.nvim",
"ray-x/aurora",
"rebelot/kanagawa.nvim",
{

    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function ()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {}
},
{
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        local conform = require('conform')
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
            },
        })
        conform.formatters.stylua = {
            prepend_args = { "--indent-type", "Spaces" },
        }
    end,
},
"neanias/everforest-nvim",
-- Local Plugins
{ dir = "~/.config/nvim/lua/config/plugins/f9", dev = true },
{ dir = "~/.config/nvim/lua/config/plugins/snakemake", dev = true }, --syntax highlighting for Snakemake
{
    dir = "~/.config/nvim/lua/config/plugins/wal",
    dev = true,
    config = function()
        vim.cmd.colorscheme("wal")
    end,
},
}

-- Plugins for PC
local extras = {
    { "RRethy/vim-hexokinase", build = { "make hexokinase" } }, -- Display colours in a file
}

if not os.getenv("SSH_TTY") then
    for _, t in pairs(extras) do
        table.insert(tbl, t)
    end
end

return tbl
