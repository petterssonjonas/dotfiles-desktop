--[[ Copycats Awesome WM configuration template github.com/lcpz
--   Modified by https://gitlab.com/fuzebox
--   Added gruvbox theme based on powerarrow-dark. Added and swapped some modules.
--   Required packages to be $PATH accessible:
--   rofi, flameshot, pactl, playerctl
--]]
-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type
local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi
-- }}}
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

-- Changing spotify notifications.
naughty.config.presets.spotify = { 
    -- if you want to disable Spotify notifications completely, return false
    callback = function(args)
        return true
    end,

    -- Adjust the size of the notification
    height = 100,
    width  = 400,
    -- Guessing the value, find a way to fit it to the proper size later
    icon_size = 90
}
table.insert(naughty.dbus.config.mapping, {{appname = "Spotify"}, naughty.config.presets.spotify})

-- }}}
-- {{{ Autostart windowless processes

local function run_once(cmd_arr)
 for _, cmd in ipairs(cmd_arr) do
     findme = cmd
     firstspace = cmd:find(" ")
     if firstspace then
         findme = cmd:sub(0, firstspace-1)
     end
     awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
 end
end

run_once({ "wmname LG3D", -- Fix java problem
        "mullvad-vpn",
        "picom",
        "dropbox",
        "xset r rate 365 55",
}) 
awful.spawn.with_shell("picom")

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]
-- }}}
-- {{{ Variable definitions
local themes = {
    "blackburn",       -- 1
    "copland",         -- 2
    "dremora",         -- 3
    "holo",            -- 4
    "multicolor",      -- 5
    "powerarrow",      -- 6
    "powerarrow-dark", -- 7
    "rainbow",         -- 8
    "steamburn",       -- 9
    "vertex",          -- 10
    "powerarrow-gruvbox", -- 11
}

local chosen_theme = themes[11]
local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "alacritty"
local editor       = os.getenv("EDITOR") or "nvim"
local gui_editor   = "atom"
local browser      = "brave"
local guieditor    = "code"
local scrlocker    = "slock"
local mute_key     = "XF86AudioMute"
local audio_prev   = "XF86AudioPrev"
local audio_next   = "XF86AudioNext"
local audio_stop   = "XF86AudioStop"
local audio_play   = "XF86AudioPlay"
local vol_down_key = "XF86AudioLowerVolume"
local vol_up_key   = "XF86AudioRaiseVolume"
--local scriptsdir   = os.getenv("HOME") .. "/.config/awesome/scripts/"
local wow          = "lutris lutris:rungame/world-of-warcraft-classic"
local twitch       = "lutris lutris:rungame/twitch-app"
local suspend      = "sudo systemctl suspend"
--local quake = lain.util.quake({ app = awful.util.terminal })

awful.util.terminal = terminal
awful.util.tagnames = { "a", "w", "e", "s", "o", "m", "e" }
awful.layout.layouts = {
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 2, function (c) c:kill() end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = dpi(250)}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}
-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or dpi(16),
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "------", echo },
        { "Open terminal", terminal },
        { "Discord", "discord" },
        { "Spotify", "spotify" },
        { "Browser", browser },
        { "Thunar", "thunar" },
        { "WoW", wow },
        { "Twitch", twitch },
        { "------", echo },
        { "Suspend to RAM", suspend },
        -- other triads can be put here
    }
})
-- hide menu when mouse leaves it -- This leaves when entering submenu!
-- awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)
-- menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}




-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}
-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
-- {{{ Key bindings
globalkeys = my_table.join(
    -- Take a screenshot
    -- https://github.com/lcpz/dots/blob/master/bin/screenshot
    awful.key({ }, "Print", function() os.execute("flameshot gui") end,
              {description = "take a screenshot", group = "hotkeys"}),
    -- X screen locker
    awful.key({ modkey, "Control" }, "l", function () os.execute(scrlocker) end,
              {description = "lock screen", group = "hotkeys"}),
    -- Hotkeys
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description = "show help", group="awesome"}),
    -- Tag browsing
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    -- Non-empty tag browsing
--   awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
--              {description = "view  previous nonempty", group = "tag"}),
--   awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
--              {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ altkey, modkey    }, "j",
        function ()
            awful.client.focus.byidx( -1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey, modkey     }, "k",
        function ()
            awful.client.focus.byidx(1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),
    awful.key({ modkey,           }, "a", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( 1)    end,
              {description = "swap with next client by index", group = "client"}),
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

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),

--[[    -- Dynamic tagging -- I dont use this.
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),
]]--
    -- Standard program
    awful.key({ modkey            }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ altkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
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
    awful.key({ modkey, "Shift"   }, "d", function() awful.spawn("discord") end,
              {description = "Run Discord", group = "hotkeys"}),
    awful.key({ modkey, "Shift"   }, "m", function() awful.spawn("mullvad-vpn") end,
              {description = "Run mullvad-vpn", group = "hotkeys"}),
    awful.key({ modkey, "Shift"   }, "b", function() awful.spawn(browser) end,
              {description = "Run brave", group = "hotkeys"}),
    awful.key({ modkey, "Shift"   }, "s", function() awful.spawn("spotify") end,
              {description = "Run Spotify", group = "hotkeys"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Dropdown application -- lain.util.quake can drop down many apps. Binding it to Alacritty.
--    awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end,
--              {description = "dropdown application", group = "launcher"}),


    -- Audio control, Alsa and playerctl (spotify and more) -- key names defined upstairs
    awful.key({  }, vol_up_key,
        function () os.execute("amixer -q set Master 5%+") end,
        {description = "volume up", group = "hotkeys"}),
    awful.key({  }, vol_down_key,
        function () os.execute("amixer -q set Master 5%-") end,
        {description = "volume down", group = "hotkeys"}),
    awful.key({  }, mute_key,
        function () os.execute("amixer -q set Master toggle") end,
        {description = "toggle mute", group = "hotkeys"}),
    awful.key({  }, audio_prev, function () os.execute("playerctl previous") end,
        {description = "player previous", group = "hotkeys"}),
    awful.key({  }, audio_next, function () os.execute("playerctl next") end,
        {description = "player next", group = "hotkeys"}),
    awful.key({  }, audio_play,
        function () os.execute("playerctl play-pause") end,
        {description = "player play-pause", group = "hotkeys"}),
    awful.key({  }, audio_stop, function () os.execute("playerctl stop") end,
        {description = "player stop", group = "hotkeys"}),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
              {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
              {description = "copy gtk to terminal", group = "hotkeys"}),

    -- Default
    -- dmenu
    --awful.key({ modkey }, "x", function () os.execute(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'", beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus)) end,
      --  {description = "show dmenu", group = "launcher"})
    -- rofi
    awful.key({ modkey, "Shift" }, "Return", function ()
            os.execute("rofi -show run -width 50 -show-icons")
        end,
        {description = "show rofi window", group = "launcher"}),
    awful.key({ modkey }, "w", function ()
            os.execute("rofi -show window -width 50 -show-icons")
        end,
        {description = "show rofi windowcd", group = "launcher"})
)

clientkeys = my_table.join(
    awful.key({ altkey, modkey   }, "i",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,           }, "f",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    -- Toggle Fullscreen
    awful.key({ modkey,           }, "m",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    -- Minimize
    awful.key({ modkey, "Control" }, "m",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    -- Maximize
    awful.key({ modkey, altkey    }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)
-- }}} END Keybinds
-- {{{ Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only - across screens.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                    for screen = 1, screen.count() do
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                            awful.tag.viewonly(tag)
                        end
                    end
                  end,
                  descr_view),
        -- Toggle tag display - across screens.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                    for screen = 1, screen.count() do
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                            awful.tag.viewtoggle(tag)
                        end
                    end
                  end,
                  descr_toggle),
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
                  descr_move),
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
                  descr_toggle_focus)
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
-- }}} END KEYS
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars -- Rules
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },
    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized = true } },
    { rule = { class = "Firefox" },
      properties = { screen = 1, switchtotag = true } },
    { rule = { class = "Opera" },
      properties = { screen = 1, switchtotag = true } },
    { rule = { class = "Atom" },
      properties = { screen = 1, switchtotag = true } },
    { rule = { class = "celluloid" },
      properties = { maximized = false, floating = true } },    { rule = { class = "Nm-connection-editor" } },
    { rule = { class = "mpv" },
      properties = { maximized = false, floating = true } },    { rule = { class = "Nm-connection-editor" } },
    { rule = { class = "Tilda"},
      properties = { floating = true, below = true } },
    -- Disable titelbar for browsers
    { rule = { class = "Mullvad-vpn" },
      properties = { screen = 1, maximized = false, titlebars_enabled = true } },
    { rule = { class = "Google-chrome" },
      properties = { screen = 1, maximized = false, titlebars_enabled = false } },
    { rule = { class = "Brave" },
      properties = { screen = 1, maximized = false, titlebars_enabled = false } },
    { rule = { class = "Transmission-gtk" },
      properties = { screen = 1, maximized = false, tag = awful.util.tagnames[3] } },
    { rule = { instance = "plugin-container" },
      properties = { floating = true } },
    { rule = { instance = "exe" },
      properties = { floating = true } },
    { rule = { role = "_NET_WM_STATE_FULLSCREEN" },
      properties = { floating = true } }
  }
-- }}}
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 2, function() c:kill() end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = dpi(20)}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
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
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
-- BROKEN --
-- {{{ Window Swallowing (start gui app from terminal minimizes terminal then restores)
-- Includes a bash script. ---------- broken atm ----------- maybe cuz i use fish.
-- Set your terminal name in is_terminal(). "term" if it contains term, i use alacritty.
-- function is_terminal(c)
    -- return (c.class and c.class:match("Alacritty")) and true or false
-- end
-- 
-- function copy_size(c, parent_client)
    -- if not c or not parent_client then
        -- return
    -- end
    -- if not c.valid or not parent_client.valid then
        -- return
    -- end
    -- c.x=parent_client.x;
    -- c.y=parent_client.y;
    -- c.width=parent_client.width;
    -- c.height=parent_client.height;
-- end
-- 
-- function check_resize_client(c)
    -- if(c.child_resize) then
        -- copy_size(c.child_resize, c)
    -- end
-- end

-- client.connect_signal("manage", function(c)
    -- if is_terminal(c) then
        -- return
    -- end
-- 
    -- local parent_client=awful.client.focus.history.get(c.screen, 1)
-- 
    -- awful.spawn.easy_async('bash '..scriptsdir..'swallowhelper.sh gppid '..c.pid, function(gppid)
    -- awful.spawn.easy_async('bash '..scriptsdir..'swallowhelper.sh ppid '..c.pid, function(ppid)
    -- if parent_client and (gppid:find('^' .. parent_client.pid) or ppid:find('^' .. parent_client.pid))and is_terminal(parent_client) then
        -- parent_client.child_resize=c
        -- parent_client.minimized = true
-- 
        -- c:connect_signal("unmanage", function() parent_client.minimized = false end)
-- 
--        c.floating=true
        -- copy_size(c, parent_client)
    -- end
-- end)
-- end)
-- end)
-- 
-- client.connect_signal("manage", function(c)
    -- if is_terminal(c) then
        -- return
    -- end
    -- local parent_client=awful.client.focus.history.get(c.screen, 1)
    -- if parent_client and is_terminal(parent_client) then
        -- parent_client.child_resize=c
        -- parent_client.minimized = true
        -- c:connect_signal("unmanage", function() parent_client.minimized = false end)
        -- 
        -- c.floating=true
        -- copy_size(c, parent_client)
    -- end
-- end)
-- 
-- }}} End Swallowing
-- {{{ Set default gap distance.  
beautiful.useless_gap = 2
-- }}}
--[[
-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = true})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
--]]

-- possible workaround for tag preservation when switching back to default screen:
-- https://github.com/lcpz/awesome-copycats/issues/251
-- }}}
