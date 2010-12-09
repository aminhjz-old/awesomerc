-- Main
theme                         = {}

-- Styles
theme.font                    = "terminus 9"

-- Colors
theme.fg_normal               = "#DCDCCC"
theme.fg_focus                = "#F0DFAF"
theme.fg_urgent               = "#CC9393"
theme.bg_normal               = "#3F3F3F"
theme.bg_focus                = "#1E2320"
theme.bg_urgent               = "#3F3F3F"

-- Borders
theme.border_width            = "1"
theme.border_normal           = "#3F3F3F"
theme.border_focus            = "#6F6F6F"
theme.border_marked           = "#CC9393"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus      = "#1A2320"

-- Widgets
--theme.fg_widget             = "#AECF96"
--theme.fg_center_widget      = "#88A175"
--theme.fg_end_widget         = "#FF5656"
--theme.bg_widget             = "#494B4F"
--theme.border_widget         = "#3F3F3F"

-- Mouse finder
theme.mouse_finder_color      = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]

-- Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height             = "15"
theme.menu_width              = "100"

--------------------
-- Icons
-------------------
-- Taglist
theme.taglist_squares_sel     = awful.util.getdir("config") .. "/icons/taglist/squarefz.png"
theme.taglist_squares_unsel   = awful.util.getdir("config") .. "/icons/taglist/squarez.png"
theme.taglist_squares_resize  = "false"

-- Misc
theme.awesome_icon            = awful.util.getdir("config") .. "/icons/awesome.png"
theme.menu_submenu_icon       = awful.util.getdir("config") .. "/icons/submenu.png"
theme.tasklist_floating_icon  = awful.util.getdir("config") .. "/icons/tasklist/floatingw.png"

-- Layout
theme.layout_tile             = awful.util.getdir("config") .. "/icons/layouts/tile.png"
theme.layout_tileleft         = awful.util.getdir("config") .. "/icons/layouts/tileleft.png"
theme.layout_tilebottom       = awful.util.getdir("config") .. "/icons/layouts/tilebottom.png"
theme.layout_tiletop          = awful.util.getdir("config") .. "/icons/layouts/tiletop.png"
theme.layout_floating         = awful.util.getdir("config") .. "/icons/layouts/floating.png"

return theme
