---------------------------
-- Default awesome theme --
-- modified by rschwalk  --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local util = require('awful.util')
local themes_path = util.get_themes_dir()
themedir = "/home/rschwalk/.config/awesome/themes/rschwalk"

local theme = {}

theme.system_color = "#1A8A74"
system_gray = "#BAC3CF"

blue        = "#1793D0"		--Arch Blue
red         = "#EB8F8F"

gray        = "#858585"
--theme.font          = "sans 10"
theme.font          = "Roboto Bold 10"

theme.bg_normal                     = "#242424"
theme.bg_focus                      = system_gray --theme.system_color -- "#404040"
theme.bg_urgent                     = "#006B8E"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal                     = system_gray --"#858585" --"#FFFFFF"
theme.fg_focus                      = "#FFFFFF" --system_gray --theme.system_color --"#0099CC"
theme.fg_urgent                     = "#CC9393"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = 0
theme.border_width  = dpi(1)
theme.border_normal                 = "#252525"
theme.border_focus                  = theme.system_color --"#0099CC"
theme.border_marked = "#91231c"

theme.taglist_font                  = "Roboto Condensed Regular 10"
theme.taglist_fg_focus              = "#FFFFFF" --system_gray -- theme.system_color --"#FFFFFF"
theme.taglist_bg_focus              = theme.system_color
theme.tasklist_bg_normal            = "#222222"
theme.tasklist_fg_focus             = theme.system_color --"#4CB7DB"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(7)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themedir.."icons/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

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

theme.widget_system             = themedir .. "/icons/system.png"
theme.widget_pac                = themedir .. "/icons/pac.png"
theme.widget_pacnew             = themedir .. "/icons/pacnew.png"
theme.widget_vol                = themedir .. "/icons/vol.png"
theme.widget_bat_full		= themedir .. "/icons/bat_full.png"
theme.widget_bat_90		= themedir .. "/icons/bat_90.png"
theme.widget_bat_80    		= themedir .. "/icons/bat_80.png"
theme.widget_bat_70		= themedir .. "/icons/bat_70.png"
theme.widget_bat_60	        = themedir .. "/icons/bat_60.png"
theme.widget_bat_50        	= themedir .. "/icons/bat_50.png"
theme.widget_bat_40             = themedir .. "/icons/bat_40.png"
theme.widget_bat_30 	        = themedir .. "/icons/bat_30.png"
theme.widget_bat_20		= themedir .. "/icons/bat_20.png"
theme.widget_bat_10	        = themedir .. "/icons/bat_10.png"
theme.widget_bat_empty          = themedir .. "/icons/bat_empty.png"
theme.widget_charged_ac	        = themedir .. "/icons/charged_ac.png"
theme.widget_charge_full	= themedir .. "/icons/charge_full.png"
theme.widget_charge_90		= themedir .. "/icons/charge_90.png"
theme.widget_charge_80		= themedir .. "/icons/charge_80.png"
theme.widget_charge_70		= themedir .. "/icons/charge_70.png"
theme.widget_charge_60		= themedir .. "/icons/charge_60.png"
theme.widget_charge_50		= themedir .. "/icons/charge_50.png"
theme.widget_charge_40		= themedir .. "/icons/charge_40.png"
theme.widget_charge_30		= themedir .. "/icons/charge_30.png"
theme.widget_charge_20		= themedir .. "/icons/charge_20.png"
theme.widget_charge_10		= themedir .. "/icons/charge_10.png"
theme.widget_charge_empty	= themedir .. "/icons/charge_empty.png"
theme.widget_cpu                = themedir .. "/icons/cpu.png"
theme.widget_net_up		= themedir .. "/icons/net_up.png"
theme.widget_net_down		= themedir .. "/icons/net_down.png"
theme.widget_temp               = themedir .. "/icons/temp.png"
theme.widget_mem                = themedir .. "/icons/mem.png"

--theme.wallpaper = themes_path.."default/background.png"
-- using nitrogen for wallpaper

-- You can use your own layout icons like this:
theme.layout_fairh              = themedir.."/layouts/fairhw.png"
theme.layout_fairv              = themedir.."/layouts/fairvw.png"
theme.layout_floating           = themedir.."/layouts/floatingw.png"
theme.layout_magnifier          = themedir.."/layouts/magnifierw.png"
theme.layout_max                = themedir.."/layouts/maxw.png"
theme.layout_fullscreen         = themedir.."/layouts/fullscreenw.png"
theme.layout_tilebottom         = themedir.."/layouts/tilebottomw.png"
theme.layout_tileleft           = themedir.."/layouts/tileleftw.png"
theme.layout_tile               = themedir.."/layouts/tilew.png"
theme.layout_tiletop            = themedir.."/layouts/tiletopw.png"
theme.layout_spiral             = themedir.."/layouts/spiralw.png"
theme.layout_dwindle            = themedir.."/layouts/dwindlew.png"
theme.layout_cornernw           = themedir.."/layouts/cornernww.png"
theme.layout_cornerne           = themedir.."/layouts/cornernew.png"
theme.layout_cornersw           = themedir.."/layouts/cornersww.png"
theme.layout_cornerse           = themedir.."/layouts/cornersew.png"

theme.awesome_icon = themedir.."/icons/opensuse.svg"
-- Generate Awesome icon:
--theme.awesome_icon = theme_assets.awesome_icon(
    --theme.menu_height, theme.system_color, theme.fg_focus
--)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
