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
-- @param one_indexed Optional. true if the list should be one indexed instead
--                    of zero indexed.
-- @return A new instance of List.
function List:new(one_indexed)
	local instance = {
		base = 0,
		counter = 0,
		items = {}
	}
	
	if one_indexed then
		instance.base = 1
		instance.counter = 1
	end
	
	setmetatable(instance, self)
	self.__index = self
	
	return instance
end


--- Adds the given item to the list.
--
-- @param ... The items to add.
function List:add(...)
	for idx, value in ipairs({...}) do
		self.items[self.counter] = value
		self.counter = self.counter + 1
	end
end

--- Clears all entries from the list.
function List:clear()
	self.counter = self.base
	self.items = {}
end

--- Checks if this list contains the given item.
--
-- @param item The item to search for.
-- @return true if this list contains the given item.
function List:contains(item)
	return self:index(item) >= 0
end

--- Iterates over all items in the list and invokes the given action on them.
--
-- @param action The function to invoke on the item, the first parameter will be
--               the item itself, the second (optional) parameter is the index.
function List:foreach(action)
	for index = self.base, self.counter - 1, 1 do
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

--- Returns the index of the given item.
--
-- @param item The item for which to get the index.
-- @param equals Optional. The equals function to use.
-- @return The index of the given item. -1 if this item is not in this list.
function List:index(item, equals)
	equals = equals or function(a, b)
		return a == b
	end
	
	for index = self.base, self.counter - 1, 1 do
		if equals(self.items[index], item) then
			return index
		end
	end
	
	return -1
end

--- Returns a List with all items that match the given condition.
--
-- @param condition The condition, a function that accepts one parameter,
--                  the item, and returns a boolean.
-- @return The List of matching items.
function List:matching(condition)
	local found = List:new(self.base == 1)
	
	for index = self.base, self.counter - 1, 1 do
		local item = self.items[index]
		
		if condition(item) then
			found:add(item)
		end
	end
	
	return found
end

--- Gets the size of the list.
--
-- @return The size of the list.
function List:size()
	return self.counter
end

--- Gets a sub list starting from the given index and the given number of items.
--
-- @param from The starting index.
-- @param count The count of items to get.
-- @return A List containing the items starting by the given index. The List
--         will be empty if the starting index is out of range, if there are not
--         as many items as specified with count, all items that there are will
--         be returned.
function List:sub_list(from, count)
	local sub = List:new()
	
	for index = math.max(from, self.base), math.min(from + count - 1, self.counter - 1), 1 do
		sub:add(self.items[index])
	end
	
	return sub
end

--- Turns this list into a table, the return table will be a zero indexed array,
-- and can freely be modified as it is not the table used by this instance.
-- However the items in the returned table are not copies.
--
-- @return This list as table.
function List:to_table()
	local table = {}
	
	self:foreach(function(item, index)
		table[index] = item
	end)
	
	return table
end

