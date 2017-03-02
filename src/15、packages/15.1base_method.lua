--[[
第一包的简单的方法是对包内的每一个对象前都加包名作为前缀。例如，假定我们正在写一个操作复数的库：我们使用表来表示复数，
表有两个域r（实数部分）和i（虚数部分）。我们在另一张表中声明我们所有的操作来实现一个包：
--]]

complex = {}

function complex.new(r, i)
	return {r = r, i = i}
end

complex.i = complex.new(0, 1)

function complex.add(c1, c2)
	return complex.new(c1.r + c2.r, c1.i + c2.i)
end

function complex.sub(c1, c2)
	return complex.new(c1.r - c2.r, c1.i - c2.i)
end

function complex.mul(c1, c2)
	return complex.new(c1.r * c2.r - c1.i * c2.i, c1.r * c2.i + c1.i * c2.r)
end

return complex
--[[
这个库定义了一个全局名：complex。其他的定义都是放在这个表内。
有了上面的定义，我们就可以使用符合规范的任何复数操作了，如：
--]]

c = complex.add(complex.i, complex.new(10, 20))

--[[
这种使用表来实现的包和真正的包的功能并不完全相同。首先，我们对每一个函数定义都必须显示的在前面加上包的名称。
第二，同一包内的函数相互调用必须在被调用函数前指定包名。我们可以使用固定的局部变量名，来改善这个问题，然后，将这个局部变量赋值给最终的包。依据这个原则，我们重写上面的代码：
--]]
local P = {}
complex = P       -- package name
P.i = {r=0, i=1}
function P.new (r, i) return {r=r, i=i} end
function P.add (c1, c2)
    return P.new(c1.r + c2.r, c1.i + c2.i)
end

-- 当在同一个包内的一个函数调用另一个函数的时候（或者她调用自身），他仍然需要加上前缀名。至少，它不再依赖于固定的包名。另外，只有一个地方需要包名。可能你注意到包中最后一个语句：
return complex
-- 这个return语句并非必需的，因为package已经赋值给全局变量complex了。但是，我们认为package打开的时候返回本身是一个很好的习惯。额外的返回语句并不会花费什么代价，并且提供了另一种操作package的可选方式。
