-- 多重继承
local function search(k, plist)
	for i = 1, table.getn(plist) do
		local v = plist[i][k]
		if v then
			return v
		end
	end
end

function createClass(...)
	local c = {}
	
	setmetatable(c, {__index = function(t, k)
		local v = search(k, arg)
		t[k] = v
		return v
	end})
	
	c.__index = c
	
	function c:new(o)
		o = o or {}
		setmetatable(o, c)
		return o
	end
	
	return c
end

Named = {}

function Named:getname()
	return self.name
end

function Named.setname(n)
	self.name = n
end

NamedAccount = createClass{Account, Named}
account = NamedAccount:new{name = "Paul"}
print(account:getname())