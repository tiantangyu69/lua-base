local results = {}
setmetatable(results, {__mode = "kv"})
function mem_loadstring(s)
	if results[s] then
		return results[s]
	else
		local res = loadstring(s)
		results[s] = res
		return res
	end
end





function createRGB(r, g, b)
	return {
		red = r,
		green = g,
		blue = b
	}
end

local results = {}
setmetatable(results, {__mode = "v"})
function createRGB(r, g, b)
	local key = r .. "-" .. g .. "-" .. b

	if results[key] then
		return results[key]
	else
		local newcolor = {
			red = r,
			green = g,
			blue = b
		}
		results[key] = newcolor
		return newcolor
	end
end