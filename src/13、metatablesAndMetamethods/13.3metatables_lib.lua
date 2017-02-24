--[[
在一些库中，在自己的metatables中定义自己的域是很普遍的情况。到目前为止，我们看到的所有metamethods都是Lua核心部分的。
有虚拟机负责处理运算符涉及到的metatables和为运算符定义操作的metamethods。但是，metatable是一个普通的表，任何人都可以使用。
tostring是一个典型的例子。如前面我们所见，tostring以简单的格式表示出table：
--]]
print({})

--[[
（注意：print函数总是调用tostring来格式化它的输出）。然而当格式化一个对象的时候，tostring会首先检查对象是否存在一个带有__tostring域的metatable。
如果存在则以对象作为参数调用对应的函数来完成格式化，返回的结果即为tostring的结果。
在我们集合的例子中我们已经定义了一个函数来将集合转换成字符串打印出来。因此，我们只需要将集合的metatable的__tostring域调用我们定义的打印函数：
--]]
a = {"a", "b", "c"}
mt = {}
mt.__tostring = function(t)
	local sep = ""
	local str = ""
	for _, v in ipairs(t) do
		str = str .. sep .. v
		sep = ", "
	end
	return "table to string: {" .. str .. "}"
end

-- 这样，不管什么时候我们调用print打印一个集合，print都会自动调用tostring，而tostring则会调用Set.tostring：
setmetatable(a, mt)
print(a)

--[[
setmetatable/getmetatable函数也会使用metafield，在这种情况下，可以保护metatables。假定你想保护你的集合使其使用者既看不到也不能修改metatables。
如果你对metatable设置了__metatable的值，getmetatable将返回这个域的值，而调用setmetatable 将会出错：
--]]

mt.__metatable = "not your business"
s1 = {1, 2, 3, 4}
setmetatable(s1, mt)
print(getmetatable(s1))          --> not your business
setmetatable(s1, {})             --> stdin:1: cannot change protected metatable

-- 关于算术运算和关系元运算的metamethods都定义了错误状态的行为，他们并不改变语言本身的行为。针对在两种正常状态：表的不存在的域的查询和修改，Lua也提供了改变tables的行为的方法