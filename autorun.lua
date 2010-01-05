function run_once(prg, sleep)
	if not prg then
		do return nil end
	end
	command= "x=" .. prg .. "; pgrep -u $USERNAME -x " .. prg .. " || ( sleep "..sleep.." && ".. prg .. " &)"
	os.execute(command)
    --awful.util.spawn_with_shell(command)
end
-- AUTORUN APPS!
--run_once("parcellite")

-- Autorun programs
autorun = true
autorunApps = 
{ 
    {"xterm -e wmname LG3D"                                , 5} , 
    {"random_background"                                   , 2} , 
    --{"xcompmgr"                                          , 0} , 
    --{"xcompmgr -cCfF -t-5 -l-5 -r0 -o.5 -D6"               , 2} , 
    {"xcompmgr -n"                                          , 2} , 
    {"audacious2"                                          , 0} , 
    --{"~/.config/openbox/autostart.sh"                    , 0} , 
    --{"conky -b -c /home/misel/Scripts/conky/brenden.conky" , 5} , 
    {"numlockx"                                            , 0} , 
    {"alunn"                                               , 0} , 
    {"parcellite"                                          , 0} , 
    {"pidgin"                                              , 0} , 
    {"idesk"                                               , 0} , 
    --{"basket"                                              , 0} , 
    --{"pcmanfm"                                              , 0} , 
    {"gvim"                                                , 0} , 
    {"thunderbird"                                         , 0} , 
    --{"midori"                                              , 0} , 
    {"arora"                                               , 0} , 
}
if autorun then
   for app = 1, #autorunApps do
       run_once( autorunApps[app][1] , autorunApps[app][2] )
   end
end

