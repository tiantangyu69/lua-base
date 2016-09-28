local P = {}
complex = P

local function checkComplex(c)
	if not ((type(c) == "table") and tonumber(c.r) and tonumber(c.i)) then
		error("bad complex number", 3)
	end
end

function P.add(c1, c2)
	checkComplex(c1)
	checkComplex(c2)
	
	return P.new(c1.r + c2.r, c1.i + c2.i)
end

return P