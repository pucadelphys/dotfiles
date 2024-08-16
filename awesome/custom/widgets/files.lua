local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local spawn = require("awful.spawn")
local gears = require("gears")

local files = {}

local function worker()

    files.widget = wibox.widget {
        {
            text = "📁 Files",
            font = beautiful.font,
            widget = wibox.widget.textbox
        },
        bg = false,
        shape = function(cr, w, h) gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 5) end,
        widget = wibox.container.background(),
        buttons = awful.util.table.join(
            awful.button({}, 1, function() spawn("pcmanfm") end),
            awful.button({}, 3, function() spawn("st -n Ranger -e zsh -ic lf") end)
        )
    }


    function files.widget.coloron()
        files.widget:set_bg(beautiful.bg_focus .. beautiful.transparency)
    end

    function files.widget.coloroff()
        files.widget:set_bg(false)
    end

    return files.widget
end

return setmetatable(files, {__call = function(_, ...) return worker(...) end})
