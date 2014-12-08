--[[
Copyright (c) 2014, Robert 'Bobby' Zenz
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]


--- A simple utility for testing values.
test = {}


--- Test if the given value matches the given expected value.
-- If the values do not match, an error with the given message (if any) and
-- an additional message containing both values will be shown.
--
-- The values will be compared with ==.
--
-- @param expected The expected value.
-- @param actual The actual value.
-- @param message Optional. The additional message to be printed.
function test.equals(expected, actual, message)
	message = message or ""
	
	if expected == nil and actual ~= nil then
		error(message .. "\nAssert failed! Expected: <nil> but got <" .. actual .. ">")
	end
	
	if expected ~= nil and actual == nil then
		error(message .. "\nAssert failed! Expected: <" .. expected .. "> but got <nil>")
	end
	
	if expected ~= nil and actual ~= nil then
		assert(expected == actual, message .. "\nAssert failed! Expected <" .. tostring(expected) .. "> but got <" .. tostring(actual) .. ">")
	end
end

