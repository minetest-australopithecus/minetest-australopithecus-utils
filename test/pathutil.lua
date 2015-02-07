
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/pathutil.lua")
dofile("./utils/stringutil.lua")


test.start("pathutil")

test.run("concat", function()
	test.equals("", pathutil.concat(nil))
	
	test.equals("", pathutil.concat(""))
	
	test.equals("a/b/c", pathutil.concat("a", "b", "c"))
	test.equals("a/b/c", pathutil.concat("a", "b", "c"))
	test.equals("/home/some/file.text", pathutil.concat("/home", "some", "file.text"))
	test.equals("/home/some/file.text", pathutil.concat("/home/", "/some/", "/file.text"))
end)

