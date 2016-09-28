-- 数组大小
print(table.getn{20, 3, 5})
print(table.getn{20, 3, nil})
print(table.getn{20, 3, nil, n = 3})
print(table.getn{n = 1000})

a = {}
print(table.getn(a))
-- table.setn(a, 10000)
-- print(table.getn(a))

-- 插入/删除
--[[
a = {}
for line in io.lines() do
	table.insert(a, line)
end

print(table.getn(a))

table.remove(a, 1)
print(table.getn(a))
]]--

-- 排序
lines = {
	luaH_set = 10,
	luaH_get = 33,
	luaH_present = 66,
}

a = {}
for n in pairs(lines) do
	table.insert(a, n)
end

table.sort(a)

for i, n in ipairs(a) do
	print(n)
end

function pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do
		table.insert(a, n)
	end
	
	table.sort(a, f)
	local i = 0
	local iter = function()
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	
	return iter
end

for name, line in pairsByKeys(lines) do
	print(name, line)
end