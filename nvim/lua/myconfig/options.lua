local o = vim.opt
o.autoindent = true
o.backup = false
o.breakindent = true
o.clipboard = 'unnamedplus'
o.colorcolumn = '80'
o.confirm = true
o.display = 'truncate'
o.encoding = 'utf-8'
o.expandtab = true
o.hidden = true
o.ignorecase = true
o.linebreak = true
o.list = true
o.number = true
o.pumblend = 90
o.relativenumber = true
o.scrolloff = 5
o.shiftwidth = 4
o.signcolumn = 'number'
o.smartcase = true
o.softtabstop = 4
o.spelllang = 'es'
o.splitright = true
o.swapfile = false
o.tabstop = 4
o.termguicolors = false
o.title = true
o.undodir = vim.fn.expand('~') .. '/.config/nvim/undodir'
o.undofile = true
o.virtualedit = 'block'
o.fillchars:append({ eob = ' ' })
o.listchars:append({ trail = '·', tab = '▸ ', leadmultispace = '│ ┆ '})
vim.g.autosave = true
vim.g.pastevar = true

-- COLORS
-- aurora colorscheme
vim.g.aurora_italic = 1
vim.g.aurora_transparent = 1
vim.g.aurora_bold = 1

vim.api.nvim_set_hl(0, 'Pmenu', {ctermbg='NONE'})
for n = 1,6 do
    vim.api.nvim_set_hl(0, 'VimwikiHeader' .. n, {bold = true, ctermfg = n})
end
