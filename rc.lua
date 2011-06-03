-----------------------------
-- Includes section
-----------------------------
-- Standard modules
require("awful")
require("awful.autofocus")
require("awful.dbus")
require("awful.placement")
require("awful.rules")
require("awful.tooltip")
require("beautiful")
require("naughty")
-- Custom modules
require("freedesktop.menu")
require("freedesktop.utils")
require("scratch")              -- Scratchpad for Awesome
require("tools.calendar")
require("tools.google")
require("tools.smartplace")
require("vicious")              -- Widgets library

-----------------------------
-- Theme section
-----------------------------
beautiful.init(awful.util.getdir("config") .. "/theme.lua")

local home   = os.getenv("HOME")
local exec   = awful.util.spawn
local sexec  = awful.util.spawn_with_shell
local scount = screen.count()

-----------------------------
-- Preferred applications section
-----------------------------
local xlocker  = "slock"
local terminal = "urxvtc"
local modeler  = "blender"
local browser  = "firefox"
local mailer   = "thunderbird"
local editor   = os.getenv("EDITOR")
local fileman  = terminal .. " -e mc"
local compmgr  = "bash -c 'PID=$(pgrep -u $USER xcompmgr); [ -z $PID ] && (xcompmgr -n -F &>/dev/null &) || kill $PID'"
local dmenu    = "dmenu_run -b -i -p 'Run command:' -fn 'terminus-9'"
    .. "  -sb '" .. beautiful.bg_focus
    .. "' -sf '" .. beautiful.fg_focus
    .. "' -nb '" .. beautiful.bg_normal
    .. "' -nf '" .. beautiful.fg_normal
    .. "'"

-----------------------------
-- Keyboard modifiers section
-----------------------------
altkey = "Mod1"
winkey = "Mod4"

-----------------------------
-- Layouts section
-----------------------------
layouts = {
   awful.layout.suit.tile,             -- 1
   awful.layout.suit.tile.left,        -- 2
   awful.layout.suit.tile.bottom,      -- 3
   awful.layout.suit.tile.top,         -- 4
   awful.layout.suit.floating          -- 5
}

-----------------------------
-- Tags section
-----------------------------
tags = {
   names  = { "main",     "devel",    "net",      "blender", "media" },
   layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] }
}
for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end

-----------------------------
-- Mouse bindings section
-----------------------------
-- Global buttons
globalbuttons = awful.util.table.join(
   awful.button({           }, 3           , function ()
                                                mainmenu:toggle()
                                             end),
   awful.button({           }, 4           , awful.tag.viewnext),
   awful.button({           }, 5           , awful.tag.viewprev)
)

-- Client's buttons
clientbuttons = awful.util.table.join(
   awful.button({           }, 1           , function (c)
                                                client.focus = c;
                                                c:raise()
                                             end),
   awful.button({ winkey    }, 1           , awful.mouse.client.move),
   awful.button({ winkey    }, 3           , awful.mouse.client.resize)
)

-- Layouts widget buttons
layoutbuttons = awful.util.table.join(
   awful.button({           }, 1           , function ()
                                                awful.layout.inc(layouts, 1)
                                             end),
   awful.button({           }, 3           , function ()
                                                awful.layout.inc(layouts, -1)
                                             end),
   awful.button({           }, 4           , function ()
                                                awful.layout.inc(layouts, 1)
                                             end),
   awful.button({           }, 5           , function ()
                                                awful.layout.inc(layouts, -1)
                                             end)
)

-- Taglist widget buttons
tagbuttons = awful.util.table.join(
   awful.button({           }, 1           , awful.tag.viewonly),
   awful.button({ winkey    }, 1           , awful.client.movetotag),
   awful.button({           }, 3           , awful.tag.viewtoggle),
   awful.button({ winkey    }, 3           , awful.client.toggletag),
   awful.button({           }, 4           , awful.tag.viewnext),
   awful.button({           }, 5           , awful.tag.viewprev)
)

-- Tasklist widget buttons
taskbuttons = awful.util.table.join(
   awful.button({           }, 1           , function (c)
                                                if not c:isvisible() then
                                                   awful.tag.viewonly(c:tags()[1])
                                                end
                                                client.focus = c
                                                c:raise()
                                             end),
   awful.button({           }, 3           , function ()
                                                if instance then
                                                   instance:hide()
                                                   instance = nil
                                                else
                                                   instance = awful.menu.clients({width=250})
                                                end
                                             end),
   awful.button({           }, 4           , function ()
                                                awful.client.focus.byidx(1)
                                                if client.focus then
                                                   client.focus:raise()
                                                end
                                             end),
   awful.button({           }, 5           , function ()
                                                awful.client.focus.byidx(-1)
                                                if client.focus then
                                                   client.focus:raise()
                                                end
                                             end)
)

-----------------------------
-- Keyboard bindings section
-----------------------------
-- Global bindings
globalkeys = awful.util.table.join(

   -- Exit and restart
   awful.key({ winkey,
               "Control"    }, "r"         , awesome.restart),
   awful.key({ winkey       }, "x"         , awesome.quit),

   -- Prompts: run, google-translate(en->ru, ru->en)
   --awful.key({ winkey       }, "r"         , function ()
   --    awful.prompt.run({ prompt = "Run: " }, promptbox[mouse.screen].widget,
   --    function (...) promptbox[mouse.screen].text = exec(unpack(arg), false) end,
   --    awful.completion.shell, awful.util.getdir("cache") .. "/history")
   --end),
   awful.key({ altkey       }, "F1"        , function ()
       awful.prompt.run({ prompt = "Translate [ru]: " }, promptbox[mouse.screen].widget,
       function (words)
           tools.google.translate(words, "en", "ru")
       end, nil, awful.util.getdir("cache") .. "/translate")
   end),

   -- Client frame manipulation
   awful.key({ winkey,
               "Control"    }, "Left"      , function ()
                                                awful.client.swap.byidx(1)
                                             end),
   awful.key({ winkey,
               "Control"    }, "Right"     , function ()
                                                awful.client.swap.byidx(-1)
                                             end),
   awful.key({ winkey       }, "Right"     , function ()
                                                awful.tag.incmwfact(0.05)
                                             end),
   awful.key({ winkey       }, "Left"      , function ()
                                                awful.tag.incmwfact(-0.05)
                                             end),

   -- Focus manipulation
   awful.key({ altkey       }, "Tab"       , function ()
                                                awful.client.focus.byidx( 1)
                                                if client.focus then
                                                   client.focus:raise()
                                                end
                                             end),
   awful.key({ winkey       }, "Tab"       , function ()
                                                awful.client.focus.byidx(-1)
                                                if client.focus then
                                                   client.focus:raise()
                                                end
                                             end),

   -- Standard program
   awful.key({ winkey       }, "Return"    , function ()  exec(terminal) end),
   awful.key({ winkey       }, "l"         , function ()  exec(xlocker) end),
   awful.key({ winkey       }, "b"         , function ()  exec(modeler) end),
   awful.key({ winkey       }, "e"         , function ()  exec(fileman) end),
   awful.key({ winkey       }, "i"         , function ()  exec(browser) end),
   awful.key({ winkey       }, "m"         , function ()  exec(mailer) end),
   awful.key({ winkey       }, "r"         , function ()  exec(dmenu) end),
   awful.key({ winkey       }, "c"         , function (c) exec(compmgr) end),

   -- Main menu
   awful.key({ "Control"    }, "Escape"    , function ()  mainmenu:show(true) end),

   -- Media keys
   awful.key({ },  "XF86MonBrightnessDown" , function ()  exec("backlight-osd lower &>/dev/null") end),
   awful.key({ },  "XF86MonBrightnessUp"   , function ()  exec("backlight-osd raise &>/dev/null") end),
   awful.key({ },  "XF86AudioRaiseVolume"  , function ()  exec("mixer-osd volup &>/dev/null") end),
   awful.key({ },  "XF86AudioLowerVolume"  , function ()  exec("mixer-osd voldown &>/dev/null") end),
   awful.key({ },  "XF86AudioPause"        , function ()  exec("audio-osd pause &>/dev/null") end),
   awful.key({ },  "XF86AudioStop"         , function ()  exec("audio-osd stop &>/dev/null") end),
   awful.key({ },  "XF86AudioPlay"         , function ()  exec("audio-osd play &>/dev/null") end),
   awful.key({ },  "XF86AudioPrev"         , function ()  exec("audio-osd prev &>/dev/null") end),
   awful.key({ },  "XF86AudioNext"         , function ()  exec("audio-osd next &>/dev/null") end),
   awful.key({ },  "XF86AudioMute"         , function ()  exec("mixer-osd mute &>/dev/null") end),
   awful.key({ },  "XF86Launch1"           , function ()  exec("launch1-osd next &>/dev/null") end),
   awful.key({ },  "XF86Suspend"           , function ()  exec("suspend-osd &>/dev/null") end),
   awful.key({ },  "XF86Display"           , function ()  exec("display-osd &>/dev/null") end)
)

-- Switch tags by number bindings (limited to 9)
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end
for i = 1, keynumber do
   globalkeys = awful.util.table.join(
      globalkeys,
      awful.key({ altkey    }, "#" .. i + 9, function ()
                                                local screen = mouse.screen
                                                if tags[screen][i] then
                                                   awful.tag.viewonly(tags[screen][i])
                                                end
                                             end),
      awful.key({ altkey,
                  "Control" }, "#" .. i + 9, function ()
                                                local screen = mouse.screen
                                                if tags[screen][i] then
                                                   awful.tag.viewtoggle(tags[screen][i])
                                                end
                                             end),
      awful.key({ altkey,
                  "Shift"   }, "#" .. i + 9, function ()
                                                if awful.client.focus
                                                   and tags[client.focus.screen][i] then
                                                   awful.client.movetotag(tags[client.focus.screen][i])
                                                end
                                             end),
      awful.key({ altkey   ,
                  "Control",
                  "Shift"   }, "#" .. i + 9, function ()
                                                if awful.client.focus
                                                   and tags[client.focus.screen][i] then
                                                   awful.client.toggletag(tags[client.focus.screen][i])
                                                end
                                             end))
end

-- Client's bindings
clientkeys = awful.util.table.join(
   awful.key({ winkey       }, "F11"       , function (c)
                                                c.fullscreen = not c.fullscreen
                                             end),
   awful.key({ altkey       }, "F4"        , function (c)
                                                c:kill()
                                             end),
   awful.key({ winkey       }, "space"     , function (c)
                                                awful.client.floating.toggle(c)
                                             end),
   awful.key({ "Control"    }, "Return"    , function (c)
                                                c:swap(awful.client.getmaster())
                                             end),
   awful.key({ winkey,
               "Shift "     }, "r"         , function (c)
                                                c:redraw()
                                             end),
   awful.key({ winkey       }, "f"         , function (c)
                                                c.maximized_horizontal = not c.maximized_horizontal
                                                c.maximized_vertical   = not c.maximized_vertical
                                             end)
)

-- Set root keys & buttons
root.buttons(globalbuttons)
root.keys(globalkeys)



-----------------------------
-- Widgets configuration
-----------------------------
-- Reusable separator
separator = widget({ type = "imagebox" })
separator.image = image(beautiful.widget_sep)

-- Applications menu
freedesktop.utils.terminal = terminal
freedesktop.utils.icon_theme = "gnome"

-- Awesome specific menu
awesomemenu = {
   { "Configure", editor .. " " .. awful.util.getdir("config") .. "/rc.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
   { "Restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'gtk-refresh' }) },
   { "Quit", awesome.quit, freedesktop.utils.lookup_icon({ icon = 'gtk-quit' }) }
}

-- XDG menu
xdgmenu = freedesktop.menu.new()
table.insert(xdgmenu, { "Awesome", awesomemenu, beautiful.awesome_icon })

-- Main menu
mainmenu = awful.menu.new({ items = xdgmenu })

-- App launcher
launcher  = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu = mainmenu })

-- CPU usage and temperature
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
cpugraph  = awful.widget.graph()
tzswidget = widget({ type = "textbox" })
cpugraph:set_width(40):set_height(14)
cpugraph:set_background_color(beautiful.fg_off_widget)
cpugraph:set_gradient_angle(0):set_gradient_colors({ beautiful.fg_end_widget,
                                                     beautiful.fg_center_widget,
                                                     beautiful.fg_widget})
vicious.register(cpugraph,  vicious.widgets.cpu,      "$1" , 0.5)
vicious.register(tzswidget, vicious.widgets.thermal, " $1C", 0.5, "thermal_zone0")

-- Memory usage
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)
membar = awful.widget.progressbar()
membar:set_width(40):set_height(14)
membar:set_background_color(beautiful.fg_off_widget)
membar:set_gradient_colors({beautiful.fg_widget,
                            beautiful.fg_center_widget,
                            beautiful.fg_end_widget})
memtxt = widget({ type = "textbox" })
vicious.register(membar, vicious.widgets.mem, "$1", 0.5)
vicious.register(memtxt, vicious.widgets.mem, "$2", 0.5)

-- Network usage
dnicon = widget({ type = "imagebox" })
upicon = widget({ type = "imagebox" })
dnicon.image = image(beautiful.widget_net)
upicon.image = image(beautiful.widget_netup)
netwidget = widget({ type = "textbox" })
vicious.register(netwidget, vicious.widgets.net, '<span color="'
                 .. beautiful.fg_netdn_widget ..'">${wlan0 down_kb}</span> <span color="'
                 .. beautiful.fg_netup_widget ..'">${wlan0 up_kb}</span>', 0.5)

-- Battery state
baticon = widget({ type = "imagebox" })
baticon.image = image(beautiful.widget_bat)
batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, "$1$2%", 0.5, "BAT0")

-- Volume level
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.widget_vol)
volbar    = awful.widget.progressbar()
volwidget = widget({ type = "textbox" })
volbar:set_vertical(true):set_ticks(true)
volbar:set_height(14):set_width(8):set_ticks_size(2)
volbar:set_background_color(beautiful.fg_off_widget)
volbar:set_gradient_colors({ beautiful.fg_widget,
                             beautiful.fg_center_widget,
                             beautiful.fg_end_widget})
vicious.cache(vicious.widgets.volume)
vicious.register(volbar,    vicious.widgets.volume,  "$1",  0.5, "Master")
vicious.register(volwidget, vicious.widgets.volume, " $2$1%", 0.5, "Master")
volbar.widget:buttons(awful.util.table.join(
   awful.button({ }, 1, function () sexec("alsamixer") end),
   awful.button({ }, 4, function () exec("mixer-osd volup", false) end),
   awful.button({ }, 5, function () exec("mixer-osd voldown", false) end)))
volwidget:buttons(volbar.widget:buttons())

-- Date and time
dateicon = widget({ type = "imagebox" })
dateicon.image = image(beautiful.widget_date)
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "%R", 61)

-- System tray
systray = widget({ type = "systray" })

-- Widget box
wibox     = {}
promptbox = {}
layoutbox = {}
taglist   = {}
tasklist  = {}

-- Add widgets to each screen
for s = 1, scount do
    -- Create a promptbox
    promptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })

    -- Create a layoutbox
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(layoutbuttons)

    -- Create the taglist
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, tagbuttons)

    -- Create the tasklist
    tasklist[s] = awful.widget.tasklist(function(c)
                                           return awful.widget.tasklist.label.currenttags(c, s)
                                        end,
                                        taskbuttons)
    -- Create the wibox
    wibox[s] = awful.wibox({      screen = s,
        fg = beautiful.fg_normal, height = 14,
        bg = beautiful.bg_normal, position = "top",
        border_color = beautiful.border_focus,
        border_width = beautiful.border_width
    })

    -- Add widgets to the wibox
    wibox[s].widgets = {
        {
            launcher, taglist[s], layoutbox[s], separator,
           ["layout"] = awful.widget.layout.horizontal.leftright
        },
        s == 1 and systray or nil,
        separator, datewidget   , dateicon       ,
        separator, volwidget    , volbar.widget  , volicon    ,
        separator, batwidget    , baticon        ,
        separator, upicon       , netwidget      , dnicon     ,
        separator, memtxt       , membar.widget  , memicon    ,
        separator, tzswidget    , cpugraph.widget, cpuicon    ,
        separator, promptbox[s] , { tasklist[s], ["layout"] = awful.widget.layout.rightleft },
        ["layout"] = awful.widget.layout.horizontal.rightleft
    }
end

-- Integrate calendar to datewidget
tools.calendar.addCalendarToWidget(datewidget, "<span color='red'>%s</span>")
tools.calendar.addCalendarToWidget(dateicon, "<span color='red'>%s</span>")

-----------------------------
--- Functions
-----------------------------
-- On floating state toggled
function floating_toggled(c)
   local l_isfloat = awful.layout.get() == awful.layout.suit.floating
   local c_isfloat = awful.client.floating.get(c)
   if l_isfloat or c_isfloat then
      c.size_hints_honor = true
      if not c.size_hints.user_position
         and not c.size_hints.program_position then
         smartplace(c)
      end
   else
      c.size_hints_honor = false
   end
end

-----------------------------
-- Window rules
-----------------------------
awful.rules.rules = {
   { -- Thunderbird -> Preferences
      rule = { class = "Thunderbird", role = "Preferences" },
      properties = {
          floating = true
      }
   },

   { -- Thunderbird -> Manager (Download, Extension)
      rule = { class = "Thunderbird", role = "Manager" },
      properties = {
          floating = true
      }
   },

   { -- Thunderbird -> any
      rule = { class = "Thunderbird" },
      properties = {
         switchtotag = true,
         tag = tags[1][3]
      }
   },

   { -- Firefox -> Preferences
      rule = { class = "Firefox", role = "Preferences" },
      properties = {
          floating = true
      }
   },

   { -- Firefox -> Manager (Download, Extension)
      rule = { class = "Firefox", role = "Manager" },
      properties = {
          floating = true
      }
   },

   { -- Firefox -> any
      rule = { class = "Firefox" },
      properties = {
         switchtotag = true,
         tag = tags[1][3]
      }
   },

   { -- FreeRDP
      rule = { name = "freerdp" },
      properties = {
         switchtotag = true,
         floating = true,
         tag = tags[1][3]
      }
   },

   { -- Skype
      rule = { class = "Skype" },
      properties = {
          floating = true
      }
   },

   { -- MPlayer
      rule = { class = "MPlayer" },
      properties = {
         switchtotag = true,
         floating = true,
         tag = tags[1][5]
     }
   },

   { -- Blender
      rule = { class = "Blender" },
      properties = {
         switchtotag = true,
         tag = tags[1][4]
      }
   },

   { -- Any
      rule = { },
      properties = {
         border_width = beautiful.border_width,
         border_color = beautiful.border_normal,
         maximized_horizontal = false,
         maximized_vertical = false,
         buttons = clientbuttons,
         keys = clientkeys,
         focus = true
      },
      callback = floating_toggled
   },
}

-----------------------------
-- Signals
-----------------------------
-- New client appears
client.add_signal("manage"  , function(c, startup)
                                 c:add_signal("property::floating", floating_toggled)
                              end)

-- Tagged
client.add_signal("tagged"  , function(c)
                                 floating_toggled(c)
                              end)

-- Untagged
client.add_signal("untagged", function(c)
                                 floating_toggled(c)
                              end)

-- Focus
client.add_signal("focus"   , function(c)
                                 c.border_color = beautiful.border_focus
                                 c.opacity = 1
                              end)

-- Unfocus
client.add_signal("unfocus" , function(c)
                                 c.border_color = beautiful.border_normal
                                 c.opacity = 0.75
                              end)

-- Dbus test
dbus.add_signal("org.naquadah.awesome.awful.mcabber", function(data, message)
                                                         naughty.notify({ text = message, timeout = 1 })
                                                      end)
dbus.request_name("session", "org.naquadah.awesome.awful.mcabber")

-----------------------------
-- Misc
-----------------------------
-- Set WM name for Java based apps
awful.util.spawn("wmname LG3D")
