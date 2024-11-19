local set = vim.keymap.set

set("n", '<leader>p', '<cmd>lua CustomRegister()<CR>')
set("n", '<leader>f', 'za')
set("n", '<leader>h', '<cmd>set hlsearch!<CR>')
set("n", '<leader>n', '<cmd>set relativenumber!<CR>')
set("n", '<leader>N', '<cmd>lua Total_numbers()<CR>')
set("n", '<leader>s', '<cmd>set spell!<CR>')
set("n", '<leader>a', '<cmd>call AutoPairsToggle()<CR>')
set("n", '<Up>', 'gk')
set("n", '<Down>', 'gj')

-- set("n", '<C-h>', '<cmd>wincmd h<CR>')
-- set("n", '<C-j>', '<cmd>wincmd j<CR>')
-- set("n", '<C-k>', '<cmd>wincmd k<CR>')
-- set("n", '<C-l>', '<cmd>wincmd l<CR>')

set({"i", "n"}, '<C-Left>', '<cmd>vertical resize -1<cr>')
set({"i", "n"}, '<C-Right>', '<cmd>vertical resize +1<cr>')
set({"i", "n"}, '<C-Up>', '<cmd>resize -1<cr>')
set({"i", "n"}, '<C-Down>', '<cmd>resize +1<cr>')

-- set("n", '<C-S-R>', '<cmd>wincmd h<CR>')
-- set("n", '<C-S-H>', '<cmd>wincmd H<CR>')
-- set("n", '<C-S-J>', '<cmd>wincmd J<CR>')
-- set("n", '<C-S-K>', '<cmd>wincmd K<CR>')
-- set("n", '<C-S-L>', '<cmd>wincmd L<CR>')

set("n", '<leader>c', '<cmd>lua ToggleComment()<CR>')
set("v", '<leader>c', '<cmd>lua ToggleComment()<CR><ESC>')

set("v", 'il', ':<c-U>norm!^vg_<cr>')
set('o', 'il', '<cmd>normal vil<cr>', {remap = true})

set("n", "<leader>0", "<cmd>CellularAutomaton make_it_rain<CR>");
set("n", "<leader>uu", "<cmd>Lazy update<CR>")
set("n", "<leader>f", "<cmd>lua require('conform').format()<CR>")

set("c", "<Down>", "<C-n>")
set("c", "<Up>", "<C-p>")

set("n", "<leader>tt",  "<cmd>NvimTreeToggle<CR>")
set("n", "<leader>tc",  "<cmd>NvimTreeCollapse<CR>")

set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>")
set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")

set("n", "<F12>", "<cmd> lua SetBg(1)<CR>")
set("n", "<F24>", "<cmd> lua SetBg(-1)<CR>")
set("n", "<C-.>", "gnn", {remap = true})
set("v", "<C-.>", "grn", {remap = true})
