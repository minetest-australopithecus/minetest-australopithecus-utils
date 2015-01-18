
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/blockutil.lua")

dofile("./utils/constants.lua")

test.start("blockutil")

test.run("get_begin", function()
	local x, y, z = blockutil.get_begin(0, -188, 188)
	
	test.equals(-32, x)
	test.equals(-192, y)
	test.equals(128, z)
end)

test.run("get_end", function()
	local x, y, z = blockutil.get_end(0, -188, 188)
	
	test.equals(47, x)
	test.equals(-113, y)
	test.equals(207, z)
end)

