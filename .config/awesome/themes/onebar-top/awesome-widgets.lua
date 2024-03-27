local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local function get_widgets(theme)
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
    local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
    local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
    local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
    local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
    local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

    local mytextclock = wibox.widget.textclock()
    -- or customized
    local cw = calendar_widget({
        placement = 'top_right',
        radius = 0,
    -- with customized next/previous (see table above)
        previous_month_button = 1,
        next_month_button = 3,
    })
    mytextclock:connect_signal("button::press",
        function(_, _, _, button)
            if button == 1 then cw.toggle() end
        end)

    local spacing_width = 10
    local spacer = wibox.container.margin(wibox.widget.textbox(""), spacing_width, 0)

    local widget_bar = {
        layout = wibox.layout.fixed.horizontal,
        spacer,
        wibox.container.margin(volume_widget(), 3, 3, 4, 4),
        spacer,
        wibox.container.margin(ram_widget(), 3, 3, 4, 4),
        spacer,
        wibox.container.margin(cpu_widget({
            width = 70,
            step_width = 2,
            step_spacing = 0,
            color = '#434c5e'
        }), 3, 3, 4, 4),
        spacer,
        wibox.container.margin(battery_widget({
            warning_msg_position = "top_right"
        }), 3, 3, 4, 4),
        spacer,
        wibox.container.margin(wibox.widget { clockicon, wibox.container.margin(mytextclock, 2, 0), layout = wibox.layout.align.horizontal }, 3, 3, 4, 4),
        spacer
    }
    return widget_bar
end

return get_widgets
