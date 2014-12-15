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


--- A simple list that keeps the order in which the items are added to it.
--
-- Provides the method foreach(action) to allow to easily iterate over all items
-- in the list:
--
-- list:foreach(function(item)
--     print(item)
-- end)
List = {}


--- Creates a new instance of List.
--
-- @return A new instance of List.
function List:new()
	local instance = {
		counter = 0,
		items = {}
	}
	
	setmetatable(instance, self)
	self.__index = self
	
	return instance
end


--- Adds the given item to the list.
--
-- @param item The item to add.
function List:add(item)
	self.items[self.counter] = item
	self.counter = self.counter + 1
end

--- Clears all entries from the list.
function List:clear()
	self.counter = 0
	self.items = {}
end

--- Iterates over all items in the list and invokes the given action on them.
--
-- @param action The function to invoke on the item, the first parameter will be
--               the item itself, the second (optional) parameter is the index.
function List:foreach(action)
	for index = 0, self.counter - 1, 1 do
		action(self.items[index], index)
	end
end

--- Gets the item at the given index. Returns nil if there is no item.
-- Note that there is no different between "no item" and "nil is the item",
-- in both cases nil is returned.
--
-- @param index The index of the item to get.
-- @return The item at the given index. nil if there is no item.
function List:get(index)
	return self.items[index]
end

--- Gets the size of the list.
--
-- @return The size of the list.
function List:size()
	return self.counter
end

