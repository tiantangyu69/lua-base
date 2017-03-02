--[[
全局变量不需要声明，虽然这对一些小程序来说很方便，但程序很大时，一个简单的拼写错误可能引起bug并且很难发现。
然而，如果我们喜欢，我们可以改变这种行为。因为Lua所有的全局变量都保存在一个普通的表中，我们可以使用metatables来改变访问全局变量的行为。
第一个方法如下：
--]]


setmetatable(_G, {
    __newindex = function (_, n)
       error("attempt to write to undeclared variable "..n, 2)
    end,
   
    __index = function (_, n)
       error("attempt to read undeclared variable "..n, 2)
    end,
})

-- 这样一来，任何企图访问一个不存在的全局变量的操作都会引起错误：
-- a = 1 --> stdin:1: attempt to write to undeclared variable a

-- 但是我们如何声明一个新的变量呢？使用rawset，可以绕过metamethod：
function declare (name, initval)
    rawset(_G, name, initval or false)
end

--[[
or 带有 false 是为了保证新的全局变量不会为 nil。注意：你应该在安装访问控制以前（before installing the access control）定义这个函数，
否则将得到错误信息：毕竟你是在企图创建一个新的全局声明。只要刚才那个函数在正确的地方，你就可以控制你的全局变量了：
--]]
declare("a")
a = 1

-- 但是现在，为了测试一个变量是否存在，我们不能简单的比较他是否为nil。如果他是nil访问将抛出错误。所以，我们使用rawget绕过metamethod：
if rawget(_G, var) == nil then
	print(nil)
end

-- 改变控制允许全局变量可以为nil也不难，所有我们需要的是创建一个辅助表用来保存所有已经声明的变量的名字。不管什么时候metamethod被调用的时候，他会检查这张辅助表看变量是否已经存在。代码如下：
local declaredNames = {}
function declare (name, initval)
    rawset(_G, name, initval)
    declaredNames[name] = true
end
setmetatable(_G, {
    __newindex = function (t, n, v)
    if not declaredNames[n] then
       error("attempt to write to undeclared var. "..n, 2)
    else
       rawset(t, n, v)   -- do the actual set
    end
end,
    __index = function (_, n)
    if not declaredNames[n] then
       error("attempt to read undeclared var. "..n, 2)
    else
       return nil
    end
end,
})
-- 两种实现方式，代价都很小可以忽略不计的。第一种解决方法：metamethods在平常操作中不会被调用。第二种解决方法：他们可能被调用，不过当且仅当访问一个值为nil的变量时。