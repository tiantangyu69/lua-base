-- Lua中函数可以作为全局变量也可以作为局部变量，我们已经看到一些例子：函数作为table的域（大部分Lua标准库使用这种机制来实现的比如io.read、math.sin）。这种情况下，必须注意函数和表语法：

-- 1. 表和函数放在一起
Lib = {}
Lib.foo = function(x, y)
	return x + y
end

Lib.goo = function(x, y)
	return x - y
end


-- 2. 使用表构造函数
Lib = {
	foo = function(x, y) return x + y end,
	goo = function(x, y) return x -y end
}

-- 3. Lua 提供另一种语法方式
Lib = {}
function Lib.foo(x, y)
	return x + y
end

function Lib.goo(x, y)
	return x - y
end

-- 当我们将函数保存在一个局部变量内时，我们得到一个局部函数，也就是说局部函数像局部变量一样在一定范围内有效。
-- 这种定义在包中是非常有用的：因为Lua把chunk当作函数处理，在chunk内可以声明局部函数（仅仅在chunk内可见），
-- 词法定界保证了包内的其他函数可以调用此函数。下面是声明局部函数的两种方式：
--[[
1. 方式一
local f = function (...)
    ...
end
 
local g = function (...)
    ...
    f()   -- external local `f' is visible here
    ...
end
2. 方式二
local function f (...)
    ...
end
--]]

-- 有一点需要注意的是在声明递归局部函数的方式：
local fact = function (n)
    if n == 0 then
       return 1
    else
       return n*fact(n-1)   -- buggy
    end
end

-- 上面这种方式导致Lua编译时遇到fact(n-1)并不知道他是局部函数fact，Lua会去查找是否有这样的全局函数fact。为了解决这个问题我们必须在定义函数以前先声明：
local fact
 
fact = function (n)
    if n == 0 then
       return 1
    else
       return n*fact(n-1)
    end
end

--[[
这样在fact内部fact(n-1)调用是一个局部函数调用，运行时fact就可以获取正确的值了。
但是Lua扩展了他的语法使得可以在直接递归函数定义时使用两种方式都可以。
在定义非直接递归局部函数时要先声明然后定义才可以：
--]]
local f, g        -- `forward' declarations
 
function g ()
	f()
end
 
function f ()
	g()
end