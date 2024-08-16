local awful = require("awful")
local naughty = require("naughty")

local layout_toggle = {
    floating = awful.layout.suit.floating,
    max = awful.layout.suit.max,
    fullscreen = awful.layout.suit.max.fullscreen,
    toggle = function(self, l)
        local s = awful.screen.focused()
        if (awful.layout.getname() ~= l ) then
            awful.layout.set(self[l])
        else
            local tile = s.screen_position == 2 and awful.layout.suit.tile or awful.layout.suit.tile.left
            awful.layout.set(tile)
        end
    end
}

local function testfunc(...)
    local args = ''
    for i,v in ipairs({...}) do
        args = args .. tostring(v) .. '\n'
    end
    naughty.notify({
        icon = '/home/alex/Pictures/icons/download.png',
        title = 'Test function',
        text = tostring(args) or 'Test function',
        timeout = 10})
end

local function change_language()
    awful.spawn.easy_async("ibus engine",
    function(stdout)
        local LAN = stdout:match"xkb:%a*::(%a*)"
        if LAN == "eng" then
            NEXT = "es::spa"
        else
            NEXT = "us::eng"
        end
        awful.spawn.with_shell( "ibus engine xkb:" .. NEXT .. ";xmodmap /home/alex/.Xmodmap" )
        naughty.notify {position = "top_middle", font = "RobotoMono Nerd Font 18",  title = "\tiBus", text = "Language: " .. string.upper(NEXT:match"%a::(%a*)" or "hangul"), margin = 10 }
    end)
end

local function change_transparency(sign)
    local tab = sign and { '<= 0.07', '0', '-' } or { '>= 0.93', '1', '+' }

    local command = "awk -i inplace -e '/^\\s*opacity =/ { if ($3 " .. tab[1] .. ') { print "opacity =", ' .. tab[2] .. '} else { print "opacity =", $3 ' .. tab[3] .. " 0.07} }' -e '!/^\\s*opacity =/ {print}' .config/alacritty/alacritty.toml"

    awful.spawn.with_shell( command )
end

return {
    layout_toggle = layout_toggle,
    test = testfunc,
    language = change_language,
    transparency = change_transparency
}
