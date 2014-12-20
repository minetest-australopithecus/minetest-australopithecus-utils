
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/tableutil.lua")


test.start("tableutil")

test.run("clone", function()
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

