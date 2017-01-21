local awful = require("awful")
awful.rules = require("awful.rules")
require('awful.autofocus')
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local naughty = require("naughty")
local lain = require("lain")

home 			= os.getenv("HOME")
confdir 		= home .. "/.config/awesome"
scriptdir 		= confdir .. "/scripts/"
themes 			= confdir .. "/themes"
active_theme 	= themes .. "/rschwalk"

beautiful.init(active_theme .. "/theme.lua")

markup      = lain.util.markup
darkblue    = beautiful.bg_focus
white       = beautiful.fg_focus
blue        = "#1793D0"		--Arch Blue
--blue        = "#7A5ADA"		--Gentoo Purple
yellow		= "#E3E34E"
red         = "#EB8F8F"
gray        = "#858585"
border      = "#4A4A4A50"
background	= "#00000050"
bright_red  = "#FF0000"
green       = "#41F300"


-- Create a textclock widget
--mytextclock = wibox.widget.textclock()
mytextclock = awful.widget.textclock(markup(gray, "%a")
.. markup(beautiful.system_color, " %d ") .. markup(gray, "%b ") ..  markup(beautiful.system_color, "%H:%M "))

-- Calendar
--lain.widgets.calendar:attach(mytextclock, { fg = gray })

-- Calendar
--mytextcalendar = wibox.widget.textclock(markup("#FFFFFF", space3 .. "%d %b " .. markup.font("Tamsyn 5", " ")))
--calendar_icon = wibox.widget.imagebox(beautiful.calendar)
--calbg = wibox.container.background(mytextcalendar, beautiful.bg_focus, shape.rectangle)
--calendarwidget = wibox.container.margin(calbg, 0, 0, 5, 5)
lain.widgets.calendar.attach(mytextclock, { fg = beautiful.system_color, position = "top_right", font = "Monospace", font_size = 10 })

-- Spacers

space = wibox.widget.textbox(' ')
bigspace = wibox.widget.textbox('   ')
separator = wibox.widget.textbox(' | ')


-- System Info

systemicon = wibox.widget.imagebox(beautiful.widget_system)
vicious.cache(vicious.widgets.os)

systemwidget = wibox.widget.textbox()
  systemwidget:set_align("left")
  --vicious.register(systemwidget, vicious.widgets.os, markup(gray, "User ") ..markup(beautiful.fg_focus, "$3") .. markup(gray, " ┈ ") .. markup(gray, "Hostname ") .. markup(beautiful.fg_focus, "$4") .. markup(gray, " ┈ ") .. markup(gray, "System ") .. markup(beautiful.fg_focus, "$2"))
  vicious.register(systemwidget, vicious.widgets.os, markup(gray, "User ") ..markup(beautiful.system_color, "$3") .. markup(gray, " ┈ ") .. markup(gray, "System ") .. markup(beautiful.system_color, "$2"))

-- Weather

--yawn = lain.widgets.yawn(2939623,
--{
--    settings = function()
--        yawn_notification_preset.fg = gray
--    end
--})

-- Pacman

-- Icon
pacicon = wibox.widget.imagebox()
pacicon:set_image(beautiful.widget_pac)

pacwidget = wibox.widget.textbox()
vicious.register(pacwidget, vicious.widgets.pkg, function(widget, args)
   if args[1] > 0 then
   pacicon:set_image(beautiful.widget_pacnew)
   else
   pacicon:set_image(beautiful.widget_pac)
   end

  return args[1]
  end, 1, "Arch S") -- Arch S for ignorepkg
--
-- Buttons
  function popup_pac()
  local pac_updates = ""
  local f = io.popen("sudo pacman -S --dbpath /tmp/checkup-db-msjche/sync")
--  local f = io.popen("cat /tmp/off.updates")
  if f then
	pac_updates = f:read("*a"):match(".*/(.*)-.*\n$")
  else
	local pac_updates = ""
  end
  f:close()
  if not pac_updates then
	  pac_updates = "System is up to date"
  end
  naughty.notify { text = pac_updates }
  end
  pacwidget:buttons(awful.util.table.join(awful.button({ }, 1, popup_pac)))
  pacicon:buttons(pacwidget:buttons())
