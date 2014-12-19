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


--- Allows to easily time blocks of code. The result will be logged.
stopwatch = {
	active_watches = {}
}


--- Start a watch with the given name.
--
-- @param watch_name The name of the watch to start.
function stopwatch.start(watch_name)
	stopwatch.active_watches[watch_name] = os.clock()
end


--- Stops the watch with the given name, logging the duration.
--
-- It will be logged as info in the format "watch_name: duration ms" or
-- if the message is provided "message: duration ms"
-- @param watch_name The name of the watch to stop.
-- @param message Optional. The message to use for the log instead of the name.
function stopwatch.stop(watch_name, message)
	local start = stopwatch.active_watches[watch_name]
	
	if start ~= nil then
		local duration = os.clock() - start
		duration = duration * 1000
		duration = mathutil.round(duration)
		
		log.info(message or watch_name, ": ", duration, " ms")
	else
		log.info(message or watch_name, ": ", "not started")
	end
end

