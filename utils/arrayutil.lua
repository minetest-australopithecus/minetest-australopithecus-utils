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


--- Various utility functions for working with arrays. An array is sub-form of
-- a array, the array is simply indexed with numbers like this:
--
-- local array = { 1 = "a", 2 = "b", 3 = "c" }
-- local array = { "a", "b", "c" }
arrayutil = {}


--- Finds the next matching column.
--
-- @param array The 2D array to search.
-- @param start_index Optional. The index at which to start. Defaults to 1, or
--                    if the direction is reversed, the number of columns in
--                    the array.
-- @param matcher Optional. The function that is used to determine if the column
--                matches or not. Is expected to take one argument, the item,
--                and return a boolean. The column matches if any of its items
--                matches this condition. Defaults to not nil and not empty
--                string.
-- @param reverse Optional. If the array should be serched backwards. Defaults
--                to false.
-- @return The index of the matching column. -1 if none was found.
function arrayutil.next_matching_column(array, start_index, matcher, reverse)
	matcher = matcher or function(item)
		return item ~= nil and item ~= ""
	end
	
	local current_column = 0
	
	if reverse and start_index == nil then
		for row_index = 1, #array, 1 do
			local row = array[row_index]
			
			current_column = math.max(current_column, #row)
		end
	else
		current_column = start_index or 1
	end
	
	local had_column = true
	
	while had_column do
		had_column = false
		
		for row_index = 1, #array, 1 do
			local row = array[row_index]
			
			if current_column >= 1 and current_column <= #row then
				had_column = true
				
				if matcher(row[current_column]) then
					return current_column
				end
			end
		end
		
		if reverse then
			current_column = current_column - 1
		else
			current_column = current_column + 1
		end
	end
	
	return -1
end

--- Finds the next matching row.
--
-- @param array The 2D array to search.
-- @param start_index Optional. The index at which to start. Defaults to 1, or
--                    if the direction is reversed, the number of rows in
--                    the array.
-- @param matcher Optional. The function that is used to determine if the row
--                matches or not. Is expected to take one argument, the item,
--                and return a boolean. The row matches if any of its items
--                matches this condition. Defaults to not nil and not empty
--                string.
-- @param reverse Optional. If the array should be serched backwards. Defaults
--                to false.
-- @return The index of the matching row. -1 if none was found.
function arrayutil.next_matching_row(array, start_index, matcher, reverse)
	matcher = matcher or function(item)
		return item ~= nil and item ~= ""
	end
	
	local to = #array
	local step = 1
	
	if reverse then
		start_index = start_index or #array
		to = 1
		step = -1
	else
		start_index = start_index or 1
	end
	
	for row_index = start_index, to, step do
		local row = array[row_index]
		
		for column_index = 1, #row, 1 do
			if matcher(row[column_index]) then
				return row_index
			end
		end
	end
	
	return -1
end

--- Finds the previous matching column.
--
-- @param array The 2D array to search.
-- @param start_index Optional. The index at which to start. Defaults to
--                    the number columns in the array.
-- @param matcher Optional. The function that is used to determine if the column
--                matches or not. Is expected to take one argument, the item,
--                and return a boolean. The column matches if any of its items
--                matches this condition. Defaults to not nil and not empty
--                string.
-- @return The index of the matching column. -1 if none was found.
function arrayutil.previous_matching_column(array, start_index, matcher)
	return arrayutil.next_matching_column(array, start_index, matcher, true)
end

--- Finds the previous matching row.
--
-- @param array The 2D array to search.
-- @param start_index Optional. The index at which to start. Defaults to
--                    the number rows in the array.
-- @param matcher Optional. The function that is used to determine if the row
--                matches or not. Is expected to take one argument, the item,
--                and return a boolean. The row matches if any of its items
--                matches this condition. Defaults to not nil and not empty
--                string.
-- @return The index of the matching row. -1 if none was found.
function arrayutil.previous_matching_row(array, start_index, matcher)
	return arrayutil.next_matching_row(array, start_index, matcher, true)
end

--- Removes empty rows and columns at the beginning and the end of the given
-- array.
--
-- @param array The array.
-- @param is_empty Optional. The function used for determining if the item is
--                 empty. By default nil and an empty string is considered
--                 empty. Expected is a function that takes one item and returns
--                 a boolean.
function arrayutil.reduce2d(array, is_empty)
	local first_row = arrayutil.next_matching_row(array, nil, is_empty)
	local last_row = arrayutil.previous_matching_row(array, nil, is_empty)
	
	local first_column = arrayutil.next_matching_column(array, nil, is_empty)
	local last_column = arrayutil.previous_matching_column(array, nil, is_empty)
	
	if last_row == -1 then
		last_row = first_row
	end
	
	if last_column == -1 then
		last_column = first_column
	end
	
	local reduced = {}
	
	if first_row ~= -1 and first_column ~= -1 then
		for row_index = first_row, last_row, 1 do
			local row = array[row_index]
			local reduced_row = {}
		
			for column_index = first_column, last_column, 1 do
				reduced_row[column_index - first_column + 1] = row[column_index]
			end
		
			reduced[row_index - first_row + 1] = reduced_row
		end
	end
	
	return reduced
end

--- Reindexes the given 2D array, swapping the two dimensions.
--
-- @param data The array to reindex.
-- @param new_x The new startpoint for the first dimension.
-- @param new_y The new startpoint for the second dimension.
-- @return The reindexed array.
function arrayutil.swapped_reindex2d(data, new_x, new_y)
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

--- Reindexes the given 3d array, swapping the two dimensions.
--
-- @param data The array to reindex.
-- @param new_x The new startpoint for the first dimension.
-- @param new_y The new startpoint for the second dimension.
-- @param new_z The new startpoint for the third dimension.
-- @return The reindexed array.
function arrayutil.swapped_reindex3d(data, new_x, new_y, new_z)
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

