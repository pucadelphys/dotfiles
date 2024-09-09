require("myconfig.keys")
require("myconfig.options")
require("myconfig.autocmds")
require("myconfig.functions")

local faces = {
    'ʕ•ᴥ•ʔ', '(ᵔᴥᵔ)', '(¬_¬)', '(ʘ‿ʘ)', '( ⚆ _ ⚆ )', 'ᕦ(ò_óˇ)ᕤ', '(~˘▾˘)~', '(¬‿¬)', '(>^.^<)'
}
math.randomseed(os.time())
print(faces[math.random(#faces)])


-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
      completion = cmp.config.window.bordered({
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:CursorLine',
          side_padding = 1,
          scrollbar = false,
      }),
	documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_next_item( { behavior = cmp.SelectBehavior.Select } ),
    ['<C-k>'] = cmp.mapping.select_prev_item( { behavior = cmp.SelectBehavior.Select } ),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = "latex_symbols",
        option ={
            strategy = 2 -- 0: mixed, 1: julia, 2: latex
        }
    }
  },
  {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig').clangd.setup {
  capabilities = capabilities
}

