
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/list.lua")
dofile("./mods/utils/tableutil.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/list.lua")


test.start("tableutil")


test.run("clone_list", function()
	local list = List:new()
	list:add(1, 2, 3, 4, 5, 6)
	
	local clone = tableutil.clone(list)
	
	test.equals(true, list ~= clone)
	
	list:clear()
	
	test.equals(false, clone == nil)
	test.equals(6, clone:size())
	test.equals(1, clone:get(1))
	test.equals(2, clone:get(2))
	test.equals(3, clone:get(3))
	test.equals(4, clone:get(4))
	test.equals(5, clone:get(5))
	test.equals(6, clone:get(6))
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

test.run("comparator", function()
	test.equals(false, tableutil.comparator(nil, nil))
	test.equals(false, tableutil.comparator(5, nil))
	test.equals(true, tableutil.comparator(nil, 6))
	test.equals(false, tableutil.comparator("a", nil))
	test.equals(true, tableutil.comparator(nil, "b"))
	test.equals(false, tableutil.comparator({}, nil))
	test.equals(true, tableutil.comparator(nil, {}))
	
	test.equals(true, tableutil.comparator(1, 2))
	test.equals(false, tableutil.comparator(2, 1))
	
	test.equals(true, tableutil.comparator("a", "b"))
	test.equals(false, tableutil.comparator("b", "a"))
	
	local unsorted = {
		"Something",
		5,
		"a",
		567,
		{ a = "a" },
		23,
		"Value",
		{ b = "b" }
	}
	
	local sorted = {
		5,
		23,
		567,
		"Something",
		"Value",
		"a",
		{ a = "a" },
		{ b = "b" }
	}
	
	table.sort(unsorted, tableutil.comparator)
	
	test.equals(sorted, unsorted)
end)

test.run("equals", function()
	test.equals(true, tableutil.equals(nil, nil))
	
	test.equals(false, tableutil.equals(1, nil))
	test.equals(false, tableutil.equals(nil, 1))
	
	test.equals(true, tableutil.equals(1, 1))
	test.equals(true, tableutil.equals("string", "string"))
	
	local a = {
		int = 5,
		string = "test",
		table = {
			deep = "test2"
		}
	}
	
	local b = {
		int = 5,
		string = "test",
		table = {
			deep = "test2"
		}
	}
	
	test.equals(true, tableutil.equals(a, b))
	test.equals(true, tableutil.equals(b, a))
	
	b.table.deep = "different"
	
	test.equals(false, tableutil.equals(a, b))
	test.equals(false, tableutil.equals(b, a))
	
	b.table.deep = "test2"
	b.table.different = "different"
	
	test.equals(false, tableutil.equals(a, b))
	test.equals(false, tableutil.equals(b, a))
end)

test.run("keys", function()
	local a = {
		int = 5,
		string = "test",
		table = {
			deep = "test"
		}
	}
	
	local b = {
		int = 7,
		newkey = false
	}
	
	local keys = tableutil.keys(a, b)
	
	test.equals(4, keys:size())
	test.equals(true, keys:contains("int"))
	test.equals(true, keys:contains("string"))
	test.equals(true, keys:contains("table"))
	test.equals(true, keys:contains("newkey"))
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

