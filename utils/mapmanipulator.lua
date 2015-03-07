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


--- The MapManipulator is a thin wrapper around the VoxelManip object
-- provided by minetest. It only capsules the VoxelManip and VoxelArea behind
-- a few functions to minimize code.
MapManipulator = {}


--- Creates a new instance of MapManipulator.
--
-- @return A new instance.
function MapManipulator:new()
	local instance = {
		area = nil,
		data = nil,
		emax = nil,
		emin = nil,
		voxelmanip = nil
	}
	
	instance.voxelmanip, instance.emin, instance.emax = minetest.get_mapgen_object("voxelmanip")
	instance.area = VoxelArea:new({
		MinEdge = instance.emin,
		MaxEdge = instance.emax
	})
	
	setmetatable(instance, self)
	self.__index = self
	
	return instance
end


--- Gets the VoxelArea for the current VoxelManip.
--
-- @return The VoxelArea.
function MapManipulator:get_area()
	return self.area
end

--- Gets the data from the VoxelManip object.
-- The data is an array that can be accessed by using the VoxelArea object.
--
-- @return The data.
function MapManipulator:get_data()
	if self.data == nil then
		self.data = self.voxelmanip:get_data()
	end
	
	return self.data
end

--- Gets the node at the given location.
--
-- @param x The x coordinate (width).
-- @param z the z coordinate (depth).
-- @param y The y coordinate (height).
-- @return The node at the given location.
function MapManipulator:get_node(x, z, y)
	if self.data == nil then
		self.data = self.voxelmanip:get_data()
	end
	
	local index = self.area:index(x, y, z)
	
	return self.data[index]
end

--- Sets the data into the VoxelManip object.
-- Will also correct and update the lighting, the liquids and flush the map.
--
-- @param data Optional. The data to set. If nil the cached data will be used.
function MapManipulator:set_data(data)
	if data ~= nil then
		self.voxelmanip:set_data(data)	
	elseif self.data ~= nil then
		self.voxelmanip:set_data(self.data)
	else
		return
	end

	self.voxelmanip:set_lighting({
		day = 1,
		night = 0
	})
	self.voxelmanip:calc_lighting()
	self.voxelmanip:update_liquids()
	self.voxelmanip:write_to_map()
	self.voxelmanip:update_map()
	
	self.data = nil
end

--- Sets the node at the given location.
--
-- @param x The x coordinate (width).
-- @param z the z coordinate (depth).
-- @param y The y coordinate (height).
-- @param node The node to set.
function MapManipulator:set_node(x, z, y, node)
	if self.data == nil then
		self.data = self.voxelmanip:get_data()
	end
	
	local index = self.area:index(x, y, z)
	
	self.data[index] = node
end

