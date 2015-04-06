
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/tableutil.lua")
dofile("./utils/mathutil.lua")
dofile("./utils/list.lua")

test.start("tableutil")


test.run("clone_list", function()
	local list = List:new()
	list:add(0, 1, 2, 3, 4, 5)
	
	local clone = tableutil.clone(list)
	
	test.equals(true, list ~= clone)
	
	list:clear()
	
	test.equals(false, clone == nil)
	test.equals(6, clone:size())
	test.equals(0, clone:get(0))
	test.equals(1, clone:get(1))
	test.equals(2, clone:get(2))
	test.equals(3, clone:get(3))
	test.equals(4, clone:get(4))
	test.equals(5, clone:get(5))
end)

test.run("clone_object", function()
	local object = {
		table = {
			something = "string"
		},
		value = 5,
		
		action = function()
			return true
		end
	}
	
	local clone = tableutil.clone(object)
	
	test.equals(true, object ~= clone)
	test.equals(false, clone == nil)
end)

test.run("clone_table", function()
	local original = {
		int = 5,
		string = "test",
		table = {
			deep = "test"
		}
	}
	
	local clone = tableutil.clone(original)
	
	test.equals(true, original ~= clone)
	
	original.int = 7
	test.equals(7, original.int)
	test.equals(5, clone.int)
	
	original.string = "a"
	test.equals("a", original.string)
	test.equals("test", clone.string)
	
	original.table.deep = "a"
	test.equals("a", original.table.deep)
	test.equals("test", clone.table.deep)
end)

test.run("merge", function()
	local tablea = {
		null = nil,
		int = 5,
		value = "something"
	}
	
	local tableb = {
		bool = true,
		value = "overriden",
		new_value = "new"
	}
	
	local merged = tableutil.merge(tablea, tableb)
	
	test.equals(merged.null, nil)
	test.equals(merged.int, 5)
	test.equals(merged.bool, true)
	test.equals(merged.value, "overriden")
	test.equals(merged.new_value, "new")
end)

