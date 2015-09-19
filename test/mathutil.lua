
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/list.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/tableutil.lua")


test.start("mathutil")

test.run("clamp", function()
	test.equals(0, mathutil.clamp(0, 0, 0))
	
	test.equals(0, mathutil.clamp(-10, 0, 20))
	test.equals(20, mathutil.clamp(30, 0, 20))
end)

test.run("distance", function()
	-- Test with positions.
	test.equals(1.7321, mathutil.round(mathutil.distance({ x = 0, y = 0, z = 0 }, { x = 1, y = 1, z = 1}), 4))
	test.equals(13.9284, mathutil.round(mathutil.distance({ x = 0, y = 0, z = 0 }, { x = 7, y = 8, z = 9}), 4))
	test.equals(26.7955, mathutil.round(mathutil.distance({ x = -18, y = 20, z = 51 }, { x = 3, y = 6, z = 60}), 4))
	
	-- Test with objects.
	local testobject = function(x, y, z)
		return {
			getpos = function()
				return { x = x, y = y, z = z }
			end
		}
	end
	
	test.equals(1.7321, mathutil.round(mathutil.distance({ x = 0, y = 0, z = 0 }, testobject(1, 1, 1)), 4))
	test.equals(13.9284, mathutil.round(mathutil.distance(testobject(0, 0, 0), { x = 7, y = 8, z = 9}), 4))
	test.equals(26.7955, mathutil.round(mathutil.distance(testobject(-18, 20, 51), testobject(3, 6,60)), 4))
end)

test.run("in_range", function()
	test.equals(true, mathutil.in_range(0, 0, 10))
	test.equals(true, mathutil.in_range(5, 0, 10))
	test.equals(true, mathutil.in_range(10, 0, 10))
	test.equals(false, mathutil.in_range(-1, 0, 10))
	test.equals(false, mathutil.in_range(11, 0, 10))
	
	test.equals(true, mathutil.in_range(0, { 0, 10 }))
	test.equals(true, mathutil.in_range(5, { 0, 10 }))
	test.equals(true, mathutil.in_range(10, { 0, 10 }))
	test.equals(false, mathutil.in_range(-1, { 0, 10 }))
	test.equals(false, mathutil.in_range(11, { 0, 10 }))
	
	test.equals(true, mathutil.in_range(0, { min = 0, max = 10 }))
	test.equals(true, mathutil.in_range(5, { min = 0, max = 10 }))
	test.equals(true, mathutil.in_range(10, { min = 0, max = 10 }))
	test.equals(false, mathutil.in_range(-1, { min = 0, max = 10 }))
	test.equals(false, mathutil.in_range(11, { min = 0, max = 10 }))
	
	test.equals(true, mathutil.in_range(5, 10, 0))
end)

test.run("next_lower_prime", function()
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
end)

test.run("round", function()
	test.equals(0, mathutil.round(0))
	
	test.equals(0, mathutil.round(0.3))
	test.equals(0, mathutil.round(0.49))
	test.equals(1, mathutil.round(0.50))
	test.equals(1, mathutil.round(0.7))
	
	test.equals(10.2, mathutil.round(10.23456, 1))
	test.equals(10.3, mathutil.round(10.25456, 1))
	
	test.equals(1.234, mathutil.round(1.2344756, 3))
end)

