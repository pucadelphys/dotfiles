local create = vim.api.nvim_create_autocmd

create({"FileChangedRO"}, {
    pattern = {"*"},
    callback = function() vim.g.autosave = false end
})

create({"BufEnter", "BufRead",}, {
    pattern ={ "vimwiki", "*.wiki" },
    callback = function ()
        vim.opt.colorcolumn='0'
        vim.opt.spelllang = 'en_us'
        vim.opt.spell = true
    end
})

create({
    "InsertLeave",
    -- "TextChanged"
}, {
    pattern = {"*"},
    callback = function() AutoSave() end
})

create({"BufEnter", "BufRead"}, {
        pattern = {"*"},
    callback = function()
       if vim.bo.filetype == "" then
            vim.o.showbreak = ''
        end
    end
})

create("FileType", {
    pattern = { "help", "text", "markdown" },
    callback = function ()
        vim.opt.colorcolumn='0'
        vim.opt.showbreak = ''
    end
})

create("FileType", {
    pattern = {"tex"},
    callback = function()
        vim.opt.showbreak = ''
        vim.opt.spell = true
        vim.opt.keymap = "spanish_utf-8"
    end
})

create("FileType", {
    pattern = {"r"},
    callback = function()
        vim.keymap.set("n", "<M-u>", "<Plug>RSendAboveLines")
        vim.keymap.set("n", "<M-l>", "<Plug>RSendLine")
        vim.keymap.set("n", "<M-p>", "<Plug>RSendParagraph")
        vim.keymap.set("i", "<M-l>", "<ESC><Plug>RSendLinea")
        vim.keymap.set("i", "<M-p>", "<ESC><Plug>RSendParagrapha")
        vim.keymap.set("v", "<M-s>", "<Cmd>lua require('r.send').selection(false)<CR>")
        vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize 83<cr>")
        vim.keymap.set({ "i", "t" }, "<<", function ()
            local pos = vim.api.nvim_win_get_cursor(0)
            local curline = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
            return curline:sub(pos[2], pos[2]) == ' ' and '<- ' or ' <- '
        end, {expr = true})
        vim.keymap.set({ "i", "t" }, ">>", function ()
            local pos = vim.api.nvim_win_get_cursor(0)
            local curline = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
            return curline:sub(pos[2], pos[2]) == ' ' and '|> ' or ' |> '
        end, {expr = true})
        vim.keymap.set({"i", "t"}, "%%", function ()
            local pos = vim.api.nvim_win_get_cursor(0)
            local curline = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
            return curline:sub(pos[2], pos[2]) == ' ' and '%>% ' or ' %>% '
        end, {expr = true})
            vim.g.r_indent_align_args = 0
            -- vim.g.R_csv_app = "tmux new-window tw %s --separator $'\t' --no-header"
    end
})
