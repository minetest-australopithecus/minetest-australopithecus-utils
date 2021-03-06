
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/list.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/settings.lua")
dofile("./mods/utils/stringutil.lua")
dofile("./mods/utils/tableutil.lua")


minetest = {}
function minetest.setting_get(name)
	if name == "nil" or name == "nonexistent" then
		return nil
	elseif name == "true" or name == "bool-true" then
		return true
	elseif name == "false" or name == "bool-false" then
		return false
	elseif name == "number" then
		return 5
	elseif name == "number-string" then
		return "6"
	elseif name == "float" then
		return 4.38
	elseif name == "float-string" then
		return "7.69"
	elseif name == "string" then
		return "Some String"
	elseif name == "pos2d" then
		return "43.23, 29.89"
	elseif name == "list" then
		return "a, b, c, d, e"
	end
	
	return nil
end
function minetest.setting_getbool(name)
	if name == "nil" or name == "nonexistent" then
		return nil
	elseif name == "true" or name == "bool-true" then
		return true
	elseif name == "false" or name == "bool-false" then
		return false
	end
	
	return nil
end

test.start("settings")

test.run("get", function()
	test.equals(nil, settings.get("nonexistent"))
	test.equals("Default", settings.get("nonexistent", "Default"))
	
	test.equals(true, settings.get("bool-true"))
	test.equals(4.38, settings.get("float"))
	test.equals("Some String", settings.get("string"))
	test.equals("Converted", settings.get("string", nil, function(value)
		return "Converted"
	end))
end)

test.run("get_bool", function()
	test.equals(nil, settings.get_bool("nonexistent"))
	test.equals(true, settings.get_bool("nonexistent", true))
	test.equals(true, settings.get_bool("bool-true"))
end)

test.run("get_list", function()
	test.equals(nil, settings.get_list("nonexistent"))
	test.equals({ "a", "b", "c", "d" }, settings.get_list("nonexistent", { "a", "b", "c", "d" }))
	test.equals({ "a", "b", "c", "d", counter = 5 }, settings.get_list("nonexistent", "a, b, c, d"))
	test.equals({ "a", "b", "c", "d", "e", counter = 6 }, settings.get_list("list", "a, b, c, d"))
end)

test.run("get_number", function()
	test.equals(nil, settings.get_number("nonexistent"))
	test.equals(34.34, settings.get_number("nonexistent", 34.34))
	
	test.equals(4.38, settings.get_number("float"))
	test.equals(7.69, settings.get_number("float-string"))
end)

test.run("get_pos2d", function()
	test.equals(nil, settings.get_pos2d("nonexistent"))
	test.equals({ x = 5, y = 6 }, settings.get_pos2d("nonexistent", { x = 5, y = 6 }))
	
	test.equals({ x = 43.23, y = 29.89 }, settings.get_pos2d("pos2d"))
end)

test.run("get_pos3d", function()
	test.equals(settings.get_pos, settings.get_pos3d)
end)

test.run("get_string", function()
	test.equals(nil, settings.get_string("nonexistent"))
	test.equals("value", settings.get_string("nonexistent", "value"))
	
	test.equals("true", settings.get_string("bool-true"))
	test.equals("4.38", settings.get_string("float"))
	test.equals("Some String", settings.get_string("string"))
end)

test.run("get_table", function()
	test.equals(nil, settings.get_table("nonexistent"))
	test.equals({ a = "b", c = "d" }, settings.get_table("nonexistent", { a = "b", c = "d" }))
	
	test.equals({ a = "a", b = "b", c = "c", d = "d", e = "e" }, settings.get_table("list", nil, "a", "b", "c", "d", "e"))
	test.equals({ a = "a", b = "b", [3] = "c", [4] = "d", [5] = "e" }, settings.get_table("list", nil, "a", "b"))
	test.equals({ a = "a", b = "b", c = "c", d = "d", e = "e" }, settings.get_table("list", nil, "a", "b", "c", "d", "e", "f", "g", "h"))
	
	local convert_function = function(value)
		return tonumber(value) - 10
	end
	
	test.equals({ min = 33.23, max = 19.89 }, settings.get_table("pos2d", nil, { name = "min", convert = convert_function }, { name = "max", convert = convert_function }))
end)

