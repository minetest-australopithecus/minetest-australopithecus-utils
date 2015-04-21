
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/arrayutil.lua")
dofile("./utils/list.lua")
dofile("./utils/mathutil.lua")
dofile("./utils/tableutil.lua")

test.start("arrayutil")


test.run("reduce2d", function()
	local reduced = arrayutil.reduce2d({})
	local expected = {}
	
	test.equals(true, tableutil.equals(reduced, expected))
	
	reduced = arrayutil.reduce2d({
		{ "", "", "", "", "" },
		{ "", "", "something", "", "" },
		{ "", "", "", "", "" },
		{ "", "", "", "something", "" },
		{ "", "", "", "", "" }
	})
	expected = arrayutil.reduce2d({
		{ "something", "" },
		{ "", "" },
		{ "", "something" },
	})
	
	test.equals(true, tableutil.equals(reduced, expected))
end)

