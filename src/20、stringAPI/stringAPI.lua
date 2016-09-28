s = "woshi"
print(string.len(s))
s = "��"
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


-- ģʽƥ�亯��
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
. �����ַ�
%a ��ĸ
%c �����ַ�
%d ����
%l Сд��ĸ
%p ����ַ�
%s �հ׷�
%u ��д��ĸ
%w ��ĸ������
%x ʮ����������
%z ����0���ַ�

�����ַ���Ĵ�д��ʽ��ʾСд������ļ��ϵĲ��������磬'%A'����ĸ���ַ�
]]--

print(string.gsub("hello, up-down!", "%A", "."))

