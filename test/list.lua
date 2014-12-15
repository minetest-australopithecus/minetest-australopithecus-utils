
-- Load the test file.
dofile("../utils/test.lua")

-- Load the file for testing.
dofile("../utils/list.lua")


local function test_clear()
	local list = List:new()
	
	list:add("a")
	list:add("b")
	list:add("c")
	
	test.equals(3, list:size())
	
	list:clear()
	
	test.equals(0, list:size())
end

local function test_get()
	local list = List:new()
	
	list:add("a")
	list:add("b")
	list:add("c")

	test.equals("a", list:get(0))
	test.equals("b", list:get(1))
	test.equals("c", list:get(2))
end

local function test_foreach()
	local list = List:new()
	
	list:add(0)
	list:add(1)
	list:add(2)
	list:add(3)
	
	local counter = 0
	
	list:foreach(function(item, index)
		test.equals(counter, item)
		test.equals(counter, index)
		counter = counter + 1
	end)
end


test.start("list")
test.run("clear", test_clear)
test.run("get", test_get)
test.run("foreach", test_foreach)

