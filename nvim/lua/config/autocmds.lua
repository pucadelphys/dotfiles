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
    end
})
