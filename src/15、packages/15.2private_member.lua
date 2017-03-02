--[[
有时候，一个package公开他的所有内容，也就是说，任何package的客户端都可以访问他。然而，一个package拥有自己的私有部分（也就是只有package本身才能访问）
也是很有用的。在Lua中一个传统的方法是将私有部分定义为局部变量来实现。例如，我们修改上面的例子增加私有函数来检查一个值是否为有效的复数：
--]]

local P = {}
complex = P

local function checkComplex(c)
	if not ((type(c) == "table") and tonumber(c.r) and tonumber(c.i)) then
		error("bad complex number", 3)
	end
end

function P.add(c1, c2)
	checkComplex(c1)
	checkComplex(c2)
	
	return P.new(c1.r + c2.r, c1.i + c2.i)
end

return P

--[[
这种方式各有什么优点和缺点呢？package中所有的名字都在一个独立的命名空间中。Package中的每一个实体（entity）都清楚地标记为公有还是私有。另外，
我们实现一个真正的隐私（privacy）：私有实体在package外部是不可访问的。缺点是访问同一个package内的其他公有的实体写法冗余，必须加上前缀P.。
还有一个大的问题是，当我们修改函数的状态(公有变成私有或者私有变成公有)我们必须修改函数得调用方式。
有一个有趣的方法可以立刻解决这两个问题。我们可以将package内的所有函数都声明为局部的，最后将他们放在最终的表中。按照这种方法，上面的complex package修改如下：
--]]
local function checkComplex (c)
    if not ((type(c) == "table")
    and tonumber(c.r) and tonumber(c.i)) then
       error("bad complex number", 3)
    end
end
 
local function new (r, i) return {r=r, i=i} end
local function add (c1, c2)
    checkComplex(c1);
    checkComplex(c2);
    return new(c1.r + c2.r, c1.i + c2.i)
end
 
...
 
complex = {
    new = new,
    add = add,
    sub = sub,
    mul = mul,
    div = div,
}

--[[
现在我们不再需要调用函数的时候在前面加上前缀，公有的和私有的函数调用方法相同。在package的结尾处，有一个简单的列表列出所有公有的函数。
可能大多数人觉得这个列表放在package的开始处更自然，但我们不能这样做，因为我们必须首先定义局部函数。
--]]