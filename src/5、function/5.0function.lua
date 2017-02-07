--[[
函数有两种用途：
	1.完成指定的任务，这种情况下函数作为调用语句使用；
	2.计算并返回值，这种情况下函数作为赋值语句的表达式使用。

语法：	
	function func_name (arguments-list)
		statements-list;
	end;
--]]

-- 调用函数的时候，如果参数列表为空，必须使用()表明是函数调用。
print(8*9, 9/8)
a = math.sin(3) + math.cos(10)
print(a)
print(os.date())


-- 上述规则有一个例外，当函数只有一个参数并且这个参数是字符串或者表构造的时候，()可有可无：
print "Hello World"      -->       print("Hello World")
-- dofile 'a.lua'           -->       dofile ('a.lua')
print [[a multi-line
		message ]]
-- f{x=10, y=20}            <-->       f({x=10, y=20})
print(type{})                   -->       type({})

--[[
Lua也提供了面向对象方式调用函数的语法，比如o:foo(x)与o.foo(o, x)是等价的。
Lua使用的函数，既可是Lua编写的，也可以是其他语言编写的，对于Lua程序员，用什么语言实现的函数使用起来都一样。
Lua函数实参和形参的匹配与赋值语句类似，多余部分被忽略，缺少部分用nil补足。
--]]

function f(a, b)
	return a or b 
end

f(3)              --> a=3, b=nil
f(3, 4)           --> a=3, b=4
f(3, 4, 5)        --> a=3, b=4   (5 is discarded)