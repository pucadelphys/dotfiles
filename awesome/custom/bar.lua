local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local browser = require('custom.widgets.browser')()
local calendar = require('custom.widgets.calendar')()
local files = require('custom.widgets.files')()
local volume = require('custom.widgets.volume')()
local hotkeys_popup = require("awful.hotkeys_popup")

local bar = {}
local terminal = "alacritty"

local lt = require('custom.functions').layout_toggle


modkey = "Mod4"

bar.myawesomemenu = {
   { "❓Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "📖 manual", terminal .. " -e zsh -ic 'man awesome'" },
   { "💻 Edit config", function () awful.spawn("alacritty -e zsh -ic 'nvim ~/.config/awesome/rc.lua'") end },
   { "🎨 Appearance", function() awful.spawn("lxappearance") end },
   { "🖱Mouse", function() awful.spawn("piper") end },
   { "🔈 Audio", function() awful.spawn("easyeffects") end },
   { "🖨Printer", function() awful.spawn("system-config-printer") end },
   { "⭕ Reboot", function() awful.spawn("sudo reboot now") end },
   { "❌ Shut Down", function() awful.spawn("sudo shutdown now") end },
}

bar.mymainmenu = awful.menu({ items = { { "⚙System", bar.myawesomemenu, beautiful.awesome_icon },
                                    { "📁 PCManFM", function () awful.spawn("pcmanfm") end },
                                    { "🦁 Brave", function () awful.spawn("brave --profile-directory='Profile 1'") end },
                                    { "🧲 Transmission", function () awful.spawn("st -n Transmission -e zsh -ic trm") end },
                                    { "🎮 Steam", function () awful.spawn("steam") end },
                                    { "🗨Whatsapp", function () awful.spawn("brave --app='http:web.whatsapp.com' --profile-directory='Default'") end },
                                    { "🖌GIMP", function () awful.spawn("gimp") end },
                                    { "🗒Gedit", function () awful.spawn("gedit") end },
                                    { "📑 Xournal", function () awful.spawn("xournalpp") end},
                                    { "📊 Xmind", function () awful.spawn("xmind") end},
                                    { "   Alacritty", terminal}
                                  }
                        })

bar.ico = beautiful.awesome_icon
bar.ico2 = beautiful.awesome_icon2

local underline = { index = 1}
function underline.create(wt)
    local widget = {
        {wt,
            bottom = dpi(2),
            color = beautiful.underline[underline.index],
            widget = wibox.container.margin
        },
        left = dpi(4),
        right = dpi(4),
        bottom = dpi(2),
        layout = wibox.container.margin
    }
    if underline.index == 6 then
        underline.index = 1
    else
        underline.index = underline.index + 1
    end
    return widget
end


local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({  }, 2, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)


local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
    end),
    awful.button({ }, 2, function (c)
        if c == awful.client.getmaster() then
            awful.client.swap.byidx( 1)
            awful.client.focus.byidx(-1)
        else
            c:swap(awful.client.getmaster())
        end
    end),
    awful.button({ }, 3, function()
        awful.menu.client_list({ teme = { width = dpi(300), height = dpi(300) } })
    end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
    end)
)



local mytextclock = wibox.widget.textclock('<span font=" .. beautiful.font .. "><b>%a %d - %R</b></span>', 60)
local clock = wibox.widget {
        mytextclock,
        bg = false,
        shape = function(cr, w, h) gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 5) end,
        widget = wibox.container.background()
}

bar.mylauncher = wibox.widget {
    widget = wibox.widget.imagebox,
    image = bar.ico
}

-- make launcher
-- bar.mylauncher = awful.widget.launcher({ image = bar.ico,
                                     -- menu = bar.mymainmenu })


local function worker(s)



    -- Create the Layoutbox
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () lt:toggle("floating") end),
                           awful.button({ }, 3, function () lt:toggle("max") end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))


    -- Create the wibar
    s.mywibox = awful.wibar({height = 50 , position = "top", screen = s, bg = "#00000022" })


    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style    = {
            shape  = gears.shape.circle,
        },
        layout   = {
                spacing = 4,
                layout  = wibox.layout.fixed.horizontal
            },
            master_fill_policy = "expand",
        widget_template = {
            {
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                    forced_width = 16,
                    align = "left",
                },
                left  = 9,
                right = 9,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:connect_signal('mouse::enter', function()
                        self.backup = self.bg
                    if not self.bg then
                        self.bg = beautiful.bg_focus .. beautiful.transparency
                    end
                end)
                self:connect_signal('mouse::leave', function()
                    if self.bg then
                        self.bg = self.backup
                    end
                end)
                self:connect_signal('button::press', function(_, _,_, bt)
                    if bt == 1 or bt == 3 then
                        self.backup =  beautiful.bg_focus
                    end
                end)
            end,
        },
    }


    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        source = function ()
            if s.index == 1 then
                local tab = client.get()
                local ntab = {}
                for i = #tab, 1, -1 do
                    table.insert(ntab, tab[i])
                end
                return ntab
            else
            return client.get()
        end
        end,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style    = {
            shape  = gears.shape.rounded_bar,
        },
        widget_template = {
        {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 4,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 5,
                right = 5,
                widget = wibox.container.margin
            },
        id     = 'background_role',
        widget = wibox.container.background,
        },
        top = 5,
        bottom = 5,
        left = 5,
        right = 5,
        widget = wibox.container.margin
        }
    }
bar.launchbox = wibox.widget {
                    {
                            bar.mylauncher,
                            forced_height = 20,
                            widget = wibox.container.place,
                    },
                    margins = 9,
                    widget = wibox.container.margin,
                    forced_height = 40,
                }

    bar.launchbox:connect_signal("mouse::enter", function ()
        bar.mylauncher.image = bar.ico2

    end)
    bar.launchbox:connect_signal("mouse::leave", function ()
        bar.mylauncher.image = bar.ico
    end)

    bar.launchbox:buttons(gears.table.join(
            awful.button({}, 1, function() bar.mymainmenu:toggle() end ),
            awful.button({}, 3, function() bar.mymainmenu:toggle() end )

    ))

    bar.left = awful.popup {
        widget = {
                { s.mytaglist , widget = wibox.container.margin, left = 3},
                bar.launchbox,
                layout = wibox.layout.fixed.horizontal
        },
        maximum_height = 42,
        offset = { x = 0 },
        forced_width = 400,
        bg = beautiful.bg_normal .. beautiful.transparency,
        shape = gears.shape.rounded_bar,
        visible = true,
        ontop = false,
    }


    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            forced_width = dpi(415),
        },
        { s.mytasklist, widget = wibox.container.background }, -- Middle widget
        textsep = "  ",
        { -- Right widgets
            underline.create(browser),
            underline.create(files),
            underline.create(volume),
            underline.create(clock),
            {
                {wibox.widget.systray(), top = 10, bottom = 10, widget = wibox.container.margin},
                layout = wibox.layout.fixed.horizontal
            },
            s.mylayoutbox,
            layout = wibox.layout.fixed.horizontal,
        },
    }

    awful.placement.left(bar.left, { parent = s.mywibox, margins = { left = dpi(4) }})

    for _,app in ipairs({browser, files, volume}) do
        app:connect_signal("mouse::enter", function()
            app:set_bg(beautiful.bg_focus .. beautiful.transparency)
        end)
        app:connect_signal("mouse::leave", function()
            app:set_bg(false)
        end)
    end

    mytextclock:connect_signal("button::press",
        function(_, _, _, button)
            if button == 1 then calendar.toggle() end
        end)
    mytextclock:connect_signal("mouse::enter", function ()
        clock:set_bg(beautiful.bg_focus .. beautiful.transparency)
    end)
    mytextclock:connect_signal("mouse::leave", function ()
        clock:set_bg(false)
    end)


    return bar

end

return setmetatable(bar, {__call = function(_, ...) return worker(...) end})
