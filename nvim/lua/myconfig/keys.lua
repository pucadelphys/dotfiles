local function im(l, r) return vim.keymap.set("i", l, r) end
local function om(l, r) return vim.keymap.set("o", l, r) end
local function vm(l, r) return vim.keymap.set("v", l, r) end
local function nm(l, r) return vim.keymap.set("n", l, r) end

vim.g.mapleader = ' '

vm('p', '"_dP')
nm('<leader>f', 'za')
nm('<leader>h', '<cmd>set hlsearch!<CR>')
nm('<leader>n', '<cmd>set relativenumber!<CR>')
nm('<leader>s', '<cmd>set spell!<CR>')
nm('<leader>a', '<cmd>call AutoPairsToggle()<CR>')
nm('<Up>', 'gk')
nm('<Down>', 'gj')

nm('<C-h>', '<cmd>wincmd h<CR>')
nm('<C-j>', '<cmd>wincmd j<CR>')
nm('<C-k>', '<cmd>wincmd k<CR>')
nm('<C-l>', '<cmd>wincmd l<CR>')

nm('<C-S-R>', '<cmd>wincmd h<CR>')
nm('<C-S-H>', '<cmd>wincmd H<CR>')
nm('<C-S-J>', '<cmd>wincmd J<CR>')
nm('<C-S-K>', '<cmd>wincmd K<CR>')
nm('<C-S-L>', '<cmd>wincmd L<CR>')

vm('il', '<Esc><cmd>normal ^vg_<CR>')
om('il', '<cmd>normal vil<CR>')

nm("<leader>0", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set('c', '<c-j>', function()
    return vim.fn.wildmenumode() == 0 and 'r' or 'k'
end, { expr = true })
