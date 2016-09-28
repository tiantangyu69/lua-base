-- Lua 使用一个名为 environment 普通的表来保存所有的全局变量
--[[
for n in pairs(_G) do
	print(n)
end
]]--

function getfield(f)
	local v = _G
	for w in string.gfind(f, "[%w_]+") do
		v = v[w]
	end
	
	return v
end

function setfield(f, v)
	local t = _G
	for w, d in string.gfind(f, "([%w_]+)(.?)") do
		if d == "." then
			t[w] = t[w] or {}
			t = t[w]
		else
			t[w] = v
		end
	end
end

setfield("t.x.y", 10)
print(t.x.y)
print(getfield("t.x.y"))


-- 申明全局变量
setmetatable(_G, {
	__newindex = function(_, n)
		error("attempt to write to undeclared variable" .. n, 2)
	end,
	
	__index = function(_, n)
		error("attempt to read undeclared variable" .. n, 2)
	end
})

function declare(name, initval)
	rawset(_G, name, initval or false)
end

local declaredNames = {}
function declare(name, initval)
	rawset(_g, name, initval)
	declaredNames[name] = true
end

setmetatable(_G, {
	__newindex = function(t, n, v)
		if not declaredNames[n] then
			error("attempt to write to undeclared var. " .. n, 2)
		else
			rawset(t, n, v)
		end
	end,
	
	__index = function(_, n)
		if not declaredNames[n] then
			error("attempt to read undeclared var." .. n, 2)
		else
			return nil
		end
	end
})