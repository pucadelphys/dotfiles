local awful = require("awful")
local spawn = require("awful.spawn")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local keyboard_text = wibox.widget{
    font = "Cousine Nerd Font 11",
    widget = wibox.widget.textbox,
    align = "center"
}

local Keyboard_widget = wibox.widget.background()
Keyboard_widget:set_widget(keyboard_text)

function Keyboard_widget.chlang()
    spawn.easy_async_with_shell("ibuslang", function() Keyboard_timer:emit_signal("timeout") end)
end

Keyboard_widget:buttons(
    awful.util.table.join(
        awful.button({}, 1, function() Keyboard_widget.chlang() end ),
        awful.button({}, 3, function() spawn.with_shell("ibus-setup") end),
        awful.button({}, 3, function() spawn.with_shell("xmodmap /home/alex/.Xmodmap") end)
    )
)

function Keyboard_widget.update(_, stdout)
    local lang = stdout:match("xkb:%a%a::(%a%a%a)") or stdout:gsub("hangul", "한국어") or "Lan"
    local upperlang = lang:len() == 0 and "ibus" or lang:gsub("^%l", string.upper)
    keyboard_text:set_text("⌨ " .. upperlang)
    collectgarbage()
end

Keyboard_widget, Keyboard_timer = watch("ibus engine", 600, Keyboard_widget.update, Keyboard_widget)
return Keyboard_widget
