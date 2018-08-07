local M = {}

function M.wait(seconds)
	local co = coroutine.running()
	assert(co ~= nil, "The main thread cannot wait!")
	--TODO use world time istaead of os
	local t0 = os.clock()
	while os.clock() - t0 <= seconds do
		coroutine.yield()
	end
end

function M.wait2(seconds)
	local co = coroutine.running()
	assert(co ~= nil, "The main thread cannot wait!")
	--TODO use world time istaead of os
	local t0 = os.clock()
	while os.clock() - t0 <= seconds do
		print(os.clock() - t0)
		coroutine.yield()
	end
end


return M