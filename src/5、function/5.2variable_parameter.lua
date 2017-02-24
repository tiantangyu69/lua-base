-- Lua�������Խ��ܿɱ���Ŀ�Ĳ�������C���������ں��������б���ʹ�����㣨...����ʾ�����пɱ�Ĳ�����Lua�������Ĳ�������һ����arg�ı��У����˲������⣬arg���л���һ����n��ʾ�����ĸ�����
-- ���磬���ǿ�����дprint������
printResult = ""
 
function print2(...)
    for i,v in ipairs(arg) do
       printResult = printResult .. tostring(v) .. "\t"
    end
    printResult = printResult .. "\n"
end

-- ��ʱ�����ǿ�����Ҫ�����̶��������Ͽɱ����
function g(a, b, ...)
end
 
-- CALL              PARAMETERS
 
g(3)              --> a=3, b=nil, arg={n=0}
g(3, 4)           --> a=3, b=4, arg={n=0}
g(3, 4, 5, 8)     --> a=3, b=4, arg={5, 8; n=2}


--[[
��������ʾ��Lua�Ὣǰ���ʵ�δ��������Ĺ̶������������ʵ�η���arg���С�
�ٸ���������ӣ��������ֻ��Ҫstring.find���صĵڶ���ֵ��һ�����͵ķ�����ʹ����Ԫ��dummy variable���»��ߣ���
--]]

local _, x = string.find("hello Lua", "Lua")
-- now use `x'
print(x)


-- ���������ÿɱ��������һ��select������
function select (n, ...)
    return arg[n]
end
print(string.find("hello hello", " hel")) --> 6  9
print(select(1, string.find("hello hello", " hel"))) --> 6
print(select(2, string.find("hello hello", " hel"))) --> 9

-- ��ʱ����Ҫ�������Ŀɱ�������ݸ�����ĺ������ã�����ʹ��ǰ������˵����unpack(arg)����arg�����еĿɱ������Lua�ṩ��һ���ı���ʽ���ĺ���string.format������C���Ե�sprintf��������
function fwrite(fmt, ...)
    return io.write(string.format(fmt, unpack(arg)))
end
-- ������ӽ��ı���ʽ��������д�������Ϊһ��������