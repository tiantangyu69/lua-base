-- 使用local创建一个局部变量，与全局变量不同，局部变量只在被声明的那个代码块内有效。代码块：指一个控制结构内，一个函数体，或者一个chunk（变量被声明的那个文件或者文本串）。
x = 10
local i = 1 -- local to the chunk

while i <=x do
	local x = i * 2    -- local to the while body
	print(x)           --> 2, 4, 6, 8, ...
	i = i + 1
end

if i > 20 then
	local x            -- local to the "then" body
	x = 20
	print(x + 2)
else
	print(x)           --> 10  (the global one)
end

print(x)               --> 10  (the global one)

--[[
注意，如果在交互模式下上面的例子可能不能输出期望的结果，因为第二句local i=1是一个完整的chunk，在交互模式下执行完这一句后，Lua将开始一个新的chunk，
这样第二句的i已经超出了他的有效范围。可以将这段代码放在do..end（相当于c/c++的{}）块中。

应该尽可能的使用局部变量，有两个好处：
1. 避免命名冲突
2. 访问局部变量的速度比全局变量更快.
我们给block划定一个明确的界限：do..end内的部分。当你想更好的控制局部变量的作用范围的时候这是很有用的。
--]]
do
	local a = 3
	local b = 4
	local c = 5
	
    local a2 = 2*a
    local d = b^2 - 4*a*c
    x1 = (-b + d)/a2
    x2 = (-b - d)/a2
end            -- scope of 'a2' and 'd' ends here
 
print(x1, x2)