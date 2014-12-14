
-- Load the test file.
dofile("../utils/test.lua")

-- Load the file for testing.
dofile("../utils/blockutil.lua")


local function test_get_begin()
	local x, y, z = blockutil.get_begin(0, -188, 188)
	
	test.equals(-32, x)
	test.equals(-192, y)
	test.equals(128, z)
end


test.start("blockutil")
test.run("get_begin", test_get_begin)

