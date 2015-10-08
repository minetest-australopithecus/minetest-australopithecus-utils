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


--- Util for various functions regarding textures.
textureutil = {}


--- Creates a dummy texture with the two given colors.
--
-- @param inner_color The color for the inner part, either a string with
--                    leading "#" or a Color.
-- @param border_color The color for the border, either a string with
--                    leading "#" or a Color.
-- @return The dummy texture (string).
function textureutil.dummy(inner_color, border_color)
	if type(inner_color) == "table" then
		inner_color = "#" .. inner_color.hex
	end
	if type(outer_color) == "table" then
		outer_color = "#" .. outer_color.hex
	end
	
	local inner = "(dummy_inner.png^[colorize:" .. inner_color .. ":240)"
	local border = "(dummy_border.png^[colorize:" .. border_color .. ":255)"
	
	return inner .. "^" .. border
end

--- Creates a tile with the given tileable parameters.
--
-- @param tile The name of the tile.
-- @param horizontal If the tile is horizontally tileable.
-- @param vertical If the tile is vertically tileable.
-- @return A tile with tileable information.
function textureutil.tileable(tile, horizontal, vertical)
	return {
		name = tile,
		tileable_horizontal = horizontal,
		tileable_vertical = vertical
	}
end

