
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/list.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/tableutil.lua")


test.start("list")

test.run("add", function()
	local list = List:new("a", "b")
	
	list:add("c")
	
	list:add("d", "e", "f")
	
	test.equals(6, list:size())
	
	test.equals("a", list:get(1))
	test.equals("b", list:get(2))
	test.equals("c", list:get(3))
	test.equals("d", list:get(4))
	test.equals("e", list:get(5))
	test.equals("f", list:get(6))
end)

test.run("add_list", function()
	local list = List:new("a", "b")
	local list_b = List:new("c", "d")
	local list_c = List:new("e", "f")
	
	list:add_list(list_b, list_c)
	
	test.equals(6, list:size())
	
	test.equals("a", list:get(1))
	test.equals("b", list:get(2))
	test.equals("c", list:get(3))
	test.equals("d", list:get(4))
	test.equals("e", list:get(5))
	test.equals("f", list:get(6))
end)

test.run("clear", function()
	local list = List:new("a", "b", "c")
	
	test.equals(3, list:size())
	
	list:clear()
	
	test.equals(0, list:size())
end)

test.run("cull_duplicates", function()
	local list = List:new("a", "a", "b", "a", "c", "a", "b", "c", "d", "a", "c", "a", "a", "a")
	
	test.equals(14, list:size())
	
	list:cull_duplicates()
	
	test.equals(4, list:size())
	test.equals("a", list:get(1))
	test.equals("b", list:get(2))
	test.equals("c", list:get(3))
	test.equals("d", list:get(4))
end)

test.run("foreach", function()
	local list = List:new(1, 2, 3, 4)
	
	local counter = 1
	
	list:foreach(function(item, index)
		test.equals(counter, item)
		test.equals(counter, index)
		counter = counter + 1
	end)
	
	test.equals(5, counter)
	
	counter = 1
	
	list:foreach(function(item, index)
		test.equals(counter, item)
		test.equals(counter, index)
		counter = counter + 1
		
		if counter == 2 then
			return true
		end
	end)
	
	test.equals(2, counter)
end)

test.run("get", function()
	local list = List:new("a", "b", "c")
	
	test.equals("a", list:get(1))
	test.equals("b", list:get(2))
	test.equals("c", list:get(3))
end)

test.run("get_first", function()
	local list = List:new(1, 2, 3, 4, 5, 6, 7, 8, 9)
	
	test.equals(2, list:get_first(function(value)
		return math.fmod(value, 2) == 0
	end))
	test.equals(5, list:get_first(function(value)
		return value == 5
	end))
	test.equals(nil, list:get_first(function(value)
		return value == 37
	end))
	
	test.equals(1, list:get_first())
end)

test.run("get_last", function()
	local list = List:new(1, 2, 3, 4, 5, 6, 7, 8, 9)
	
	test.equals(8, list:get_last(function(value)
		return math.fmod(value, 2) == 0
	end))
	test.equals(5, list:get_last(function(value)
		return value == 5
	end))
	test.equals(nil, list:get_last(function(value)
		return value == 37
	end))
	
	test.equals(9, list:get_last())
end)

test.run("index", function()
	local list = List:new("a", "b", "c", "d", "e")
	
	test.equals(1, list:index("a"))
	test.equals(3, list:index("c"))
	test.equals(5, list:index("e"))
	
	test.equals(-1, list:index(" "))
	test.equals(-1, list:index("f"))
end)

test.run("invoke", function()
	local list = List:new()
	
	local a_invoked = nil
	local b_invoked = nil
	local c_invoked = nil
	
	list:add(function(parama, paramb, paramc)
		a_invoked = (parama ~= nil)
			and (paramb ~= nil)
			and (paramc ~= nil)
	end)
	list:add(function(parama, paramb, paramc)
		b_invoked = (parama ~= nil)
			and (paramb ~= nil)
			and (paramc ~= nil)
	end)
	list:add(function(parama, paramb, paramc)
		c_invoked = (parama ~= nil)
			and (paramb ~= nil)
			and (paramc ~= nil)
	end)
	
	list:invoke(5, 6, 7)
	
	test.equals(true, a_invoked)
	test.equals(true, b_invoked)
	test.equals(true, c_invoked)
end)

test.run("is_empty", function()
	local list = List:new()
	
	test.equals(true, list:is_empty())
	
	list:add("value")
	
	test.equals(false, list:is_empty())
	
	list:clear()
	
	test.equals(true, list:is_empty())
end)

test.run("matching", function()
	local list = List:new("a", "b", "c", "d", "e")
	
	local found = list:matching(function(item)
		return item == "a" or item == "d"
	end)
	
	test.equals(2, found:size())
	test.equals("a", found:get(1))
	test.equals("d", found:get(2))
end)

test.run("remove", function()
	local list = List:new("a", "b", "c", "d", "e")
	
	list:remove("b", "d", "e")
	
	test.equals(2, list:size())
	test.equals("a", list:get(1))
	test.equals("c", list:get(2))
	test.equals(nil, list:get(3))
end)

test.run("remove_index", function()
	local list = List:new("a", "b", "c", "d", "e")
	
	list:remove_index(3)
	
	test.equals(4, list:size())
	test.equals("a", list:get(1))
	test.equals("b", list:get(2))
	test.equals("d", list:get(3))
	test.equals("e", list:get(4))
	test.equals(nil, list:get(5))
	
	list:remove_index(1, 3, 4)
	
	test.equals(1, list:size())
	test.equals("b", list:get(1))
end)

test.run("return_first", function()
	local list = List:new()
	
	list:add(function()
		return nil
	end)
	list:add(function()
		return nil
	end)
	list:add(function(value)
		return "a" .. value
	end)
	list:add(function(value)
		return "b" .. value
	end)
	list:add(function()
		return nil
	end)
	
	test.equals("ac", list:return_first(List.ACCEPT_NON_NIL, "c"))
end)

test.run("return_last", function()
	local list = List:new()
	
	list:add(function()
		return nil
	end)
	list:add(function()
		return nil
	end)
	list:add(function(value)
		return "a" .. value
	end)
	list:add(function(value)
		return "b" .. value
	end)
	list:add(function()
		return nil
	end)
	
	test.equals("bc", list:return_last(List.ACCEPT_NON_NIL, "c"))
end)

test.run("sort", function()
	local list = List:new("y", "n", "m", "b", "e", "a")
	
	list:sort()
	
	test.equals("a", list:get(1))
	test.equals("b", list:get(2))
	test.equals("e", list:get(3))
	test.equals("m", list:get(4))
	test.equals("n", list:get(5))
	test.equals("y", list:get(6))
end)

test.run("sub_list", function()
	local list = List:new("a", "b", "c", "d", "e")
	
	local sub = list:sub_list(2, 3)
	test.equals(3, sub:size())
	test.equals("b", sub:get(1))
	test.equals("c", sub:get(2))
	test.equals("d", sub:get(3))
	
	sub = list:sub_list(4, 4)
	test.equals(2, sub:size())
	test.equals("d", sub:get(1))
	test.equals("e", sub:get(2))
	
	sub = list:sub_list(-3, 6)
	test.equals(2, sub:size())
	test.equals("a", sub:get(1))
	test.equals("b", sub:get(2))
end)

test.run("to_table", function()
	local list = List:new(1, 2, 3, 4)
	
	local table = list:to_table()
	
	test.equals(1, table[1])
	test.equals(2, table[2])
	test.equals(3, table[3])
	test.equals(4, table[4])
end)

