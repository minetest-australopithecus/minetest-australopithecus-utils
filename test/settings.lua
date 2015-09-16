
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/list.lua")
dofile("./utils/mathutil.lua")
dofile("./utils/settings.lua")
dofile("./utils/stringutil.lua")
dofile("./utils/tableutil.lua")


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

