
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/interpolate.lua")
dofile("./utils/list.lua")
dofile("./utils/transform.lua")
dofile("./utils/mathutil.lua")
dofile("./utils/tableutil.lua")


local function test_big_linear()
	test.equals(0, transform.big_linear(-10))
	test.equals(0.25, transform.big_linear(-5))
	test.equals(0.5, transform.big_linear(0))
	test.equals(0.75, transform.big_linear(5))
	test.equals(1, transform.big_linear(10))
	
	test.equals(20, transform.big_linear(-10, 20, 30))
	test.equals(22.5, transform.big_linear(-5, 20, 30))
	test.equals(25, transform.big_linear(0, 20, 30))
	test.equals(27.5, transform.big_linear(5, 20, 30))
	test.equals(30, transform.big_linear(10, 20, 30))
end

local function test_centered_linear()
	test.equals(0, transform.centered_linear(-1))
	test.equals(0.5, transform.centered_linear(-0.5))
	test.equals(1, transform.centered_linear(0))
	test.equals(0.5, transform.centered_linear(0.5))
	test.equals(0, transform.centered_linear(1))
	
	test.equals(100, transform.centered_linear(10, 10, 20, 100, 110))
	test.equals(105, transform.centered_linear(12.5, 10, 20, 100, 110))
	test.equals(110, transform.centered_linear(15, 10, 20, 100, 110))
	test.equals(105, transform.centered_linear(17.5, 10, 20, 100, 110))
	test.equals(100, transform.centered_linear(20, 10, 20, 100, 110))
end

local function test_linear()
	test.equals(0, transform.linear(-1))
	test.equals(0.25, transform.linear(-0.5))
	test.equals(0.5, transform.linear(0))
	test.equals(0.75, transform.linear(0.5))
	test.equals(1, transform.linear(1))
	
	test.equals(100, transform.linear(10, 10, 20, 100, 110))
	test.equals(102.5, transform.linear(12.5, 10, 20, 100, 110))
	test.equals(105, transform.linear(15, 10, 20, 100, 110))
	test.equals(107.5, transform.linear(17.5, 10, 20, 100, 110))
	test.equals(110, transform.linear(20, 10, 20, 100, 110))
end

local function test_small_linear()
	test.equals(0, transform.small_linear(-1))
	test.equals(0.25, transform.small_linear(-0.5))
	test.equals(0.5, transform.small_linear(0))
	test.equals(0.75, transform.small_linear(0.5))
	test.equals(1, transform.small_linear(1))
	
	test.equals(20, transform.small_linear(-1, 20, 30))
	test.equals(22.5, transform.small_linear(-0.5, 20, 30))
	test.equals(25, transform.small_linear(0, 20, 30))
	test.equals(27.5, transform.small_linear(0.5, 20, 30))
	test.equals(30, transform.small_linear(1, 20, 30))
end

test.start("transform")
test.run("big_linear", test_big_linear)
test.run("centered_linear", test_centered_linear)
test.run("linear", test_linear)
test.run("small_linear", test_small_linear)

