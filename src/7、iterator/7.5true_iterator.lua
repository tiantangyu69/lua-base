--[[
��������������һЩ�󵼣���Ϊ����û�е�������ɵ������ܵ���for��䣬Ҳ����õĽз�Ӧ������������generator�����������������Ա���java��C++��������˵���Ѿ����ձ��ˣ�����Ҳ������������
��һ�ַ�ʽ����һ�����ڲ���ɵ����ĵ�����������������ʹ�õ�������ʱ��Ͳ���Ҫʹ��ѭ���ˣ����ǽ���ʹ��ÿһ�ε�����Ҫ�����������Ϊ�������õ��������ɣ������˵������������һ��������Ϊ������������������ڵ������ڲ������á�
��Ϊһ����������ӣ�����ʹ��������ʽ��дallwords��������
--]]

function allwords (f)
    -- repeat for each line in the file
    for l in io.lines() do
       -- repeat for each word in the line
       for w in string.gfind(l, "%w+") do
           -- call the function
           f(w)
       end
    end
end

-- ���������Ҫ��ӡ�����ʣ�ֻ��Ҫ
allwords(print)

-- ��һ�������������ʹ������������Ϊ��Ϊ��������������Ӵ�ӡ������'hello'���ֵĴ�����
local count = 0
allwords(function (w)
    if w == "hello" then count = count + 1 end
end)
print(count)

-- ��for�ṹ���ͬ��������
local count = 0
for w in allwords() do
    if w == "hello" then count = count + 1 end
end
print(count)

--[[
�����ĵ���������д����Lua�ϰ汾�к����У���ʱ��û��forѭ����
���ַ���д�����󣬵�Ҳ������
	һ���棬�ڶ��ַ���������д����⣻
	��һ���棬for�ṹ��������ʹ��break��continue��䣻�������ĵ��������д����return���ֻ�Ǵ����������з��ض������˳�ѭ����
--]]