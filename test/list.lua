
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/list.lua")


test.start("list")

test.run("clear", function()
	local list = List:new()
	
	list:add("a")
	list:add("b")
	list:add("c")
	
	test.equals(3, list:size())
	
	list:clear()
	
	test.equals(0, list:size())
end)

test.run("get", function()
	local list = List:new()
	
	list:add("a")
	list:add("b")
	list:add("c")

	test.equals("a", list:get(0))
	test.equals("b", list:get(1))
	test.equals("c", list:get(2))
end)

test.run("foreach", function()
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
end)

test.run("to_table", function()
	local list = List:new()
	
	list:add(0)
	list:add(1)
	list:add(2)
	list:add(3)
	
	local table = list:to_table()
	
	test.equals(0, table[0])
	test.equals(1, table[1])
	test.equals(2, table[2])
	test.equals(3, table[3])
end)

