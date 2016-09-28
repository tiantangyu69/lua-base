local function checkComplex(c)
	if not((type(c) == "table") and tonumber(c.r) and tonumber(c.i)) then
		error("bad complex number", 3)
	end
end

local function new(r, i)
	return {r = r, i = i}
end

local function add(c1, c2)
	checkComplex(c1)
	checkComplex(c2)
	return new(c1.r + c2.r, c1.i + c2.i)
end

complex = {
	new = new,
	add = add
}