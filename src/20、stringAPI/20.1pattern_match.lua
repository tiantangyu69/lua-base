--[[
在string库中功能最强大的函数是：string.find（字符串查找），string.gsub（全局字符串替换），and string.gfind（全局字符串查找）。这些函数都是基于模式匹配的。
与其他脚本语言不同的是，Lua并不使用POSIX规范的正则表达式（也写作regexp）来进行模式匹配。主要的原因出于程序大小方面的考虑：实现一个典型的符合POSIX标准的regexp大概需要4000行代码，
这比整个Lua标准库加在一起都大。权衡之下，Lua中的模式匹配的实现只用了500行代码，当然这意味着不可能实现POSIX所规范的所有可能。然而，Lua中的模式匹配功能是很强大的，并且包含了一些
使用标准POSIX模式匹配不容易实现的功能。
string.find的基本应用就是用来在目标串（subject string）内搜索匹配指定的模式的串。函数如果找到匹配的串返回他的位置，否则返回nil.
最简单的模式就是一个单词，仅仅匹配单词本身。比如，模式'hello'仅仅匹配目标串中的"hello"。当查找到模式的时候，函数返回两个值：匹配串开始索引和结束索引。
--]]
s = "hello world"
i, j = string.find(s, "hello")
print(i, j)                                   --> 1    5
print(string.sub(s, i, j))                    --> hello
print(string.find(s, "world"))                --> 7    11
i, j  = string.find(s, "l")                   
print(i, j)                                   --> 3    3
print(string.find(s, "lll"))                  --> nil

--[[
例子中，匹配成功的时候，string.sub利用string.find返回的值截取匹配的子串。（对简单模式而言，匹配的就是其本身）
string.find函数第三个参数是可选的：标示目标串中搜索的起始位置。当我们想查找目标串中所有匹配的子串的时候，
这个选项非常有用。我们可以不断的循环搜索，每一次从前一次匹配的结束位置开始。下面看一个例子，下面的代码用一个字符串中所有的新行构造一个表：
--]]
local t = {}
local i = 0
while true do
	i = string.find(s, "\n", i + 1)
	if i == nil then
		break;
	end
	table.insert(t, i)
end

--[[
后面我们还会看到可以使用string.gfind迭代子来简化上面这个循环。
string.gsub函数有三个参数：目标串，模式串，替换串。他基本作用是用来查找匹配模式的串，并将使用替换串其替换掉：
--]]
s = string.gsub("Lua is cute", "cute", "great")
print(s)                                                --> Lua is great
s = string.gsub("all lii", "l", "x")
print(s)                                                --> axx xii
s = string.gsub("Lua is great", "perl", "tcl")
print(s)                                                --> Lua is great   

-- 第四个参数是可选的，用来限制替换的范围：
s = string.gsub("all lii", "l", "x", 1)
print(s)                                                --> xl lii
s = string.gsub("all lii", "l", "x", 2)
print(s)                                                --> axx lii

-- string.gsub的第二个返回值表示他进行替换操作的次数。例如，下面代码涌来计算一个字符串中空格出现的次数：
_, count = string.gsub(str, " ", " ")
print(count)
-- （注意，_ 只是一个哑元变量）





s = "Deadline is 30/05/1999, firm"
date = "%d%d/%d%d/%d%d%d%d"
print(string.sub(s, string.find(s, date)))

--[[
. 任意字符
%a 字母
%c 控制字符
%d 数字
%l 小写字母
%p 标点字符
%s 空白符
%u 大写字母
%w 字母和数字
%x 十六进制数字
%z 代表0的字符

上面字符类的大写形式表示小写所代表的集合的补集。例如，'%A'非字母的字符
]]--

print(string.gsub("hello, up-down!", "%A", "."))

