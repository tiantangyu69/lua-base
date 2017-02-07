-- ָ�ַ������С�lua��8λ�ֽڣ������ַ������԰����κ���ֵ�ַ�������Ƕ���0������ζ������Դ洢����Ķ�����������һ���ַ����Lua���ַ����ǲ������޸ĵģ�����Դ���һ���µı��������Ҫ���ַ��������£�
a = "one string"
b = string.gsub(a, "one", "another")
print(a) -- one string
print(b) -- another string

-- Ϊ�˷��ͳһ�����ʹ��һ�֣�������������Ƕ������������ַ����к������ŵ����������ʹ��ת���\����ʾ��Lua�е�ת�������У�

--[[
\a bell
\b back space               -- ����
\f form feed                -- ��ҳ
\n newline                  -- ����
\r carriage return          -- �س�
\t horizontal tab           -- �Ʊ�
\v vertical tab
\\ backslash                 -- "\"
\" double quote             -- ˫����
\' single quote             -- ������
\[ left square bracket      -- ��������
\] right square bracket     -- ��������
--]]

--[[
���������ַ�����ʹ��\ddd��dddΪ��λʮ�������֣���ʽ��ʾ��ĸ��
"alo\n123\""��'\97lo\10\04923"'����ͬ�ġ�
--]]

-- ������ʹ�����·�ʽ��ʾ�ַ�����������ʽ���ַ������԰�������Ҳ������Ƕ���Ҳ������ת�����У������һ���ַ��ǻ��з��ᱻ�Զ����Ե���������ʽ���ַ�����������һ�δ����Ƿǳ�����ġ�

page = [[
<HTML>
<HEAD>
<TITLE>An HTML Page</TITLE>
</HEAD>
<BODY>
Lua
a text between double brackets
</BODY>
</HTML>
]]
 
io.write(page)

-- ����ʱ��Lua���Զ���string��numbers֮���Զ���������ת������һ���ַ���ʹ������������ʱ��string�ͻᱻת�����֡�
print("10" + 1)
print("10 + 1")
-- print("-5.3e - 10" * "2")   --> -1.06e-09
-- print("hello" + 1)          -- ERROR (cannot convert "hello")

-- ����������Lua����һ��string����������ʱ���Ὣ����ת��string��
print(10 .. 20)      --> 1020


-- ..��Lua�����ַ������ӷ�������һ�����ֺ���д..ʱ��������Ͽո��Է�ֹ�����ʹ�
-- �����ַ��������ֿ����Զ�ת�����������ǲ�ͬ�ģ���10 == "10"�����ıȽ���Զ���Ǵ�ġ������Ҫ��ʽ��stringת�����ֿ���ʹ�ú���tonumber()�����string������ȷ�����ָú���������nil��
line = io.read()         -- read a line
n = tonumber(line)       -- try to convert it to a number
if n == nil then
    error(line .. " is not a valid number")
else
    print(n*2)
end

-- ��֮,���Ե���tostring()������ת���ַ���������ת��һֱ��Ч��
print(tostring(10) == "10")     --> true
print(10 .. "" == "10")         --> true