
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

test.run("intersects", function()
	test.equals(true, mathutil.intersects(0, 0, 0))
	test.equals(true, mathutil.intersects(2, 0, 4))
	test.equals(false, mathutil.intersects(-1, 0, 0))
	test.equals(false, mathutil.intersects(5, 0, 4))
	
	test.equals(true, mathutil.intersects({ x = 5, y = 5 }, { x = 0, y = 0 }, { x = 10, y = 10 }))
	test.equals(false, mathutil.intersects({ x = 5, y = 5 }, { x = 0, y = 8 }, { x = 10, y = 10 }))
	test.equals(false, mathutil.intersects({ x = 5, y = 5 }, { x = 8, y = 0 }, { x = 10, y = 10 }))
	
	test.equals(true, mathutil.intersects({ x = 5, z = 5 }, { x = 0, z = 0 }, { x = 10, z = 10 }))
	test.equals(false, mathutil.intersects({ x = 5, z = 5 }, { x = 0, z = 8 }, { x = 10, z = 10 }))
	test.equals(false, mathutil.intersects({ x = 5, z = 5 }, { x = 8, z = 0 }, { x = 10, z = 10 }))
	test.equals(true, mathutil.intersects({ x = 5, y= 5, z = 5 }, { x = 0, y = 0, z = 0 }, { x = 10, y = 10, z = 10 }))
end)

