
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/arrayutil.lua")
dofile("./mods/utils/list.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/tableutil.lua")

test.start("arrayutil")


test.run("contains", function()
	test.equals(false, arrayutil.contains({}, nil))
	
	test.equals(true, arrayutil.contains({ "test" }, "test"))
	test.equals(true, arrayutil.contains({ "a", "b", "test" }, "test"))
	test.equals(true, arrayutil.contains({ "a", "b" , "c", "test", "d", "e" }, "test"))
	
	test.equals(true, arrayutil.contains({ "a", "b" , "c", "test", "d", "e" }, { "a", "b", "c" }))
	test.equals(true, arrayutil.contains({ "a", "b" , "c", "test", "d", "e" }, { "b", "c" }))
	test.equals(true, arrayutil.contains({ "a", "b" , "c", "test", "d", "e" }, { "d", "e" }))
	test.equals(true, arrayutil.contains({ "a", "b" , "c", "test", "d", "e" }, { "d", "e", "a", "b" }))
	
	test.equals(false, arrayutil.contains({ "a", "b" , "c", "test", "d", "e" }, { "b", "d" }))
	test.equals(false, arrayutil.contains({ "a", "b" , "c", "test", "d", "e" }, { "d", "e", "a", "c" }))
end)

test.run("create2d", function()
	local array = arrayutil.create2d(1, 1, 4, 3, "value")

	test.equals("value", array[1][1])
	test.equals("value", array[1][3])
	test.equals("value", array[4][1])
	test.equals("value", array[4][3])
	test.equals(nil, array[0])
	test.equals(nil, array[1][0])
	test.equals(nil, array[5])
	test.equals(nil, array[4][4])
end)

test.run("create3d", function()
	local array = arrayutil.create3d(1, 1, 1, 4, 3, 2, "value")

	test.equals("value", array[1][1][1])
	test.equals("value", array[1][1][2])
	test.equals("value", array[4][1][1])
	test.equals("value", array[4][3][2])
	test.equals(nil, array[0])
	test.equals(nil, array[1][0])
	test.equals(nil, array[5])
	test.equals(nil, array[4][3][3])
end)

test.run("index", function()
	test.equals(-1, arrayutil.index({}, nil))
	
	test.equals(1, arrayutil.index({ "test" }, "test"))
	test.equals(3, arrayutil.index({ "a", "b", "test" }, "test"))
	test.equals(4, arrayutil.index({ "a", "b" , "c", "test", "d", "e" }, "test"))
	
	test.equals(1, arrayutil.index({ "a", "b" , "c", "test", "d", "e" }, { "a", "b", "c" }))
	test.equals(2, arrayutil.index({ "a", "b" , "c", "test", "d", "e" }, { "b", "c" }))
	test.equals(5, arrayutil.index({ "a", "b" , "c", "test", "d", "e" }, { "d", "e" }))
	test.equals(5, arrayutil.index({ "a", "b" , "c", "test", "d", "e" }, { "d", "e", "a", "b" }))
	
	test.equals(-1, arrayutil.index({ "a", "b" , "c", "test", "d", "e" }, { "b", "d" }))
	test.equals(-1, arrayutil.index({ "a", "b" , "c", "test", "d", "e" }, { "d", "e", "a", "c" }))
end)

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

