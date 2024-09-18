local o = vim.opt

o.breakindentopt = 'sbr' -- apply showbreak before indenting
o.autoindent = true -- apply indent automatically
o.backup = false -- do not keep backup file
o.breakindent = true -- indent wrapped lines
o.clipboard = 'unnamedplus' -- use the + register
o.colorcolumn = '80' -- colo the 80th column
o.confirm = true -- read only Files canbe saved w confirmation
o.encoding = 'utf-8'
o.expandtab = true -- change tabs to spaces
o.ignorecase = true -- ignores case in search
o.linebreak = true -- wrap lines on blank characters
o.list = true -- show listchars
o.number = true -- show line number
o.relativenumber = true -- show relative line number
o.scrolloff = 5 -- minimum # of lines to the edge
o.shiftwidth = 4 -- spaces used for autoindent
o.signcolumn = 'number' -- display signs in the number column
o.smartcase = true -- search doesnt ignore case when using uppercase
o.softtabstop = 4 -- number of spaces in expandtab
o.spelllang = 'es' -- spellcheck in spanish
o.splitright = true -- vsplits appear on the right
o.swapfile = false -- do not use a swapfile
o.tabstop = 4 -- # of spaces to display as tab
o.termguicolors = false -- disable 24-bit RGB color
o.title = false -- vim sets window title
o.undodir = vim.fn.expand('~') .. '/.config/nvim/undodir' -- path to undo files
o.undofile = true -- set undo information
o.virtualedit = 'block' -- cursor in block mode can be outside text
o.fillchars:append({ eob = ' ' }) -- no ~ on empty lines
o.listchars:append({ trail = '·', tab = '▸ ', leadmultispace = '│ ┆ ', extends = '>', precedes = '<'}) -- strings to show on list mode
o.showbreak = "└>" -- string to use at the start of wraped lines

-- COLORS

vim.api.nvim_set_hl(0, 'Pmenu', {ctermbg='NONE'})
for n = 1,6 do
    vim.api.nvim_set_hl(0, 'VimwikiHeader' .. n, {bold = true, ctermfg = n})
end
