--[[
Copyright (c) 2015, Robert 'Bobby' Zenz
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


--- A util for working with inventories.
inventoryutil = {}


--- Test if the given inventory equals the given hash.
--
-- @param inventory The InvRef object.
-- @param name The name of the inventory.
-- @param hash The hash.
-- @param true If the inventory equals the hash.
function inventoryutil.equals_hash(inventory, name, hash)
	if hash == nil then
		return false
	end
	
	for index = 1, inventory:get_size(name), 1 do
		local stack = inventory:get_stack(name, index)
		local item_hash = hash[index]
		
		if not stack:is_empty()  then
			if item_hash.id ~= minetest.get_content_id(stack:get_name()) or item_hash.count ~= stack:get_count() then
				return false
			end
		else
			if item_hash.id ~= 0 or item_hash.count ~= 0 then
				return false
			end
		end
	end
	
	return true
end

--- Creates a hash for the given inventory.
-- The hash is a 2D table containing the ID and the stack count of all items.
--
-- @param inventory The InvRef object.
-- @param name The name of the inventory.
-- @return The hash.
function inventoryutil.hash(inventory, name)
	local hash = {}
	
	for index = 1, inventory:get_size(name), 1 do
		local stack = inventory:get_stack(name, index)
		
		if not stack:is_empty()  then
			hash[index] = {
				id = minetest.get_content_id(stack:get_name()),
				count = stack:get_count()
			}
		else
			hash[index] = {
				id = 0,
				count = 0
			}
		end
	end
	
	return hash
end

