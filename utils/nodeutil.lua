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


--- Various functions related to nodes.
nodeutil = {}


--- Gets the content id of the given node.
--
-- @param node The node, can either be an id, a name or a table with the name.
-- @return The content id of the given node.
function nodeutil.get_id(node)
	if type(node) == "string" then
		return minetest.get_content_id(node)
	elseif type(node) == "table" then
		return minetest.get_content_id(node.name)
	end
	
	return node
end

--- Converts the given wallmounted value to a facedir value.
--
-- @param wallmounted The wallmounted value.
-- @return The facedir value.
function nodeutil.wallmounted_to_facedir(wallmounted)
	if wallmounted == 0 then
		-- Ceiling
		return 0
	elseif wallmounted == 1 then
		-- Floor
		return 0
	elseif wallmounted == 2 then
		return 1
	elseif wallmounted == 3 then
		return 3
	elseif wallmounted == 4 then
		return 0
	elseif wallmounted == 5 then
		return 2
	end
	
	return 0
end

