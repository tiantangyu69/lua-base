--[[
function dofile(filename)
	local f = assert(loadfile(filename))
	return f()
end
]]--

f = loadstring("i = i + 1")
i = 0
f()
print(i)
f()
print(i)

f = loadstring("local a = 10; return a + 20")
print(f())        --> 30

print(loadstring("i i"))

-- 另外，loadfile和loadstring都不会有边界效应产生，他们仅仅编译chunk成为自己内部实现的一个匿名函数。通常对他们的误解是他们定义了函数。Lua中的函数定义是发生在运行时的赋值而不是发生在编译时。假如我们有一个文件foo.lua：
-- 当我们执行命令f = loadfile("foo.lua")后，foo被编译了但还没有被定义，如果要定义他必须运行chunk：
f = loadfile("foo.lua")
f()           -- defines `foo'
foo("ok")     --> ok

-- assert(loadstring("i i"))()

print "enter your expression:"
local l = io.read()
local func = assert(loadstring("return " .. l))
print("the value of your expression is " .. func())



print "enter function to be plotted (with variable 'x'):"
local l = io.read()
local f = assert(loadstring("return " .. l))
for i=1,20 do
    x = i   -- global 'x' (to be visible from the chunk)
    print(string.rep("*", f()))
end
