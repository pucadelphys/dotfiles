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
	"nvim-tree/nvim-tree.lua", -- File explorer
	"preservim/tagbar", -- Browse the tags of current file
	"tpope/vim-surround", -- Modify surrounding pairs
	"vim-airline/vim-airline", -- Status/tabline
	"vimwiki/vimwiki", -- Personal wiki for Vim
	-- { 'RRethy/vim-hexokinase', build = { 'make hexokinase' } }, -- Display colours in a file
	{ "ShaiberAlon/snakemake-vim", rtp = "misc/vim/" }, --syntax highlighting for Snakemake
	-- Color Schemes
	"cocopon/iceberg.vim",
	"wuelnerdotexe/vim-enfocado",
	"olivercederborg/poimandres.nvim",
	"rose-pine/neovim",
	"folke/tokyonight.nvim",
	"ray-x/aurora",
	"rebelot/kanagawa.nvim",
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
				},
			})
		end,
	},
	"neanias/everforest-nvim",
	-- Local Plugins
	{ dir = "~/.config/nvim/lua/myconfig/plugins/f9", dev = true },
	{
		dir = "~/.config/nvim/lua/myconfig/plugins/wal",
		dev = true,
		config = function()
			vim.cmd.colorscheme("wal")
		end,
	},
	-- { dir = '~/.config/nvim/lua/myconfig/plugins/setcolors', dev = true },
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
