--[[

     Multicolor Awesome WM theme 2.0
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
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/multicolor"
theme.wallpaper                                 = theme.confdir .. "/wall.jpg"
-- theme.font                                      = "Terminus 12"
theme.font                                      = "Noto Sans Regular 11"
theme.taglist_font                              = "Noto Sans Regular 12"
theme.menu_bg_focus                             = "#000000"
theme.bg_normal                                 = "#000000"
theme.bg_focus                                  = "#000000"
theme.bg_urgent                                 = "#000000"
theme.fg_normal                                 = "#aaaaaa"
theme.fg_focus                                  = "#ffffff"
theme.fg_urgent                                 = "#af1d18"
theme.fg_minimize                               = "#aaaaaa"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#000000"
theme.border_focus                              = "#606060"
theme.border_marked                             = "#3ca4d8"
theme.menu_border_width                         = 10
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(250)
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.widget_temp                               = theme.confdir .. "/icons/temp.svg"
theme.widget_uptime                             = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                                = theme.confdir .. "/icons/cpu.svg"
theme.widget_weather                            = theme.confdir .. "/icons/dish.png"
theme.widget_fs                                 = theme.confdir .. "/icons/fs.png"
theme.widget_mem                                = theme.confdir .. "/icons/mem.svg"
theme.widget_note                               = theme.confdir .. "/icons/note.png"
theme.widget_note_on                            = theme.confdir .. "/icons/note_on.png"
theme.widget_net                                = theme.confdir .. "/icons/net.svg"
theme.widget_mail                               = theme.confdir .. "/icons/mail.png"
theme.widget_batt                               = theme.confdir .. "/icons/bat.png"
theme.widget_clock                              = theme.confdir .. "/icons/clock.png"
theme.widget_vol                                = theme.confdir .. "/icons/spkr.svg"
theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.tasklist_disable_task_name                = false
theme.useless_gap                               = dpi(5)
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

local markup = lain.util.markup

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
-- local mytextclock = wibox.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#de5e1e", " %H:%M "))
local mytextclock = wibox.widget.textclock(markup(theme.fg_normal, "%A %d %B ") .. markup(theme.fg_normal, " %H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        -- font = "Terminus 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Weather
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = { font = theme.font, fg = theme.fg_normal },
    -- weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
    weather_na_markup = markup.fontfg(theme.font, theme.fg_normal, "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        -- widget:set_markup(markup.fontfg(theme.font, "#eca4c4", descr .. " @ " .. units .. "°C "))
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, descr .. " @ " .. units .. "°C "))
    end
})

local keyboardlayout = awful.widget.keyboardlayout:new()

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        -- widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        -- widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, coretemp_now .. "°C "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        -- widget:set_markup(markup.fontfg(theme.font, "#7493d2", volume_now.level .. "% "))
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, volume_now.level .. "% "))
    end
})

-- Net
-- local netdownicon = wibox.widget.imagebox(theme.widget_net)
-- local netdowninfo = wibox.widget.textbox()
-- local netupinfo = lain.widget.net({
--     settings = function()
--         if iface ~= "network off" and
--            string.match(theme.weather.widget.text, "N/A")
--         then
--             theme.weather.update()
--         end

--         -- widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
--         -- netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
--         widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, net_now.sent .. " "))
--         netdowninfo:set_markup(markup.fontfg(theme.font, theme.fg_normal, net_now.received .. " "))
--     end
-- })

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        -- widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, mem_now.perc .. "% "))
    end
})

local separator = wibox.widget {
    widget = wibox.widget.separator,
    orientation = "vertical",
    forced_width = 10,
    visible = true
 }

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end)
                        --    awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                        --    awful.button({}, 3, function () awful.layout.inc(-1) end),
                        --    awful.button({}, 4, function () awful.layout.inc( 1) end),
                        --    awful.button({}, 5, function () awful.layout.inc(-1) end)
                        ))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal,
    opacity = 1.0, border_width = 2, border_color = theme.bg_normal  })


    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox
        },
        s.mytasklist, -- Middle widget
        -- nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            keyboardlayout,
            separator,
            volicon,
            theme.volume.widget,
            -- netdownicon,
            -- netupinfo.widget,
            -- netdowninfo,
            memicon,
            memory.widget,
            cpuicon,
            cpu.widget,
            tempicon,
            temp.widget,
            separator,
            mytextclock,
            s.mylayoutbox,
        },
    }
end

return theme
