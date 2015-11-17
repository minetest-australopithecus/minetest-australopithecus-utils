
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/list.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/stringutil.lua")
dofile("./mods/utils/tableutil.lua")


test.start("stringutil")

test.run("concat", function()
	test.equals("", stringutil.concat(nil))
	
	test.equals("", stringutil.concat(""))
	
	test.equals("abc", stringutil.concat("a", "b", "c"))
	test.equals("a9true5.55", stringutil.concat("a", 9, true, 5.55))
end)

test.run("endswith", function()
	test.equals(false, stringutil.endswith(nil, nil))
	test.equals(false, stringutil.endswith("", nil))
	test.equals(false, stringutil.endswith(nil, ""))
	test.equals(true, stringutil.endswith("", ""))
	
	test.equals(true, stringutil.endswith("abcde", "e"))
	test.equals(true, stringutil.endswith("abcde", "cde"))
	test.equals(true, stringutil.endswith("abcde", "abcde"))
	
	test.equals(false, stringutil.endswith("abcde", "ab"))
	test.equals(false, stringutil.endswith("abcde", "abcd"))
end)

test.run("hash", function()
	test.equals(0, stringutil.hash(nil))
	test.equals(0, stringutil.hash(""))
	
	test.equals(97, stringutil.hash("a"))
	test.equals(98, stringutil.hash("b"))
	
	test.equals(303616488, stringutil.hash("Something something something test."))
	
	test.equals(1313428347, stringutil.hash(string.rep("a", 6700)))
end)

test.run("split", function()
	local single = stringutil.split("value", ",")
	test.equals(1, single:size())
	test.equals("value", single:get(1))
	
	local empty = stringutil.split("", ",")
	test.equals(0, empty:size())
	test.equals(nil, empty:get(1))
	
	local only_split = stringutil.split(", ", ",")
	test.equals(2, only_split:size())
	test.equals("", only_split:get(1))
	
	local splitted = stringutil.split("test, something, value, to", ",")
	test.equals(4, splitted:size())
	test.equals("test", splitted:get(1))
	test.equals("something", splitted:get(2))
	test.equals("value", splitted:get(3))
	test.equals("to", splitted:get(4))
	
	local params = stringutil.split("-100 100 /some/path/", " ")
	test.equals(3, params:size())
	test.equals("-100", params:get(1))
	test.equals("100", params:get(2))
	test.equals("/some/path/", params:get(3))
	
	local not_trimmed = stringutil.split("no, trimming , required", ",", false)
	test.equals(3, not_trimmed:size())
	test.equals("no", not_trimmed:get(1))
	test.equals(" trimming ", not_trimmed:get(2))
	test.equals(" required", not_trimmed:get(3))
end)

test.run("startswith", function()
	test.equals(false, stringutil.startswith(nil, nil))
	test.equals(false, stringutil.startswith("", nil))
	test.equals(false, stringutil.startswith(nil, ""))
	test.equals(true, stringutil.startswith("", ""))
	
	test.equals(true, stringutil.startswith("abcde", "a"))
	test.equals(true, stringutil.startswith("abcde", "abc"))
	test.equals(true, stringutil.startswith("abcde", "abcde"))
	
	test.equals(false, stringutil.startswith("abcde", "b"))
	test.equals(false, stringutil.startswith("abcde", "bcde"))
end)

test.run("trim", function()
	test.equals(nil, stringutil.trim(nil))
	test.equals("", stringutil.trim(""))
	test.equals("", stringutil.trim(" 	 	"))
	
	test.equals("Something", stringutil.trim("  Something	"))
	test.equals("A whole sentence this is.", stringutil.trim("  A whole sentence this is.   "))
end)

