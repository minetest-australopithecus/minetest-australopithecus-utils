
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/list.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/tableutil.lua")


test.start("mathutil")


test.run("cantor_pairing", function()
	test.equals(3192, mathutil.cantor_pairing(47, 32))
end)

test.run("in_range", function()
	test.equals(true, mathutil.in_range(0, 0, 0))
	test.equals(true, mathutil.in_range(0, -1, 1))
	test.equals(true, mathutil.in_range(10, 5, 15))
	test.equals(true, mathutil.in_range(10, 15, 5))
	test.equals(true, mathutil.in_range(14, 5, 15))
	test.equals(true, mathutil.in_range(14, 15, 5))
	test.equals(true, mathutil.in_range(-10, -15, -5))
	test.equals(true, mathutil.in_range(-10, -5, -15))
	test.equals(true, mathutil.in_range(-14, -15, -5))
	test.equals(true, mathutil.in_range(-14, -5, -15))
	
	test.equals(false, mathutil.in_range(-1, 0, 0))
	test.equals(false, mathutil.in_range(1, 0, 0))
	test.equals(false, mathutil.in_range(4, 5, 15))
	test.equals(false, mathutil.in_range(4, 15, 5))
	test.equals(false, mathutil.in_range(16, 5, 15))
	test.equals(false, mathutil.in_range(16, 15, 5))
	test.equals(false, mathutil.in_range(-4, -15, -5))
	test.equals(false, mathutil.in_range(-4, -5, -15))
	test.equals(false, mathutil.in_range(-16, -15, -5))
	test.equals(false, mathutil.in_range(-16, -5, -15))
end)

