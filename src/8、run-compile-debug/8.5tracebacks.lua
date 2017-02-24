--[[
��Ȼ�����ʹ���κ����͵�ֵ��Ϊ������Ϣ��ͨ������£�����ʹ���ַ��������������Ĵ���
��������ڲ����󣨱����һ����table��ֵʹ�������±���ʣ�Lua���Լ�����������Ϣ��
����Luaʹ�ô��ݸ�error�����Ĳ�����Ϊ������Ϣ��������ʲô����£�Lua��������������������ⷢ����Ե�ɡ�
--]]
local status, err = pcall(function () a = 'a'+ 1 end)
print(err)
--> stdin:1: attempt to perform arithmetic on a string value
 
local status, err = pcall(function () error("my error") end)
print(err)
--> stdin:1: my error

--[[
�����д�����Ϣ�������ļ�����stdin�����кš�
����error�������еڶ�����������ʾ�������Ĳ㼶�����磬��д��һ������������顰error�Ƿ���ȷ���á���
--]]
function foo (str)
    if type(str) ~= "string" then
       error("string expected")
    end
end

-- �������������ô˺�����
-- foo({x=1})

-- Lua��ָ�������������foo������error��ʵ���ϣ������ǵ���errorʱ�����ġ�Ϊ�˾���������⣬�޸�ǰ��Ĵ�����error����������ڵڶ��������Լ��ĺ����ǵ�һ�������£�
function foo (str)
    if type(str) ~= "string" then
       error("string expected", 2)
    end
end
-- foo({x=1})

--[[
����������ʱ�����ǳ���ϣ���˽���ϸ����Ϣ���������Ǵ�������λ�á�
�����˽⵽��������ʱ��ջ��Ϣ���ͺ��ˣ���pcall���ش�����Ϣʱ���Ѿ��ͷ��˱�������������ջ��Ϣ��
��ˣ�����õ�tracebacks�����Ǳ�����pcall������ǰ��ȡ��Lua�ṩ��xpcall��ʵ��������ܣ�xpcall�����������������ú���������������
��������ʱ��Lua����ջ�ͷ���ǰ���ô�����������˿���ʹ��debug���ռ����������Ϣ��
���������õ�debug��������debug.debug��debug.traceback��ǰ�߸���Lua����ʾ����������Լ����ֲ쿴������ʱ�����������ͨ��traceback��������Ĵ�����Ϣ��
Ҳ�ǿ���̨��������������������Ϣ�ĺ�������������κ�ʱ�����debug.traceback��ȡ��ǰ���е�traceback��Ϣ��
--]]
print(debug.traceback())
