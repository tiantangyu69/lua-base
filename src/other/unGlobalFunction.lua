-- 1. 表和函数放在一起
Lib = {}
Lib.foo = function(x, y)
	return x + y
end

Lib.goo = function(x, y)
	return x - y
end

print(Lib.foo(3, 4))
print(Lib.goo(2, 1))

-- 2. 使用表构造函数
Lib2 = {
	foo = function(x, y)
		return x + y
	end,
	goo = function(x, y)
		return x - y
	end
}

print(Lib2.foo(3, 4))
print(Lib2.goo(2, 1))

-- 3. Lua提供另一种语法方式
Lib3 = {}
function Lib3.foo(x, y)
	return x + y
end
function Lib3.goo(x, y)
	return x - y
end

print(Lib3.foo(3, 4))
print(Lib3.goo(2, 1))

--[[
当我们将函数保存在一个局部变量内时，我们得到一个局部函数，也就是说局部函数像局部变量一样在一定范围内有效。
这种定义在包中是非常有用的：因为Lua把chunk当作函数处理，在chunk内可以声明局部函数（仅仅在chunk内可见），词法定界保证了包内的其他函数可以调用此函数。
下面是声明局部函数的两种方式：
]]--

-- 方式一
local f = function()
	print("this is function f")
end

local g = function()
	f()
	print("this is function g")
end

g()

-- 方式二
local function h()
	print("this is function h")
end

--[[
local fact = function(n)
	if n == 0 then
		return 1
	else
		return n * fact(n - 1)   -- buggy
	end
end

fact(3)
]]--

local fact;
fact = function(n)
	if n == 0 then
		return 1
	else
		return n * fact(n - 1)   -- buggy
	end
end

print(fact(3))


-- 在定义非直接递归局部函数时要先声明然后定义才可以：
--[[
local f, g        -- `forward' declarations

function g ()
	print("this is function g")
	f()
end

function f ()
	print("this is function f")
	g()
	return;
end

g()
f()
]]--

local foo;
foo = function(n)
    if n > 0 then
		return foo(n - 1)
	end
end

foo(3)


function room1 ()
    local move = io.read()
    if move == "south" then
       return room3()
    elseif move == "east" then
       return room2()
    else
       print("invalid move")
       return room1()   -- stay in the same room
    end
end

function room2 ()
    local move = io.read()
    if move == "south" then
       return room4()
    elseif move == "west" then
       return room1()
    else
       print("invalid move")
       return room2()
    end
end
 
function room3 ()
    local move = io.read()
    if move == "north" then
       return room1()
    elseif move == "east" then
       return room4()
    else
       print("invalid move")
       return room3()
    end
end

function room4 ()
    print("congratilations!")
end

room1()