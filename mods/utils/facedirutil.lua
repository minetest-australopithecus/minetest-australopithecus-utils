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


--- Various functions and constants for working with the facedir value.
facedirutil = {
	--- Attached to the node in the negative x direction.
	NEGATIVE_X = 3,
	
	--- Attached to the node in the negative z direction.
	NEGATIVE_Z = 2,
	
	--- The vector for the negative x direction.
	NEGATIVE_X_VECTOR = {
		x = -1,
		y = 0,
		z = 0
	},
	
	--- The vector for the negative z direction.
	NEGATIVE_Z_VECTOR = {
		x = 0,
		y = 0,
		z = -1
	},
	
	--- Attached to the node in the positive x direction.
	POSITIVE_X = 1,
	
	--- Attached to the node in the positive z direction.
	POSITIVE_Z = 0,
	
	--- The vector for the positive x direction.
	POSITIVE_X_VECTOR = {
		x = 1,
		y = 0,
		z = 0
	},
	
	--- The vector for the positive z direction.
	POSITIVE_Z_VECTOR = {
		x = 0,
		y = 0,
		z = 1
	}
}


--- Gets the vector for the given ID.
--
-- @param id The ID for which to get the vector.
-- @return The vector for the given ID.
function facedirutil.get_vector(id)
	if id == facedirutil.NEGATIVE_X then
		return facedirutil.NEGATIVE_X_VECTOR
	elseif id == facedirutil.NEGATIVE_Z then
		return facedirutil.NEGATIVE_Z_VECTOR
	elseif id == facedirutil.POSITIVE_X then
		return facedirutil.POSITIVE_X_VECTOR
	elseif id == facedirutil.POSITIVE_Z then
		return facedirutil.POSITIVE_Z_VECTOR
	end
	
	return facedirutil.NEGATIVE_X_VECTOR
end

--- Turns the placed node upside down if the placer was looking at
-- the underside of another node or did look steep upwards. This function is
-- supposed to be attached to the after_node_place callback of a node
-- definition.
--
-- @param pos The position of the placed node.
-- @param placer The placed, a Player object.
-- @param itemstack The user ItemStack.
-- @param pointed_thing The nodes that the placed pointed at.
function facedirutil.make_upsidedown(pos, placer, itemstack, pointed_thing)
	-- Check if the placer did look at the underside of a node
	-- or looked quite steep up.
	if (pos.y == pointed_thing.under.y - 1
		and pos.x == pointed_thing.under.x
		and pos.z == pointed_thing.under.z)
		or placer:get_look_pitch() > 0.45 then
		
		local placed_node = minetest.get_node(pos)
		
		-- We need to rotate the node by 180 degrees for these values,
		-- this is becaus if how the rotation works.
		if placed_node.param2 == facedirutil.POSITIVE_X
			or placed_node.param2 == facedirutil.NEGATIVE_X then
			
			placed_node.param2 = rotationutil.increment(placed_node.param2)
			placed_node.param2 = rotationutil.increment(placed_node.param2)
		end
		
		placed_node.param2 = placed_node.param2 + rotationutil.NEG_Y
		
		minetest.set_node(pos, placed_node)
	end
end

--- Gets the corresponding wallmounted value for the given facedir value.
--
-- @param facedir_id The facedir value/ID.
-- @return The wallmounted value/ID.
function facedirutil.to_wallmounted(facedir_id)
	if facedir_id == facedirutil.NEGATIVE_X then
		return wallmountedutil.NEGATIVE_X
	elseif facedir_id == facedirutil.NEGATIVE_Z then
		return wallmountedutil.NEGATIVE_Z
	elseif facedir_id == facedirutil.POSITIVE_X then
		return wallmountedutil.POSITIVE_X
	elseif facedir_id == facedirutil.POSITIVE_Z then
		return wallmountedutil.POSITIVE_Z
	end
	
	return wallmountedutil.NEGATIVE_Y
end

