--[[
��Ȼ���ǰ�Lua�������������ԣ�����Lua�����ȰѴ���Ԥ������м���Ȼ����ִ�У��ܶ���������Զ�����ô���ģ���
�ڽ����������д��ڱ���׶������������ʣ�Ȼ�������������Ե����������������Ƿ񱻱��룬���Ǳ���������������ʱ��һ���֣����ԣ�ִ�б���������м����ٶȻ���졣
���ǿ���˵����dofile�Ĵ��ھ���˵�����Խ�Lua��Ϊһ�ֽ��������Ա����á�
ǰ�����ǽ��ܹ�dofile����������Lua���д����chunk��һ��ԭʼ�Ĳ�����
dofileʵ������һ�������ĺ�����������ɹ��ܵĺ�����loadfile��
��dofile��ͬ����loadfile���������м��벢�ҷ��ر�����chunk��Ϊһ������������ִ�д��룻����loadfile�����׳�������Ϣ���Ƿ��ش����롣���ǿ�����������dofile��
--]]

function dofile (filename)
	local f = assert(loadfile(filename))
	return f()
end

dofile("testCompile.lua")
testCompile()

--[[
���loadfileʧ��assert���׳�����
��ɼ򵥵Ĺ���dofile�ȽϷ��㣬�������ļ����벢��ִ�С�Ȼ��loadfile�������ڷ������������£�loadfile����nil�ʹ�����Ϣ���������ǾͿ����Զ��������
���⣬�����������һ���ļ���εĻ���loadfileֻ��Ҫ����һ�Σ����ɶ�����С�dofileȴÿ�ζ�Ҫ���롣
loadstring��loadfile���ƣ�ֻ���������Ǵ��ļ������chunk�����Ǵ�һ�����ж��롣���磺
--]]

f = loadstring("i = i + 1")
-- f����һ������������ʱִ��i=i+1��
i = 0
f()
print(i) --> 1
f()
print(i) --> 2


--[[
loadstring��������ǿ�󣬵�ʹ��ʱ����С�ġ�ȷ��û�������򵥵Ľ������ķ�����ʹ�á�
Lua��ÿһ��chunk����Ϊһ�����������������磺chunk "a = 1"��loadstring��������ȼ۵�function () a = 1 end
����������һ����chunks���Զ���ֲ�����Ҳ���Է���ֵ��
--]]
f = loadstring("local a = 10; return a + 20")
print(f()) --> 30

-- loadfile �� loadstring �������׳�������������������ǽ����� nil ���ϴ�����Ϣ
print(loadstring("i i"))  --> nil    [string "i i"]:1: '=' expected near 'i'


-- ���⣬loadfile��loadstring�������б߽�ЧӦ���������ǽ�������chunk��Ϊ�Լ��ڲ�ʵ�ֵ�һ������������
-- ͨ�������ǵ���������Ƕ����˺�����Lua�еĺ��������Ƿ���������ʱ�ĸ�ֵ�����Ƿ����ڱ���ʱ������������һ���ļ�foo.lua��
--[[
function foo (x)
    print(x)
end
--]]

-- ������ִ������f = loadfile("foo.lua")��foo�������˵���û�б����壬���Ҫ��������������chunk��
f = loadfile("foo.lua")
f()
foo("ok")
-- ��������ݵĵ���dostring��������ز����У�����������
loadstring("s")()

-- ͨ��ʹ��loadstring����һ���ִ�ûʲô���壬���磺
f = loadstring("i = i + 1")
-- �����f = function () i = i + 1 end�ȼۣ����ǵڶ��δ����ٶȸ�����Ϊ��ֻ��Ҫ����һ�Σ���һ�δ���ÿ�ε���loadstring�������±��룬����һ����Ҫ����loadstring�����ʱ�򲻹��Ĵʷ���Χ��
local i = 0
f = loadstring("i = i + 1")
g = function () i = i + 1 end
--[[
��������У��������һ��gʹ�þֲ�����i��Ȼ��fʹ��ȫ�ֱ���i��loadstring������ȫ�ֻ����б������Ĵ���
loadstringͨ���������г����ⲿ�Ĵ��룬���������û��Զ���Ĵ��롣ע�⣺loadstring����һ��chunk������䡣�����Ҫ���ر��ʽ����Ҫ�ڱ��ʽǰ��return�����������ر��ʽ��ֵ�������ӣ�
--]]
print "enter your expression:"
local l = io.read()
local func = assert(loadstring("return " .. l))
print("the value of your expression is " .. func())

-- loadstring���صĺ�������ͨ����һ�������Զ�α����ã�
print "enter function to be plotted (with variable 'x'):"
local l = io.read()
local f = assert(loadstring("return " .. l))
for i=1,20 do
    x = i   -- global 'x' (to be visible from the chunk)
    print(string.rep("*", f()))
end


