-- {{{ Menu
mythememenu = {}

function theme_load(theme)
   local cfg_path = awful.util.getdir("config")

   -- Create a symlink from the given theme to /home/user/.config/awesome/current_theme
   awful.util.spawn("ln -sf " .. cfg_path .. "/themes/" .. theme .. " " .. cfg_path .. "/current_theme")
   awesome.restart()
end

function theme_menu()
   -- List your theme files and feed the menu table
   local cmd = "ls -1 " .. awful.util.getdir("config") .. "/themes/"
   local f = io.popen(cmd)

   for l in f:lines() do
	  local item = { l, function () theme_load(l) end }
	  table.insert(mythememenu, item)
   end

   f:close()
end

-- Generate your table at startup or restart
theme_menu()

-- Modify your awesome menu to add your theme sub-menu
--
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "lock"        , "xscreensaver-command -activate" }                              , 
   { "manual"      , terminal .. " -e man awesome" }                                 , 
   { "edit config" , editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" } , 
   { "themes", mythememenu },
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

