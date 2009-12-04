-- Grab environment we need
local os = os

-- Autostart Apps same as openbox
os.execute("wmname LG3D &") -- pour les programmes JAVA
--os.execute("~/.config/openbox/autostart.sh &")
--os.execute("audacious2 &")
os.execute("alunn &")					-- archlinux updater
os.execute("parcellite &") 			-- Lightweight GTK+ clipboard manager
os.execute("conky -b -c /home/misel/Scripts/conky/brenden.conky &")
os.execute("numlockx &")

-- DESKTOP	APPS
---------------------------------------------------------------------------------
--os.execute("sleep 0	&& terminator &")			--
os.execute("pidgin &")
os.execute("idesk &")
os.execute("basket &")
--os.execute("sleep 0	&& gvim &")
os.execute("sleep 1	&& thunderbird &")
--os.execute("sleep 1	&& alltray geany -s -x  &")
--os.execute("sleep 1	&& alltray google-chrome -s -x  &")
--os.execute("sleep 2	&& alltray firefox -s  &")
--os.execute("sleep 2	&& firefox  &")
--os.execute("sleep 3	&& rhythmbox &")
--os.execute("sleep 3	&& alltray -s -st -stask -g +1280+0 audacious2 &")
os.execute("sleep 3	&& audacious2 &" )&
--os.execute("sleep 3	&& alltray audacious2 -s -x -stask -nt &")	-- pour le no task !!
--os.execute("sleep 6	&& amarok &")
