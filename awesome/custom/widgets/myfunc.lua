local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")


local function screen_num()
    return screen[screen:count()]
end

local function note_place(d)
    local f = awful.placement.no_overlap+awful.placement.no_offscreen+awful.placement.top_right
    return f(d, {parent = awful.screen.focused(), margins = { top = 40, right = 20 }})
end

local lt = {
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


local underline = {index = 1}
function underline.create(wt)
    local widget = {
        -- { { wt, bg = beautiful.bg_focus .. beautiful.transparency, shape = function(cr, w, h) gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 5) end, widget = wibox.container.background },
        {wt,
            bottom = 2,
            color = beautiful.underline[underline.index],
            widget = wibox.container.margin
        },
        -- top = 2,
        left = 3,
        right = 3,
        bottom = 2,
        layout = wibox.container.margin
    }
    if underline.index == 6 then
        underline.index = 1
    else
        underline.index = underline.index + 1
    end
    return widget
end
