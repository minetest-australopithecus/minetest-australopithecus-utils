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


--- The Scatterer is a (simple) object that allows to scatter objects in
-- a 2D plane.
Scatterer = {}


function Scatterer:new()
	local instance = {
		height = 0,
		items_counter = 0,
		items = {},
		minx = 0,
		miny = 0,
		offset = 0,
		scattered_items = nil,
		source = nil,
		width = 0
	}
	
	setmetatable(instance, self)
	self.__index = self
	
	return instance
end


function Scatterer:check(origin_x, origin_y, item)
	if item.min_distance == nil and item.max_distance == nil then
		return true
	end
	
	local distance = item.min_distance or 0
	if item.max_distance ~= nil then
		distance = math.random(distance, item.max_distance)
	end
	
	for x = origin_x - distance, origin_x + distance, 1 do
		for y = origin_y - distance, origin_y + distance, 1 do
			if x ~= origin_x or y ~= origin_y then
				local index = noiseutil.index2d(x, y, self.width)
			
				if self.scattered_items[index] == item then
					return false
				end
			end
		end
	end
	
	return true
end

function Scatterer:get(x, y)
	x = math.abs(x - self.minx)
	y = math.abs(y - self.miny)
	
	return self.scattered_items[noiseutil.index2d(x, y, self.width) + self.offset]
end

function Scatterer:get_item(x, y, value)
	for idx = 0, self.items_counter - 1, 1 do
		local item = self.items[idx]
		if (item.threshold == nil or value >= item.threshold)
			and (item.probability == nil or self:next_random_probability() <= item.probability)
			and self:check(x, y, item) then
			return item
		end
	end
	
	return nil
end

function Scatterer:init(source, minx, miny, width, height, offset)
	self.source = source
	self.minx = minx or 0
	self.miny = miny or 0
	self.width = width or 112
	self.height = height or 112
	self.offset = offset or 0
	
	self.scattered_items = {}
	
	local max_counter = self.width * self.height - 1
	
	local numbers = {}
	
	for counter = self.offset, max_counter + self.offset, 1 do
		numbers[counter] = counter
	end
	
	for counter = self.offset, max_counter + self.offset, 1 do
		local swap_index = math.random(counter, max_counter + self.offset)
		
		local temp = numbers[counter]
		numbers[counter] = numbers[swap_index]
		numbers[swap_index] = temp
		
		local number = numbers[counter]
		local x = math.fmod(number, self.width)
		local y = math.floor(number / self.width)
		local index = noiseutil.index2d(x, y, self.width)
		local value = 1
		
		if self.source ~= nil then
			value = self.source[index]
		end
		
		self.scattered_items[index] = self:get_item(x, y, value)
	end
end

function Scatterer:next_random_probability()
	return (10000 - math.random(0, 10000)) / 10000
end

function Scatterer:register(item)
	self.items[self.items_counter] = item
	self.items_counter = self.items_counter + 1
end

