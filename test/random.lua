
-- Load the test file.
dofile("./mods/utils/test.lua")

-- Load the file for testing.
dofile("./mods/utils/random.lua")
dofile("./mods/utils/mathutil.lua")
dofile("./mods/utils/tableutil.lua")


-- The following tests are neither perfect nor well formed,
-- but they make sure the code is run and is kinda working.


test.start("random")


test.run("next_boolean", function()
	for counter = 0, 1000, 1 do
		test.equals(true, random.next_bool(1), "next_bool(1) returned false.")
	end
	
	local trues = 0
	for counter = 0, 1000, 1 do
		if random.next_bool() then
			trues = trues + 1
		end
	end
	
	test.equals(false, trues > 750, "next_bool() returned more than 3/4 (" .. trues .. ") as true.")
	test.equals(false, trues < 250, "next_bool() returned less than 1/4 (" .. trues .. ") as true.")
	
	trues = 0
	for counter = 0, 1000, 1 do
		if random.next_bool(5) then
			trues = trues + 1
		end
	end
	
	test.equals(false, trues > 250, "next_bool() returned more than 250 (" .. trues .. ") as true.")
	test.equals(false, trues < 50, "next_bool() returned less than 50 (" .. trues .. ") as true.")
end)

test.run("next_float", function()
	for counter = 0, 1000, 1 do
		local value = random.next_float(0, 15)
		test.equals(true, mathutil.in_range(value, 0, 14.9999999999999), value .. " is not in range 0-14.999...")
	end
	for counter = 0, 1000, 1 do
		local value = random.next_float(0.25, 0.5)
		test.equals(true, mathutil.in_range(value, 0.25, 0.49999999999), value .. " is not in range 0.25-0.4999...")
	end
	
	for counter = 0, 1000, 1 do
		local value = random.next_float(0, 1.0, 2)
		test.equals(value, mathutil.round(value, 2), value .. " has more than 2 decimal places.")
	end
end)

test.run("next_int", function()
	for counter = 0, 1000, 1 do
		local value = random.next_int(0, 15)
		test.equals(true, mathutil.in_range(value, 0, 14), value .. " is not in range 0-14.")
	end
	for counter = 0, 1000, 1 do
		local value = random.next_int(15, 30)
		test.equals(true, mathutil.in_range(value, 15, 29), value .. " is not in range 15-29.")
	end
end)

