--[[
������������;��
	1.���ָ����������������º�����Ϊ�������ʹ�ã�
	2.���㲢����ֵ����������º�����Ϊ��ֵ���ı��ʽʹ�á�

�﷨��	
	function func_name (arguments-list)
		statements-list;
	end;
--]]

-- ���ú�����ʱ����������б�Ϊ�գ�����ʹ��()�����Ǻ������á�
print(8*9, 9/8)
a = math.sin(3) + math.cos(10)
print(a)
print(os.date())


-- ����������һ�����⣬������ֻ��һ��������������������ַ������߱����ʱ��()���п��ޣ�
print "Hello World"      -->       print("Hello World")
-- dofile 'a.lua'           -->       dofile ('a.lua')
print [[a multi-line
		message ]]
-- f{x=10, y=20}            <-->       f({x=10, y=20})
print(type{})                   -->       type({})

--[[
LuaҲ�ṩ���������ʽ���ú������﷨������o:foo(x)��o.foo(o, x)�ǵȼ۵ġ�
Luaʹ�õĺ������ȿ���Lua��д�ģ�Ҳ�������������Ա�д�ģ�����Lua����Ա����ʲô����ʵ�ֵĺ���ʹ��������һ����
Lua����ʵ�κ��βε�ƥ���븳ֵ������ƣ����ಿ�ֱ����ԣ�ȱ�ٲ�����nil���㡣
--]]

function f(a, b)
	return a or b 
end

f(3)              --> a=3, b=nil
f(3, 4)           --> a=3, b=4
f(3, 4, 5)        --> a=3, b=4   (5 is discarded)