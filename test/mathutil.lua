
-- Load the test file.
dofile("../utils/test.lua")

-- Load the file for testing.
dofile("../utils/mathutil.lua")


function test_big_linear()
	test.equals(0, mathutil.big_linear(-10))
	test.equals(0.25, mathutil.big_linear(-5))
	test.equals(0.5, mathutil.big_linear(0))
	test.equals(0.75, mathutil.big_linear(5))
	test.equals(1, mathutil.big_linear(10))
end

function test_centered_linear()
	test.equals(0, mathutil.centered_linear(-1))
	test.equals(0.5, mathutil.centered_linear(-0.5))
	test.equals(1, mathutil.centered_linear(0))
	test.equals(0.5, mathutil.centered_linear(0.5))
	test.equals(0, mathutil.centered_linear(1))
end


test_big_linear()
test_centered_linear()

