
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/color.lua")
dofile("./utils/mathutil.lua")


test.start("color")

test.run("basic", function()
	local color = Color:new(32, 64, 128)
	
	test.equals(32, color.red)
	test.equals(64, color.green)
	test.equals(128, color.blue)
	test.equals("204080", color.hex)
end)

