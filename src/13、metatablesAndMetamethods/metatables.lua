--[[
t = {}
print(getmetatable(t))

setmetatable(t, t1)
assert(getmetatable(t) == t1)
]]--

Set = {}
--[[
function Set.new(t)
	local set = {}
	for _, l in ipairs(t) do
		set[l] = true
	end
	
	return set
end
]]--

function Set.tostring(set)
	local s = "{"
	local sep = ""
	for e in pairs(set) do
		s = s .. sep .. e
		sep = ", "
	end
	
	return s .. "}"
end

function Set.print(s)
	print(Set.tostring(s))
end

Set.mt = {}
function Set.new(t)
	local set = {}
	setmetatable(set, Set.mt)
	for _, l in ipairs(t) do
		set[l] = true
	end
	
	return set
end

function Set.union(a, b)
	if getmetatable(a) ~= Set.mt or getmetatable(b) ~= Set.mt then
		error("attempt to add a set with a non-set value", 2)
	end

	local res = Set.new{}
	for k in pairs(a) do
		res[k] = true
	end
	
	for k in pairs(b) do
		res[k] = true
	end
	
	return res
end

function Set.intersection(a, b)
	local res = Set.new{}
	for k in pairs(a) do
		res[k] = b[k]
	end
	
	return res
end

s1 = Set.new{10, 20, 30, 40, 50}
s2 = Set.new{30, 55}

print(getmetatable(s1))
print(getmetatable(s2))

Set.mt.__tostring = Set.tostring

Set.print(s1)
Set.print(s2)

Set.mt.__add = Set.union
s3 = s1 + s2
Set.print(s3)
print(s3)

Set.mt.__sub = Set.intersection
s4 = s1 - s2
Set.print(s4)
print(s4)
--[[
-- 库函数定义的 metamethods
print({})

-- 保护 metatable
Set.mt.__metatable = "not your business"

s1 = Set.new{}
print(getmetatable(s1))
setmetatable(s1, {})
]]--

Window = {}
Window.prototype = {x = 0, y = 0, width = 100, height = 100, }
Window.mt = {}
function Window.new(o)
	setmetatable(o, Window.mt)
	return o
end

-- 以下方式是等价的
Window.mt.__index = function(table, key)
	return Window.prototype[key]
end

Window.mt.__index = Window.prototype
-- end


w = Window.new{x = 10, y = 20}
print(w.width)












