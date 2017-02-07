-- function
-- 函数只有一个参数，且这个参数是字符串类型，调用函数时可不用加()
print "aaaaaa"
-- 调用函数的时候，如果参数列表为空，必须使用()表明是函数调用
print(9 / 3, 3 * 3)
a = math.sin(3) + math.cos(10)
print(a)
print(os.date())

-- Lua函数实参和形参的匹配与赋值语句类似，多余部分被忽略，缺少部分用nil补足。
function f(a, b)
	print(a, b)
	return a or b
end
f(3)
f(3, 4)
f(3, 4, 5)

-- 多返回值
s, e = string.find("hello Lua users", "Lua")
print(s, e);

function maximum(a)
	local mi = 1;  -- maximum index
	local m = a[mi]  -- maximum value
	for i, val in ipairs(a) do
		if val > m then
			mi = i
			m = val
		end
	end
	return m, mi
end

print(maximum({23, 35, 656, 6, 87, 34, 345636, 3446, 346}));

-- Lua总是调整函数返回值的个数以适用调用环境，当作为独立的语句调用函数时，所有返回值将被忽略。假设有如下三个函数：
function foo()
end

function foo1()
	return 'a'
end

function foo2()
	return 'a', 'b'
end

--[[
第一，当作为表达式调用函数时，有以下几种情况：
1. 当调用作为表达式最后一个参数或者仅有一个参数时，根据变量个数函数尽可能多地返回多个值，不足补nil，超出舍去。
2. 其他情况下，函数调用仅返回第一个值（如果没有返回值为nil）
]]--
x, y = foo2()  -- x='a', y='b'
x = foo2()   -- x='a', 'b' is discarded
x, y, z = 10, foo2()  -- x=10, y='a', z='b'

x, y = foo()  -- x=nil, y=nil
x, y = foo1()  -- x='a', y=nil
x, y, z = foo2()  -- x='a', y='b', z=nil

x, y = foo2(), 20  -- x='a', y=20
x, y = foo(), 20, 30     -- x='nil', y=20, 30 is discarded

--第二，函数调用作为函数参数被调用时，和多值赋值是相同。
print(foo())            -->
print(foo1())            --> a
print(foo2())            --> a   b
print(foo2(), 1)         --> a   1
print(foo2() .. "x")     --> ax


--第三，函数调用在表构造函数中初始化时，和多值赋值时相同。
a = {foo()}             -- a = {}    (an empty table)
a = {foo1()}             -- a = {'a'}
a = {foo2()}             -- a = {'a', 'b'}

a = {foo(), foo2(), 4}  -- a[1] = nil, a[2] = 'a', a[3] = 4

function foo3 (i)
    if i == 0 then 
		return foo()
    elseif i == 1 then 
		return foo1()
    elseif i == 2 then 
		return foo2()
    end
end

print(foo3(0))
print(foo3(1))
print(foo3(2))

--可以使用圆括号强制使调用返回一个值。
print((foo()))      --> nil
print((foo1()))      --> a
print((foo2()))      --> a


--[[
一个return语句如果使用圆括号将返回值括起来也将导致返回一个值。
函数多值返回的特殊函数unpack，接受一个数组作为输入参数，返回数组的所有元素。
unpack被用来实现范型调用机制，在C语言中可以使用函数指针调用可变的函数，可以声明参数可变的函数，但不能两者同时可变。在Lua中如果你想调用可变参数的可变函数只需要这样：
--]]
f(unpack(a))

-- unpack返回a所有的元素作为f()的参数
f = string.find
a = {"hello", "ll"}
print(f(unpack(a)))      --> 3  4

cc = {"c1", "c2", "c3", "c4"}
print(unpack(cc))

-- 预定义的unpack函数是用C语言实现的，我们也可以用Lua来完成：
function unpack(t, i)
    i = i or 1
    if t[i] then
       return t[i], unpack(t, i + 1)
    end
end
print(unpack(cc))
