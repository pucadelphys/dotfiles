vim.api.nvim_create_autocmd({"BufEnter", "BufRead",}, {
    pattern ={ "Snakefile", "*.rules", "*.snakefile", "*.snake", "*.smk" },
    command = "set syntax=snakemake"
})

vim.api.nvim_create_autocmd({"BufEnter", "BufRead",}, {
    pattern ={ "vimwiki", "*.wiki" },
    command = "set colorcolumn=0"
})

vim.api.nvim_create_autocmd({"FileChangedRO"}, {
    pattern = {"*"},
    callback = function() vim.g.autosave = false end
})

vim.api.nvim_create_autocmd({
    "InsertLeave",
    -- "TextChanged"
}, {
    pattern = {"*"},
    callback = function() autoSave() end
})

