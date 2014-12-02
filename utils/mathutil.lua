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


--- Various mathemtical functions.
mathutil = {}


--- Performs a linear transform on the given value to transform the value
-- from the range -10/10 to 0/1.
--
-- @param value The value to transform.
-- @param new_min Optional. The minimum value for the new range, defaults to 0.
-- @param new_max Optional. The maximum value for the new range, defaults to 1.
-- @return The transformed value.
function mathutil.big_linear(value, new_min, new_max)
	return mathutil.linear(value, -10, 10, new_min, new_max)
end

--- Performs a linear transformation on the given value with the peak in center
-- of the min and max values.
--
-- @param value The value to transform.
-- @param min Optional. The original minimum value, defaults to -1.
-- @param max Optional. The original maximum value, default to 1.
-- @param new_min Optional. The minimum value for the new range, defaults to 0.
-- @param new_max Optional. The maximum value for the new range, defaults to 1.
function mathutil.centered_linear(value, min, max, new_min, new_max)
	min = min or -1
	max = max or 1
	
	local center = (min + max) / 2
	
	if value < center then
		return mathutil.linear(value, min, center, new_min, new_max)
	else
		return mathutil.linear(value, max, center, new_min, new_max)
	end
end

--- Performs a cosine interpolation with the given offset between the given
-- min and max values.
--
-- @param offset The offset to get, should be between 0 and 1.
-- @param min Optional. The minimum value of the range, defaults to 0.
-- @param max Optional. The maximum value of the range, defaults to 1.
-- @return The interpolated value at the given offset.
function mathutil.cosine(offset, min, max)
	local value = (1 - math.cos(offset * math.pi)) / 2
	
	if min ~= nil and max ~= nil then
		return min * (1 - value) + max * value
	else
		return value
	end
end

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

--- Performs a linear transform on the given value to transform the value
-- from one range to another.
--
-- @param value The value to transform.
-- @param min Optional. The original minimum value of the range, defaults to -1.
-- @param max Optional. The original maximum value of the range, defaults to 1.
-- @param new_min Optional. The minimum value for the new range, defaults to 0.
-- @param new_max Optional. The maximum value for the new range, defaults to 1.
-- @return The transformed value.
function mathutil.linear(value, min, max, new_min, new_max)
	min = min or -1
	max = max or 1
	
	if new_min == nil or new_max == nil then
		return (value - min) / (max - min)
	else
		return (value - min) / (max - min) * (new_max - new_min) + new_min
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

--- Performs a linear transform on the given value to transform the value
-- from the range -1/1 to 0/1.
--
-- @param value The value to transform.
-- @param new_min Optional. The minimum value for the new range, defaults to 0.
-- @param new_max Optional. The maximum value for the new range, defaults to 1.
-- @return The transformed value.
function mathutil.small_linear(value, new_min, new_max)
	return mathutil.linear(value, -1, 1, new_min, new_max)
end

