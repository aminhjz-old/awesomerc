-- Main
theme = {}
theme.confdir       = awful.util.getdir("config")
theme.wallpaper_cmd = { "/bin/false" }

-- Styles
theme.font      = "terminus 9"

-- Colors
theme.fg_normal = "#DCDCCC"
theme.fg_focus  = "#F0DFAF"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#3F3F3F"
theme.bg_focus  = "#1E2320"
theme.bg_urgent = theme.bg_normal

-- Borders
theme.border_width  = 1
theme.border_focus  = "#6F6F6F"
theme.border_normal = theme.bg_normal
theme.border_marked = theme.fg_urgent

-- Widgets
theme.fg_widget        = "#AECF96"
theme.fg_center_widget = "#88A175"
theme.fg_end_widget    = "#FF5656"
theme.fg_off_widget    = "#494B4F"
theme.fg_netup_widget  = "#7F9F7F"
theme.fg_netdn_widget  = theme.fg_urgent
theme.bg_widget        = theme.bg_normal
theme.border_widget    = theme.bg_normal

-- Taglist icons
theme.taglist_squares_sel   = theme.confdir .. "/icons/taglist/sel.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/taglist/unsel.png"

-- Misc icons
theme.tasklist_floating_icon = theme.confdir .. "/icons/tasklist/floating.png"

-- Widget icons
theme.widget_cpu    = theme.confdir .. "/icons/cpu.png"
theme.widget_bat    = theme.confdir .. "/icons/bat.png"
theme.widget_mem    = theme.confdir .. "/icons/mem.png"
theme.widget_net    = theme.confdir .. "/icons/down.png"
theme.widget_netup  = theme.confdir .. "/icons/up.png"
theme.widget_vol    = theme.confdir .. "/icons/vol.png"
theme.widget_date   = theme.confdir .. "/icons/time.png"
theme.widget_sep    = theme.confdir .. "/icons/separator.png"

return theme
