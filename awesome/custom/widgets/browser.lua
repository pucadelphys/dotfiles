local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local spawn = require("awful.spawn")
local gears = require("gears")


local ICON_DIR = os.getenv("HOME") .. '/.config/awesome/custom/icons/'

local browser = {}

local function worker()

    browser.widget = wibox.widget {
        {
            {
                {
                    resize = true,
                    valign = "center",
                    forced_width = 28,
                    image = ICON_DIR .. "brave.svg",
                    widget = wibox.widget.imagebox
                },
                valign = 'center',
                halign = 'center',
                layout = wibox.container.place
            },
            {
                markup = "Brave",
                font = beautiful.font,
                widget = wibox.widget.textbox
            },
            layout = wibox.layout.fixed.horizontal
        },
        bg = false,
        shape = function(cr, w, h) gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 5) end,
        widget = wibox.container.background(),
        buttons = awful.util.table.join(
                awful.button({}, 1, function() spawn("brave --profile-directory='Profile 1'") end),
                awful.button({}, 2, function() spawn("brave --app='http:web.whatsapp.com' --profile-directory='Default'") end),
                awful.button({}, 3, function() spawn("brave --incognito --profile-directory='Profile 1'") end)
            )
    }

    function browser.widget.coloron()
        browser.widget:set_bg(beautiful.bg_focus .. beautiful.transparency)
    end

    function browser.widget.coloroff()
        browser.widget:set_bg(false)
    end

    return browser.widget

end

return setmetatable(browser, {__call = function(_, ...) return worker(...) end})
