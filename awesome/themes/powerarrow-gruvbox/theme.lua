--[[

     Powerarrow Gruvbox Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-gruvbox"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "Operator Mono Lig Book 10"
theme.taglist_fg_focus                          = "#FABD2F"
theme.taglist_fg_occupied                       = "#81A1C1"
theme.taglist_fg_urgent                         = "#CC9393"
theme.taglist_fg_empty                          = "#ebdbb2"
theme.taglist_spacing                           = 2
theme.taglist_font                              = "awesomewm-font 11"
theme.fg_normal                                 = "#ebdbb2"
theme.fg_focus                                  = "#FABD2F"-- "#FB4934"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#1d2021"
theme.bg_focus                                  = "#313131"
theme.bg_urgent                                 = "#1d2021"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#7F7F7F"
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = "#1A1A1A"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = "#FABD2F"
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(0)
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +'%a %d %b %R'", 60,
   function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)
-- Spotify -- Requires spotify CLI client installed.
--[[    BROKEN?! - nvm fixed now. needed streeturtles fork of sp.
        git clone https://gist.github.com/wandernauta/6800547.git
        cd ./6800547
        chmod +x sp
        sudo cp ./sp /usr/local/bin/ 
--]]
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, "" .. mem_now.used .. "MB "))
    end
})
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
        tempfile = "/sys/devices/virtual/thermal/thermal_zone2/temp",
        settings = function()
        widget:set_markup(markup.font(theme.font, "" .. coretemp_now .. "°C "))
    end
})


local fsicon = wibox.widget.imagebox(theme.widget_hdd)
local fs = require("awesome-wm-widgets.fs-widget.fs-widget")

local volicon = wibox.widget.imagebox(theme.widget_vol)
local volumebar_widget = require("awesome-wm-widgets.volumebar-widget.volumebar")
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function() widget:set_markup(markup.font(theme.font, markup("#FABD2F", "dl:" .. string.format("%06.1f", net_now.received)) .. " " .. markup("#81A1C1", "ul:" .. string.format("%06.1f", net_now.sent) .. " "))) end })
local todo_widget = require("awesome-wm-widgets.todo-widget.todo")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local cw = calendar_widget({ theme = 'dark', placement = 'top_right' })
clock:connect_signal("button::press", 
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

function theme.at_screen_connect(s)

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            arrl_ld,
            wibox.container.background(spotify_widget({
            font = 'Operator Mono Lig Book 9',
            play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
            pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
            dim_when_paused = true,
            dim_opacity = 0.5,
            show_tooltip = true,
            max_length = 24,
            }), theme.bg_focus),
            arrl_dl,
            spr,
            wibox.widget.systray(),
            spr,
            arrl_ld,
            wibox.container.background(volicon, theme.bg_focus),
            wibox.container.background(volumebar_widget({
                main_color = '#FABD2F', mute_color = '#FB4934',
                width = 50, shape = 'rounded_bar', margins = 7
                }), theme.bg_focus ),
            wibox.container.background(spr, theme.bg_focus),
            wibox.container.background(spr, theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(spr, theme.bg_focus),
            wibox.container.background(cpuicon, theme.bg_focus),
            wibox.container.background(cpu_widget({
                width = 50, step_width = 4, step_spacing = 0,
                enable_kill_button = true, process_info_max_lenght = -1, color = '#FABD2F'
                }), theme.bg_focus ),
            wibox.container.background(spr, theme.bg_focus),
            wibox.container.background(spr, theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(memicon, theme.bg_focus),
            wibox.container.background(mem.widget, theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(fsicon, theme.bg_focus),
            wibox.container.background(fs({
                    mounts = { '/', '/home', '/media/hdd', '/media/backup-disk', '/media/ssd1' }
            }), theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(tempicon, theme.bg_focus),
            wibox.container.background(temp, theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(neticon, theme.bg_focus),
            wibox.container.background(net.widget, theme.bg_focus),
            arrl_dl,
            arrl_ld,
            wibox.container.background(todo_widget, theme.bg_focus),
            wibox.container.background(spr, theme.bg_focus),
            wibox.container.background(spr, theme.bg_focus),
            arrl_dl,
            clock,
            spr,
            spr,
            arrl_ld,
            wibox.container.background(s.mylayoutbox, theme.bg_focus),
        },
    }
end

return theme
