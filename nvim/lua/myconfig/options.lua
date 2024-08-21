local o = vim.opt

o.clipboard = 'unnamedplus'
o.autoindent = true
o.breakindent = true
o.confirm = true
o.display = 'truncate'
o.encoding = 'utf-8'
o.expandtab = true
o.hidden = true
o.ignorecase = true
o.linebreak = true
o.list = true
o.number = true
o.relativenumber = true
o.scrolloff = 5
o.shiftwidth = 4
o.signcolumn = 'number'
o.smartcase = true
o.softtabstop = 4
o. splitright = true
o.tabstop = 4
o.title = true
o.swapfile = false
o.backup = false
o.undofile = true
o.spelllang = 'es'
o.termguicolors = false
o.colorcolumn = '80'
o.undodir = vim.fn.expand('~') .. '/.config/nvim/undodir'
o.fillchars:append({ eob = ' ' })
o.listchars:append({ trail = '·', tab = '▸ ', leadmultispace = '│   '})

vim.cmd.colorscheme('wal')

for n = 1,6 do
    vim.cmd.highlight({ "VimwikiHeader" .. n, "ctermfg=" .. n })
end

vim.api.nvim_create_autocmd({"BufEnter", "BufRead",}, {
    pattern ={ "Snakefile", "*.rules", "*.snakefile", "*.snake", "*.smk" },
    command = "set syntax=snakemake"
})

