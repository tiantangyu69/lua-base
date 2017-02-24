--[[
迭代器是一种支持指针类型的结构，它可以遍历集合的每一个元素。在Lua中我们常常使用函数来描述迭代器，每次调用该函数就返回集合的下一个元素。
迭代器需要保留上一次成功调用的状态和下一次成功调用的状态，也就是他知道来自于哪里和将要前往哪里。闭包提供的机制可以很容易实现这个任务。
记住：闭包是一个内部函数，它可以访问一个或者多个外部函数的外部局部变量。每次闭包的成功调用后这些外部局部变量都保存他们的值（状态）。
当然如果要创建一个闭包必须要创建其外部局部变量。所以一个典型的闭包的结构包含两个函数：一个是闭包自己；另一个是工厂（创建闭包的函数）。
举一个简单的例子，我们为一个list写一个简单的迭代器，与ipairs()不同的是我们实现的这个迭代器返回元素的值而不是索引下标：
--]]
function list_iter (t)
    local i = 0
    local n = table.getn(t)
    return function ()
       i = i + 1
       if i <= n then return t[i] end
    end
end

-- 这个例子中list_iter是一个工厂，每次调用他都会创建一个新的闭包（迭代器本身）。闭包保存内部局部变量(t,i,n)，因此每次调用他返回list中的下一个元素值，当list中没有值时，返回nil.我们可以在while语句中使用这个迭代器：
t = {10, 20, 30}
iter = list_iter(t)      -- creates the iterator
while true do
    local element = iter()   -- calls the iterator
    if element == nil then
		break
	end
    print(element)
end
-- 我们设计的这个迭代器也很容易用于范性for语句
for element in list_iter(t) do
	print(element)
end

--[[
范性for为迭代循环处理所有的薄记（bookkeeping）：首先调用迭代工厂；内部保留迭代函数，因此我们不需要iter变量；然后在每一个新的迭代处调用迭代器函数；当迭代器返回nil时循环结束（后面我们将看到范性for能胜任更多的任务）。
下面看一个稍微复杂一点的例子：我们写一个迭代器遍历一个文件内的所有匹配的单词。为了实现目的，我们需要保留两个值：当前行和在当前行的偏移量，我们使用两个外部局部变量line、pos保存这两个值。
--]]
function allwords()
	local line = io.read()
	local pos = 1
	return function()
		while line do
			local s, e = string.find(line, "%w+", pos)
			if s then
				pos = e + 1
				return string.sub(line, s, e)
			else
				line = io.read()
				pos = 1
			end
		end
	return nil
	end
end
	
--[[
迭代函数的主体部分调用了string.find函数，string.find在当前行从当前位置开始查找匹配的单词，例子中匹配的单词使用模式'%w+'描述的；
如果查找到一个单词，迭代函数更新当前位置pos为单词后的第一个位置，并且返回这个单词（string.sub函数从line中提取两个位置参数之间的子串）。否
则迭代函数读取新的一行并重新搜索。如果没有line可读返回nil结束。
尽管迭代函数有些复杂，但使用起来是很直观的：
--]]
for word in allwords() do
    print(word)
end	

-- 通常情况下，迭代函数大都难写易用。这不是大问题，一般Lua编程不需要自己写迭代函数，语言本身提供了许多。当然，必要时，自己动手构造一二亦可。