-- Awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys.vim")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/alex/.config/awesome/theme.lua")

-------------------------------------------------------------
--------------     CUSTOM DEFINITIONS START    --------------
-------------------------------------------------------------

local ico = beautiful.awesome_icon
local ico2 = beautiful.awesome_icon2

-- local function testfunc(meme) naughty.notify({ icon = '/home/alex/Pictures/icons/download.png', title = 'Test function', text = tostring(meme) or 'Test function', timeout = 10}) end

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

-- Widget packages
local browser = require('widgets.browser')()
local calendar = require('widgets.calendar')()
local files = require('widgets.files')()
local volume = require('widgets.volume')()


-------------------------------------------------------------
--------------      CUSTOM DEFINITIONS END     --------------
-------------------------------------------------------------

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


-- {{{ Variable definitions

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.top,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
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

mymainmenu = awful.menu({ items = { { "⚙System", myawesomemenu, beautiful.awesome_icon },
                                    { "📁 PCManFM", function () awful.spawn("pcmanfm") end },
                                    { "🦁 Brave", function () awful.spawn("brave --profile-directory='Profile 1'") end },
                                    { "🧲 Transmission", function () awful.spawn("st -n Transmission -e zsh -ic 'tremc -X'") end },
                                    { "🎮 Steam", function () awful.spawn("steam") end },
                                    { "🗨Whatsapp", function () awful.spawn("brave --app='http:web.whatsapp.com' --profile-directory='Default'") end },
                                    { "🖌GIMP", function () awful.spawn("gimp") end },
                                    { "🗒Gedit", function () awful.spawn("gedit") end },
                                    { "📑 Xournal", function () awful.spawn("xournalpp") end},
                                    { "📊 Xmind", function () awful.spawn("xmind") end},
                                    { "   Alacritty", terminal}
                                  }
                        })

mylauncher = awful.widget.launcher({ image = ico,
                                     menu = mymainmenu })

mylauncher:buttons(gears.table.join(
        awful.button({}, 1, function() mymainmenu:toggle() end ),
        awful.button({}, 3, function() mymainmenu:toggle() end )

))

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = awful.widget.textclock('<span font="Cousine Nerd Font 11">%a %d - %R</span>', 60)
local clock = wibox.widget {
        mytextclock,
        bg = false,
        shape = function(cr, w, h) gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 5) end,
        widget = wibox.widget.background()
}

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
                                              awful.menu.client_list({ theme = { width = 300, height = 34 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end)
                                          )

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    s.screen_position = s.index
    local layout_start = ( s.index == 1 ) and 3 or 1
    awful.tag({ "  ", "  ", "  ", "  ", " 烈 ", "  ", "  ", "  ", "  "}, s, awful.layout.layouts[layout_start])
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () lt:toggle("floating") end),
                           awful.button({ }, 3, function () lt:toggle("max") end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))


    -- Create a tasklist widget
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
                        margins = 2,
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
        top = 4,
        bottom = 4,
        left = 5,
        right = 5,
        widget = wibox.container.margin
    }
}
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style    = {
            shape  = gears.shape.circle,
        },
        master_fill_policy = "expand",
        widget_template = {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 7,
                right = 7,
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



    -- Create the wibox
    -- local bw = 350
    s.mywibox = awful.wibar({height =50, position = "top", screen = s, bg = "#00000022" })
    -- s.mywibox.y = 5
    -- if s.index  == 1 then
        -- s.mywibox.x = bw
    -- else
        -- s.mywibox.x = 1920 + bw
    -- end


    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 3,
            -- s.mytaglist,
            s.mypromptbox,
        },
        -- s.mytasklist, -- Middle widget
        -- { -- Right widgets
            -- wibox.widget.textbox(" "),
            -- layout = wibox.layout.fixed.horizontal,
            -- spacing = 1,
            -- underline.create(browser),
            -- underline.create(files),
            -- underline.create(volume),
            -- underline.create(clock),
            -- {wibox.widget.systray(), top = 3, bottom = 5, widget = wibox.container.margin},
            -- s.mylayoutbox,
        -- },
    }

    s.left_popup = awful.popup {
        widget = { { s.mytaglist, { mylauncher, margins = 10, widget = wibox.container.margin }, layout = wibox.layout.fixed.horizontal}, widget = wibox.container.margin},
        maximum_height = 40,
        offset = { x = 0 },
        forced_width = 400,
        bg = beautiful.bg_normal .. beautiful.transparency,
        shape = gears.shape.rounded_bar,
        visible = true,
        ontop = false,
    }

    s.center_popup = awful.popup {
        widget = { s.mytasklist, forced_width = 850 , widget = wibox.container.background },
        maximum_height = 40,
        offset = { x = 0 },
        bg = beautiful.bg_normal .. beautiful.transparency,
        shape = gears.shape.rounded_bar,
        visible = true,
        ontop = false,
    }

    s.right_popup = awful.popup {
        widget = {
            {
                underline.create(browser),
                underline.create(files),
                underline.create(volume),
                underline.create(clock),
                {wibox.widget.systray(), top = 3, bottom = 5, widget = wibox.container.margin},
                s.mylayoutbox,
                layout = wibox.layout.fixed.horizontal
            },
            left = 2,
            right = 2,
            widget = wibox.container.margin
        },
        maximum_height = 40,
        offset = { x = 5 },
        forced_width = 400,
        bg = beautiful.bg_normal .. beautiful.transparency,
        shape = function(cr, w, h) gears.shape.partially_rounded_rect(cr, w, h, true, false, false, true, 5) end,
        visible = true,
        ontop = false,
    }
    -- s.popbar = awful.popup {
        -- widget = wibox.container.background
    -- }
-- 
    -- s.popbar:connect_signal("mouse::enter", function ()
        -- s.right_popup.visible = true
    -- end)

    awful.placement.top_left(s.left_popup, {parent = s, margins = { left = 5, top = 5 }})
    awful.placement.top(s.center_popup, {parent = s, margins = { top = 5 }})
    local pl = awful.placement.no_overlap+awful.placement.no_offscreen + awful.placement.top_right
    if s.index == 1 then
        pl(s.right_popup, {parent = s, margins = { right = 77, top = 5 }})
    else
        pl(s.right_popup, {parent = s, margins = { right = 45, top = 5 }})
    end
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 12, function () awful.spawn("playerctl play-pause") end)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "g",      function () awful.spawn("ibuslang") end,
              {description="Switch keyboard input", group="Awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "Tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "Tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "Tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            local p = (awful.screen.focused().screen_position == 1) and 1 or -1
            awful.client.focus.byidx(p)
        end,
        {description = "focus next by index", group = "Client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            local p = (awful.screen.focused().screen_position == 1) and -1 or 1
            awful.client.focus.byidx(p)
        end,
        {description = "focus previous by index", group = "Client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "Show main menu", group = "Awesome"}),

    -- Layout manipulation
    awful.key({ modkey,           }, "KP_Add", function () 
        awful.tag.incgap(5, awful.screen.focused().selected_tag)
    end,
              {description = "Increase gaps", group = "Layout"}),
    awful.key({ modkey,           }, "KP_Subtract", function () 
        awful.tag.incgap(-5, awful.screen.focused().selected_tag)
    end,
              {description = "Decrease gaps", group = "Layout"}),
    awful.key({ modkey,           }, "f", function () lt:toggle("floating") end,
              {description = "Toggle floating tag", group = "Tag"}),
    awful.key({ modkey,           }, "d", function() lt:toggle("max") end,
              {description = "Toggle maximized tag", group = "Tag"}),
    awful.key({ modkey,            }, "s", function() lt:toggle("fullscreen") end,
              {description = "Toggle fullscreen tag", group = "Tag"}),
    awful.key({ modkey, "Shift"   }, "j", function ()
                                          local p = (awful.screen.focused().screen_position == 1) and 1 or -1
                                          awful.client.swap.byidx(p)
                                      end,
              {description = "swap with next client by index", group = "Client"}),
    awful.key({ modkey, "Shift"   }, "k", function ()
                                          local p = (awful.screen.focused().screen_position == 1) and -1 or 1
                                          awful.client.swap.byidx(p)
                                      end,
              {description = "swap with previous client by index", group = "Client"}),
    awful.key({ modkey,           }, "/", function () awful.screen.focus_relative( 1) end,
              {description = "focus the previous screen", group = "Screen"}),
    -- awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              -- {description = "jump to urgent client", group = "Client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "Client"}),

    -- Standard program
    awful.key({                   }, "Scroll_Lock", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end,
              {description =  "Show Hotkeys", group = "Awesome"}),
    awful.key({ modkey, "Control" }, "space", function () awful.spawn("dymscript") end,
              {description = "Check Spelling", group = "Launcher"}),
    awful.key({ modkey, "Shift" }, "space", function () awful.spawn("dymscript es") end,
              {description = "open a terminal", group = "Launcher"}),
    awful.key({ modkey,           }, "space", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "Launcher"}),
    awful.key({ modkey, "Control" }, "BackSpace", awesome.restart,
              {description =  "reload awesome", group = "Awesome"}),
    awful.key({ modkey, "Shift"   }, "BackSpace", awesome.quit,
              {description = "quit awesome", group = "Awesome"}),
    awful.key({ modkey,           }, "b", function () awful.spawn("brave --profile-directory='Profile 1'") end,
              {description = "Open the browser", group = "Launcher"}),
    awful.key({ modkey, "Shift" }, "b", function () awful.spawn("brave --incognito --profile-directory='Profile 1'") end,
              {description = "Open the browser in incognito mode", group = "Launcher"}),
    awful.key({ modkey, "Control"   }, "b", function () awful.spawn("brave --app='http:web.whatsapp.com' --profile-directory='Default'") end,
              {description = "Open whatsapp", group = "Launcher"}),
    awful.key({ modkey,             }, "y", function () awful.spawn("alacritty --class  'music.youtube.com' -e zsh -ic pipe-viewer") end,
              {description = "Open pipe-viewer", group = "Launcher"}),
    awful.key({ modkey, "Shift"   }, "y", function () awful.spawn("brave --app=http:music.youtube.com --profile-directory='Profile 1'") end,
              {description = "Open YoutubeMusic", group = "Launcher"}),
    awful.key({ modkey, "Control"   }, "y", function () awful.spawn("gtk-pipe-viewer") end,
              {description = "Open GTK Pipe Viewer", group = "Launcher"}),
    awful.key({ modkey,           }, "v", function () awful.spawn("st -n Ranger -e zsh -ic ranger") end,
              {description = "Open ranger", group = "Launcher"}),
    awful.key({ modkey, "Shift"  }, "v", function () awful.spawn("pcmanfm") end,
              {description = "Open pcmanfm", group = "Launcher"}),
    awful.key({ modkey,           }, "t", function () awful.spawn("st -n Transmission -e zsh -ic 'tremc -X'") end,
              {description = "Open ranger", group = "Launcher"}),
    awful.key({ modkey,           }, "m", function () awful.spawn("alacritty --title Julia --class notesapp -e zsh -ic -c julia") end,
              {description = "Launch Julia", group = "Launcher"}),
    awful.key({ modkey,  "Shift"  }, "m", function () awful.spawn("alacritty --title Mathematica --class 'Mathematica,Mathematica' -e zsh -ic wolfram") end,
              {description = "Launch Mathematica shell", group = "Launcher"}),
    awful.key({ modkey,           }, "u", function () awful.spawn("playerctl play-pause") end,
              {description = "Media play-pause", group = "Launcher"}),
    awful.key({                   }, "Pause", function () awful.spawn("playerctl play-pause") end,
              {description = "Media play-pause", group = "Launcher"}),
    awful.key({ modkey, "Control" }, "space", function () awful.spawn("dymscript") end,
              {description = "Diccionary", group = "Launcher"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.spawn("dymscript es") end,
              {description = "Diccionario", group = "Launcher"}),
    awful.key({}, "Print", function () awful.spawn.with_shell("flameshot gui &") end,
              {description = "Screenshot", group = "Launcher"}),
    awful.key({ modkey,     }, "Print", function () awful.spawn("xdisplay") end,
              {description = "Open media in clipboard", group = "Launcher"}),
    -- awful.key({ modkey,           }, "print", function () awful.spawn.with_shell("st -n floatwin -e /bin/sh -c 'xclip -selection clipboard -t image/png -o | display'") end,
              -- {description = "Display image from clipboard", group = "Launcher"}),
    awful.key({ modkey,           }, "minus", function () volume.level_down(5) end,
              {description = "Decrease Volume", group = "Launcher"}),
    awful.key({ modkey,           }, "equal", function () volume.level_up(5) end,
              {description = "Increase Volume", group = "Launcher"}),
    awful.key({ modkey,           }, "0", function () volume.toggle() end,
              {description = "Toggle volume", group = "Launcher"}),
    awful.key({ modkey,           }, "n", function () awful.spawn("alacritty --class notesapp -e zsh -ic 'nvim -c Goyo -c startinsert /tmp/tempnote'") end,
              {description = "Open temporary note", group = "Launcher"}),
    awful.key({ modkey,  "Shift" }, "n", function () awful.spawn("alacritty -e zsh -ic 'nvim -c VimwikiIndex'") end,
              {description = "Launch Vimwiki", group = "Launcher"}),
    awful.key({ modkey,  "Control" }, "n", function () awful.spawn("gedit") end,
              {description = "Open Gedit", group = "Launcher"}),
    awful.key({ modkey, "Shift",  "Control" }, "n", function () awful.spawn("xournalpp") end,
              {description = "Open Xournal", group = "Launcher"}),
    awful.key({ modkey,           }, "l",   function ()
                                                local p = (awful.screen.focused().screen_position == 1) and -0.05 or 0.05
                                                awful.tag.incmwfact(p)
                                            end,
              {description = "increase master width factor", group = "Layout"}),
    awful.key({ modkey,           }, "h",   function ()
                                                local p = (awful.screen.focused().screen_position == 1) and 0.05 or -0.05
                                                awful.tag.incmwfact(p)
                                            end,
              {description = "decrease master width factor", group = "Layout"}),
    awful.key({ modkey, "Control"   }, "k",   function ()
                                                awful.client.incwfact(-0.05, client.focused)
                                            end,
              {description = "increase client width factor", group = "Layout"}),
    awful.key({ modkey, "Control"   }, "j",   function ()
                                                awful.client.incwfact(0.05, client.focused)
                                            end,
              {description = "increase client width factor", group = "Layout"}),
    awful.key({ modkey, "Control"   }, "r",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "Layout"}),
    awful.key({ modkey, "Control"   }, "e",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "Layout"}),
    awful.key({ modkey, "Shift"     }, "r",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "Layout"}),
    awful.key({ modkey, "Shift"     }, "e",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "Layout"}),
    awful.key({ modkey,           }, "r", function () awful.layout.inc( -1)                end,
              {description = "select next", group = "Layout"}),
    awful.key({ modkey,           }, "e", function () awful.layout.inc(1)                end,
              {description = "select previous", group = "Layout"}),

    -- awful.key({ modkey, "Control" }, "n",
              -- function ()
                  -- local c = awful.client.restore()
                  -- Focus restored client
                  -- if c then
                    -- c:emit_signal(
                        -- "request::activate", "key.unminimize", {raise = true}
                    -- )
                  -- end
              -- end,
              -- {description = "restore minimized", group = "Client"}),

    -- Prompt
    awful.key({ modkey, "Shift" },         "p",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "Launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "Awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "Launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,  "Shift" }, "s",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "fullscreen", group = "Client"}),
    awful.key({ modkey,  "Shift" }, "d",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "Client"}),
    awful.key({ modkey,  }, "o",  function (c) c.ontop = not c.ontop end,
              {description = "Toggle on top", group = "Client"}),
    awful.key({ modkey,  "Shift" }, "f",  awful.client.floating.toggle                     ,
              {description = "float", group = "Client"}),
    awful.key({           }, "KP_F1",      function (c) c:kill()                         end,
              {description = "close", group = "Client"}),
    awful.key({ modkey,           }, "Return",
        function (c)
            if c == awful.client.getmaster() then
                awful.client.swap.byidx( 1)
                awful.client.focus.byidx(-1)
            else
                c:swap(awful.client.getmaster())
            end
        end,
              {description = "move to master", group = "Client"}),
    awful.key({ modkey,           }, "KP_Enter",
        function (c)
            if c == awful.client.getmaster() then
                awful.client.swap.byidx( 1)
                awful.client.focus.byidx(-1)
            else
                c:swap(awful.client.getmaster())
            end
        end,
              {description = "move to master", group = "Client"}),
    awful.key({ modkey,  "Shift" }, "/",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "Client"})
    -- awful.key({ modkey,           }, "n",
        -- function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            -- c.minimized = true
        -- end ,
        -- {description = "minimize", group = "Client"}),
    -- awful.key({ modkey, "Control" }, "m",
        -- function (c)
            -- c.maximized_vertical = not c.maximized_vertical
            -- c:raise()
        -- end ,
        -- {description = "(un)maximize vertically", group = "Client"}),
    -- awful.key({ modkey,      }, "<",
        -- function (c)
            -- c.maximized_horizontal = not c.maximized_horizontal
            -- c:raise()
        -- end ,
        -- {description = "(un)maximize horizontally", group = "Client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #", group = "Tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #", group = "Tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move client to tag #", group = "Tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle client on tag #" , group = "Tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end),
    awful.button({  }, 10, function (c)
        local m = mouse.coords()
        c:move_to_screen()
        awful.spawn("xdotool mousemove " .. m["x"] .. " " .. m["y"])
    end),
    awful.button({  }, 11, function (c)
        c:kill()
    end),
    awful.button({ }, 12, function () awful.spawn("playerctl play-pause") end)
)
-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
          "floatwin",
        },
        class = {
          "Arandr",
          "Dunst",
          "QjackCtl",
          "Blueman-manager",
          "floatwin",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          -- "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    ------- Custom Rules -------
    { rule = { class = "startwin",  },
      properties = { floating = true, geometry = { x = 559, y = 296, height = 480, width = 720 } } },
    { rule = { class = "notesapp",  },
      properties = { floating = true, geometry = { height = 445, width = 671 }, ontop = true, placement = note_place }},
    { rule = { instance = "mpv" },
      properties = { tag = "  " } },
    { rule = { instance = "screen1_client2" },
      properties = { screen = 1, focus = false, callback = function(c) awful.client.swap.byidx(1, c) end } },
    { rule = { instance = "screen2_client2" },
      properties = { screen = screen_num, focus = false, callback = function(c) awful.client.swap.byidx(1, c) end } },
    { rule = { instance = "clientswap" },
      properties = { callback = function(c) awful.client.swap.byidx(1, c) end } },
    { rule = { instance = "web.whatsapp.com" },
      properties = { screen = screen_num, tag = "  " } },
    { rule = { instance = "music.youtube.com" },
      properties = { screen = screen_num, tag = "  " } },
    { rule = { instance = "Mathematica" },
      properties = { screen = screen_num, tag = " 烈 " } },
    { rule_any = { instance = { "pavucontrol", "easyeffects" } },
      properties = { screen = screen_num, tag = "  " } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

---------------------------------------------------
---------         CUSTOM SETTINGS         ---------
---------------------------------------------------
do
    -- Autostart loop
    local cmds = {
        "numlockx",
        "picom -f",
        "parcellite -n",
        "ibus-daemon -drxR",
        "xset r rate 350 50",
        "xdotool mousemove 1640 540",
        "kitty --class startwin startfetch",
        -- "xsetwacom set 9 Area 0 0 21600 12150",
        -- "xsetwacom set 9 MapToOutput 1920x1080+1920+0",
        "pkill -0 transmission-da || transmission-daemon",
    }
    for c=1, #cmds do
        awful.spawn.with_shell(cmds[c])
    end

    -- Increase size of master in all tags
    local tags = root.tags()
    for t=1, #tags do
        awful.tag.incmwfact(0.05, tags[t])
    end
end

-- Notification settings
naughty.config.defaults.notification_shape = function(cr, w, h)
gears.shape.rounded_rect(cr, w, h, dpi(6))
end

-- No gaps or borders for single client
beautiful.gap_single_client = false
client.connect_signal("focus", function(c)
    local scr = awful.screen.focused()
    local layout = awful.layout.getname()
    local cli = scr.clients
    if c.floating == false and #cli == 1 or layout == "max" or layout == "fullscreen" then
        c.border_width = 0
    else
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end)

-- Custom Signals
for _,app in ipairs({browser, files, volume}) do
    app:connect_signal("mouse::enter", function()
        app.coloron()
    end)
    app:connect_signal("mouse::leave", function()
        app.coloroff()
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
mylauncher:connect_signal("mouse::enter", function ()
    mylauncher.image = ico2
end)
mylauncher:connect_signal("mouse::leave", function ()
    mylauncher.image = ico
end)
