---------------------------
-- Custom awesome theme  --
---------------------------

wal = dofile("/home/alex/.cache/wal/colors_awesome.lua")
local cairo = require("lgi").cairo
local gears_color = require("gears.color")
local shape = require("gears.shape")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

local function meme_squares(size, fg, filled)
    local img = cairo.ImageSurface(cairo.Format.ARGB32, 4 * size, 2 * size)
    local cr = cairo.Context(img)
    local x, y = size * 3.5, size * 1.3
    local angle1, angle2 = 0, math.rad(360)
    local radius = size/2

    cr:set_source(gears_color(fg))
    cr:arc(x, y, radius, angle1, angle2)
    if filled then
        cr:fill()
    else
        cr:stroke()
    end
    cr:fill()

    return img
end

theme.font          = "RobotoMono Nerd Font, Bold 12"
theme.transparency = "60"

theme.bg_normal     = wal.c00
theme.bg_focus      = wal.c02
theme.bg_urgent     = "#d53838"
theme.bg_minimize   = "#666666"
theme.bg_systray    = wal.c01
theme.systray_icon_spacing = 2


theme.fg_normal     = wal.c15
theme.fg_focus      = wal.c15
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#000000"

theme.useless_gap   = dpi(6)
theme.border_width  = dpi(3)
theme.border_normal = wal.c00
theme.border_focus  = wal.c15
theme.border_marked = "#91231c"

-- Widget colors
theme.cal_bg        = wal.c10
theme.cal_fg        = wal.c15
theme.cal_normbg    = wal.c10
theme.cal_selbg     = wal.c15
theme.cal_selfg     = wal.c10
theme.cal_border    = wal.c00
theme.cal_webg      = wal.c04

theme.tasklist_fg_normal = wal.c15
theme.tasklist_bg_normal = wal.c00
theme.tasklist_fg_focus = wal.c15
theme.tasklist_bg_focus = wal.c02
theme.tasklist_fg_minimize = "#000000"
theme.tasklist_bg_minimize = "#666666"

theme.underline = { wal.c09, wal.c11, wal.c10, wal.c14, wal.c13, wal.c12 }

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.hotkeys_font = "Free Sans Bold 13"
theme.hotkeys_description_font = "Free Sans 11"
-- theme.hotkeys_shape = function (cr) shape.rounded_rect(cr, 1920, 700, 5) end

-- Generate taglist squares:
local taglist_square_size = dpi(5)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    -- taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    -- taglist_square_size, theme.fg_normal
-- )

theme.taglist_squares_sel = meme_squares(
    taglist_square_size, theme.fg_normal, true
)
theme.taglist_squares_unsel = meme_squares(
    taglist_square_size, theme.fg_normal, false
)

-- Variables set for theming notifications:
theme.notification_icon_size = dpi(64)
theme.notification_margin = dpi(8)
theme.notification_border_width = 3
theme.notification_opacity = 0.8
theme.notification_max_width = dpi(400)
theme.notification_shape = function(cr, w, h)
    shape.rounded_rect(cr, w, h, dpi(6))
end


-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(150)
theme.menu_font   = "Fira Mono 11"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
theme.bg_widget = "#ff0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.bg_normal
)
theme.awesome_icon2 = theme_assets.awesome_icon(
    theme.menu_height, theme.fg_normal, theme.bg_normal
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
