local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local beautiful = require("beautiful")
local gears = require("gears")

local volume = {}

-- Widget Text

local function worker()

    local volume_text = wibox.widget{
        font = beautiful.font,
        widget = wibox.widget.textbox,
    }

    volume.widget = wibox.widget {
        bg = false,
        shape = function(cr, w, h) gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 5) end,
        widget = wibox.widget.background()
    }

    volume.widget:set_widget(volume_text)

    function volume.widget.coloron()
        volume.widget:set_bg(beautiful.bg_focus .. beautiful.transparency)
    end

    function volume.widget.coloroff()
        volume.widget:set_bg(false)
    end

    local function update(_, stdout)
        local ico = ""
        local vol_level = ""
        local speaker = string.match(stdout, "%[(o%a%a?)%]")
        if speaker == "off" then
            ico, vol_level = "🔇", "M"
        elseif speaker == "on" then
            vol_level = string.match(stdout, "%[(%d+)%%%]")
            local vol_num = tonumber(vol_level)
            if vol_num > 50 then
                ico = "🔊"
            elseif vol_num > 0 then
                ico = "🔉"
            else
                ico = "🔈"
            end
        else
            ico, vol_level = "", ""
        end
        volume_text:set_text(ico .. ' ' .. vol_level)
    end

    function volume.toggle()
        spawn.with_shell("pamixer -t")
    end

    function volume.poise()
        spawn.with_shell("pamixer --set-volume 50")
    end

    function volume.control()
        spawn("pavucontrol")
    end

    function volume.level_up(step)
        spawn.with_shell("pamixer --allow-boost -i " .. step)
    end

    function volume.level_down(step)
        spawn.with_shell("pamixer --allow-boost -d " .. step)
    end

    volume.widget:buttons(
        awful.util.table.join(
        awful.button({}, 1, function () volume.toggle() end ),
        awful.button({}, 2, function () volume.poise() end ),
        awful.button({}, 3, function () volume.control() end ),
        awful.button({}, 4, function () volume.level_up(5) end ),
        awful.button({}, 5, function () volume.level_down(5) end )
        )
    )

    watch("amixer -D pulse sget Master", 1, update, volume.widget)

    return volume.widget
end

return setmetatable(volume, {__call = function(_, ...) return worker(...) end })
