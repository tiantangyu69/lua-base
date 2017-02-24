--[[
�ٶ������г���һ��Դ�����г��ֵ����б�ʾ����ĳ�̶ֳ��ϣ�����Ҫ���˵���Щ���Ա���ı����֡�һЩC����Աϲ����һ���ַ�����������ʾ��
�����еı����ַ��������У���ÿһ����ʾ������������в��ҿ��Ƿ�Ϊ�����֣���ʱ��Ϊ����߲�ѯЧ�ʣ�������洢��ʱ��ʹ�ö��ֲ��һ���hash�㷨��
Lua�б�ʾ���������һ������Ч�ķ����������м����е�Ԫ����Ϊ�±�����һ��table����治��Ҫ����table��ֻ��Ҫ���Կ����ڸ�����Ԫ�أ���Ķ�Ӧ�±��Ԫ��ֵ�Ƿ�Ϊnil�����磺
--]]
reserved = {
    ["while"] = true,    ["end"] = true,
    ["function"] = true, ["local"] = true,
}
--[[
for w in allwords() do
    if reserved[w] then
    -- `w' is a reserved word
    ...
--]]

-- ������ʹ�ø����������������Ĺ��켯�ϣ�
function Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end
 
reserved = Set{"while", "end", "function", "local", }