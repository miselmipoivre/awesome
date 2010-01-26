--module("mouse_move")
-- set the desired pixel coordinates:
--  if your screen is 1024x768 the this line sets the bottom right.
local safeCoords = {x=1280, y=1024}
--  this line sets top middle(ish).
local safeCoords = {x=640, y=0}
-- Flag to tell Awesome whether to do this at startup.
local moveMouseOnStartup = true

-- Simple function to move the mouse to the coordinates set above.
local function moveMouse(x_co, y_co)
    mouse.coords({ x=x_co, y=y_co })
end

-- Bind ''Meta4+Ctrl+m'' to move the mouse to the coordinates set above.
--   this is useful if you needed the mouse for something and now want it out of the way
globalkeys = awful.util.table.join(globalkeys,
awful.key({ modkey, "Control" }, "m", function() moveMouse(safeCoords.x, safeCoords.y) end)
)
-- Optionally move the mouse when rc.lua is read (startup)
if moveMouseOnStartup then
        moveMouse(safeCoords.x, safeCoords.y)
end
root.keys(globalkeys)

function floats(c)
  local ret = false
  local l = awful.layout.get(c.screen)
  if awful.layout.getname(l) == 'floating' or awful.client.floating.get(c) then
    ret = true
  end
  return ret
end

function move_client_float(c,x,y)
    if floats(c) then
        local g = c:geometry()
        g.x = g.x + x
        g.y = g.y + y
        c:geometry(g)
        mouse_warp(c)
    end
end

function resize_client(c,w,h,is_absolute)
    if floats(c) then
        local g = c:geometry()
        if is_absolute then 
			g.width = w
			g.height = h
		else
			g.width = g.width + w
			g.height = g.height + h
		end
        c:geometry(g)
        mouse_warp(c)
    end
end

function resize_client_absolute(c,w,h)
    resize_client(c,w,h,true)
end

function move_client_edge(c,edge)
      if floats(c) then
        local g = c:geometry()
        local w = screen[c.screen].workarea
        
		if		edge == "TOPRIGHT"	then 
			g.x = w.width - g.width + w.x
			g.y = 0 + w.y
		elseif	edge == "BOTTOMLEFT"	then  
			g.x = 0 + w.x
			g.y = w.height - g.height + w.y
		elseif	edge == "BOTTOMCENTER"	then  
			g.x = (w.width - g.width)/2 + w.x
			g.y = w.height - g.height + w.y
		elseif	edge == "BOTTOMRIGHT"	then  
			g.x = w.width - g.width + w.x
			g.y = w.height - g.height + w.y
		elseif	edge == "CENTERLEFT"	then  
			g.x = 0 + w.x
			g.y = (w.height - g.height)/2 + w.y
		elseif	edge == "CENTERH"	then  
			g.x = (w.width - g.width)/2 + w.x
		elseif	edge == "CENTERV"	then  
			g.y = (w.height - g.height)/2 + w.y
		elseif	edge == "CENTERCENTER"	then  
			g.x = (w.width - g.width)/2 + w.x
			g.y = (w.height - g.height)/2 + w.y
		elseif	edge == "CENTERRIGHT"	then  
			g.x = w.width - g.width + w.x
			g.y = (w.height - g.height)/2 + w.y
		elseif	edge == "TOPLEFT"	then  
			g.x = 0 + w.x
			g.y = 0 + w.y
		elseif	edge == "TOPCENTER"	then  
			g.x = (w.width - g.width)/2 + w.x
			g.y = 0 + w.y
		elseif	edge == "TOPRIGHT"	then  
			g.x = w.width - g.width + w.x
			g.y = 0 + w.y

		else
		end
        c:geometry(g)
        mouse_warp(c)
      end
end

local moveStep = 10
local moveStep2 = 10*5

clientkeys = awful.util.table.join(clientkeys,


-- move floating windows
    awful.key({ modkey } , "KP_End"   , function(c ) move_client_float(c , -moveStep , moveStep  ) end )  , 
    awful.key({ modkey } , "KP_Down"  , function(c ) move_client_float(c , 0          , moveStep  ) end )  , 
    awful.key({ modkey } , "KP_Next"  , function(c ) move_client_float(c , moveStep  , moveStep  ) end )  , 
    awful.key({ modkey } , "KP_Left"  , function(c ) move_client_float(c , -moveStep , 0          ) end )  , 
    awful.key({ modkey } , "KP_Begin" , function(c) move_client_edge(c , "CENTERCENTER" )  end  )  , 
    awful.key({ modkey } , "KP_Right" , function(c ) move_client_float(c , moveStep  , 0          ) end )  , 
    awful.key({ modkey } , "KP_Home"  , function(c ) move_client_float(c , -moveStep , -moveStep ) end )  , 
    awful.key({ modkey } , "KP_Up"    , function(c ) move_client_float(c , 0          , -moveStep ) end )  , 
    awful.key({ modkey } , "KP_Prior" , function(c ) move_client_float(c , moveStep  , -moveStep ) end )  , 
    awful.key({ modkey } , "KP_End"   , function(c ) move_client_float(c , -moveStep , moveStep  ) end )  , 
    
    awful.key({ "Control","Shift" } , "KP_Multiply", function ()  awful.util.spawn("transset-df -p --inc 0.1") end),
    awful.key({ "Control","Shift" } , "KP_Divide", function ()  awful.util.spawn("transset-df -p --dec 0.1") end),
	
    --awful.key({ modkey, "Control" } , "KP_Divide", function (c) c.maximized_vertical = 1 end),
    --awful.key({ modkey, "Control" } , "KP_Multiply", function (c) c.maximized_horizontal = 1 end),
    awful.key({ modkey } , "KP_Divide" , function(c) move_client_edge(c , "CENTERH" )  end  )  , 
    awful.key({ modkey } , "KP_Multiply" , function(c) move_client_edge(c , "CENTERV" )  end  )  , 
    
    awful.key({ modkey, "Control" } , "KP_Divide", function (c) c.maximized_vertical = not c.maximized_vertical; mouse_wrap(c) end),
    awful.key({ modkey, "Control" } , "KP_Multiply", function (c) c.maximized_horizontal = not c.maximized_horizontal; mouse_wrap(c) end),
    
    awful.key({ modkey } , "KP_Subtract"   , function(c ) resize_client(c , -moveStep , -moveStep ) end )  , 
	awful.key({ modkey } , "KP_Add"   , function(c ) resize_client(c , moveStep , moveStep ) end )  , 
	awful.key({ modkey, "Control" } , "KP_Subtract"   , function(c ) resize_client_absolute(c , moveStep2 , moveStep2 ) end )  , 
	awful.key({ modkey, "Control" } , "KP_Add"   , function(c ) resize_client(c , moveStep2 , moveStep2 ) end )  , 

    awful.key({ modkey, "Control" } , "KP_End"   , function(c ) move_client_float(c , -moveStep2 , moveStep2  ) end )  , 
    awful.key({ modkey, "Control" } , "KP_Down"  , function(c ) move_client_float(c , 0          , moveStep2  ) end )  , 
    awful.key({ modkey, "Control" } , "KP_Next"  , function(c ) move_client_float(c , moveStep2  , moveStep2  ) end )  , 
    awful.key({ modkey, "Control" } , "KP_Left"  , function(c ) move_client_float(c , -moveStep2 , 0          ) end )  , 
    awful.key({ modkey, "Control" } , "KP_Begin" , function(c ) move_client_edge(c , "CENTERCENTER" )  end  )  , 
    awful.key({ modkey, "Control" } , "KP_Right" , function(c ) move_client_float(c , moveStep2  , 0          ) end )  , 
    awful.key({ modkey, "Control" } , "KP_Home"  , function(c ) move_client_float(c , -moveStep2 , -moveStep2 ) end )  , 
    awful.key({ modkey, "Control" } , "KP_Up"    , function(c ) move_client_float(c , 0          , -moveStep2 ) end )  , 
    awful.key({ modkey, "Control" } , "KP_Prior" , function(c ) move_client_float(c , moveStep2  , -moveStep2 ) end )  , 
    awful.key({ modkey, "Control" } , "KP_End"   , function(c ) move_client_float(c , -moveStep2 , moveStep2  ) end )  , 
    
	-- move floating windows to screen edges

    awful.key({ modkey , "Shift" } , "KP_End"   , function(c) move_client_edge(c , "BOTTOMLEFT"   )  end  )  , 
    awful.key({ modkey , "Shift" } , "KP_Down"  , function(c) move_client_edge(c , "BOTTOMCENTER" )  end  )  , 
    awful.key({ modkey , "Shift" } , "KP_Next"  , function(c) move_client_edge(c , "BOTTOMRIGHT"  )  end  )  , 
    awful.key({ modkey , "Shift" } , "KP_Left"  , function(c) move_client_edge(c , "CENTERLEFT"   )  end  )  , 
    awful.key({ modkey , "Shift" } , "KP_Begin" , function(c) move_client_edge(c , "CENTERCENTER" )  end  )  , 
    awful.key({ modkey , "Shift" } , "KP_Right" , function(c) move_client_edge(c , "CENTERRIGHT"  )  end  )  , 
    awful.key({ modkey , "Shift" } , "KP_Home"  , function(c) move_client_edge(c , "TOPLEFT"      )  end  )  , 
    awful.key({ modkey , "Shift" } , "KP_Up"    , function(c) move_client_edge(c , "TOPCENTER"    )  end  )  , 
    awful.key({ modkey , "Shift" } , "KP_Prior" , function(c) move_client_edge(c , "TOPRIGHT"     )  end  ) 



	---		Num_lock	KP_Divide	KP_Multiply		KP_Subtract  
	---		7			8			9				KP_Add
	---		4			5			6
	---		1			2			3				KP_Enter
	---		KP_Insert				KP_Delete		


)

