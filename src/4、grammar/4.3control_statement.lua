-- ���ƽṹ���������ʽ����������κ�ֵ��Lua��Ϊfalse��nilΪ�٣�����ֵΪ�档

--[[
if��䣬��������ʽ��
if conditions then
    then-part
end;
 
if conditions then
    then-part
else
    else-part
end;
 
if conditions then
    then-part
elseif conditions then
    elseif-part
..            --->���elseif
else
    else-part
end;
--]]
a  = 10
if a == 10 then
	print(a .. "==" .. 10)
end

if a < 10 then
	print("a < 10")
else
	print("a >= 10")
end

if a < 10 then
	print("a < 10")
elseif a == 10 then
	print("a == 10")
else
	print("a > 10")
end



--[[
while��䣺
while condition do
    statements;
end;
--]]
x = 10
while x > 0 do
	print("x:" .. x)
	x = x - 1
end


--[[
repeat-until��䣺
repeat
    statements;
until conditions;
--]]
y = 5
repeat
	print("y:" .. y)
	y = y + 1
until y > 10



--[[
for����������ࣺ
��һ����ֵforѭ����
for var=exp1,exp2,exp3 do
    loop-part
end

for����exp3��Ϊstep��exp1����ʼֵ����exp2����ֵֹ����ִ��loop-part������exp3����ʡ�ԣ�Ĭ��step=1
�м�����Ҫע�⣺

1. �������ʽֻ�ᱻ����һ�Σ���������ѭ����ʼǰ��
for i=1,f(x) do
    print(i)
end
--]]
 
for i=10,1,-1 do
    print(i)
end
-- ��һ������f(x)ֻ����ѭ��ǰ������һ�Ρ�



--[[
2. ���Ʊ���var�Ǿֲ������Զ�������,����ֻ��ѭ������Ч.
for i=1,10 do
    print(i)
end
max = i       -- probably wrong! 'i' here is global

�����Ҫ�������Ʊ�����ֵ����Ҫ��ѭ���н��䱣��
-- find a value in a list
local found = nil
for i=1,a.n do
    if a[i] == value then
       found = i         -- save value of 'i'
       break
    end
end
print(found)
--]]

-- 3. ѭ�������в�Ҫ�ı���Ʊ�����ֵ���������Ľ���ǲ���Ԥ֪�ġ����Ҫ�˳�ѭ����ʹ��break��䡣
--[[
�ڶ�������forѭ����
ǰ���Ѿ�����һ�����ӣ�
--]]
-- print all values of array 'a'
a = {1,2,3,4,5,6}
for i,v in ipairs(a) do print("v:" .. v) end

--[[
����for���������Ӻ������ص�ÿһ��ֵ��
�ٿ�һ��������key�����ӣ�
--]]
-- print all keys of table 't'
t = {["a"] = 1, ["b"] = 2, c = 3}
for k in pairs(t) do print(k) end


--[[
����for����ֵfor��������ͬ��
1. ���Ʊ����Ǿֲ�����
2. ��Ҫ�޸Ŀ��Ʊ�����ֵ
�ٿ�һ�����ӣ��ٶ���һ����:
--]]
days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
			  
-- ������Ѷ�Ӧ������ת�������ڼ���һ����Ч�ؽ������ķ�ʽ�ǹ���һ�������
revDays = {["Sunday"] = 1, ["Monday"] = 2,
                     ["Tuesday"] = 3, ["Wednesday"] = 4,
                     ["Thursday"] = 5, ["Friday"] = 6, 
                     ["Saturday"] = 7}
					 
-- ����Ϳ��Ժ����׻�ȡ����Ĵ���:
x = "Tuesday"
print(revDays[x])        --> 3

-- ���ǲ���Ҫ�ֹ��������Զ����췴���
revDays = {}
for i,v in ipairs(days) do
    revDays[v] = i
end