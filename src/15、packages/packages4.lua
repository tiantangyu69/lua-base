local P = {}
if _REQUIREDNAME == nil then
	complex = P
else
	_G[_REQUIREDNAME] = P
end

local P = {}
complex = P
setfenv(1, P)

function add(c1, c2)
	return new(c1.r + c2.r, c1.i + c2.i)
end



local P = {}
if _REQUIREDNAME == nil then
	complex = P
else
	_G[_REQUIREDNAME] = P
end
setfenv(1, P)


local P = {}
setmetatable(P, {__index = _G})
setfenv(1, P)


local P = {}
pack = P
local _G = _G
setfenv(1, P)