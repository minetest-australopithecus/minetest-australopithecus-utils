
-- Load the test file.
dofile("../utils/test.lua")

-- Load the file for testing.
dofile("../utils/mathutil.lua")


local function test_clamp()
	test.equals(0, mathutil.clamp(0, 0, 0))
	
	test.equals(0, mathutil.clamp(-10, 0, 20))
	test.equals(20, mathutil.clamp(30, 0, 20))
end

local function test_next_lower_prime()
	test.equals(0, mathutil.next_lower_prime(0))
	test.equals(1, mathutil.next_lower_prime(1))
	test.equals(2, mathutil.next_lower_prime(2))
	test.equals(3, mathutil.next_lower_prime(3))
	test.equals(3, mathutil.next_lower_prime(4))
	test.equals(5, mathutil.next_lower_prime(5))
	test.equals(5, mathutil.next_lower_prime(6))
	test.equals(7, mathutil.next_lower_prime(7))
	test.equals(7, mathutil.next_lower_prime(8))
	test.equals(7, mathutil.next_lower_prime(9))
	
	test.equals(619, mathutil.next_lower_prime(623))
	test.equals(907, mathutil.next_lower_prime(910))
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
test.run("next_lower_prime", test_next_lower_prime)
test.run("round", test_round)

