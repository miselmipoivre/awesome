-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")



require("teardrop")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
--beautiful.init("/usr/share/awesome/themes/sky/theme.lua")
--beautiful.init("/usr/share/awesome/themes/sky-grey/theme.lua")
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

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
-- Each screen has its own tag table.
tags[1] = awful.tag({ "Edit", "Mail", "Music", 4, 5, 6, 7, 8, 9 ,""}, 1, awful.layout.suit.max)
tag2 = 1
if screen.count() == 2 then
    tag2 = 2
    tags[2] = awful.tag({ "www", 2, 3, 4, 5, 6, 7, 8, 9 ,""}, 2, awful.layout.suit.max)
end
-- }}}

require("rc.menu.lua")

require("rc.wibox.lua")


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
            --if tags[mouse.screen][10] then awful.tag.viewonly(tags[mouse.screen][10]) end
                                                  --awful.tag.viewonly(c:tags()[1])
            local allclients = awful.client.visible(client.focus.screen)
          
            for i,v in ipairs(allclients) do
              if allclients[i+1] then
                allclients[i+1].client.minimized = true
              end
            end
            --awful.client.focus.byidx(-1)
            --if client.focus then client.focus:raise() end
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
    awful.key({ modkey,          }, "Prior", function (c) c.ontop = not c.ontop end),
    awful.key({ modkey,          }, "Next", function (c) c.ontop = not c.ontop end),
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
    awful.button({ "Mod1"            } , 3, awful.mouse.client.resize),    -- misel adds
    awful.button({ modkey            } , 3, awful.mouse.client.resize),
    awful.button({ "Control","Shift" } , 4, function ()  awful.util.spawn_with_shell("transset-df -p --inc 0.05") end),
    awful.button({ "Control","Shift" } , 5, function ()  awful.util.spawn_with_shell("transset-df -p --dec 0.05") end),
    awful.button({ modkey            } , 4, function ()  awful.util.spawn_with_shell("/home/misel/Scripts/openbox/oss-menu up") end),
    awful.button({ modkey            } , 5, function ()  awful.util.spawn_with_shell("/home/misel/Scripts/openbox/oss-menu down") end),
    awful.button({ modkey,"Control"  } , 4, function ()  awful.util.spawn_with_shell("/home/misel/Scripts/openbox/oss-menu up 3") end),
    awful.button({ modkey,"Control"  } , 5, function ()  awful.util.spawn_with_shell("/home/misel/Scripts/openbox/oss-menu down 3") end)
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
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Pidgin"                     }, properties = { tag = tags[1][2], floating = true, switchtotag = true, callback = awful.placement.centered } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    { rule = { class = "Audacious"                  }, properties = { tag = tags[1][3], switchtotag = true }  }, 
    { rule = { class = "Terminator"                 }, properties = { floating = true , callback = awful.placement.centered  }  }, 
    { rule = { class = "Thunderbird-bin"            }, properties = { tag = tags[1][2], switchtotag = true } }, 
    { rule = { class = "Firefox"                    }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "GNU IceCat"                 }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "Chrome"                     }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "Opera"                      }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "Midori"                     }, properties = { tag = tags[tag2][1] } }, 
    -- tag 3 WWW perso
    { rule = { class = "Arora"                      }, properties = { tag = tags[tag2][3] } }, 

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

