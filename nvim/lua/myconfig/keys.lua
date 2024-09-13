local function im(l, r) return vim.keymap.set("i", l, r) end
local function om(l, r) return vim.keymap.set("o", l, r) end
local function vm(l, r) return vim.keymap.set("v", l, r) end
local function nm(l, r) return vim.keymap.set("n", l, r) end
local function cm(l, r) return vim.keymap.set("c", l, r) end


vim.g.mapleader = ' '

-- vm('p', '"_dP')
nm('<leader>p', '<cmd>lua customRegister()<CR>')
nm('<leader>f', 'za')
nm('<leader>h', '<cmd>set hlsearch!<CR>')
nm('<leader>n', '<cmd>set relativenumber!<CR>')
nm('<leader>N', '<cmd>lua total_numbers()<CR>')
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

nm('<leader>c', '<cmd>lua toggleComment()<CR>')
vm('<leader>c', '<cmd>lua toggleComment()<CR><ESC>')

vm('il', '<Esc><cmd>normal ^vg_<CR>')
om('il', '<cmd>normal vil<CR>')

nm("<leader>0", "<cmd>CellularAutomaton make_it_rain<CR>");
nm("<leader>uu", "<cmd>Lazy update<CR>")

cm("<Down>", "<C-n>")
cm("<Up>", "<C-p>")

nm("<F12>", "<cmd> lua setBg()<CR>")
vim.keymap.set("n", "<C-.>", "gnn", {remap = true})
vim.keymap.set("v", "<C-.>", "grn", {remap = true})

vim.keymap.set('c', '<c-j>', function()
    return vim.fn.wildmenumode() == 0 and 'r' or 'k'
end, { expr = true })


vim.keymap.set('c', '<c-j>', function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<c-j>"
end, { expr = true })
