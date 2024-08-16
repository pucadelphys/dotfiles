local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local calendar = {}

local function worker()
    local styles = {}
    local function rounded_shape(size)
        return function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, size)
        end
    end

    styles.header  = { fg_color = beautiful.cal_fg,
                       bg_color = beautiful.cal_bg,
                       markup   = function(t) return '<b>' .. t .. '</b>' end,
                       shape    = rounded_shape(10)
    }
    styles.weekday = { fg_color = beautiful.cal_fg,
                       bg_color = beautiful.cal_bg,
                       markup   = function(t) return '<b>' .. t .. '</b>' end,
                       shape    = rounded_shape(5)
    }
    styles.normal  = { shape    = rounded_shape(5) }
    styles.month   = { padding      = 5,
                       bg_color     = beautiful.cal_bg,
                       border_width = 0,
                       shape        = rounded_shape(8)
    }
    styles.focus   = { fg_color = beautiful.cal_selfg,
                       bg_color = beautiful.cal_selbg,
                       markup   = function(t) return '<b>' .. t .. '</b>' end,
                       shape    = rounded_shape(4)
    }

    local function decorate_cell(widget, flag, date)
        if flag=='monthheader' and not styles.monthheader then
            flag = 'header'
        end
        local props = styles[flag] or {}
        if props.markup and widget.get_text and widget.set_markup then
            widget:set_markup(props.markup(widget:get_text()))
        end
        -- Change bg color for weekends
        local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
        local weekday = tonumber(os.date('%w', os.time(d)))
        local default_bg = (weekday==0 or weekday==6) and beautiful.cal_webg or beautiful.cal_normbg
        local ret = wibox.widget {
            {
                widget,
                margins = (props.padding or 2) + (props.border_width or 0),
                widget  = wibox.container.margin
            },
            shape              = props.shape,
            shape_border_color = props.border_color or beautiful.cal_border,
            shape_border_width = props.border_width or 0,
            fg                 = props.fg_color or beautiful.cal_fg,
            bg                 = props.bg_color or default_bg,
            widget             = wibox.container.background
        }
        return ret
    end

    local cal = wibox.widget {
        date = os.date("*t"),
        font = beautiful.get_font(),
        fn_embed = decorate_cell,
        long_weekdays = true,
        start_sunday = false,
        widget = wibox.widget.calendar.month,
    }

    local ycal = wibox.widget {
        date = os.date("*t"),
        font = beautiful.get_font(),
        fn_embed = decorate_cell,
        long_weekdays = true,
        start_sunday = false,
        widget = wibox.widget.calendar.year
    }

    local popup = awful.popup {
        ontop = true,
        visible = false,
        shape = rounded_shape(8),
        offset = { y = 5 },
        border_width = 1,
        border_color = beautiful.border_normal,
        widget = cal
    }

    local ypopup = awful.popup {
        ontop = true,
        visible = false,
        shape = rounded_shape(8),
        offset = { y = 5 },
        border_width = 1,
        border_color = beautiful.border_normal,
        widget = ycal
    }

    popup:buttons(
            awful.util.table.join(
                    awful.button({}, 1, function()
                        popup.visible = not popup.visible
                        awful.placement.top_right(ypopup, {margins = { top = 35, right = 10 }, parent =awful.screen.focused() })
                        ypopup.visible = true
                    end),
                    awful.button({}, 3, function ()
                        cal:set_date(nil)
                        cal:set_date(os.date('*t'))
                        popup:set_widget(nil)
                        popup:set_widget(cal)
                        popup.visible = not popup.visible
                    end),
                    awful.button({}, 4, function()
                        local a = cal:get_date()
                        a.month = a.month + 1
                        cal:set_date(nil)
                        cal:set_date(a)
                        popup:set_widget(cal)
                    end),
                    awful.button({}, 5, function()
                        local a = cal:get_date()
                        a.month = a.month - 1
                        cal:set_date(nil)
                        cal:set_date(a)
                        popup:set_widget(cal)
                    end)
            )
    )


    ypopup:buttons(
            awful.util.table.join(
                    awful.button({}, 1, function()
                        ycal:set_date(nil)
                        ycal:set_date(os.date('*t'))
                        ypopup:set_widget(nil)
                        ypopup:set_widget(ycal)
                        ypopup.visible = not ypopup.visible
                    end),
                    awful.button({}, 3, function()
                        ycal:set_date(nil)
                        ycal:set_date(os.date('*t'))
                        ypopup:set_widget(nil)
                        ypopup:set_widget(ycal)
                        ypopup.visible = not ypopup.visible
                    end)
            )
    )

    function calendar.toggle()
        if popup.visible then
            cal:set_date(nil)
            cal:set_date(os.date('*t'))
            popup:set_widget(nil)
            popup:set_widget(cal)
            popup.visible = not popup.visible
        elseif ypopup.visible then
            ycal:set_date(nil)
            ycal:set_date(os.date('*t'))
            ypopup:set_widget(nil)
            ypopup:set_widget(ycal)
            ypopup.visible = not ypopup.visible
        else
            awful.placement.top_right(popup, {margins = { top = 35, right = 10 }, parent =awful.screen.focused() })
            popup.visible = true
        end
        collectgarbage()
    end

    return calendar
end

return setmetatable(calendar, {__call = function(_, ...) return worker(...) end})
