local awful = require("awful")
awful.rules = require("awful.rules")
require('awful.autofocus')
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local naughty = require("naughty")
local lain = require("lain")
local shape         = require("gears.shape")

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

---- Icon
--pacicon = wibox.widget.imagebox()
--pacicon:set_image(beautiful.widget_pac)
--
--pacwidget = wibox.widget.textbox()
--vicious.register(pacwidget, vicious.widgets.pkg, function(widget, args)
--   if args[1] > 0 then
--   pacicon:set_image(beautiful.widget_pacnew)
--   else
--   pacicon:set_image(beautiful.widget_pac)
--   end
--
--  return args[1]
--  end, 1, "Arch S") -- Arch S for ignorepkg
----
---- Buttons
--  function popup_pac()
--  local pac_updates = ""
--  local f = io.popen("sudo pacman -S --dbpath /tmp/checkup-db-msjche/sync")
----  local f = io.popen("cat /tmp/off.updates")
--  if f then
--	pac_updates = f:read("*a"):match(".*/(.*)-.*\n$")
--  else
--	local pac_updates = ""
--  end
--  f:close()
--  if not pac_updates then
--	  pac_updates = "System is up to date"
--  end
--  naughty.notify { text = pac_updates }
--  end
--  pacwidget:buttons(awful.util.table.join(awful.button({ }, 1, popup_pac)))
--  pacicon:buttons(pacwidget:buttons())

-- Volume

volicon = wibox.widget.imagebox(beautiful.widget_vol)
vicious.cache(vicious.widgets.volume)

-- ALSA
volumewidget = lain.widgets.alsa({
    settings = function()
        header = " Vol "
        vlevel  = volume_now.level

        if volume_now.status == "off" then
            vlevel = vlevel .. "M "
        else
            vlevel = vlevel .. " "
        end

        widget:set_markup(markup(beautiful.system_color, vlevel))
    end
})

volumewidget:buttons(awful.util.table.join(
    awful.button({}, 1, function ()
        awful.util.spawn("pavucontrol")
        volumewidget.update()
    end)
))

-- Battery

batpct = wibox.widget.textbox()
baticon = wibox.widget.imagebox()
vicious.register(batpct, vicious.widgets.bat, function(widget, args)
    bat_state  = args[1]
    bat_charge = args[2]
    bat_time   = args[3]

    if bat_state == "↯" then
        baticon:set_image(beautiful.widget_charged_ac)
    elseif bat_state == "+" then
        if 	bat_charge >= 90 then
            baticon:set_image(beautiful.widget_charge_full)
        elseif bat_charge >= 80 and bat_charge < 90 then
            baticon:set_image(beautiful.widget_charge_90)
        elseif bat_charge >= 70 and bat_charge < 80 then
            baticon:set_image(beautiful.widget_charge_80)
        elseif bat_charge >= 60 and bat_charge < 70 then
            baticon:set_image(beautiful.widget_charge_70)
        elseif bat_charge >= 50 and bat_charge < 60 then
            baticon:set_image(beautiful.widget_charge_60)
        elseif bat_charge >= 40 and bat_charge < 50 then
            baticon:set_image(beautiful.widget_charge_50)
        elseif bat_charge >= 30 and bat_charge < 40 then
            baticon:set_image(beautiful.widget_charge_40)
        elseif bat_charge >= 20 and bat_charge < 30 then
            baticon:set_image(beautiful.widget_charge_30)
        elseif bat_charge >= 10 and bat_charge < 20 then
            baticon:set_image(beautiful.widget_charge_20)
        elseif bat_charge >= 5 and bat_charge < 10 then
            baticon:set_image(beautiful.widget_charge_10)
        else
            baticon:set_image(beautiful.widget_charge_empty)
        end
    elseif bat_state == "−" then
        if bat_charge >= 90 then
            baticon:set_image(beautiful.widget_bat_full)
        elseif bat_charge >= 80 and bat_charge < 90 then
            baticon:set_image(beautiful.widget_bat_90)
        elseif bat_charge >= 70 and bat_charge < 80 then
            baticon:set_image(beautiful.widget_bat_80)
        elseif bat_charge >= 60 and bat_charge < 70 then
            baticon:set_image(beautiful.widget_bat_70)
        elseif bat_charge >= 50 and bat_charge < 60 then
            baticon:set_image(beautiful.widget_bat_60)
        elseif bat_charge >= 40 and bat_charge < 50 then
            baticon:set_image(beautiful.widget_bat_50)
        elseif bat_charge >= 30 and bat_charge < 40 then
            baticon:set_image(beautiful.widget_bat_40)
        elseif bat_charge >= 20 and bat_charge < 30 then
            baticon:set_image(beautiful.widget_bat_30)
        elseif bat_charge >= 10 and bat_charge < 20 then
            baticon:set_image(beautiful.widget_bat_20)
        elseif bat_charge >= 5 and bat_charge < 10 then
            baticon:set_image(beautiful.widget_bat_10)
        else
            baticon:set_image(beautiful.widget_bat_empty)
        end
    else
        baticon:set_image(beautiful.widget_charge_empty)
    end
--  if args[1] == "-" then
--    if bat_charge > 70 then
--      baticon:set_image(beautiful.widget_batfull)
--    elseif bat_charge > 30 then
--      baticon:set_image(beautiful.widget_batmed)
--    elseif bat_charge > 10 then
--      baticon:set_image(beautiful.widget_batlow)
--    else
--      baticon:set_image(beautiful.widget_batempty)
--    end
--  else
--    baticon:set_image(beautiful.widget_ac)
--    if args[1] == "+" then
--      blink = not blink
--      if blink then
--        baticon:set_image(beautiful.widget_acblink)
--      end
--    end
--  end

  return args[2] .. "% " .. bat_state .. " "
end, nil, "BAT0")

batpct:buttons(awful.util.table.join(awful.button({}, 1, function()
    local state = ""
    local popup_bat_preset = { font = "Insonsolata 15" }
    if bat_state == "↯" then
        state = "Full"
    elseif bat_state == "↯" then
        state = "Charged"
    elseif bat_state == "+" then
        state = "Charging"
    elseif bat_state == "−" then
        state = "Discharging"
    elseif bat_state == "⌁" then
        state = "Not charging"
    else
        state = "Unknown"
    end

      naughty.notify { text = "Charge : " .. bat_charge .. "%\nState  : " .. state ..
        " (" .. bat_time .. ")", timeout = 5, hover_timeout = 0.5 }
end)))

baticon:buttons(batpct:buttons())

--baticon = wibox.widget.imagebox()

--batwidget = lain.widgets.bat({
----
--settings = function()
--
--
--    local bat_state  	= ""
--    local bat_charge 	= 0
--    local bat_time  	= 0
--    local blink      	= true
--    local timeout		= 1
--
--    bat_90	= tostring (92)
--    bat_80	= tostring (85)
--    bat_70	= tostring (75)
--    bat_60	= tostring (65)
--    bat_50	= tostring (55)
--    bat_40	= tostring (45)
--    bat_30	= tostring (35)
--    bat_20	= tostring (25)
--    bat_10	= tostring (15)
--    bat_5	= tostring (7)
--
--    bat_perc = bat_now.perc
--    bat_p = tostring (bat_perc)
--    bat_s = bat_now.status
--    bat_t = bat_now.time
--
--    if bat_s == "Full" then
--        baticon:set_image(beautiful.widget_charged_ac)
--    elseif bat_s == "Discharging" then
--        --widget:set_markup("" .. bat_perc .. "% ")
--        if 	bat_perc >= bat_90 then
--            baticon:set_image(beautiful.widget_bat_full)
--        elseif bat_perc >= bat_80 and bat_perc < bat_90 then
--            baticon:set_image(beautiful.widget_bat_90)
--        elseif bat_perc >= bat_70 and bat_perc < bat_80 then
--            baticon:set_image(beautiful.widget_bat_80)
--        elseif bat_perc >= bat_60 and bat_perc < bat_70 then
--            baticon:set_image(beautiful.widget_bat_70)
--        elseif bat_perc >= bat_50 and bat_perc < bat_60 then
--            baticon:set_image(beautiful.widget_bat_60)
--        elseif bat_perc >= bat_40 and bat_perc < bat_50 then
--            baticon:set_image(beautiful.widget_bat_50)
--        elseif bat_perc >= bat_30 and bat_perc < bat_40 then
--            baticon:set_image(beautiful.widget_bat_40)
--        elseif bat_perc >= bat_20 and bat_perc < bat_30 then
--            baticon:set_image(beautiful.widget_bat_30)
--        elseif bat_perc >= bat_10 and bat_perc < bat_20 then
--            baticon:set_image(beautiful.widget_bat_20)
--        elseif bat_perc >= bat_5 and bat_perc < bat_10 then
--            baticon:set_image(beautiful.widget_bat_10)
--        else
--            baticon:set_image(beautiful.widget_bat_empty)
--        end
--    else
--        if 	bat_perc >= bat_90 then
--            baticon:set_image(beautiful.widget_charge_full)
--        elseif bat_perc >= bat_80 and bat_perc < bat_90 then
--            baticon:set_image(beautiful.widget_charge_90)
--        elseif bat_perc >= bat_70 and bat_perc < bat_80 then
--            baticon:set_image(beautiful.widget_charge_80)
--        elseif bat_perc >= bat_60 and bat_perc < bat_70 then
--            baticon:set_image(beautiful.widget_charge_70)
--        elseif bat_perc >= bat_50 and bat_perc < bat_60 then
--            baticon:set_image(beautiful.widget_charge_60)
--        elseif bat_perc >= bat_40 and bat_perc < bat_50 then
--            baticon:set_image(beautiful.widget_charge_50)
--        elseif bat_perc >= bat_30 and bat_perc < bat_40 then
--            baticon:set_image(beautiful.widget_charge_40)
--        elseif bat_perc >= bat_20 and bat_perc < bat_30 then
--            baticon:set_image(beautiful.widget_charge_30)
--        elseif bat_perc >= bat_10 and bat_perc < bat_20 then
--            baticon:set_image(beautiful.widget_charge_20)
--        elseif bat_perc >= bat_5 and bat_perc < bat_10 then
--            baticon:set_image(beautiful.widget_charge_10)
--        else
--            baticon:set_image(beautiful.widget_charge_empty)
--        end
--    end
--    widget:set_markup(markup(beautiful.system_color, bat_now.perc))
--end, --1, "BAT0"
--})
--
----batwidget:buttons(awful.util.table.join(awful.button({}, 1, popup_test)))
--batwidget:buttons(awful.util.table.join(awful.button({}, 1, function()
--    local state = ""
--    local popup_bat_preset = { font = "Insonsolata 15" }
--    if bat_state == "↯" then
--        state = "Full"
--    elseif bat_state == "↯" then
--        state = "Charged"
--    elseif bat_state == "+" then
--        state = "Charging"
--    elseif bat_state == "−" then
--        state = "Discharging"
--    elseif bat_state == "⌁" then
--        state = "Not charging"
--    else
--        state = "Unknown"
--    end
--
--      naughty.notify { text = "Charge : " .. bat_p .. "%\nState  : " .. bat_s ..
--        " (" .. bat_t .. ")", timeout = 5, hover_timeout = 0.5 }
--end)))
--
--baticon:buttons(batwidget:buttons())
--
---- Buttons
--function popup_bat()
--  local state = ""
--  local popup_bat_preset = { font = "Insonsolata 15" }
--  if bat_state == "↯" then
--    state = "Full"
--  elseif bat_state == "↯" then
--    state = "Charged"
--  elseif bat_state == "+" then
--    state = "Charging"
--  elseif bat_state == "−" then
--    state = "Discharging"
--  elseif bat_state == "⌁" then
--    state = "Not charging"
--  else
--    state = "Unknown"
--  end
--
----  naughty.notify { text = "Charge : " .. bat_p .. "%\nState  : " .. bat_s ..
----    " (" .. bat_t .. ")", timeout = 5, hover_timeout = 0.5 }
--    naughty.notify({ text = "Test", ontop = true})
--end
--
---- Battery Warning
--local function trim(s)
--  return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
--end
--
--local function bat_notification()
--  local f_capacity = assert(io.open("/sys/class/power_supply/BAT0/capacity", "r"))
--  local f_status = assert(io.open("/sys/class/power_supply/BAT0/status", "r"))
--  local bat_capacity = tonumber(f_capacity:read("*all"))
--  local bat_status = trim(f_status:read("*all"))
--  local bat_status_preset = { font = "Insonsolata 15" }
--
--  if (bat_capacity <= 15 and bat_status == "Discharging") then
--    naughty.notify({ title = "Battery Warning"
--      , text = "Battery low! " .. bat_capacity .."%" .. " left!"
--      , fg="#ffffff"
--      , bg="#C91C1C"
--      , timeout = 10
--      , position = "top_right"
--    })
--  end
--end
--
--battimer = timer({timeout = 15})
--battimer:connect_signal("timeout", bat_notification)
--battimer:start()

-- File System

vicious.cache(vicious.widgets.fs)

-- Initialize widget
fshome = lain.widgets.fs({
    partition = "/",
    settings  = function()
        --fs_notification_preset.fg = gray
        fs_header = ""
        fs_p      = ""
        fs_ps	  = ""

        if fs_now.used >=  0 then
            fs_header = " Hdd "
            fs_p      = fs_now.used
			fs_ps	  = " % "
        end

        widget:set_markup(markup(gray, " ◘ ") .. markup(gray, fs_header) .. markup(beautiful.system_color, fs_p) .. markup(gray, fs_ps))
    end
})

-- CPU
cpu_icon = wibox.widget.imagebox(beautiful.widget_cpu)
cpu_widget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup(gray, " CPU ") .. markup(beautiful.system_color, cpu_now.usage) .. markup(gray, " % "))
    end
})
--cpubg = wibox.container.background(cpu_widget, beautiful.system_color, shape.rectangle)
cpuwidget = wibox.container.margin(cpu_widget, 0, 0, 5, 5)

-- Net
netdown_icon = wibox.widget.imagebox(beautiful.widget_net_down)
netup_icon = wibox.widget.imagebox(beautiful.widget_net_up)
netwidget = lain.widgets.net({
    settings = function()
        widget:set_markup(markup(beautiful.system_color, net_now.received) .. markup(gray, " - ")
                          .. markup(beautiful.system_color, net_now.sent) )
    end
})
--netbg = wibox.container.background(netwidget, beautiful.system_color, shape.rectangle)
networkwidget = wibox.container.margin(netwidget, 0, 0, 5, 5)

-- Coretemp

tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup(beautiful.system_color, coretemp_now) .. markup(gray, markup(gray, " °C")))
    end
})

-- Memory

memicon = wibox.widget.imagebox(beautiful.widget_mem)
memicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn("urxvt -e htop -s PERCENT_MEM", false) end)))
memwidget = lain.widgets.mem({
    settings  = function()
        mem_header = "mem "
        mem_u      = mem_now.used
        mem_t      = mem_now.total
        mem_p      = mem_now.percent
	widget:set_markup(markup(beautiful.system_color, mem_u) .. markup(gray, " MB") .. " / " .. markup(gray, mem_t) .. markup(gray, " MB"))
        --widget:set_markup(markup(gray, " ") .. markup(blue, mem_u))
	widget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn("urxvt -e htop -s PERCENT_MEM", false) end)))
    end
})
