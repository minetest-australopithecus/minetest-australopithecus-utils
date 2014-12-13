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


--- Various mathematical functions.
mathutil = {}


--- Clamps one value to the given minimum/maximum values. Defaults to
-- 0 to 1 if min/max are omitted.
--
-- @param value The value to clamp.
-- @param min Optional. The minimum value, defaults to 0.
-- @param max Optional. The masximum value, defaults to 1.
-- @return The value clamped to the given range.
function mathutil.clamp(value, min, max)
	if min == nil or max == nil then
		return math.min(math.max(value, -1), 1)
	else
		return math.min(math.max(value, min), max)
	end
end

--- Gets the next lower prime from the given number.
--
-- @param number The number.
-- @return The next lower prime.
function mathutil.next_lower_prime(number)
	for lower = number, 0, -1 do
		if (lower <= 2 or math.fmod(lower, 2) ~= 0)
			and (lower <= 3 or math.fmod(lower, 3) ~= 0)
			and (lower <= 5 or math.fmod(lower, 5) ~= 0)
			and (lower <= 7 or math.fmod(lower, 7) ~= 0) then
			
			return lower
		end	
	end
	
	return 0
end

--- Rounds to the nearest number with the given decimal places.
--
-- @param value The value to round.
-- @param decimal_places Optional. The number of decimal places to round to,
--                       defaults to 0.
-- @return The rounded value.
function mathutil.round(value, decimal_places)
	decimal_places = decimal_places or 0
	
	local multiplicator = 10 ^ decimal_places
	return math.floor(value * multiplicator + 0.5) / multiplicator
end

