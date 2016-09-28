s = "woshi"
print(string.len(s))
s = "我"
print(string.len(s))

print(string.rep("hello ", 3))

print(string.lower("aaaHHHddd??"))

print(string.upper("aaaDDD33??##"))

print(string.sub("abcdefghijklmnopqrstuvwxyz", 1, 4))

print(string.char(97))

i = 99
print(string.char(i, i + 1, i + 2))
print(string.byte("abc"))
print(string.byte("abc", 2))
print(string.byte("abc", 3))

print(string.format("pi = %.4f", 3.1415936))

d = 5; m = 11; y = 1990
print(string.format("%02d/%02d/%04d", d, m, y))

tag, title = "h1", "a title"
print(string.format("<%s>%s</%s>", tag, title, tag))


-- 模式匹配函数
s = "hello world"
i, j = string.find(s, "hello")
print(i, j)
print(string.sub(s, i, j))
print(string.find(s, "world"))
i, j  = string.find(s, "l")
print(i, j)
print(string.find(s, "lll"))


local t = {}
local i = 0
while true do
	i = string.find(s, "\n", i + 1)
	if i == nil then
		break;
	end
	table.insert(t, i)
end

s = string.gsub("Lua is cute", "cute", "great")
print(s)
s = string.gsub("all lii", "l", "x")
print(s)
s = string.gsub("Lua is great", "perl", "tcl")
print(s)

s = string.gsub("all lii", "l", "x", 1)
print(s)
s = string.gsub("all lii", "l", "x", 2)
print(s)


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

