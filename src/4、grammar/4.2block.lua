-- ʹ��local����һ���ֲ���������ȫ�ֱ�����ͬ���ֲ�����ֻ�ڱ��������Ǹ����������Ч������飺ָһ�����ƽṹ�ڣ�һ�������壬����һ��chunk���������������Ǹ��ļ������ı�������
x = 10
local i = 1 -- local to the chunk

while i <=x do
	local x = i * 2    -- local to the while body
	print(x)           --> 2, 4, 6, 8, ...
	i = i + 1
end

if i > 20 then
	local x            -- local to the "then" body
	x = 20
	print(x + 2)
else
	print(x)           --> 10  (the global one)
end

print(x)               --> 10  (the global one)

--[[
ע�⣬����ڽ���ģʽ����������ӿ��ܲ�����������Ľ������Ϊ�ڶ���local i=1��һ��������chunk���ڽ���ģʽ��ִ������һ���Lua����ʼһ���µ�chunk��
�����ڶ����i�Ѿ�������������Ч��Χ�����Խ���δ������do..end���൱��c/c++��{}�����С�

Ӧ�þ����ܵ�ʹ�þֲ��������������ô���
1. ����������ͻ
2. ���ʾֲ��������ٶȱ�ȫ�ֱ�������.
���Ǹ�block����һ����ȷ�Ľ��ޣ�do..end�ڵĲ��֡���������õĿ��ƾֲ����������÷�Χ��ʱ�����Ǻ����õġ�
--]]
do
	local a = 3
	local b = 4
	local c = 5
	
    local a2 = 2*a
    local d = b^2 - 4*a*c
    x1 = (-b + d)/a2
    x2 = (-b - d)/a2
end            -- scope of 'a2' and 'd' ends here
 
print(x1, x2)