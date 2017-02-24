-- Lua函数可以返回多个结果值，比如string.find，其返回匹配串“开始和结束的下标”（如果不存在匹配串返回nil）。
s, e = string.find("hello Lua users", "Lua")
print(s, e)

-- Lua函数中，在return后列出要返回的值得列表即可返回多值，如：
function maximum (a)
    local mi = 1             -- maximum index
    local m = a[mi]          -- maximum value
    for i,val in ipairs(a) do
       if val > m then
           mi = i
           m = val
       end
    end
    return m, mi
end
 
print(maximum({8,10,23,12,5}))     --> 23   3

-- Lua总是调整函数返回值的个数以适用调用环境，当作为独立的语句调用函数时，所有返回值将被忽略。假设有如下三个函数：
function foo0 () end                   -- returns no results
function foo1 () return 'a' end        -- returns 1 result
function foo2 () return 'a','b' end    -- returns 2 results

--[[
第一，当作为表达式调用函数时，有以下几种情况：
1. 当调用作为表达式最后一个参数或者仅有一个参数时，根据变量个数函数尽可能多地返回多个值，不足补nil，超出舍去。
2. 其他情况下，函数调用仅返回第一个值（如果没有返回值为nil）
--]]
x,y = foo2()             -- x='a', y='b'
x = foo2()               -- x='a', 'b' is discarded
x,y,z = 10,foo2()        -- x=10, y='a', z='b'
 
x,y = foo0()             -- x=nil, y=nil
x,y = foo1()             -- x='a', y=nil
x,y,z = foo2()           -- x='a', y='b', z=nil
 
x,y = foo2(), 20         -- x='a', y=20
x,y = foo0(), 20, 30     -- x='nil', y=20, 30 is discarded

-- 第二，函数调用作为函数参数被调用时，和多值赋值是相同。
print(foo0())            -->
print(foo1())            --> a
print(foo2())            --> a   b
print(foo2(), 1)         --> a   1
print(foo2() .. "x")     --> ax

-- 第三，函数调用在表构造函数中初始化时，和多值赋值时相同。
a = {foo0()}             -- a = {}    (an empty table)
a = {foo1()}             -- a = {'a'}
a = {foo2()}             -- a = {'a', 'b'}
 
a = {foo0(), foo2(), 4}  -- a[1] = nil, a[2] = 'a', a[3] = 4

-- 另外，return f()这种形式，则返回“f()的返回值”：
function foo (i)
    if i == 0 then
		return foo0()
    elseif i == 1 then
		return foo1()
    elseif i == 2 then
		return foo2()
    end
end
print("---------------------------------------------")
print(foo(1))        --> a
print(foo(2))        --> a  b
print(foo(0))        -- (no results)
print(foo(3))        -- (no results)

-- 可以使用圆括号强制使调用返回一个值。
print((foo0()))      --> nil
print((foo1()))      --> a
print((foo2()))      --> a
-- 一个return语句如果使用圆括号将返回值括起来也将导致返回一个值。

--[[
函数多值返回的特殊函数unpack，接受一个数组作为输入参数，返回数组的所有元素。
unpack被用来实现范型调用机制，在C语言中可以使用函数指针调用可变的函数，可以声明参数可变的函数，但不能两者同时可变。
在Lua中如果你想调用可变参数的可变函数只需要这样：
f(unpack(a))
--]]
-- unpack返回a所有的元素作为f()的参数
f = string.find
a = {"hello", "ll"}
print(f(unpack(a)))      --> 3  4

-- 预定义的unpack函数是用C语言实现的，我们也可以用Lua来完成：
function unpack(t, i)
    i = i or 1
    if t[i] then
       return t[i], unpack(t, i + 1)
    end
end