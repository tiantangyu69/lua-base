--[[
Lua中的table由于定义的行为，我们可以对key-value对执行加操作，访问key对应的value，遍历所有的key-value。但是我们不可以对两个table执行加操作，也不可以比较两个表的大小。
Metatables允许我们改变table的行为，例如，使用Metatables我们可以定义Lua如何计算两个table的相加操作a+b。当Lua试图对两个表进行相加时，他会检查两个表是否有一个表有Metatable，
并且检查Metatable是否有__add域。如果找到则调用这个__add函数（所谓的Metamethod）去计算结果。
Lua中的每一个表都有其Metatable。（后面我们将看到userdata也有Metatable），Lua默认创建一个不带metatable的新表
--]]

t = {}
print(getmetatable(t))      --> nil

-- 可以使用setmetatable函数设置或者改变一个表的metatable
t1 = {}
setmetatable(t, t1)
assert(getmetatable(t) == t1)