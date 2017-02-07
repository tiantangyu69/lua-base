-- �������Ǵ����ͳ�ʼ����ı��ʽ������Lua���еĹ���ǿ��Ķ�������򵥵Ĺ��캯����{}����������һ���ձ�����ֱ�ӳ�ʼ������:
days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}

-- Lua��"Sunday"��ʼ��days[1]����һ��Ԫ������Ϊ1������"Monday"��ʼ��days[2]...
print(days[4])       --> Wednesday

-- ���캯������ʹ���κα��ʽ��ʼ����
function sin(x)
	return x
end
	
tab = {sin(1), sin(2), sin(3), sin(4), sin(5),sin(6), sin(7), sin(8)}
print(tab)

-- ������ʼ��һ������Ϊrecordʹ�ÿ���������
a = {x=1, y=3}       -->       a = {}; a.x=0; a.y=0
print(a.x)

-- �����ú��ַ�ʽ����table�����Ƕ������������ӻ���ɾ���κ����͵��򣬹��캯������Ӱ���ĳ�ʼ����
w = {x=0, y=0, label="console"}
x = {sin(0), sin(1), sin(2)}
w[1] = "another field"
x.f = w
print(w["x"])     --> 0
print(w[1])       --> another field
print(x.f[1])     --> another field
w.x = nil         -- remove field "x"


-- ��ͬһ�����캯���п��Ի���б����record�����г�ʼ�����磺
polyline = {color="blue", thickness=2, npoints=4,
              {x=0,   y=0},
              {x=-10, y=0},
              {x=-10, y=1},
              {x=0,   y=1}
}
-- �������Ҳ�������ǿ���Ƕ�׹��캯������ʾ���ӵ����ݽṹ.
print(polyline[2].x)     --> -10


-- ÿ�ε��ù��캯����Lua���ᴴ��һ���µ�table������ʹ��table����һ��list��
--[[
list = nil
for line in io.lines() do
    list = {next=list, value=line}
end
--]]
-- ��δ���ӱ�׼�������ÿ�У�Ȼ�����γ���������Ĵ����ӡ��������ݣ�

-- �������ֹ��캯���ĳ�ʼ����ʽ�������ƣ������㲻��ʹ�ø�������ʼ��һ������Ԫ�أ��ַ�������Ҳ���ܱ�ǡ���ı�ʾ���������һ�ָ�һ��ĳ�ʼ����ʽ��������[expression]��ʾ�ı�ʾ������ʼ����������
opnames = {["+"] = "add", ["-"] = "sub",
              ["*"] = "mul", ["/"] = "div"}
 
i = 20; s = "-"
a = {[i+0] = s, [i+1] = s..s, [i+2] = s..s..s}
 
print(opnames[s])    --> sub
print(a[22])         --> ---

-- list����ʼ����record����ʼ��������һ���ʼ��������:
a = {x=0, y=0}        -->       {["x"]=0, ["y"]=0}
a = {"red", "green", "blue"}        --> {[1]="red", [2]="green", [3]="blue"}

-- ��������Ҫ�����±��0��ʼ��
days = {[0]="Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}

-- ע�⣺���Ƽ������±��0��ʼ������ܶ��׼�ⲻ��ʹ�á�
-- �ڹ��캯��������","�ǿ�ѡ�ģ����Է����Ժ����չ��
a = {[1]="red", [2]="green", [3]="blue",}

-- �ڹ��캯������ָ������ţ�","�������÷ֺţ�";"�������ͨ������ʹ�÷ֺ������ָͬ���͵ı�Ԫ�ء�
a = {x=10, y=45; "one", "two", "three"}
print(a[1])

