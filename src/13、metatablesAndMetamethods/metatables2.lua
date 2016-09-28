-- 监控表
t = {}

local _t = t

t= {}

local mt = {
	__index = function(t, k)
		print("*access to element " .. tostring(k))
		return _t[k]
	end,
	
	__newindex = function(t, k, v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		_t[k] = v
	end
}
setmetatable(t, mt)

t[2] = 'hello'
print(t[2])

-- 优化的监控表
local index = {}

local mt = {
	__index = function(t, k)
		print("*access to element " .. tostring(k))
		return t[index][k]
	end,
	
	__newindex = function(t, k, v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		t[index][k] = v
	end
}

function track(t)
	local proxy = {}
	proxy[index] = t
	setmetatable(proxy, mt)
	return proxy
end

t = track(t)
t[2] = 'hello'
print(t[2])


-- 只读表
function readOnly(t)
	local proxy = {}
	local mt = {
		__index = t,
		__newindex = function(t, k, v)
			error("attempt to update a read-only table", 2)
		end
	}
	
	setmetatable(proxy, mt)
	return proxy
end

days = readOnly({"Sunday", "Monday", "Tuesday"})

print(days[1])
days[2] = "Noday"