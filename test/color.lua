
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/color.lua")
dofile("./mods/utils/list.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/tableutil.lua")


test.start("color")

test.run("basic", function()
	local color = Color:new(32, 64, 128)
	
	test.equals(32, color.red)
	test.equals(64, color.green)
	test.equals(128, color.blue)
	test.equals("204080", color.hex)
end)

