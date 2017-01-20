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

-- System Info

systemicon = wibox.widget.imagebox(beautiful.widget_system)
vicious.cache(vicious.widgets.os)

systemwidget = wibox.widget.textbox()
  systemwidget:set_align("left")
  --vicious.register(systemwidget, vicious.widgets.os, markup(gray, "User ") ..markup(beautiful.fg_focus, "$3") .. markup(gray, " ┈ ") .. markup(gray, "Hostname ") .. markup(beautiful.fg_focus, "$4") .. markup(gray, " ┈ ") .. markup(gray, "System ") .. markup(beautiful.fg_focus, "$2"))
  vicious.register(systemwidget, vicious.widgets.os, markup(gray, "User ") ..markup(beautiful.system_color, "$3") .. markup(gray, " ┈ ") .. markup(gray, "System ") .. markup(beautiful.system_color, "$2"))

