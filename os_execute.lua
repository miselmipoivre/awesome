module("autostart")

local os_exec_old = {
        {1,3,'wmname LG3D'},
        {1,3,'xcompmgr'},
        {1,3,'audacious2'},
        {1,3,'pidgin'},
        {1,3,'idesk'},
        {1,3,'basket'},
        {1,3,'thunderbird'},
        {1,3,'basket'},
        {1,3,'basket'}
    }

function os_execute ()
 local os_exec_list = {
        {1,3,'wmname LG3D'},
        {1,3,'xcompmgr'},
        {1,3,'audacious2'},
        {1,3,'pidgin'},
        {1,3,'idesk'},
        {1,3,'basket'},
        {1,3,'thunderbird'},
        {1,3,'basket'},
        {1,3,'basket'}
    }
    --local os_exec = os_exec
    for os_exec_list in os_exec_list do
        print( string.format('os.execute("%s %s = %s &")'),tostring( os_exec[i][0] ),tostring( os_exec[i][1] ),tostring( os_exec[i][2] ) )
    end
    --os.execute("wmname LG3D &") -- pour les programmes JAVA
end

os_execute()
