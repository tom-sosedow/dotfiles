local colors = {}
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()

colors.light_black = xrdb.color0
colors.black = xrdb.color0
colors.deep_black = xrdb.color0
colors.white = xrdb.color1
colors.light_white = xrdb.color1
colors.pink = xrdb.color2
colors.red = xrdb.color3
colors.orange = xrdb.color4
colors.yellow = xrdb.color5
colors.green = xrdb.color6
colors.blue = xrdb.color7
colors.purple = xrdb.color8
colors.grey = xrdb.color9

colors.bg_normal     = xrdb.background
colors.bg_focus      = xrdb.color12
colors.bg_urgent     = xrdb.color9
colors.bg_minimize   = xrdb.color8
colors.bg_systray    = colors.bg_normal

colors.fg_normal     = xrdb.foreground
colors.fg_focus      = colors.bg_normal
colors.fg_urgent     = colors.bg_normal
colors.fg_minimize   = colors.bg_normal

colors.border_normal = xrdb.color0
colors.border_active = colors.bg_focus
colors.border_focus = xrdb.color10

colors.titlebar_bg_focus = colors.bg_focus
colors.titlebar_bg_normal = colors.bg_normal
colors.titlebar_fg_focus = colors.fg_focus
colors.notification_bg = colors.bg_normal
colors.notification_fg = colors.fg_normal

return colors
