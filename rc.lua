-----------------------------
-- Includes section
-----------------------------
require("awful")
require("awful.autofocus")
require("awful.rules")
require("awful.tooltip")
require("awful.placement")
require("beautiful")
require("naughty")
require('tools.calendar')
require("tools.smartplace")

-----------------------------
-- Theme section
-----------------------------
beautiful.init(awful.util.getdir("config") .. "/theme.lua")

-----------------------------
-- Preferred applications section
-----------------------------
xlocker  = "slock"
terminal = "urxvtc"
modeler  = "blender"
browser  = "firefox"
mailer   = "thunderbird"
editor   = os.getenv("EDITOR")
fileman  = terminal .. " -e mc"
dmenu    = "dmenu_run -b -i -p 'Run command:' -fa 'Sans-10'"
   .. "  -sb '" .. beautiful.bg_focus
   .. "' -sf '" .. beautiful.fg_focus
   .. "' -nb '" .. beautiful.bg_normal
   .. "' -nf '" .. beautiful.fg_normal
   .. "'"

-----------------------------
-- Keyboard modifiers section
-----------------------------
winkey = "Mod4"
altkey = "Mod1"

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
   layout = { layouts[1], layouts[1], layouts[1], layouts[5], layouts[1] }
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
                                                mymainmenu:toggle()
                                             end                                              ),
   awful.button({           }, 4           , awful.tag.viewnext                               ),
   awful.button({           }, 5           , awful.tag.viewprev                               )
)
-- Client's buttons
clientbuttons = awful.util.table.join(
   awful.button({           }, 1           , function (c)
                                                client.focus = c;
                                                c:raise()
                                             end                                              ),
   awful.button({ winkey    }, 1           , awful.mouse.client.move                          ),
   awful.button({ winkey    }, 3           , awful.mouse.client.resize                        )
)
-- Layouts widget buttons
layoutbuttons = awful.util.table.join(
   awful.button({           }, 1           , function ()
                                                awful.layout.inc(layouts, 1)
                                             end                                              ),
   awful.button({           }, 3           , function ()
                                                awful.layout.inc(layouts, -1)
                                             end                                              ),
   awful.button({           }, 4           , function ()
                                                awful.layout.inc(layouts, 1)
                                             end                                              ),
   awful.button({           }, 5           , function ()
                                                awful.layout.inc(layouts, -1)
                                             end                                              )
)
-- Taglist widget buttons
tagbuttons = awful.util.table.join(
   awful.button({           }, 1           , awful.tag.viewonly                               ),
   awful.button({ winkey    }, 1           , awful.client.movetotag                           ),
   awful.button({           }, 3           , awful.tag.viewtoggle                             ),
   awful.button({ winkey    }, 3           , awful.client.toggletag                           ),
   awful.button({           }, 4           , awful.tag.viewnext                               ),
   awful.button({           }, 5           , awful.tag.viewprev                               )
)
-- Tasklist widget buttons
taskbuttons = awful.util.table.join(
   awful.button({           }, 1           , function (c)
                                                if not c:isvisible() then
                                                   awful.tag.viewonly(c:tags()[1])
                                                end
                                                client.focus = c
                                                c:raise()
                                             end                                              ),
   awful.button({           }, 3           , function ()
                                                if instance then
                                                   instance:hide()
                                                   instance = nil
                                                else
                                                   instance = awful.menu.clients({width=250})
                                                end
                                             end                                              ),
   awful.button({           }, 4           , function ()
                                                awful.client.focus.byidx(1)
                                                if client.focus then
                                                   client.focus:raise()
                                                end
                                             end                                              ),
   awful.button({           }, 5           , function ()
                                                awful.client.focus.byidx(-1)
                                                if client.focus then
                                                   client.focus:raise()
                                                end
                                             end                                              )
)

-----------------------------
-- Keyboard bindings section
-----------------------------
-- Global bindings
globalkeys = awful.util.table.join(
   -- Exit and restart
   awful.key({ winkey,
               "Control"    }, "r"         , awesome.restart                                  ),
   awful.key({ winkey       }, "x"         , awesome.quit                                     ),
   -- Client frame manipulation
   awful.key({ winkey,
               "Control"    }, "Left"      , function ()
                                                awful.client.swap.byidx(1)
                                             end                                              ),
   awful.key({ winkey,
               "Control"    }, "Right"     , function ()
                                                awful.client.swap.byidx(-1)
                                             end                                              ),
   awful.key({ winkey       }, "Right"     , function ()
                                                awful.tag.incmwfact(0.05)
                                             end                                              ),
   awful.key({ winkey       }, "Left"      , function ()
                                                awful.tag.incmwfact(-0.05)
                                             end                                              ),
   -- Focus manipulation
   awful.key({ altkey       }, "Tab"       , function ()
                                                awful.client.focus.byidx( 1)
                                                if client.focus then
                                                   client.focus:raise()
                                                end
                                             end                                              ),
   awful.key({ winkey       }, "Tab"       , function ()
                                                awful.client.focus.byidx(-1)
                                                if client.focus then
                                                   client.focus:raise()
                                                end
                                             end                                              ),
   -- Standard program
   awful.key({ winkey       }, "Return"    , function ()
                                                awful.util.spawn(terminal)
                                             end                                              ),
   awful.key({ winkey       }, "l"         , function ()
                                                awful.util.spawn(xlocker)
                                             end                                              ),
   awful.key({ winkey       }, "b"         , function ()
                                                awful.util.spawn(modeler)
                                             end                                              ),
   awful.key({ winkey       }, "e"         , function ()
                                                awful.util.spawn(fileman)
                                             end                                              ),
   awful.key({ winkey       }, "i"         , function ()
                                                awful.util.spawn(browser)
                                             end                                              ),
   awful.key({ winkey       }, "m"         , function ()
                                                awful.util.spawn(mailer)
                                             end                                              ),
   awful.key({ winkey       }, "r"         , function ()
                                                awful.util.spawn(dmenu)
                                             end                                              ),
   -- Main menu
   awful.key({ "Control"    }, "Escape"    , function ()
                                                mymainmenu:show(true)
                                             end                                              ),
   -- Media keys
   awful.key({ },  "XF86MonBrightnessDown" , function ()
                                                awful.util.spawn("backlight-osd lower &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86MonBrightnessUp"   , function ()
                                                awful.util.spawn("backlight-osd raise &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86AudioRaiseVolume"  , function ()
                                                awful.util.spawn("mixer-osd volup &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86AudioLowerVolume"  , function ()
                                                awful.util.spawn("mixer-osd voldown &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86AudioPause"        , function ()
                                                awful.util.spawn("audio-osd pause &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86AudioStop"         , function ()
                                                awful.util.spawn("audio-osd stop &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86AudioPlay"         , function ()
                                                awful.util.spawn("audio-osd play &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86AudioPrev"         , function ()
                                                awful.util.spawn("audio-osd prev &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86AudioNext"         , function ()
                                                awful.util.spawn("audio-osd next &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86AudioMute"         , function ()
                                                awful.util.spawn("mixer-osd mute &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86Launch1"           , function ()
                                                awful.util.spawn("launch1-osd next &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86Suspend"           , function ()
                                                awful.util.spawn("suspend-osd &>/dev/null")
                                             end                                              ),
   awful.key({ },  "XF86Display"           , function ()
                                                awful.util.spawn("display-osd &>/dev/null")
                                             end                                              )
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
                                             end                                              ),
      awful.key({ altkey,
                  "Control" }, "#" .. i + 9, function ()
                                                local screen = mouse.screen
                                                if tags[screen][i] then
                                                   awful.tag.viewtoggle(tags[screen][i])
                                                end
                                             end                                              ),
      awful.key({ altkey,
                  "Shift"   }, "#" .. i + 9, function ()
                                                if awful.client.focus
                                                   and tags[client.focus.screen][i] then
                                                   awful.client.movetotag(tags[client.focus.screen][i])
                                                end
                                             end                                              ),
      awful.key({ altkey   ,
                  "Control",
                  "Shift"   }, "#" .. i + 9, function ()
                                                if awful.client.focus
                                                   and tags[client.focus.screen][i] then
                                                   awful.client.toggletag(tags[client.focus.screen][i])
                                                end
                                             end                                              )
   )
end

-- Client's bindings
clientkeys = awful.util.table.join(
   awful.key({ winkey       }, "F11"       , function (c)
                                                c.fullscreen = not c.fullscreen
                                             end                                              ),
   awful.key({ altkey       }, "F4"        , function (c)
                                                c:kill()
                                             end                                              ),
   awful.key({ winkey       }, "space"     , function (c)
                                                awful.client.floating.toggle(c)
                                             end                                              ),
   awful.key({ "Control"    }, "Return"    , function (c)
                                                c:swap(awful.client.getmaster())
                                             end                                              ),
   awful.key({ winkey,
               "Shift "     }, "r"         , function (c)
                                                c:redraw()
                                             end                                              ),
   awful.key({ winkey       }, "c"         , function (c)
                                                c.minimized = not c.minimized
                                             end                                              ),
   awful.key({ winkey       }, "f"         , function (c)
                                                c.maximized_horizontal = not c.maximized_horizontal
                                                c.maximized_vertical   = not c.maximized_vertical
                                             end                                              )
)
-- Set root keys & buttons
root.buttons(globalbuttons)
root.keys(globalkeys)

-----------------------------
-- Widgets section
-----------------------------
-- Awesome specific menu
myawesomemenu = {
   { "manual"     , terminal .. " -e man awesome"                             },
   { "edit config", editor .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart"    , awesome.restart                                           },
   { "quit"       , awesome.quit                                              }
}

-- Main menu
mymainmenu = awful.menu(
   {
      items = {
         { "awesome"      , myawesomemenu, beautiful.awesome_icon },
         { "open terminal", terminal                              }
      }
   }
)

-- Main menu button, clock & systray are singletons
mylauncher  = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu = mymainmenu })
mytextclock = awful.widget.textclock({ align = "right" })
mysystray   = widget({ type = "systray" })

-- Wibox, command prompt, layoutbox, taglist, tasklist
mywibox     = {}
mylayoutbox = {}
mytaglist   = {}
mytasklist  = {}

for s = 1, screen.count() do
   -- Create widgets
   mylayoutbox[s] = awful.widget.layoutbox(s)
   mylayoutbox[s]:buttons(layoutbuttons)
   mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, tagbuttons)
   mytasklist[s] = awful.widget.tasklist(function(c)
                                            return awful.widget.tasklist.label.currenttags(c, s)
                                         end,
                                         taskbuttons)
   -- Add widgets to corresponding wibox
   mywibox[s] = awful.wibox({ position = "top", screen = s })
   mywibox[s].widgets = {
      {
         mytaglist[s],
         mylauncher,
         layout = awful.widget.layout.horizontal.leftright
      },
      mylayoutbox[s],
      -- Single instance of clock for all screens
      mytextclock,
      -- Systray on first screen only
      s == 1 and mysystray or nil,
      mytasklist[s],
      layout = awful.widget.layout.horizontal.rightleft
   }
end

tools.calendar.addCalendarToWidget(mytextclock, "<span color='green'>%s</span>")

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
   { -- Sonata
      rule = { class = "Sonata" },
      properties = {
         switchtotag = true,
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
                              end)
-- Unfocus
client.add_signal("unfocus" , function(c)
                                 c.border_color = beautiful.border_normal
                              end)
