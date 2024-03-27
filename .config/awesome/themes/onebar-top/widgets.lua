local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local function get_widgets(theme)
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
    
    local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
    
    -- Net
    local neticon = wibox.widget.imagebox(theme.widget_net)
    local net = lain.widget.net({
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, widget_colors[7], " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
        end
    })

    local spacing_width = 10
    local spacer = wibox.container.margin(wibox.widget.textbox(""), spacing_width, 0)

    local widget_bar = {
        layout = wibox.layout.fixed.horizontal,
        spacer,
        wibox.container.margin(volume_widget({mixer_cmd = "pactl"}), 3, 3, 4, 4),
        spacer,
        wibox.container.margin(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
        spacer,
        wibox.container.margin(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
        spacer,
        wibox.container.margin(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
        spacer,
        wibox.container.margin(wibox.widget { clockicon, wibox.container.margin(clock, 2, 0), layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
        spacer
    }
    return widget_bar
end

return get_widgets
