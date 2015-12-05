
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

