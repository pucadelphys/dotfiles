return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"c", "lua", "vim", "vimdoc", "query", "html", "python", "r", "markdown", "markdown_inline", "rnoweb", "yaml",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = false,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm,",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- jump forward
						keymaps = {
							["af"] = "@function.outer", -- defined in textobjects.scm
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						}, -- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						include_surrounding_whitespace = true, --default false canalso be a function thatreturns true or false
					},
				},
			})
		end,
	}, -- Use the tree-sitter interface
	"nvim-treesitter/nvim-treesitter-textobjects",
}
