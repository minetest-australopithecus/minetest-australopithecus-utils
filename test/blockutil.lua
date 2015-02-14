
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/blockutil.lua")

dofile("./utils/constants.lua")


test.start("blockutil")

test.run("get_begin", function()
	test.equals(-112, blockutil.get_begin(-112))
	test.equals(-112, blockutil.get_begin(-111))
	test.equals(-112, blockutil.get_begin(-33))
	test.equals(-32, blockutil.get_begin(-32))
	test.equals(-32, blockutil.get_begin(-31))
	test.equals(-32, blockutil.get_begin(0))
	test.equals(-32, blockutil.get_begin(47))
	test.equals(48, blockutil.get_begin(48))
	test.equals(48, blockutil.get_begin(49))
	test.equals(48, blockutil.get_begin(127))
	test.equals(128, blockutil.get_begin(128))
	test.equals(128, blockutil.get_begin(129))
	test.equals(208, blockutil.get_begin(220))
	
	local x, y, z = blockutil.get_begin(0, -188, 188)
	
	test.equals(-32, x)
	test.equals(-192, y)
	test.equals(128, z)
end)

test.run("get_end", function()
	test.equals(-113, blockutil.get_end(-114))
	test.equals(-113, blockutil.get_end(-113))
	test.equals(-33, blockutil.get_end(-112))
	test.equals(-33, blockutil.get_end(-34))
	test.equals(-33, blockutil.get_end(-33))
	test.equals(47, blockutil.get_end(0))
	test.equals(47, blockutil.get_end(46))
	test.equals(47, blockutil.get_end(47))
	test.equals(127, blockutil.get_end(48))
	test.equals(127, blockutil.get_end(126))
	test.equals(127, blockutil.get_end(127))
	test.equals(207, blockutil.get_end(128))
	
	local x, y, z = blockutil.get_end(0, -188, 188)
	
	test.equals(47, x)
	test.equals(-113, y)
	test.equals(207, z)
end)

