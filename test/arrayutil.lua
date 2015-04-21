
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/arrayutil.lua")
dofile("./utils/list.lua")
dofile("./utils/mathutil.lua")
dofile("./utils/tableutil.lua")

test.start("arrayutil")


test.run("next_matching_column", function()
	local array = {
		{ "", "", "", "", "" },
		{ "", "something", "", "", "" },
		{ "", "", "", "", "" },
		{ "", "", "", "something", "" },
		{ "", "", "", "", "" }
	}
	
	test.equals(2, arrayutil.next_matching_column(array))
	test.equals(4, arrayutil.next_matching_column(array, 3))
	test.equals(-1, arrayutil.next_matching_column(array, 5))
	
	-- Reverse
	test.equals(4, arrayutil.previous_matching_column(array))
	test.equals(2, arrayutil.previous_matching_column(array, 3))
	test.equals(-1, arrayutil.previous_matching_column(array, 1))
end)

test.run("next_matching_row", function()
	local array = {
		{ "", "", "", "", "" },
		{ "", "", "something", "", "" },
		{ "", "", "", "", "" },
		{ "", "", "", "something", "" },
		{ "", "", "", "", "" }
	}
	
	test.equals(2, arrayutil.next_matching_row(array))
	test.equals(4, arrayutil.next_matching_row(array, 3))
	test.equals(-1, arrayutil.next_matching_row(array, 5))
	
	-- Reverse
	test.equals(4, arrayutil.previous_matching_row(array))
	test.equals(2, arrayutil.previous_matching_row(array, 3))
	test.equals(-1, arrayutil.previous_matching_row(array, 1))
end)

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

