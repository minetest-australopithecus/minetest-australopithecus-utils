
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/list.lua")
dofile("./utils/stringutil.lua")


test.start("stringutil")

test.run("concat", function()
	test.equals("", stringutil.concat(nil))
	
	test.equals("", stringutil.concat(""))
	
	test.equals("abc", stringutil.concat("a", "b", "c"))
	test.equals("a9true5.55", stringutil.concat("a", 9, true, 5.55))
end)

test.run("split", function()
	local single = stringutil.split("value", ",")
	test.equals(1, single:size())
	test.equals("value", single:get(0))
	
	local empty = stringutil.split("", ", ")
	test.equals(0, empty:size())
	test.equals(nil, empty:get(0))
	
	local only_split = stringutil.split(", ", ", ")
	test.equals(2, only_split:size())
	test.equals("", only_split:get(0))
	
	local splitted = stringutil.split("test, something, value, to", ", ")
	test.equals(4, splitted:size())
	test.equals("test", splitted:get(0))
	test.equals("something", splitted:get(1))
	test.equals("value", splitted:get(2))
	test.equals("to", splitted:get(3))
	
	local params = stringutil.split("-100 100 /some/path/", " ")
	test.equals(3, params:size())
	test.equals("-100", params:get(0))
	test.equals("100", params:get(1))
	test.equals("/some/path/", params:get(2))
end)

