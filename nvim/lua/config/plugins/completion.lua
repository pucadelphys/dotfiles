return {
    { "rafamadriz/friendly-snippets", dependencies = LuaSnip },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	"hrsh7th/cmp-buffer", -- Source for buffer words
	"hrsh7th/cmp-cmdline", -- Source for vim's cmdline
	"hrsh7th/cmp-nvim-lsp", -- Source for built-in lsp
	"hrsh7th/cmp-path", -- Source for filesystem paths
	"hrsh7th/nvim-cmp", -- Completion engine
	"kdheepak/cmp-latex-symbols", -- Add latex symbol support
	"neovim/nvim-lspconfig", -- Default lsp config
	{ "R-nvim/cmp-r",
    config = function ()
        local opts = {
            hook = {
                on_filetype = function ()
                    vim.api.nvim_buf_set_keymap(0,  "n", "<Enter>", "<Plug>RDSendLine", {})
                    vim.api.nvim_buf_set_keymap(0,  "v", "<Enter>", "<Plug>RSendSelection", {})
                end
            },
            R_args = { "--quiet", "--no-save" },
            objbr_auto_start =  true,
            objbr_place = "script, right",
            objbr_w = 30,
            rconsole_height = 6,
            rconsole_width = 0,
            disable_cmds = {
                "RClearConsole",
                "RCustomStart",
                "RSPlot",
                "RSaveClose"
            },
        }
        if vim.env.R_AUTO_START == "true" then
            opts.auto_start = "on startup"
            opts.objbr_auto_start = true
        end
        require('r').setup(opts)
    end,
    lazy = false
    }, -- Source for filesystem paths
	"williamboman/mason.nvim",
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright" },
			})
			require("lspconfig").lua_ls.setup({
				on_init = function(client)
                    local folders = client.workspace_folders
                    if not folders then return end
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                        return
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend("force",
                    client.config.settings.Lua, {
                        runtime = {
                            version = "LuaJIT",
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                            }, -- library = vim.api.nvim_get_runtime_file("", true) (much slower)
                        },
                    })
				end,
				settings = {
					Lua = {},
				},
			})
			require("lspconfig").pyright.setup({})
		end,
	},
}
