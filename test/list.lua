
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/list.lua")
dofile("./utils/mathutil.lua")


test.start("list")

test.run("add", function()
	local list = List:new()
	
	list:add("a")
	list:add("b")
	list:add("c")
	
	list:add("d", "e", "f")
	
	test.equals(6, list:size())
	
	test.equals("a", list:get(0))
	test.equals("b", list:get(1))
	test.equals("c", list:get(2))
	test.equals("d", list:get(3))
	test.equals("e", list:get(4))
	test.equals("f", list:get(5))
end)

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

test.run("one_indexed", function()
	local list = List:new(true)
	
	list:add("a")
	list:add("b")
	list:add("c")
	
	test.equals(nil, list:get(0))
	test.equals("a", list:get(1))
	test.equals("b", list:get(2))
	test.equals("c", list:get(3))
	
	local table = list:to_table()
	
	test.equals(nil, table[0])
	test.equals("a", table[1])
	test.equals("b", table[2])
	test.equals("c", table[3])
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

