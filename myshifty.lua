require("shifty")

-- {{{ Tags
--[[
shifty.config.tags = {
  --  ["foo"] = { position = 13, init = true, },
    ["urxvt"] = { position = 1, init = true, },
    ["ssh"] = { position = 2, nopopup = true, },
    ["www"]  = { position = 3,  spawn = browser,},
    ["gimp"] = { position = 6, exclusive = true, nopopup = true, spawn = gimp, },
    ["irc"]  = { position = 4,  nopopup = true, spawn = "rxvt-unicode -T weechat -e weechat-curses"  },
    ["sys"]  = { position = 5, exclusive = true,  nopopup = true, },
    ["msg"]  = { position = 7, exclusive = true,  nopopup = true,  },
    ["view"] = { position = 8, exclusive = true, nopopup = true,  },
    ["vbox"] = { position = 9, exclusive = true, nopopup = true,  },
    ["mail"] = { position = 10, exclusive = true, nopopup = true,  },
    ["med"] = { position = 11, nopopup = true,                      },
    ["dl"] = { position = 12, nopopup = true, spawn = "Transmission"},
    ["foo"] = { position = 13, nopopop = true, init = true, },
}
]]--

--[[
shifty.taglist = mytaglist 
-- Clients rules

shifty.config.apps = {

         { match = {"Transmission","Tucan.py"                    }, tag = "dl" },
         { match = {"ssh"                                       }, tag = "ssh"},
         { match = {"^Download$", "Preferences", "VideoDownloadHelper","Downloads", "Firefox Preferences", }, float = true, intrusive = true },
         { match = {"Firefox","Iceweasel","Vimperator","Shiretoko"} , tag = "www", opacity = 1.0       } ,
         { match = { "WeeChat 0.2.6","weechat-curses","weechat"     }, tag = "irc" ,                 },
         { match = {"Gimp"                           }, tag = "gimp",  float = true , opacity = 1.0    },
         { match = {"gimp-image-window"              }, slave = true,  opacity = 1.0                     },
         { match = {"MPlayer","ffplay"                       }, float = true,  opacity = 1.0             },
         { match = {"alpine"                    }, tag = "mail",                                       },
         { match = {"med"                          }, tag = "med"                                      },
         { match = {"ncmpcpp","ncmpc++ ver.0.3.4","med"                }, tag = "med",                 },
         { match = {"Pidgin"                         }, tag = "msg",                                   },
         { match = {"htop"                           }, tag = "sys",                                   },
         { match = {"VirtualBox"                     }, tag = "vbox", float = true,  opacity = 1.0     },
         { match = {"lxappearence","Caml graphics"               }, float = true, opacity = 1.0                      },
         { match = {"gpicview","Epdfview"                       }, float = true, tag = "view",                    },
         { match = { "" },
                   buttons = awful.util.table.join(
                       awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
                    awful.button({ modkey }, 1, awful.mouse.client.move),
                     awful.button({ modkey }, 3, awful.mouse.client.resize),
              awful.button({ modkey }, 8, awful.mouse.client.resize))
  }
}
--]]

-- Options par dÃ©faut.
shifty.config.defaults = {
  layout = awful.layout.suit.tile,
  ncol = 1,
  mwfact = 0.50,
  floatBars=false,
}


-- {{{ Key bindings
globalkeys = awful.util.table.join( globalkeys,
-- Shifty
    
    awful.key({ modkey, "Shift"   }, "t",             shifty.add),
    awful.key({ modkey            }, "r",           shifty.rename),
    awful.key({ modkey            }, "w",           shifty.del),

    awful.key({ modkey, "Shift"   }, "Left",   shifty.shift_prev        ),
    awful.key({ modkey, "Shift"   }, "Right",  shifty.shift_next        ),
 --   awful.key({ modkey            }, "Escape", function() awful.tag.history.restore() end), -- move to prev tag by history
    awful.key({ modkey, "Shift"   }, "n", shifty.send_prev), -- move client to prev tag
    awful.key({ modkey            }, "n", shifty.send_next)


--    shifty.config.clientkeys = clientkeys
--
)
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
--shifty.config.clientkeys = clientkeys
shifty.init()
