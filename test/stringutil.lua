
-- Load the test file.
dofile("../utils/test.lua")

-- Load the file for testing.
dofile("../utils/stringutil.lua")

dofile("../utils/log.lua")

local function test_concat()
	test.equals("", stringutil.concat(nil))
	
	test.equals("", stringutil.concat(""))
	
	test.equals("abc", stringutil.concat("a", "b", "c"))
	test.equals("a9true5.55", stringutil.concat("a", 9, true, 5.55))
end


test.start("stringutil")
test.run("concat", test_concat)

