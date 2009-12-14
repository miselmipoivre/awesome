
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

