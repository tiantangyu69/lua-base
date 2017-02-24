-- Lua�к���������Ϊȫ�ֱ���Ҳ������Ϊ�ֲ������������Ѿ�����һЩ���ӣ�������Ϊtable���򣨴󲿷�Lua��׼��ʹ�����ֻ�����ʵ�ֵı���io.read��math.sin������������£�����ע�⺯���ͱ��﷨��

-- 1. ��ͺ�������һ��
Lib = {}
Lib.foo = function(x, y)
	return x + y
end

Lib.goo = function(x, y)
	return x - y
end


-- 2. ʹ�ñ��캯��
Lib = {
	foo = function(x, y) return x + y end,
	goo = function(x, y) return x -y end
}

-- 3. Lua �ṩ��һ���﷨��ʽ
Lib = {}
function Lib.foo(x, y)
	return x + y
end

function Lib.goo(x, y)
	return x - y
end

-- �����ǽ�����������һ���ֲ�������ʱ�����ǵõ�һ���ֲ�������Ҳ����˵�ֲ�������ֲ�����һ����һ����Χ����Ч��
-- ���ֶ����ڰ����Ƿǳ����õģ���ΪLua��chunk��������������chunk�ڿ��������ֲ�������������chunk�ڿɼ�����
-- �ʷ����籣֤�˰��ڵ������������Ե��ô˺����������������ֲ����������ַ�ʽ��
--[[
1. ��ʽһ
local f = function (...)
    ...
end
 
local g = function (...)
    ...
    f()   -- external local `f' is visible here
    ...
end
2. ��ʽ��
local function f (...)
    ...
end
--]]

-- ��һ����Ҫע������������ݹ�ֲ������ķ�ʽ��
local fact = function (n)
    if n == 0 then
       return 1
    else
       return n*fact(n-1)   -- buggy
    end
end

-- �������ַ�ʽ����Lua����ʱ����fact(n-1)����֪�����Ǿֲ�����fact��Lua��ȥ�����Ƿ���������ȫ�ֺ���fact��Ϊ�˽������������Ǳ����ڶ��庯����ǰ��������
local fact
 
fact = function (n)
    if n == 0 then
       return 1
    else
       return n*fact(n-1)
    end
end

--[[
������fact�ڲ�fact(n-1)������һ���ֲ��������ã�����ʱfact�Ϳ��Ի�ȡ��ȷ��ֵ�ˡ�
����Lua��չ�������﷨ʹ�ÿ�����ֱ�ӵݹ麯������ʱʹ�����ַ�ʽ�����ԡ�
�ڶ����ֱ�ӵݹ�ֲ�����ʱҪ������Ȼ����ſ��ԣ�
--]]
local f, g        -- `forward' declarations
 
function g ()
	f()
end
 
function f ()
	g()
end