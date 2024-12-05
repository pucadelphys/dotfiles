-- TOGGLE LINE NUMBERS --
function Total_numbers()
    local n = vim.opt.number:get()
    local rn = vim.opt.relativenumber:get()
    if (n or rn)
    then
        vim.opt.number = false
        vim.opt.relativenumber = false
    else
        vim.opt.number = true
        vim.opt.relativenumber = true
    end
end

-- TOGGLE COMMENTS --
vim.g.comment_map = { c = '//', cpp = '//', go = '//', java = '//', javascript = '//', lua = '%-%-', scala = '//', php = '//', python = '#', ruby = '#', rust = '//', sh = '#', desktop = '#', fstab = '#', conf = '#', profile = '#', bashrc = '#', bash_profile = '#', mail = '>', eml = '>', r = "#", bat = 'REM', ahk = ';', vim = '', tex = '%%', yaml = '#', julia = '#', zsh = '#', }

vim.g.comment_mult = {
    html = { fst  = '<!--', lst = '--!>' },
    css = { fst = '/*', lst = '*/' }
}

function ToggleComment()
    local fType = vim.bo.filetype
    local com = vim.g.comment_map[fType]
    if (not com) then
        print("Comment is not known")
        return
    end
    local mode = vim.api.nvim_get_mode()["mode"]
    local vstart, vend
    if mode:match("[vV]") then
        vstart = vim.fn.getpos('v')[2]
        vend = vim.api.nvim_win_get_cursor(0)[1]
    else
        vstart = vim.api.nvim_win_get_cursor(0)[1]
        vend = vstart
    end
    local cr = vim.api.nvim_buf_get_lines(0, vend -1, vend, 1)[1]
    local cline = cr:find("^%s*" .. com .. " ") and true or false
    if vstart > vend then
        vend, vstart = vstart, vend
    end
    for nline = vstart, vend do
        ln = vim.api.nvim_buf_get_lines(0, nline -1, nline, 1)[1]
        if ln:find("^%s*$") then goto continue end
        if cline then
            --Uncomment line
            ln = ln:gsub("^(%s*)" .. com .. " ", "%1")
        else
            -- Comment line
            ln = ln:gsub("^(%s*)","%1" .. com .. " ")
        end
        vim.api.nvim_buf_set_lines(0, nline -1, nline, 1, {ln})
        ::continue::
    end
end

-- CYCLE TROUGH COLORSCHEMES --
vim.g.schemes = {
    { name = "wal", themes = { 'dark' }, airline = true },
    { name = "rose-pine", themes = { 'dark', 'light' }, airline = false },
    { name = "iceberg", themes = { 'dark', 'light' }, airline = true },
    { name = "enfocado", themes = { 'dark', 'light' }, airline = true },
    { name = "poimandres", themes = { 'dark' }, airline = false },
    { name = "tokyonight", themes = { 'dark', 'light' }, airline = false },
    { name = "aurora", themes = { 'dark' }, airline = true },
    { name = "kanagawa", themes = {  'dark', 'light'  }, airline = false },
    { name = "everforest", themes = { 'dark', 'light' }, airline = false },
}

local names = {}
for _,v in pairs(vim.g.schemes) do
    names[v.name] = v.themes
end
vim.g.names = names

Changefunc = function(index, shade, dir)
    local prev = vim.g.schemes[index]
    local nextup = vim.g.schemes[index + dir ]
    local dir = dir == 1
    if (prev.themes[dir and #(prev.themes) or 1] ~= shade) then
        return {prev.name,
        prev.themes[dir and #(prev.themes) or 1],
        prev.airline}
    elseif nextup then
        return {nextup.name,
        nextup.themes[dir and 1 or #(nextup.themes)],
        nextup.airline}
    else
        local default = vim.g.schemes[dir and 1 or #(vim.g.schemes)]
        return {default.name,
        default.themes[dir and 1 or #(default.themes)],
        default.airline}
    end
end


SetBg = function(dir)
    local cScheme = vim.g.colors_name or ''
    local cTheme = vim.o.background
    local resTable
    local schemes = vim.g.schemes
    if vim.g.names[cScheme] then
        for col=1,#schemes do
            if (schemes[col].name == cScheme) then
                resTable = Changefunc(col, cTheme, dir)
            end
        end
    end
    if ( resTable[1] == 'wal' ) then
        vim.opt.termguicolors = false
        if vim.g.locals then
            vim.cmd[[HexokinaseTurnOff]]
        end
        require('lualine').setup({ options = {theme = 'pywal'} })
    else
        if vim.g.locals then
            vim.cmd[[HexokinaseTurnOn]]
        end
        require('lualine').setup({ options = {theme = 'auto'} })
    end
    vim.cmd.colorscheme(resTable[1])
    vim.opt.background = resTable[2]
    vim.g["colors_name"] = resTable[1]
    print(resTable[1] .. " " .. resTable[2])
end

-- AUTOSAVE AFTER EDIT --
SaveToggle = function()
    vim.g.autosave = not vim.g.autosave
    local state = vim.g.autosave and "on" or "off"
    print("Autosave is " .. state)
end

AutoSave = function()
    if vim.g.autosave then
        vim.cmd[[silent! update]]
    end
end

-- TOGGLE DEFAULT REGISTER --
CustomRegister = function()
    if vim.g.pastevar then
        vim.keymap.set("v", "p", '"_dP')
        vim.keymap.set("v", "d", '"_d')
        vim.keymap.set("n", "dd", '"_dd')
        vim.g.pastevar = false
        print('Defaults to ""_ register')
    else
        vim.keymap.del('v', 'p')
        vim.keymap.del('v', 'd')
        vim.keymap.del('n', 'dd')
        vim.g.pastevar = true
        print("Standard register settings")
    end
end
