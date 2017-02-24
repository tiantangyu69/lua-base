--[[
��һ�������ڲ�Ƕ����һ����������ʱ���ڲ��ĺ�������Է����ⲿ�ĺ����ľֲ������������������ǳ����ʷ����硣��Ȼ�⿴�������������ʵ������ˣ��ʷ�������ϵ�һ�ຯ���ڱ����������һ������ǿ��ĸ�����������ṩ����֧�֡�
���濴һ���򵥵����ӣ��ٶ���һ��ѧ���������б��һ��ѧ�����ͳɼ���Ӧ�ı����������ѧ���ĳɼ��Ӹߵ��Ͷ�ѧ���������򣬿�����������
--]]
names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}
table.sort(names, function (n1, n2)
    return grades[n1] > grades[n2]    -- compare the grades
end)

-- �ٶ�����һ������ʵ�ִ˹��ܣ�
function sortbygrade (names, grades)
    table.sort(names, function (n1, n2)
       return grades[n1] > grades[n2]    -- compare the grades
    end)
end

-- �����а�����sortbygrade�����ڲ���sort�е������������Է���sortbygrade�Ĳ���grades�������������ڲ�grades����ȫ�ֱ���Ҳ���Ǿֲ����������ǳ����ⲿ�ľֲ�������external local variable������upvalue��
--��upvalue��˼��Щ�󵼣�Ȼ����Lua�����Ĵ�������ʷ�ĸ�Դ������������external local variable��̣���
-- ������Ĵ��룺
function newCounter()
	local i = 0
	return function()   -- anonymous function
		i = i + 1
		return i
	end
end

c1 = newCounter()
print(c1())
print(c1())

-- ��������ʹ��upvalue i�������ļ����������ǵ�������������ʱ��i�Ѿ����������÷�Χ����Ϊ����i�ĺ���newCounter�Ѿ������ˡ�
-- Ȼ��Lua�ñհ���˼����ȷ����������������򵥵�˵���հ���һ�������Լ�����upvalues����������ٴε���newCounter��������һ���µľֲ�����i��������ǵõ���һ���������µı���i�ϵ��±հ���
c2 = newCounter()
print(c2())  --> 1
print(c1())  --> 3
print(c2())  --> 2

--[[
c1��c2�ǽ�����ͬһ�������ϣ���������ͬһ���ֲ������Ĳ�ͬʵ���ϵ�������ͬ�ıհ���
�������������հ�ֵָ������ָ���������������Ǳհ���һ��ԭ��������������ˣ��ڲ��ᵼ�»�������������Ǽ���ʹ�����ﺯ����ָ�հ���
�հ��������Ļ������ṩ�����õĹ��ܣ���ǰ�����Ǽ����Ŀ�����Ϊ�߼�������sort���Ĳ�������Ϊ����Ƕ�׵ĺ�����newCounter����
��һ����ʹ�����ǿ�����Lua�ĺ�����������ϳ���õı�̼������հ�Ҳ�����ڻص������У�������GUI����������Ҫ����һϵ��button��
���û�����buttonʱ�ص����������ã����ܲ�ͬ�İ�ť������ʱ��Ҫ����������е����𡣾���������һ��ʮ���Ƽ�������Ҫ10�����Ƶİ�ť��ÿ����ť��Ӧһ�����֣�����ʹ������ĺ����������ǣ�
--]]
function digitButton (digit)
    return Button{  label = digit,
           action = function ()
              add_to_display(digit)
           end
    }
end

-- ������������Ǽٶ�Button��һ�����������°�ť�Ĺ��ߣ� label�ǰ�ť�ı�ǩ��action�ǰ�ť������ʱ���õĻص�������
--��ʵ������һ���հ�����Ϊ������upvalue digit����digitButton������񷵻غ󣬾ֲ�����digit������Χ���ص�������Ȼ���Ա����ò��ҿ��Է��ʾֲ�����digit��



-- �հ�����ȫ��ͬ����������Ҳ�Ǻ�����;�ġ���Ϊ�������洢����ͨ�ı��������ǿ��Ժܷ�����ض������Ԥ���庯����
-- ͨ��������Ҫԭʼ������һ���µ�ʵ��ʱ�����ض��庯��������������ض���sinʹ�����һ�����������ǻ�����Ϊ������
oldSin = math.sin
math.sin = function (x)
    return oldSin(x*math.pi/180)
end
-- ������ķ�ʽ��
do
    local oldSin = math.sin
    local k = math.pi/180
    math.sin = function (x)
       return oldSin(x*k)
    end
end

-- �������ǰ�ԭʼ�汾����һ���ֲ������ڣ�����sin��Ψһ��ʽ��ͨ���°汾�ĺ�����
-- ����ͬ�����������ǿ��Դ���һ����ȫ�Ļ�����Ҳ����ɳ�䣬��java���ɳ��һ����������������һ�β����εĴ��루����������������������ϻ�ȡ�Ĵ��룩ʱ��ȫ�Ļ�������Ҫ�ģ�
-- �������ǿ���ʹ�ñհ��ض���io���open���������Ƴ���򿪵��ļ���
do
    local oldOpen = io.open
    io.open = function (filename, mode)
       if access_OK(filename, mode) then
           return oldOpen(filename, mode)
       else
           return nil, "access denied"
       end
    end
end
