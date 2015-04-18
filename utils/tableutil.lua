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


--- Various utility functions for working with tables.
tableutil = {}


--- Performs a deep/recursive clone on the given table.
--
-- @param table The table to deep clone.
-- @return The clone of the table.
function tableutil.clone(table)
	if table == nil then
		return nil
	end
	
	if type(table) ~= "table" then
		local clone = table
		return clone
	end
	
	local clone = {}
	
	for key, value in next, table, nil do
		if value ~= table then
			clone[tableutil.clone(key)] = tableutil.clone(value)
		else
			clone[tableutil.clone(key)] = clone
		end
	end
	
	setmetatable(clone, tableutil.clone(getmetatable(table)))
	
	return clone
end

--- Tests the two given tables for equality.
--
-- @param a The first table.
-- @param b The second table.
-- @retunr true if the tables are equal.
function tableutil.equals(a, b)
	if a == b then
		return true
	end
	
	if type(a) ~= "table" or type(b) ~= "table" then
		return a == b
	end
	
	if #a ~= #b then
		return false
	end
	
	local keys = tableutil.keys(a, b):to_table()
	
	for index, key in pairs(keys) do
		local valuea = a[key]
		local valueb = b[key]
		
		if type(valuea) == "table" then
			if not tableutil.equals(valuea, valueb) then
				return false
			end
		else
			if valuea ~= valueb then
				return false
			end		
		end
	end
	
	return true
end

--- Returns a (unique) list with all keys of all tables.
--
-- @param ... The list of tables.
-- @return A list with all keys.
function tableutil.keys(...)
	if ... == nil then
		return {}
	end
	
	local keys = List:new()
	
	for index, table in ipairs({...}) do
		for key, value in pairs(table) do
			if not keys:contains(key) then
				keys:add(key)
			end
		end
	end
	
	return keys
end

--- Merges the given tables into one instance. Note that no cloning is performed
-- so fields may refer to the same instances.
--
-- @param ... The tables to merge.
-- @return The merged table.
function tableutil.merge(...)
	if ... == nil then
		return nil
	end
	
	local merged = {}
	
	for index, table in ipairs({...}) do
		for key, value in next, table, nil do
			merged[key] = value
		end
	end
	
	return merged
end

--- Removes empty rows and columns at the beginning and the end of teh given
-- 2D table.
--
-- @param table The 2D table.
-- @param is_empty Optional. The function used for determining if the item is
--                 empty. By default nil and an empty string is considered
--                 empty. Expected is a function that takes one item and returns
--                 a boolean.
function tableutil.reduce2d(table, is_empty)
	is_empty = is_empty or function(item)
		return item == nil or item == ""
	end
	
	local first_row = -1
	local last_row = -1
	
	for row_index = 1, #table, 1 do
		local row = table[row_index]
		local row_is_empty = true
		
		for column_index = 1, #row, 1 do
			if not is_empty(row[column_index]) then
				row_is_empty = false
			end
		end

		if not row_is_empty then
			if first_row == -1 then
				first_row = row_index
			else
				last_row = row_index
			end
		end
	end
	
	local first_column = -1
	local last_column = -1
	
	for column_index = 1, 5, 1 do
		local column_is_empty = true
		
		for row_index = 1, #table, 1 do
			local row = table[row_index]
			
			if column_index <= #row and not is_empty(row[column_index]) then
				column_is_empty = false
			end
		end
		
		if not column_is_empty then
			if first_column == -1 then
				first_column = column_index
			else
				last_column = column_index
			end
		end
	end
	
	if last_row == -1 then
		last_row = first_row
	end
	
	if last_column == -1 then
		last_column = first_column
	end
	
	local reduced = {}
	
	if first_row ~= -1 and first_column ~= -1 then
		for row_index = first_row, last_row, 1 do
			local row = table[row_index]
			local reduced_row = {}
		
			for column_index = first_column, last_column, 1 do
				reduced_row[column_index - first_column + 1] = row[column_index]
			end
		
			reduced[row_index - first_row + 1] = reduced_row
		end
	end
	
	return reduced
end

--- Reindexes the given 2d array/table, swapping the two dimensions.
--
-- @param data The array/table to reindex.
-- @param new_x The new startpoint for the first dimension.
-- @param new_y The new startpoint for the second dimension.
-- @return The reindexed data.
function tableutil.swapped_reindex2d(data, new_x, new_y)
	local reindexed_data = {}
	
	for old_x = 1, constants.block_size, 1 do
		local index_x = new_x + old_x - 1
		reindexed_data[index_x] = {}
		
		for old_y = 1, constants.block_size, 1 do
			local index_y = new_y + old_y - 1
				
			reindexed_data[index_x][index_y] = data[old_y][old_x]
		end
	end
	
	return reindexed_data
end

--- Reindexes the given 3d array/table, swapping the two dimensions.
--
-- @param data The array/table to reindex.
-- @param new_x The new startpoint for the first dimension.
-- @param new_y The new startpoint for the second dimension.
-- @param new_z The new startpoint for the third dimension.
-- @return The reindexed data.
function tableutil.swapped_reindex3d(data, new_x, new_y, new_z)
	local reindexed_data = {}
	
	for old_x = 1, constants.block_size, 1 do
		local index_x = new_x + old_x - 1
		reindexed_data[index_x] = {}
	
		for old_z = 1, constants.block_size, 1 do
			local index_z = new_z + old_z - 1
			reindexed_data[index_x][index_z] = {}
		
			for old_y = 1, constants.block_size, 1 do
				local index_y = new_y + old_y - 1
			
				reindexed_data[index_x][index_z][index_y] = data[old_z][old_y][old_x]
			end
		end
	end
	
	return reindexed_data
end

--- Returns the string representation of the given table.
--
-- @param table The table.
-- @param indent Optional. The number of spaces of indentation.
-- @return The string representation of the given table.
function tableutil.to_string(table, indent)
	if table == nil then
		return "nil"
	end
	
	indent = indent or 0
	
	if type(table) == "table" and #table ~= 0 then
		local str = tostring(table) .. " {\n"
		
		local indentation = string.rep(" ", indent + 4)
		
		for key, value in pairs(table) do
			str = str .. indentation .. tostring(key) .. " = "
			str = str .. tableutil.to_string(value, indent + 4) .. ",\n"
		end
		
		str = string.sub(str, 0, string.len(str) - 2)
		str = str .. "\n" .. string.rep(" ", indent) .. "}"
		
		return str
	elseif type(table) == "string" then
		return "\"" .. tostring(table) .. "\""
	else
		return tostring(table)
	end
end

