--[[
Lua�е�table���ڶ������Ϊ�����ǿ��Զ�key-value��ִ�мӲ���������key��Ӧ��value���������е�key-value���������ǲ����Զ�����tableִ�мӲ�����Ҳ�����ԱȽ�������Ĵ�С��
Metatables�������Ǹı�table����Ϊ�����磬ʹ��Metatables���ǿ��Զ���Lua��μ�������table����Ӳ���a+b����Lua��ͼ��������������ʱ���������������Ƿ���һ������Metatable��
���Ҽ��Metatable�Ƿ���__add������ҵ���������__add��������ν��Metamethod��ȥ��������
Lua�е�ÿһ��������Metatable�����������ǽ�����userdataҲ��Metatable����LuaĬ�ϴ���һ������metatable���±�
--]]

t = {}
print(getmetatable(t))      --> nil

-- ����ʹ��setmetatable�������û��߸ı�һ�����metatable
t1 = {}
setmetatable(t, t1)
assert(getmetatable(t) == t1)