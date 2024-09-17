-- local function im(l, r) return vim.keymap.set("i", l, r) end
local function om(l, r) return vim.keymap.set("o", l, r) end
local function vm(l, r) return vim.keymap.set("v", l, r) end
local function nm(l, r) return vim.keymap.set("n", l, r) end
local function cm(l, r) return vim.keymap.set("c", l, r) end

vim.g.mapleader = ' '

nm('<leader>p', '<cmd>lua CustomRegister()<CR>')
nm('<leader>f', 'za')
nm('<leader>h', '<cmd>set hlsearch!<CR>')
nm('<leader>n', '<cmd>set relativenumber!<CR>')
nm('<leader>N', '<cmd>lua Total_numbers()<CR>')
nm('<leader>s', '<cmd>set spell!<CR>')
nm('<leader>a', '<cmd>call AutoPairsToggle()<CR>')
nm('<Up>', 'gk')
nm('<Down>', 'gj')

nm('<C-h>', '<cmd>wincmd h<CR>')
nm('<C-j>', '<cmd>wincmd j<CR>')
nm('<C-k>', '<cmd>wincmd k<CR>')
nm('<C-l>', '<cmd>wincmd l<CR>')

-- nm('<C-S-R>', '<cmd>wincmd h<CR>')
nm('<C-S-H>', '<cmd>wincmd H<CR>')
nm('<C-S-J>', '<cmd>wincmd J<CR>')
nm('<C-S-K>', '<cmd>wincmd K<CR>')
nm('<C-S-L>', '<cmd>wincmd L<CR>')

nm('<leader>c', '<cmd>lua ToggleComment()<CR>')
vm('<leader>c', '<cmd>lua ToggleComment()<CR><ESC>')

vm('il', '<Esc><cmd>normal ^vg_<CR>')
om('il', '<cmd>normal vil<CR>')

nm("<leader>0", "<cmd>CellularAutomaton make_it_rain<CR>");
nm("<leader>uu", "<cmd>Lazy update<CR>")
nm("<leader>f", "<cmd>lua require('conform').format()<CR>")

cm("<Down>", "<C-n>")
cm("<Up>", "<C-p>")

nm("<leader>tt",  "<cmd>NvimTreeToggle<CR>")
nm("<leader>tc",  "<cmd>NvimTreeCollapse<CR>")

nm("<leader>ff", "<cmd>Telescope find_files<cr>")
nm("<leader>fr", "<cmd>Telescope oldfiles<cr>")
nm("<leader>fs", "<cmd>Telescope live_grep<cr>")
nm("<leader>fc", "<cmd>Telescope grep_string<cr>")

nm("<F12>", "<cmd> lua SetBg()<CR>")
vim.keymap.set("n", "<C-.>", "gnn", {remap = true})
vim.keymap.set("v", "<C-.>", "grn", {remap = true})
