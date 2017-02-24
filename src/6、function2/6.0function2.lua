--[[
Lua�еĺ����Ǵ��дʷ����磨lexical scoping���ĵ�һ��ֵ��first-class values����
��һ��ֵָ����Lua�к���������ֵ����ֵ���ַ�����һ�����������Ա�����ڱ����У�Ҳ���Դ���ڱ��У�������Ϊ�����Ĳ�������������Ϊ�����ķ���ֵ��
�ʷ�����ָ��Ƕ�׵ĺ������Է������ⲿ�����еı�������һ���Ը�Lua�ṩ��ǿ��ı��������
Lua�й��ں�����΢���������Ǻ���Ҳ����û�����֣������ġ��������ᵽ������������print����ʵ������˵һ��ָ�����ı������������������ֵ�ı���һ����
--]]

local now = os.date("%Y-%m-%d %H:%M:%S")
print(now)

a = {p = print}
a.p("Hello World")   --> Hello World
print = math.sin  -- `print' now refers to the sine function
a.p(print(1))     --> 0.841470
sin = a.p         -- `sin' now refers to the print function
sin(10, 20)       --> 10   20

-- ��Ȼ������ֵ����ô���ʽҲ���Դ��������ˣ�Lua�����Ǿ�������д��
function foo (x) return 2*x end

-- ��ʵ������Lua�﷨��������������ԭ���ĺ�����
foo = function (x) return 2*x end

--[[
��������ʵ������һ����ֵ��䣬������Ϊfunction�ı�������һ������������ʹ��function (x) ... end������һ��������ʹ��{}����һ����һ����
table��׼���ṩһ��������������һ������Ϊ�����������������е�Ԫ�ء�
������������ܹ��Բ�ͬ���͵�ֵ���ַ���������ֵ����������߽����������
Lua���Ǿ����ܶ���ṩ������������Щ�������Ҫ�����ǽ���һ����������Ϊ����������C++�ĺ������󣩣�������������������Ԫ����Ϊ������������ҷ������ߵĴ�С��ϵ��
���磺
--]]

network = {
    {name = "grauna",    IP = "210.26.30.34"},
    {name = "arraial",   IP = "210.26.30.23"},
    {name = "lua",       IP = "210.26.23.12"},
    {name = "derain",    IP = "210.26.23.20"},
}

-- ���������ͨ�����name������
table.sort(network, function (a,b)
    return (a.name > b.name)
end)

-- ������������Ϊ�����ĺ�����Lua�б������߼�������higher-order function�����������sort����Lua�У��߼���������ͨ����û����������ֻ�ǰѡ���Ϊ�����ĺ�����������һ��ֵ��first-class value��������ѡ�
-- �������һ����ͼ���������ӣ�
function eraseTerminal()
    io.write("\27[2J")
end
 
-- writes an '*' at column 'x' , 'row y'
function mark (x,y)
    io.write(string.format("\27[%d;%dH*", y, x))
end
 
-- Terminal size
TermSize = {w = 80, h = 24}
 
-- plot a function
-- (assume that domain and image are in the range [-1,1])
function plot (f)
    eraseTerminal()
    for i=1,TermSize.w do
       local x = (i/TermSize.w)*2 - 1
       local y = (f(x) + 1)/2 * TermSize.h
       mark(i, y)
    end
    io.read()  -- wait before spoiling the screen
end

plot(function (x) return math.sin(x*2*math.pi) end)

