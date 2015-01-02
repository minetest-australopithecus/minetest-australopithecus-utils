
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
	test.equals("value", single[0])
	
	local empty = stringutil.split("", ", ")
	test.equals(nil, empty[0])
	
	local only_split = stringutil.split(", ", ", ")
	test.equals("", only_split[0])
	
	local splitted = stringutil.split("test, something, value, to", ", ")
	test.equals("test", splitted[0])
	test.equals("something", splitted[1])
	test.equals("value", splitted[2])
	test.equals("to", splitted[3])
end)

