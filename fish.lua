-- in rc.lua require("fish")
-- add  fish.widget to mywibox[s].widgets
-- uncomment last line awful.hooks...fish.update)

 fish = { }
 fish.widget = widget({ type = "textbox", align = "right" })
 fish.state = 1
 fish.states = { "<°}))o»«", "<°)})o>«", "<°))}o»<" }
 fish.widget:buttons({
     button({ }, 1, function () fish.fortune() end ) })
 
 function fish.fortune()
     local fh = io.popen("fortune -n 100 -s")
     local fortune = fh:read("*all")
     fh:close()
     naughty.notify({ text = fortune, timeout = 7 })
 end
 function fish.update()
     local t = ""
     t = t .. awful.util.escape(fish.states[fish.state])
     t = t .. ""
     fish.widget.text = t
     fish.state = (fish.state + 1) % #(fish.states) + 1
 end
 fish.update()
 
 awful.hooks.timer.register(0.5, fish.update)
