pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local lain          = require("lain")
require("awful.hotkeys_popup.keys")

if awesome.startup_errors then
    naughty.notify({ 
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors 
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

local colors = {
    gruvbox_dark = {
        colors = require("themes.colors.gruvbox-dark"),
        add_icons = require("themes.icons.white.icons"),
        theme = {},
        name = "Gruvbox Dark"
    },
    catpuccin = {
        colors = require("themes.colors.catppuccin"),
        add_icons = require("themes.icons.white.icons"),
        theme = {},
        name = "Catppuccin Dark"
    },
    xresources = {
        colors = require("themes.colors.xresources"),
        add_icons = require("themes.icons.white.icons"),
        theme = {},
        name = "Pywal Theme (Xresources)"
    }
}
for _, theme in pairs(colors) do theme.theme = theme.add_icons(theme.colors) end

local layouts = {
    separated = {
        get_layout = require("themes.separated.theme")
    },
    onebar_top = {
        get_layout = require("themes.onebar-top.theme")
    }
}
local chosen_color = colors.gruvbox_dark
local chosen_layout = layouts.separated

local theme = chosen_layout.get_layout(chosen_color.theme)
beautiful.init(theme)

modkey = "Mod4"
-- This is used later as the default programs to run
terminal = "kitty"
browser = "firefox"
file_manager = "nemo"
editor = "codium"
discord = "discord"
spotify = "spotify-launcher"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    --awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", function() awful.spawn.with_shell(editor .. " " .. string.format("%s/.config/awesome/rc.lua", os.getenv("HOME"))) end },
   { "edit theme", function() awful.spawn.with_shell(editor .. " " .. theme_path) end },
   { "suspend", function() awful.spawn.with_shell("systemctl suspend") end},
   { "shutdown", function() awful.spawn.with_shell("shutdown now") end},
}

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu =  awful.menu({items = myawesomemenu})})

globalkeys = gears.table.join(
    awful.key({ modkey, "Shift" }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() awful.spawn("rofi -show drun") end,
              {description = "show rofi", group = "launcher"}),
    awful.key({ modkey, }, "f", 
        function (c) awful.spawn(browser) end ,
        {description = "run browser", group = "launcher"}),
    awful.key({ modkey, }, "d", 
        function (c) awful.spawn(discord) end ,
        {description = "run discord", group = "launcher"}),
    awful.key({ modkey, }, "s", 
        function (c) awful.spawn(spotify) end ,
        {description = "run music spotify", group = "launcher"}),
    awful.key({ modkey, }, "e",
        function (c) awful.spawn(file_manager) end ,
        {description = "run file manager", group = "launcher"}),
    awful.key({ modkey, }, ".",
        function (c) awful.spawn("flatpak run it.mijorus.smile") end ,
        {description = "run emoji picker", group = "launcher"}),
    --my keys
    awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn("blight -5%") end,
        {description = "brightness down", group = "media keys"}),
    awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn("blight +5%") end,
        {description = "brightness up", group = "media keys"}),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") end,
        {description = "volume down", group = "media keys"}),
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+") end,
        {description = "volume up", group = "media keys"}),
    awful.key({ }, "XF86AudioMute", function () awful.spawn("amixer -D pulse set Master 1+ toggle") end, {description = "toggle mute", group = "media keys"}),
    awful.key({ }, "Print", function () awful.spawn("flameshot gui") end, {description = "screenshot", group = "media keys"}),
    awful.key({ modkey }, ".", function () awful.spawn("emote") end, {description = "Emoji Picker", group = "launcher"}),
    awful.key({ modkey }, "u", function () awful.spawn.with_shell(editor .. " ~/Dokumente/Uni/") end, {description = "launch uni notes", group = "launcher"}),
    awful.key({ modkey, "Control" }, "s", function () awful.spawn.with_shell("systemctl suspend") end, {description = "suspend", group = "awesome"})
    --,awful.key({ modkey, "Shift"}, "t", function () naughty.notify({text = "Welt", title = "Hallo", position = "top_middle"}) end, {description = "launch uni notes", group = "testing"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "m",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    --[[awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}), --]]
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    local border_radius = beautiful.window_border_radius
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,border_radius)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { size = 30 }): setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            awful.titlebar.widget.ontopbutton(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),            
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
client.connect_signal("property::floating", function(c)
    if c.floating and not (c.requests_no_titlebar or c.fullscreen) then
      awful.titlebar.show(c)
    else
      awful.titlebar.hide(c)
    end
end)

awful.tag.attached_connect_signal(nil, "property::layout", function (t)
    local float = t.layout.name == "floating"
    for _,c in pairs(t:clients()) do
        c.floating = float
    end
end)


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
client.disconnect_signal("request::geometry", awful.ewmh.client_geometry_requests)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

awful.screen.connect_for_each_screen(function(s)
    beautiful.at_screen_connect(s)
    -- freedesktop.desktop.add_icons({screen = s})
end)

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            clientbuttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
          "smile", --emoji picker
          "gnome-calculator"
        },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
          "Taschenechner"
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},
}

awful.spawn.easy_async_with_shell("autorandr --change", function() 
--random wallaper
    --awful.spawn.with_shell("nitrogen --head=0 --set-zoom-fill --random ~/Bilder/Hintergründe/favorites")
    --awful.spawn.with_shell("nitrogen --head=1 --set-zoom-fill --random ~/Bilder/Hintergründe/favorites")
--restore old wallpaper
    awful.spawn.with_shell("nitrogen --restore")
    --awful.spawn.with_shell("~/.fehbg")
end)
awful.spawn.with_shell("wal -R")
awful.spawn.with_shell("xrdb merge ~/.Xcursor")
-- awful.spawn.with_shell("exec --no-startup-id /usr/lib/pam_kwallet_init")
awful.spawn.with_shell("xinput set-prop 'Elan Touchpad' 'libinput Natural Scrolling Enabled' 1")
awful.spawn.with_shell("xinput set-prop 'Elan Touchpad' 'libinput Tapping Enabled' 1")
awful.spawn.with_shell("blueman-applet")
awful.spawn.with_shell("flameshot")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("/usr/bin/gnome-keyring-daemon --start --components=pkcs11")
awful.spawn.with_shell("/usr/bin/gnome-keyring-daemon --start --components=secrets")
awful.spawn.with_shell("/usr/bin/gnome-keyring-daemon --start --components=ssh")
awful.spawn.with_shell("nm-applet")
