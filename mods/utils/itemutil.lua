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


--- Provides various utility functions for working with items.
itemutil = {}


--- "Blops" the item into existence at the given position and assigns it
-- a random velocity/acceleration.
--
-- @param position_or_object The position, a pos value or an ObjectRef.
-- @param itemstring_or_stack The item string or an ItemStack.
-- @param x_strength Optional. The strength of the random movement in
--                   the x direction, defaults to 5.
-- @param y_strength Optional. The strength o the random movement in
--                   the y direction, defaults to 5, minimum is 1.
-- @param z_strength Optional. The strength of the random movement in
--                   the z direction, defaults to 5.
-- @return The spawned item.
function itemutil.blop(position_or_object, itemstring_or_stack, x_strength, y_strength, z_strength)
	x_strength = x_strength or 5
	y_strength = math.max(y_strength or 5, 1)
	z_strength = z_strength or 5
	
	local position = position_or_object
	if type(position.getpos) == "function" then
		position = position:getpos()
	end
	
	local item = itemstring_or_stack
	if type(itemstring_or_stack.to_string) == "function" then
		item = item:to_string()
	end
	
	local spawned_item = minetest.add_item(position, item)
	
	spawned_item:setvelocity({
		x = random.next_float(-x_strength, x_strength),
		y = random.next_float(1, y_strength),
		z = random.next_float(-z_strength, z_strength)
	})
	
	return spawned_item
end

