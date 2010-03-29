--timing = {module_start=3,module_end=7}
timing = {}
timing.module_start = os.time()
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

--require("vicious")
require("volume")
require("teardrop")
require("rodentbane")
timing.module_end = os.time()

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/default/theme.lua")
--beautiful.init("/usr/share/awesome/themes/sky-grey/theme.lua")
--beautiful.init("/usr/share/awesome/themes/sky/theme.lua")
--beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")
--beautiful.init("/usr/share/awesome/themes/lunar/theme.lua")

--beautiful.init( os.getenv("HOME").."/.config/awesome/themes/grey/theme.lua" )


-- This is used later as the default terminal and editor to run.
--terminal = "terminator"
--terminal = "urxvt"
terminal = "urxvt-tabbed"
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
--m = { W = "Mod4", C = "Control", S = "Shift", A = "Alt" }

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
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

tag1 = 1 
tag2 = 1
tags[tag1] = awful.tag({ "1.Edit", "2.Mail", "3.Music", "4.Files", "5.Terms", 6, 7, 8, 9 ,""}, tag1, awful.layout.suit.tile)
if screen.count() == 2 then
    tag2 = 2
    tags[tag2] = awful.tag({ "www", 2, 3, 4, 5, 6, 7, 8, 9 ,""}, tag2, awful.layout.suit.floating)
end
-- }}}


  require('freedesktop.menu')
  --require("debian.menu")

  menu_items = freedesktop.menu.applications_menu

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
                                        { "menu_items", menu_items },
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
 
--{{{ -- DATE widget
mytextbox = widget({type="textbox", align = 'right' })

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
        mytextbox,
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
    
    awful.key({ modkey,"Mod1","Control"           }, "m",  function()  rodentbane.start() end  ),

    
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

    awful.key({ modkey              }, "twosuperior"    , function () awful.screen.focus_relative( 1) end) , 
    awful.key({ modkey , "Shift"    }, "twosuperior"    , function () awful.screen.focus_relative( -1) end) , 

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
    awful.key({ modkey }, "F2", function () awful.util.spawn("gnome-do") end),
    awful.key({ "Mod1",          }, "F2", function () awful.util.spawn("gmrun") end),
    --awful.key({ "Mod1",          }, "F2", function () teardrop("gmrun") end),
    --awful.key({ "Mod1","Control" }, "l", function () awful.util.spawn("xlock") end),
    awful.key({ "Mod1","Control" }, "l",  function()  awful.util.spawn('xscreensaver-command -activate') end  ),
    awful.key({ modkey,"Mod1","Control"}, "End", function () awful.util.spawn("xkill") end),


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Mod1","Control" }, "r", awesome.restart),
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
    
    awful.key({ modkey,"Mod1","Control"          }, "t",    function (c)
        if c.titlebar == nil then
            awful.titlebar.add(c, { modkey = modkey })
        else
            c.titlebar = nil
        end
        --cc.ontop = not c.ontop
    end),
    
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

    -- bouton dessus  1,2,3  molette: 4,5 14,13 bouton cote: 9,8
    --awful.button({ "Mod1"            } , 2, function ()  awful.util.spawn("audacious2 --play-pause") end),
    awful.button({ modkey            } , 8, function ()  awful.util.spawn("audacious2 --play-pause") end),
    awful.button({ modkey            } , 9, function ()  awful.util.spawn("audacious2 --play-pause") end),
    awful.button({ modkey            } , 6, function ()  awful.util.spawn("audacious2 --rew") end),
    awful.button({ modkey            } , 7, function ()  awful.util.spawn("audacious2 --fwd") end),

    awful.button({ modkey            } , 4, function ()  awful.util.spawn("/home/misel/Scripts/openbox/oss-menu up") end),
    awful.button({ modkey            } , 5, function ()  awful.util.spawn("/home/misel/Scripts/openbox/oss-menu down") end),
    awful.button({ modkey,"Control"  } , 4, function ()  awful.util.spawn("/home/misel/Scripts/openbox/oss-menu up 3") end),
    awful.button({ modkey,"Control"  } , 5, function ()  awful.util.spawn("/home/misel/Scripts/openbox/oss-menu down 3") end),
    
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

--require("shifty")
--shifty.config.apps = {
--       { match = {"Terminator"                        }, geometry = { 100,100,100,100 },       }
--}
--shifty.init()

require("mouse_move")
-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { --border_width = beautiful.border_width,
                     border_width = 1,
                     border_color = beautiful.border_normal,
                     focus = true,
                     switchtotag = true,
                     keys = clientkeys,
                     -- screen, tag, float, geometry, slave, nopopup, nofocus, intrusive, fullscreen, honorsizehints, kill
                     -- ontop, below, above, buttons, keys, hide, minimized, dockable, urgent, opacity, titlebar, run, sticky, wfact, struts.
                     buttons = clientbuttons } },

    { rule = { class = "MPlayer"                    }, properties = { floating = true } },
    { rule = { class = "Xev"                        }, properties = { floating = true } },
    { rule = { class = "pinentry"                   }, properties = { floating = true } },
    { rule = { class = "gimp"                       }, properties = { floating = true } },
    --{ rule = { class = "Pidgin"                     }, properties = { tag = tags[1][2], floating = true, switchtotag = true, callback = awful.placement.centered } },
    { rule = { class = "Pidgin"                     }, properties = { tag = tags[tag1][2], floating = true, sticky = false } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    { rule = { class = "Audacious"                  }, properties = { tag = tags[tag1][3], border_width=0 }  }, 
    { rule = { name  = "spotify.exe"                }, properties = { tag = tags[tag1][3] }  }, 
    --{ rule = { class = "Terminator"                 }, properties = { floating = true , callback = awful.placement.centered  }  }, 
    { rule = { class = "Thunderbird"                }, properties = { tag = tags[tag1][2] } }, 

    { rule = { class = "Firefox"                    }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "GNU IceCat"                 }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "Chrome"                     }, properties = { tag = tags[tag2][1] , border_width = 0, fullscreen } }, 
    { rule = { class = "Opera"                      }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "Midori"                     }, properties = { tag = tags[tag2][1] } }, 
    { rule = { class = "Epiphany"                   }, properties = { tag = tags[tag2][1] } }, 
    -- tag 3 WWW perso
    { rule = { class = "Arora"                      }, properties = { tag = tags[tag2][3] } }, 
    { rule = { class = "Pcmanfm"                    }, properties = { tag = tags[tag1][4], opacity = 0.9 } }, 
    { rule = { class = "Terminator"                 }, properties = { border_width=0, geometry={x=nil,y=nil,width=300,height=200} } }, 
    { rule = { class = "URxvt"                      }, properties = { border_width=0, geometry={x=nil,y=nil,width=300,height=200} } }, 
    --{ rule = { class = "Terminator"                 }, properties = { border_width=0, ontop =true, geometry={x=100,y=100,width=400,height=200} } }, 
    { rule = { class = "Conky"                      }, properties = { opacity = 0.8 } }, 

    { rule = { class = "Basket"                     }, properties = { tag = tags[tag1][4] } }, 
    { rule = { class = "oracle-ide-boot-Launcher"   }, properties = { tag = tags[tag1][2] } },

    --{ rule = { class ~= "oracle"                    }, properties = { tag = tags[tag2][2] } }, 
            
--[[
    { rule = { type = "xxx"  }, properties = {}}, 
    { rule = { class = "xxx"  }, properties = {}, 
    { rule = { instance = "xxx"  }, properties = {}, 
    { rule = { role = "xxx"  }, properties = {}, 
    { rule = { name = "xxx"  }, properties = {}, 
]]--

    { rule = { class = "Gvim"                    }, properties = {
--beautiful.border_normal = "#000000"
--beautiful.border_focus  = "#3accc5"
--beautiful.border_marked = "#0000f0"

        border_color = beautiful.border_focus
        --border_color = "#CACACA"
    }}, 


}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    --awful.titlebar.add(c, { modkey = modkey })
    
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

local function blackBorderClient(c,black)
    --if floats(c) then
    --    c.border_color = '#FFFF00'
    --else

    --local l = awful.layout.get(c.screen)
    --local w = screen[c.screen].workarea
    
    if not floats(c) then
        --c.border_color = '#FF0000'
        if 1 == black then
            --c.opacity = 0.95
            c.border_color = '#CC0000'
        else
            --c.opacity = 0.75
            c.border_color = '#000000'
        end
        if c.border_width > 1 then
            c.border_width = 15 
        end
    else
        --c.opacity = 1
        if c.border_width > 1 then
            c.border_width = 15 
        end
    end
    mouse_warp(c)
    --c.opacity = 0.4
end

client.add_signal("focus"  , function(c) blackBorderClient(c,1) end )
client.add_signal("unfocus", function(c) blackBorderClient(c,0) end)


--client.add_signal("unfocus", function(c) c.opacity = 0.4 end)


require("revelation")

globalkeys = awful.util.table.join(globalkeys,

	awful.key({ modkey},'Pause' , revelation.revelation )
)



require("autorun")
require("keybind")
--require("myshifty")



-- {{{ Key Chaining
--
--
--[[

keybindActivate = true
keybindsArrayList={
    { 
        { {modkey}, "x", "killall xcompmgr"},
        { {modkey}, "l", "killall lxpanel"},
        { {modkey}, "f", "killall firefox"},
        { {modkey}, "t", "killall thunderbird"},
        { {modkey}, "p", "killall pcmanfm"},
    },
    { 
        { {modkey}, "x", "xcompmgr"},
        { {modkey}, "l", "lxpanel"},
        { {modkey}, "f", "firefox"},
        { {modkey}, "t", "thunderbird"},
        { {modkey}, "p", "pcmanfm"},
    }
}

keybindsArray = {  }
keybindsKey = {"k","e" }

if keybindActivate then

for n = 1, #keybindsArrayList do
   keybinds = keybindsArrayList[n] 
   for k = 1, #keybinds do
       tmp =  keybinds[k]
       keybindsArray[n] = awful.util.table.join(keybindsArray[n],

            {
                myrc.keybind.key( tmp[1], tmp[2] , tmp[3], function () 
                    awful.util.spawn( tmp[3] )
                    myrc.keybind.pop() 
                end)
            }
        ) 
    --globalkeys = awful.util.table.join(globalkeys,	awful.key({ modkey   }, keybindsKey[n], function () 
    --    myrc.keybind.push( 
    --        
    --            myrc.keybind.key( tmp[1], tmp[2] , tmp[3], function () 
    --                awful.util.spawn( tmp[3] )
    --                myrc.keybind.pop() 
    --            end)
    --        
    --    , "Killall action") 
    --end))

   end
    keybindsArray[n] = awful.util.table.join(keybindsArray[n],{
                myrc.keybind.key( {}, "Escape", "Escape", function () 
                    myrc.keybind.pop() 
                end)
    })

end

end

globalkeys = awful.util.table.join(globalkeys,	awful.key({ modkey   }, "k", function () 
        myrc.keybind.push( keybindsArray[1] , "Killall action") 
    end))
globalkeys = awful.util.table.join(globalkeys,	awful.key({ modkey   }, "e", function () 
        myrc.keybind.push( keybindsArray[2] , "Execute action") 
    end))

]]--

globalkeys = awful.util.table.join(globalkeys,
	awful.key({ modkey   }, "t", function () 
        myrc.keybind.push({
				myrc.keybind.key( {}, "t", "test 1", function () 
-- --[[
                    myrc.keybind.push({
                        myrc.keybind.key( {}, "t", "test 1", function () 

                        myrc.keybind.pop() 
                        end),

                    } , "test1 action") 
-- ]]--
                    
                myrc.keybind.pop() 
                end),

				myrc.keybind.key( {}, "Escape", "Escape", function () myrc.keybind.pop() end),

            } , "test action") 
    end)
    ,
    awful.key({ modkey   }, "i", function () 
        myrc.keybind.push({
                myrc.keybind.key( {} , "k" , " + Super + Control + Alt   = killall" , function () awful.util.spawn( "xdotool key super+ctrl+k" ) myrc.keybind.pop()end)    , 
                myrc.keybind.key( {} , "e" , " + Super                   = execute" , function () awful.util.spawn( "xdotool key super+e" ) myrc.keybind.pop()end)    , 
                --myrc.keybind.key( {} , "l" , " + Super + Control + Shift = lighttpd" , function () awful.util.spawn_with_shell( "xdotool key Super_L+ctrl+shift+l" ) myrc.keybind.pop()end)    , 
                myrc.keybind.key( {} , "l" , " + Super + Control + Alt = lighttpd" , function () awful.util.spawn( "xdotool key super+ctrl+alt+l" ) myrc.keybind.pop()end)    , 
                
				myrc.keybind.key( {}, "Escape", "Escape", function () myrc.keybind.pop() end),

            } , "help action") 
    end)
    ,
	awful.key({ modkey,"Control", "Mod1" }, "k", function () 
        myrc.keybind.push({
                myrc.keybind.key( {} , "x" , "killall xcompmgr -n" , function () awful.util.spawn( "killall xcompmgr -n" ) myrc.keybind.pop() end)    , 
                --myrc.keybind.key( {} , "l" , "killall lxpanel"     , function () awful.util.spawn( "killall lxpanel" ) myrc.keybind.pop() end)     , 
                myrc.keybind.key( {} , "f" , "killall firefox"     , function () awful.util.spawn( "killall firefox" ) myrc.keybind.pop() end)     , 
                --myrc.keybind.key( {} , "f" , "killall icecat"      , function () awful.util.spawn( "killall icecat" ) myrc.keybind.pop() end)     , 
                myrc.keybind.key( {} , "i" , "killall iron"        , function () awful.util.spawn( "killall iron" ) myrc.keybind.pop() end)        , 
                myrc.keybind.key( {} , "c" , "killall chrome"      , function () awful.util.spawn( "killall chrome" ) myrc.keybind.pop() end)        , 
                myrc.keybind.key( {} , "t" , "killall thunderbird" , function () awful.util.spawn( "killall thunderbird" ) myrc.keybind.pop() end) , 
                myrc.keybind.key( {} , "p" , "killall pcmanfm"     , function () awful.util.spawn( "killall pcmanfm" ) myrc.keybind.pop() end)     , 
                --myrc.keybind.key( {} , "p" , "killall pidgin"      , function () awful.util.spawn( "killall pidgin" ) myrc.keybind.pop() end)     , 
                myrc.keybind.key( {} , "g" , "killall gvim"        , function () awful.util.spawn( "killall gvim" ) myrc.keybind.pop() end)        , 
                myrc.keybind.key( {} , "l" , "killall listen"      , function () awful.util.spawn( "killall listen" ) myrc.keybind.pop() end)        , 
                myrc.keybind.key( {} , "a" , "killall audacious"   , function () awful.util.spawn( "killall audacious" ) myrc.keybind.pop() end)        , 

                myrc.keybind.key( {}, "Escape", "Escape", function () myrc.keybind.pop() end),
            } , "Killall action") 
    end)
    ,
	awful.key({ modkey   }, "e", function () 
        myrc.keybind.push({
                myrc.keybind.key( {} , "x" , "xcompmgr -n" , function () awful.util.spawn( "xcompmgr -n" ) myrc.keybind.pop() end)    , 
                --myrc.keybind.key( {} , "l" , "lxpanel"     , function () awful.util.spawn( "lxpanel" ) myrc.keybind.pop() end)     , 
                myrc.keybind.key( {} , "f" , "firefox"     , function () awful.util.spawn( "firefox" ) myrc.keybind.pop() end)     , 
                --myrc.keybind.key( {} , "f" , "icecat"     , function () awful.util.spawn( "icecat" ) myrc.keybind.pop() end)     , 
                myrc.keybind.key( {} , "i" , "iron"        , function () awful.util.spawn( "iron" ) myrc.keybind.pop() end)        , 
                myrc.keybind.key( {} , "c" , "chrome"      , function () awful.util.spawn( "chrome" ) myrc.keybind.pop() end)        , 
                myrc.keybind.key( {} , "t" , "thunderbird" , function () awful.util.spawn( "thunderbird" ) myrc.keybind.pop() end) , 
                myrc.keybind.key( {} , "p" , "pcmanfm"     , function () awful.util.spawn( "pcmanfm" ) myrc.keybind.pop() end)     , 
                --myrc.keybind.key( {} , "p" , "pidgin"     , function () awful.util.spawn( "pidgin" ) myrc.keybind.pop() end)     , 
                myrc.keybind.key( {} , "g" , "gvim"        , function () awful.util.spawn( "gvim" ) myrc.keybind.pop() end)        , 
                myrc.keybind.key( {} , "l" , "listen"      , function () awful.util.spawn( "listen" ) myrc.keybind.pop() end)        , 
                myrc.keybind.key( {} , "a" , "audacious"   , function () awful.util.spawn( "audacious" ) myrc.keybind.pop() end)        , 


                myrc.keybind.key( {}, "Escape", "Escape", function () myrc.keybind.pop() end),
            } , "Execute action")   
    end)    ,
	awful.key({ modkey,"Control", "Mod1"  }, "l", function () 
        myrc.keybind.push({
                myrc.keybind.key( {} , "s" , "lightstart"       , function () awful.util.spawn_with_shell( "lightstart" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {} , "t" , "lightstop"        , function () awful.util.spawn_with_shell( "lightstop" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {} , "r" , "lightrestart"     , function () awful.util.spawn_with_shell( "lightrestart" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {} , "a" , "read lightaccess" , function () awful.util.spawn_with_shell( "xterm -e lightaccess" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {} , "e" , "read lighterror"  , function () awful.util.spawn_with_shell( "xterm -e lighterror" ) myrc.keybind.pop() end)    , 

                myrc.keybind.key( {} , "m" , "add meetic"      , function () awful.util.spawn_with_shell( "lighty_manager -a meetic.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {} , "v" , "add meeticvip"   , function () awful.util.spawn_with_shell( "lighty_manager -a meeticvip.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {} , "o" , "add meetic-obo"  , function () awful.util.spawn_with_shell( "lighty_manager -a meetic-obo.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {} , "u" , "add ulteem"      , function () awful.util.spawn_with_shell( "lighty_manager -a ulteem.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {} , "p" , "add paymentv4"   , function () awful.util.spawn_with_shell( "lighty_manager -a paymentv4.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {} , "l" , "add local"       , function () awful.util.spawn_with_shell( "lighty_manager -a local.conf" ) myrc.keybind.pop() end)    , 

                myrc.keybind.key( {"Mod1"} , "m" , "del meetic"      , function () awful.util.spawn_with_shell( "lighty_manager -d meetic.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {"Mod1"} , "v" , "del meeticvip"   , function () awful.util.spawn_with_shell( "lighty_manager -d meeticvip.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {"Mod1"} , "o" , "del meetic-obo"  , function () awful.util.spawn_with_shell( "lighty_manager -d meetic-obo.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {"Mod1"} , "u" , "del ulteem"      , function () awful.util.spawn_with_shell( "lighty_manager -d ulteem.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {"Mod1"} , "p" , "del paymentv4"   , function () awful.util.spawn_with_shell( "lighty_manager -d paymentv4.conf" ) myrc.keybind.pop() end)    , 
                myrc.keybind.key( {"Mod1"} , "l" , "del local"       , function () awful.util.spawn_with_shell( "lighty_manager -d local.conf" ) myrc.keybind.pop() end)    , 


                myrc.keybind.key( {}, "Escape", "Escape", function () myrc.keybind.pop() end),
            } , "lighty action") 
    end)

    
)


root.keys(globalkeys)
naughty.notify({ title = "<b>Achtung!</b>", text = "" .. (timing.module_end - timing.module_start)
, timeout = 0 })

