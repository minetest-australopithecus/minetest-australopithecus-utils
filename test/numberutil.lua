
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/list.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/numberutil.lua")
dofile("./mods/utils/tableutil.lua")


test.start("numberutil")


test.run("format", function()
	test.equals("12", numberutil.format(12))
	test.equals("12.74632", numberutil.format(12.74632))
	test.equals("12,121,212.74", numberutil.format(12121212.74))
	test.equals("-12,121,212.74", numberutil.format(-12121212.74))
	
	test.equals("1#123#456#789$588", numberutil.format(1123456789.58823347239, 3, "$", "#"))
	test.equals("12.00000", numberutil.format(12, 5))
end)

