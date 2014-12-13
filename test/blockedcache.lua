
-- Load the test file.
dofile("../utils/test.lua")

-- Load the file for testing.
dofile("../utils/blockedcache.lua")


local function test_basic()
	local cache = BlockedCache:new()
	
	cache:put(0, 0, "a")
	
	test.equals(true, cache:is_cached(0, 0))
	test.equals("a", cache:get(0, 0))
end

local function test_auto_compacting()
	local cache = BlockedCache:new(5, true)

	cache:put(0, 0, "a")
	cache:put(1, 1, "b")
	cache:put(2, 2, "c")
	cache:put(3, 3, "d")
	cache:put(4, 4, "e")
	cache:put(5, 5, "f")
	cache:put(6, 6, "g")
	cache:put(7, 7, "h")
	cache:put(8, 8, "i")
	cache:put(9, 9, "j")

	test.equals(false, cache:is_cached(0, 0))
	test.equals(false, cache:is_cached(1, 1))
	test.equals(false, cache:is_cached(2, 2))
	test.equals(false, cache:is_cached(3, 3))
	test.equals(false, cache:is_cached(4, 4))
	test.equals(true, cache:is_cached(5, 5))
	test.equals(true, cache:is_cached(6, 6))
	test.equals(true, cache:is_cached(7, 7))
	test.equals(true, cache:is_cached(8, 8))
	test.equals(true, cache:is_cached(9, 9))

	test.equals("f", cache:get(5, 5))
	test.equals("g", cache:get(6, 6))
	test.equals("h", cache:get(7, 7))
	test.equals("i", cache:get(8, 8))
	test.equals("j", cache:get(9, 9))
end


test.start("BlockedCache")
test.run("auto_compacting", test_auto_compacting)
test.run("basic", test_basic)

