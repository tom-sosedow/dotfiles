local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local function get_theme(base_theme)
    local theme = base_theme

    --my colors
    theme.useless_gap                               = 0
    theme.window_border_radius                      = 0
    theme.status_border_radius                      = 0
    theme.border_width                              = 1
    theme.systray_icon_spacing                      = 12
    theme.font                                      = "mononoki Nerd Font 12"
    theme.taglist_font                              = "mononoki Nerd Font 12"
    theme.menu_height                               = 20
    theme.menu_width                                = 140
    
    theme.tasklist_plain_task_name                  = true
    theme.tasklist_disable_icon                     = true
    
    theme.notification_font = "JetBrainsMono Nerd Font 12"
    theme.notification_shape =  function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, theme.window_border_radius)
    end
    --theme.notification_opacity = 1.0
    theme.notification_margin = 100
    --theme.notification_width  = 400
    --theme.notification_height = 80
    theme.notification_max_width = 400
    theme.notification_max_height = 300
    theme.notification_icon_size = 20
    -- theme.icon_theme = "Adwaita"
    
    
    local markup = lain.util.markup
    local separators = lain.util.separators
    local widget_colors = {
        theme.yellow,
        theme.grey,
        theme.blue,
        theme.orange,
        theme.red,
        theme.pink,
        theme.green,
        theme.purple,
    }
    
    -- Textclock
    local clockicon = wibox.widget.imagebox(theme.widget_cal)
    local clock = awful.widget.watch(
        "date +'%a %d. %b. %R'", 60,
        function(widget, stdout)
            widget:set_markup(" " .. markup.fontfg(theme.font, widget_colors[1], stdout))
        end
    )
    
    -- Calendar
    theme.cal = lain.widget.cal({
        attach_to = { clock },
        notification_preset = {
            font = theme.font,
            fg   = theme.fg_normal,
            bg   = theme.bg_normal
        }
    })
    
    
    -- MEM
    local memicon = wibox.widget.imagebox(theme.widget_mem, true)
    local mem = lain.widget.mem({
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, widget_colors[3], " " .. mem_now.used .. "MB "))
        end
    })
    
    -- CPU
    local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
    local cpu = lain.widget.cpu({
        settings = function()
            local prefix = " "
            if string.len(cpu_now.usage) == 1 then
                prefix = prefix .. " "
            elseif string.len(cpu_now.usage) == 3 then
                prefix = ""
            end
            widget:set_markup(markup.fontfg(theme.font, widget_colors[4], " " .. prefix .. cpu_now.usage .. "% "))
        end
    })
    
    -- Battery
    local baticon = wibox.widget.imagebox(theme.widget_battery)
    local bat = lain.widget.bat({
        settings = function()
            local color_critical = theme.red
            local color_low = theme.yellow
            local color_ok = theme.white
            local color_full = theme.green
            local status_color = color_ok
            if bat_now.status and bat_now.status ~= "N/A" then
                if bat_now.status == "Charging" then
                    status_color = color_ok
                    baticon:set_image(theme.widget_battery_charging)
                elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                    baticon:set_image(theme.widget_battery_empty)
                    status_color = color_critical
                elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                    baticon:set_image(theme.widget_battery_low)
                    status_color = color_low
                elseif not bat_now.perc and tonumber(bat_now.perc) <= 75 then
                    baticon:set_image(theme.widget_battery_high)
                    status_color = color_full
                else
                    baticon:set_image(theme.widget_battery_full)
                    status_color = color_full
                end
                widget:set_markup(markup.fontfg(theme.font, status_color, " " .. bat_now.perc .. "% "))
            else
                widget:set_markup(markup.fontfg(theme.font, status_color, " ..."))
                baticon:set_image(theme.widget_battery_empty)
            end
        end
    })
    
    -- ALSA volume
    local volicon = wibox.widget.imagebox(theme.widget_vol)
    theme.volume = lain.widget.alsa({
        settings = function()
            if volume_now.status == "off" or tonumber(volume_now.level) == 0 then
                volicon:set_image(theme.widget_vol_mute)
            elseif tonumber(volume_now.level) <= 33 then
                volicon:set_image(theme.widget_vol_low)
            elseif tonumber(volume_now.level) <= 66 then
                volicon:set_image(theme.widget_vol_medium)
            else
                volicon:set_image(theme.widget_vol_loud)
            end
    
            widget:set_markup(markup.fontfg(theme.font, widget_colors[6]," " .. volume_now.level .. "% "))
        end
    })
    
    -- Net
    local neticon = wibox.widget.imagebox(theme.widget_net)
    local net = lain.widget.net({
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, widget_colors[7], " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
        end
    })
    
    function theme.at_screen_connect(s)
        -- Quake application
       -- s.quake = lain.util.quake({ app = awful.util.terminal })
       s.quake = lain.util.quake({ app = "alacritty", height = 0.50, argname = "--name %s" })
    
        -- All tags open with layout 1
        awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 "}, s, awful.layout.layouts[1])
    
        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()
        -- Create an imagebox widget which will contains an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(my_table.join(
                               awful.button({ }, 1, function () awful.layout.inc( 1) end),
                               awful.button({ }, 3, function () awful.layout.inc(-1) end),
                               awful.button({ }, 4, function () awful.layout.inc( 1) end),
                               awful.button({ }, 5, function () awful.layout.inc(-1) end)))
        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = awful.util.taglist_buttons,
            layout = {
                layout  = wibox.layout.fixed.horizontal
            },
            widget_template = {
                {
                    {
                        {
                            id     = 'index_role',
                            widget = wibox.widget.textbox,
                        },
                        {
                            id     = 'text_role',
                            widget = wibox.widget.textbox,
                        },
                        layout = wibox.layout.fixed.horizontal,
                    },
                    left = 5,
                    right = 5,
                    widget  = wibox.container.margin,
                },
                widget = wibox.container.background,
                id = "background_role"
            }
        }
        -- Create a tasklist widget
        local tasklist_buttons = gears.table.join(
            awful.button({ }, 1,
                function (c)
                    c:emit_signal("request::activate", "tasklist", {raise = true})
                end
            ),
            awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
            nil,
            nil
        )
        s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons,
            style    = {
                shape_border_width = 1,
                shape_border_color = '#777777',
                shape  = gears.shape.rounded_bar,
            },
            layout   = {
                spacing = 20,
                spacing_widget = {
                    {
                        forced_width = 5,
                        shape        = gears.shape.circle,
                        widget       = wibox.widget.separator
                    },
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.container.place,
                },
                layout  = wibox.layout.fixed.horizontal
            },
            -- Notice that there is *NO* wibox.wibox prefix, it is a template,
            -- not a widget instance.
            widget_template = {
                {
                    {
                        id     = 'clienticon',
                        widget = awful.widget.clienticon,
                    },
                    forced_height = 30,
                    margins = 0,
                    widget  = wibox.container.margin
                },
                nil,
                create_callback = function(self, c, index, objects) --luacheck: no unused args
                    self:get_children_by_id('clienticon')[1].client = c
                end,
                layout = wibox.layout.fixed.horizontal,
            },
        }
    
        -- Create the wibox
        
        s.mywibox = awful.wibar(
            {
                position = "top",
                screen = s,
                height = 22,
                fg = theme.fg_normal,
                bg = theme.bg_normal,
            }
        )
    
        local systray = wibox.widget.systray()
        local spr = wibox.widget.textbox(" | ")
        local spacing_width = 10
        local spacer = wibox.container.margin(wibox.widget.textbox(""), spacing_width, 0)
    
        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacer,
                    mylauncher,
                },
                {
                    {
                        layout = wibox.layout.fixed.horizontal,
                        s.mytaglist,
                    },
                    left = spacing_width,
                    color = theme.transparent,
                    widget = wibox.container.margin,
                },
                {
                    s.mytasklist,
                    left = spacing_width,
                    top = 2,
                    bottom = 2,
                    color = theme.transparent,
                    widget = wibox.container.margin,
                },
            },
            wibox.widget{},
            {
                layout = wibox.layout.fixed.horizontal,
                spacer,
                wibox.container.place(wibox.widget { systray, layout = wibox.layout.align.horizontal }, "center", "center"),
                spacer,
                wibox.container.margin(wibox.widget { volicon, theme.volume.widget, layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
                spacer,
                wibox.container.margin(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
                spacer,
                wibox.container.margin(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
                spacer,
                wibox.container.margin(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
                spacer,
                wibox.container.margin(wibox.widget { clockicon, wibox.container.margin(clock, 2, 0), layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
                spacer,
                s.mylayoutbox,
                spacer
            },
        }
        
    end
    return theme
end

return get_theme
