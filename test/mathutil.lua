
-- Load the test file.
dofile("../utils/test.lua")

-- Load the file for testing.
dofile("../utils/mathutil.lua")


local function test_clamp()
	test.equals(0, mathutil.clamp(0, 0, 0))
	
	test.equals(0, mathutil.clamp(-10, 0, 20))
	test.equals(20, mathutil.clamp(30, 0, 20))
end

local function test_round()
	test.equals(0, mathutil.round(0))
	
	test.equals(0, mathutil.round(0.3))
	test.equals(0, mathutil.round(0.49))
	test.equals(1, mathutil.round(0.50))
	test.equals(1, mathutil.round(0.7))
	
	test.equals(10.2, mathutil.round(10.23456, 1))
	test.equals(10.3, mathutil.round(10.25456, 1))
	
	test.equals(1.234, mathutil.round(1.2344756, 3))
end

test.start("mathutil")
test.run("clamp", test_clamp)
test.run("round", test_round)

