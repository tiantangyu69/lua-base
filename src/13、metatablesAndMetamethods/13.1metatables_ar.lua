Set = {}

--[[
function Set.new(t)
	local set = {}
	for _, l in ipairs(t) do
		set[l] = true
	end
	return set
end
--]]

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

--[[
现在我们想加号运算符(+)执行两个集合的并操作，我们将所有集合共享一个metatable，并且为这个metatable添加如何处理相加操作。
第一步，我们定义一个普通的表，用来作为metatable。为避免污染命名空间，我们将其放在set内部。
--]]
Set.mt = {}         -- metatable for sets
-- 第二步，修改set.new函数，增加一行，创建表的时候同时指定对应的metatable。
function Set.new(t)
	local set = {}
	setmetatable(set, Set.mt)
	for _, l in ipairs(t) do
		set[l] = true
	end
	
	return set
end

-- 这样一来，set.new创建的所有的集合都有相同的metatable了：
s1 = Set.new({10, 20, 30, 50})
s2 = Set.new({30, 1})
print(getmetatable(s1))     --> table: 00672B60
print(getmetatable(s2))     --> table: 00672B60

-- 第三步，给metatable增加__add函数。
Set.mt.__add = Set.union

--[[
当Lua试图对两个集合相加时，将调用这个函数，以两个相加的表作为参数。
通过metamethod，我们可以对两个集合进行相加：
--]]
s3 = s1 + s2
Set.print(s3)     --> {1, 10, 20, 30, 50}

-- 同样的我们可以使用相乘运算符来定义集合的交集操作
Set.mt.__mul = Set.intersection
Set.print((s1 + s2)*s1)     --> {10, 20, 30, 50}

--[[
对于每一个算术运算符，metatable都有对应的域名与其对应，除了__add、__mul外，还有__sub(减)、__div(除)、__unm(负)、__pow(幂)，我们也可以定义__concat定义连接行为。
当我们对两个表进行加没有问题，但如果两个操作数有不同的metatable例如：
--]]


--[[
s = Set.new{1,2,3}
s = s + 8
Lua选择metamethod的原则：如果第一个参数存在带有__add域的metatable，Lua使用它作为metamethod，和第二个参数无关；
否则第二个参数存在带有__add域的metatable，Lua使用它作为metamethod 否则报错。
Lua不关心这种混合类型的，如果我们运行上面的s=s+8的例子在Set.union发生错误：
bad argument #1 to `pairs' (table expected, got number)
--]]
-- 如果我们想得到更加清楚地错误信息，我们需要自己显式的检查操作数的类型
