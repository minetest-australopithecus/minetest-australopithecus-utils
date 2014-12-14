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

