-- Lua�������Է��ض�����ֵ������string.find���䷵��ƥ�䴮����ʼ�ͽ������±ꡱ�����������ƥ�䴮����nil����
s, e = string.find("hello Lua users", "Lua")
print(s, e)

-- Lua�����У���return���г�Ҫ���ص�ֵ���б��ɷ��ض�ֵ���磺
function maximum (a)
    local mi = 1             -- maximum index
    local m = a[mi]          -- maximum value
    for i,val in ipairs(a) do
       if val > m then
           mi = i
           m = val
       end
    end
    return m, mi
end
 
print(maximum({8,10,23,12,5}))     --> 23   3

-- Lua���ǵ�����������ֵ�ĸ��������õ��û���������Ϊ�����������ú���ʱ�����з���ֵ�������ԡ���������������������
function foo0 () end                   -- returns no results
function foo1 () return 'a' end        -- returns 1 result
function foo2 () return 'a','b' end    -- returns 2 results

--[[
��һ������Ϊ���ʽ���ú���ʱ�������¼��������
1. ��������Ϊ���ʽ���һ���������߽���һ������ʱ�����ݱ����������������ܶ�ط��ض��ֵ�����㲹nil��������ȥ��
2. ��������£��������ý����ص�һ��ֵ�����û�з���ֵΪnil��
--]]
x,y = foo2()             -- x='a', y='b'
x = foo2()               -- x='a', 'b' is discarded
x,y,z = 10,foo2()        -- x=10, y='a', z='b'
 
x,y = foo0()             -- x=nil, y=nil
x,y = foo1()             -- x='a', y=nil
x,y,z = foo2()           -- x='a', y='b', z=nil
 
x,y = foo2(), 20         -- x='a', y=20
x,y = foo0(), 20, 30     -- x='nil', y=20, 30 is discarded

-- �ڶ�������������Ϊ��������������ʱ���Ͷ�ֵ��ֵ����ͬ��
print(foo0())            -->
print(foo1())            --> a
print(foo2())            --> a   b
print(foo2(), 1)         --> a   1
print(foo2() .. "x")     --> ax

-- ���������������ڱ��캯���г�ʼ��ʱ���Ͷ�ֵ��ֵʱ��ͬ��
a = {foo0()}             -- a = {}    (an empty table)
a = {foo1()}             -- a = {'a'}
a = {foo2()}             -- a = {'a', 'b'}
 
a = {foo0(), foo2(), 4}  -- a[1] = nil, a[2] = 'a', a[3] = 4

-- ���⣬return f()������ʽ���򷵻ء�f()�ķ���ֵ����
function foo (i)
    if i == 0 then
		return foo0()
    elseif i == 1 then
		return foo1()
    elseif i == 2 then
		return foo2()
    end
end
print("---------------------------------------------")
print(foo(1))        --> a
print(foo(2))        --> a  b
print(foo(0))        -- (no results)
print(foo(3))        -- (no results)

-- ����ʹ��Բ����ǿ��ʹ���÷���һ��ֵ��
print((foo0()))      --> nil
print((foo1()))      --> a
print((foo2()))      --> a
-- һ��return������ʹ��Բ���Ž�����ֵ������Ҳ�����·���һ��ֵ��

--[[
������ֵ���ص����⺯��unpack������һ��������Ϊ����������������������Ԫ�ء�
unpack������ʵ�ַ��͵��û��ƣ���C�����п���ʹ�ú���ָ����ÿɱ�ĺ������������������ɱ�ĺ���������������ͬʱ�ɱ䡣
��Lua�����������ÿɱ�����Ŀɱ亯��ֻ��Ҫ������
f(unpack(a))
--]]
-- unpack����a���е�Ԫ����Ϊf()�Ĳ���
f = string.find
a = {"hello", "ll"}
print(f(unpack(a)))      --> 3  4

-- Ԥ�����unpack��������C����ʵ�ֵģ�����Ҳ������Lua����ɣ�
function unpack(t, i)
    i = i or 1
    if t[i] then
       return t[i], unpack(t, i + 1)
    end
end