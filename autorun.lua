function run_once(prg, sleep)
	if not prg then
		do return nil end
	end
	command= "x=" .. prg .. "; pgrep -u $USERNAME -x " .. prg .. " || ( sleep "..sleep.." && ".. prg .. " &) > /dev/null"
	os.execute(command)
    --awful.util.spawn_with_shell(command)
end
-- AUTORUN APPS!
--run_once("parcellite")

-- Autorun programs
autorun = true
autorunApps = 
{ 
    --{"wbar -vbar -filter 0 -bpress -fc 0xffdb1212 -nanim 3", 5} , 
    {"xset m 3 1"                                , 5} , -- set mouse speed ex: m xset m 5/2 http://linuxreviews.org/howtos/xfree/mouse_speed_in_x/
    --{"xset m default"                                , 5} , -- set mouse speed ex: m xset m 5/2 http://linuxreviews.org/howtos/xfree/mouse_speed_in_x/
    {"xterm -e wmname LG3D"                                , 5} , 
    {"xcompmgr -n"                                , 5} , 
    --{"xcompmgr -cCfF -t-5 -l-5 -r0 -o.5 -D6"               , 2} , 
    {"random_background"                                   , 2} , 
    --{"audacious2"                                          , 0} , 
    --{"~/.config/openbox/autostart.sh"                    , 0} , 
    --{"conky -b -c ~/Scripts/conky/brenden.conky" , 5} , 
    {"numlockx"                                            , 0} , 
    --{"alunn"                                               , 0} , 
    {"parcellite"                                          , 0} , 
    {"pidgin"                                              , 0} , 
    {"idesk"                                               , 0} , 
    --{"basket"                                              , 0} , 
    --{"pcmanfm"                                              , 0} , 
    --{"gvim"                                                , 0} , 
    {"thunderbird"                                         , 4} , 
    --{"chrome"                                              , 0} , 
    --{"iron"                                              , 0} , 
    --{"midori"                                              , 0} , 
    --{"arora"                                               , 0} , 
}
if autorun then
   for app = 1, #autorunApps do
       run_once( autorunApps[app][1] , autorunApps[app][2] )
   end
end

