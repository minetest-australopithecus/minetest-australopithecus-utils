
-- Load the test file.
dofile("./utils/test.lua")

-- Load the file for testing.
dofile("./utils/fisheryates.lua")
dofile("./utils/mathutil.lua")
dofile("./utils/transform.lua")


test.start("fisheryates")

test.run("basic", function()
	local data = {}
	
	for index = 0, 10, 1 do
		data[index] = index
	end
	
	math.randomseed(0)
	
	local counter = 0
	local hits = 0
	
	fisheryates.run(data, 0, 10, math.random, function(item)
		if item == counter then
			hits = hits + 1
		end
		
		counter = counter + 1
	end)
	
	test.equals(false, hits >= 5, "More than 50% of the items did match, this is not good.")
end)

