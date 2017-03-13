--[[
��string���й�����ǿ��ĺ����ǣ�string.find���ַ������ң���string.gsub��ȫ���ַ����滻����and string.gfind��ȫ���ַ������ң�����Щ�������ǻ���ģʽƥ��ġ�
�������ű����Բ�ͬ���ǣ�Lua����ʹ��POSIX�淶��������ʽ��Ҳд��regexp��������ģʽƥ�䡣��Ҫ��ԭ����ڳ����С����Ŀ��ǣ�ʵ��һ�����͵ķ���POSIX��׼��regexp�����Ҫ4000�д��룬
�������Lua��׼�����һ�𶼴�Ȩ��֮�£�Lua�е�ģʽƥ���ʵ��ֻ����500�д��룬��Ȼ����ζ�Ų�����ʵ��POSIX���淶�����п��ܡ�Ȼ����Lua�е�ģʽƥ�书���Ǻ�ǿ��ģ����Ұ�����һЩ
ʹ�ñ�׼POSIXģʽƥ�䲻����ʵ�ֵĹ��ܡ�
string.find�Ļ���Ӧ�þ���������Ŀ�괮��subject string��������ƥ��ָ����ģʽ�Ĵ�����������ҵ�ƥ��Ĵ���������λ�ã����򷵻�nil.
��򵥵�ģʽ����һ�����ʣ�����ƥ�䵥�ʱ������磬ģʽ'hello'����ƥ��Ŀ�괮�е�"hello"�������ҵ�ģʽ��ʱ�򣬺�����������ֵ��ƥ�䴮��ʼ�����ͽ���������
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
�����У�ƥ��ɹ���ʱ��string.sub����string.find���ص�ֵ��ȡƥ����Ӵ������Լ�ģʽ���ԣ�ƥ��ľ����䱾��
string.find���������������ǿ�ѡ�ģ���ʾĿ�괮����������ʼλ�á������������Ŀ�괮������ƥ����Ӵ���ʱ��
���ѡ��ǳ����á����ǿ��Բ��ϵ�ѭ��������ÿһ�δ�ǰһ��ƥ��Ľ���λ�ÿ�ʼ�����濴һ�����ӣ�����Ĵ�����һ���ַ��������е����й���һ����
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
�������ǻ��ῴ������ʹ��string.gfind�����������������ѭ����
string.gsub����������������Ŀ�괮��ģʽ�����滻������������������������ƥ��ģʽ�Ĵ�������ʹ���滻�����滻����
--]]
s = string.gsub("Lua is cute", "cute", "great")
print(s)                                                --> Lua is great
s = string.gsub("all lii", "l", "x")
print(s)                                                --> axx xii
s = string.gsub("Lua is great", "perl", "tcl")
print(s)                                                --> Lua is great   

-- ���ĸ������ǿ�ѡ�ģ����������滻�ķ�Χ��
s = string.gsub("all lii", "l", "x", 1)
print(s)                                                --> xl lii
s = string.gsub("all lii", "l", "x", 2)
print(s)                                                --> axx lii

-- string.gsub�ĵڶ�������ֵ��ʾ�������滻�����Ĵ��������磬�������ӿ������һ���ַ����пո���ֵĴ�����
_, count = string.gsub(str, " ", " ")
print(count)
-- ��ע�⣬_ ֻ��һ����Ԫ������





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

