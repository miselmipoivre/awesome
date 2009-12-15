-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

require("vicious")
require("volume")
require("teardrop")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
--beautiful.init("/usr/share/awesome/themes/sky/theme.lua")
beautiful.init("/usr/share/awesome/themes/sky-grey/theme.lua")
--beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

--beautiful.init( os.getenv("HOME").."/.config/awesome/themes/grey/theme.lua" )


-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
--skey   = "Shift"
--akey   = "Mod1"     -- alt
--ckey   = "Control"  

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
--tags = {}
--for s = 1, screen.count() do
--    -- Each screen has its own tag table.
--    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 ,""}, s, awful.layout.suit.max)
--end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}

-- add some settings vars
settings = {}
settings.window_d=1

-- Each screen has its own tag table.
tags[1] = awful.tag({ "1.Edit", "2.Mail", "3.Music", "4.Files", "5.Terms", 6, 7, 8, 9 ,""}, 1, awful.layout.suit.max)
tag2 = 1
if screen.count() == 2 then
    tag2 = 2
    tags[2] = awful.tag({ "www", 2, 3, 4, 5, 6, 7, 8, 9 ,""}, 2, awful.layout.suit.max)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "lock"        , "xscreensaver-command -activate" }                              , 
   { "manual"      , terminal .. " -e man awesome" }                                 , 
   { "edit config" , editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" } , 
   { "restart"     , awesome.restart }                                               , 
   { "quit"        , awesome.quit }
}

mycommons = {
   { "pidgin"     , "pidgin" }      , 
   { "OpenOffice" , "soffice-dev" } , 
   { "Graphic"    , "gimp" }
}

mymainmenu = awful.menu.new({ items = { 
                                        { "terminal", terminal },
                                        { "icecat", "icecat" },
                                        { "Editor", "gvim" },
                                        { "File Manager", "pcmanfm" },
                                        { "VirtualBox", "VirtualBox" },
                                        { "Common App", mycommons, beautiful.awesome_icon },
                                        { "awesome", myawesomemenu, beautiful.awesome_icon },
                                       }
                             })
mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
--
mytextclock = awful.widget.textclock({ align = "right" })
require("calendar")
--require("clock_calendar")

--{{{ widgets
-- Create a systray
mysystray = widget({ type = "systray" })

-- {{{ -- VOLUME
--pb_volume = volume.init()

--[[
 {{{ -- DATE widget
datewidget = widget({type="textbox", align = 'right' })
 
datewidget.mouse_enter = function() calendar.add_calendar() end
datewidget.mouse_leave = function() calendar.remove_calendar() end
datewidget:buttons({
  awful.button({ }, 4, function() calendar.add_calendar(-1) end),
  awful.button({ }, 5, function() calendar.add_calendar(1) end)
})
vicious.register(datewidget, vicious.widgets.date, markup.fg(beautiful.fg_sb_hi, '%k:%M'), 59)
-- }}}

-- CPU widget
cpuwidget = widget({type="textbox", align = 'right' })
cpuwidget.width = 40
vicious.register(cpuwidget, vicious.widgets.cpu, 'cpu:' .. markup.fg(beautiful.fg_sb_hi, '$1'))

-- MEMORY widgets
memwidget = widget({type="textbox", align = 'right' })
memwidget.width = 45
vicious.register(memwidget, vicious.widgets.mem, 'mem:' .. markup.fg(beautiful.fg_sb_hi,'$1'))

--]]

--require('fish')


-- }}}
-------------------------------------------------------------------------



-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 2, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                    awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            --fish.widget,
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        --cpuwidget,
        --memwidget,
        --datewidget,
        mytextclock,
        --pb_volume,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),
    awful.key({ modkey,"Control"  }, "w", function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ modkey,           }, "d",
        function ()
            
            settings.window_d = settings.window_d * -1

            if settings.window_d == 1 then
                showtag = 1
            else
                showtag = 10
            end
            for s = 1, screen.count() do
                awful.tag.viewonly(tags[s][showtag]) end
            

            --if tags[mouse.screen][10] then awful.tag.viewonly(tags[mouse.screen][10]) end
                                                  --awful.tag.viewonly(c:tags()[1])

            --[[
            local allclients = awful.client.visible(client.focus.screen)
          
            for i,v in ipairs(allclients) do
              if allclients[i+1] then
                allclients[i+1].client.minimized = true
              end
            end
            --awful.client.focus.byidx(-1)
            --if client.focus then client.focus:raise() end
            --]]
        end),
    awful.key({ "Mod1",           }, "Tab",
        function ()
            local allclients = awful.client.visible(client.focus.screen)
          
            for i,v in ipairs(allclients) do
              if allclients[i+1] then
                allclients[i+1]:swap(v)
              end
            end
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ "Mod1","Shift"    }, "Tab",
        function ()
            local allclients = awful.client.visible(client.focus.screen)

            for i,v in ipairs(allclients) do
              allclients[1]:swap(allclients[i])
            end
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end),
    -- Layout manipulation Misel add
    awful.key({ "Mod1" , "Control"  }, "Left"  , awful.tag.viewprev       )                       , 
    awful.key({ "Mod1" , "Control"  }, "Right" , awful.tag.viewnext       )                       , 
    
    awful.key({ modkey , "Mod1"     }, "Right" , function () awful.client.swap.byidx(  1)    end) , 
    awful.key({ modkey , "Mod1"     }, "Left"  , function () awful.client.swap.byidx( -1)    end) , 
    awful.key({ modkey              }, "Up"    , function () awful.screen.focus_relative( 1) end) , 
    awful.key({ modkey ,            }, "Down"  , function () awful.screen.focus_relative(-1) end) , 

    awful.key({ modkey , "Control" }, "Left"  ,
        function ()
            awful.client.focus.byidx( -1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,"Control"   }, "Right",  
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),

    -- alt key : Mod1 , use xev to see all key names!!!
    awful.key({ "Mod1",          }, "F2", function () awful.util.spawn("gmrun") end),
    --awful.key({ "Mod1",          }, "F2", function () teardrop("gmrun") end),
    awful.key({ "Mod1","Control" }, "l", function () awful.util.spawn("xlock") end),
    awful.key({ modkey,"Mod1","Control"}, "End", function () awful.util.spawn("xkill") end),


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    
    awful.key({ modkey, "Mod1"   }, "space", function () awful.layout.set( awful.layout.suit.max ) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,          }, "Prior",    function (c) c.ontop = not c.ontop end),
    awful.key({ modkey,          }, "Next",     function (c) c.minimized = not c.minimized end),
    awful.key({ modkey,          }, "Home",     function (c) c.sticky=not c.sticky            end),
    awful.key({ modkey,"Mod1","Control"}, "Left",      awful.client.movetoscreen                        ),
    awful.key({ modkey,"Mod1","Control"}, "Right",      awful.client.movetoscreen                        ),

    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ "Mod1"            }, "F4",     function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Control" }, "Up",     awful.client.movetoscreen                        ),
    awful.key({ modkey, "Control" }, "Down",   awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({                   } , 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey            } , 1, awful.mouse.client.move),

    awful.button({ "Mod1"            } , 1, awful.mouse.client.move),       -- misel adds
    --awful.button({                   } , 3, awful.mouse.client.move),       -- misel adds
    awful.button({ "Mod1"            } , 3, awful.mouse.client.resize),    -- misel adds
    awful.button({ modkey            } , 3, awful.mouse.client.resize),

    awful.button({ "Mod1"            } , 2, function ()  awful.util.spawn("audacious2 --play-pause") end),
    awful.button({ "Mod1"            } , 6, function ()  awful.util.spawn("audacious2 --rew") end),
    awful.button({ "Mod1"            } , 7, function ()  awful.util.spawn("audacious2 --fwd") end),

    awful.button({ "Mod1"            } , 4, function ()  awful.util.spawn("/home/misel/Scripts/openbox/oss-menu up") end),
    awful.button({ "Mod1"            } , 5, function ()  awful.util.spawn("/home/misel/Scripts/openbox/oss-menu down") end),
    awful.button({ "Mod1","Control"  } , 4, function ()  awful.util.spawn("/home/misel/Scripts/openbox/oss-menu up 3") end),
    awful.button({ "Mod1","Control"  } , 5, function ()  awful.util.spawn("/home/misel/Scripts/openbox/oss-menu down 3") end),
    
    awful.button({ "Control","Shift" } , 4, function ()  awful.util.spawn("transset-df -p --inc 0.05") end),
    awful.button({ "Control","Shift" } , 5, function ()  awful.util.spawn("transset-df -p --dec 0.05") end)
    

    --[[
    awful.button({ modkey            } , 4, function ()  volume.vol("up","2")   end),
    awful.button({ modkey            } , 5, function ()  volume.vol("down","2") end),
    awful.button({ modkey,"Control"  } , 4, function ()  volume.vol("up","5")   end),
    awful.button({ modkey,"Control"  } , 5, function ()  volume.vol("down","5") end)
    ]]--
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },      properties = { floating = true } },
    { rule = { class = "Xev" },      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    --{ rule = { class = "Pidgin"                     }, properties = { tag = tags[1][2], floating = true, switchtotag = true, callback = awful.placement.centered } },
    { rule = { class = "Pidgin"                     }, properties = { tag = tags[1][2], floating = true, switchtotag = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    { rule = { class = "Audacious"                  }, properties = { tag = tags[1][3], switchtotag = true, border_width=0 }  }, 
    { rule = { class = "Terminator"                 }, properties = { floating = true , callback = awful.placement.centered  }  }, 
    { rule = { class = "Thunderbird-bin"            }, properties = { tag = tags[1][2], switchtotag = true } }, 
    { rule = { class = "Firefox"                    }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "GNU IceCat"                 }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "Chrome"                     }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "Opera"                      }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "Midori"                     }, properties = { tag = tags[tag2][1] } }, 
    -- tag 3 WWW perso
    { rule = { class = "Arora"                      }, properties = { tag = tags[tag2][3] } }, 
    { rule = { class = "Pcmanfm"                    }, properties = { tag = tags[1][4], opacity = 0.9 } }, 
    { rule = { class = "Terminator"                 }, properties = { border_width=0, ontop =true } }, 
    { rule = { class = "Conky"                      }, properties = { opacity = 0.8 } }, 

    { rule = { class = "Basket"                     }, properties = { tag = tags[1][4], switchtotag = true } }, 
    { rule = { class = "oracle-ide-boot-Launcher"   }, properties = { tag = tags[1][2] }, switchtotag = true }, 
    --{ rule = { class ~= "oracle"                    }, properties = { tag = tags[tag2][2] } }, 
    --{ rule = { class ~= "Gvim"                    }, properties = { tag = tags[1][1] } }, 
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })
    
    --Gaps! There are gaps! How do I get rid of the gaps at the top/bottom of the screen
    c.size_hints_honor = false
    
    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


--require("autostart")
-- 1200/60 = 20 minutes
awful.hooks.timer.register(1200, function () awful.util.spawn_with_shell("sh ~/Scripts/random_background") end)
-- on redemarre le serveur php toutes les heures a cause des fuites de memoires
awful.hooks.timer.register(6000, function () awful.util.spawn_with_shell("lightrestart") end)


--client.add_signal("focus", function(c) c.opacity = 0.95 end)
--client.add_signal("unfocus", function(c) c.opacity = 0.4 end)


require("autorun")
require("mouse_move")

