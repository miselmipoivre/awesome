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
keybinding({ modkey, "Control" }, "m", function() moveMouse(safeCoords.x, safeCoords.y) end):add()

-- Optionally move the mouse when rc.lua is read (startup)
if moveMouseOnStartup then
        moveMouse(safeCoords.x, safeCoords.y)
end
