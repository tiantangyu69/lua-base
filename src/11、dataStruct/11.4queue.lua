-- ��Ȼ����ʹ��Lua��table���ṩ��insert��remove������ʵ�ֶ��У������ַ�ʽʵ�ֵĶ�����Դ�������ʱЧ��̫�ͣ���Ч�ķ�ʽ��ʹ�����������±꣬һ����ʾ��һ��Ԫ�أ���һ����ʾ���һ��Ԫ�ء�
function ListNew ()
    return {first = 0, last = -1}
end

-- Ϊ�˱�����Ⱦȫ�������ռ䣬������д����Ĵ��룬�������һ����Ϊlist��table�У�
List = {}
function List.new ()
    return {first = 0, last = -1}
end

-- ���棬���ǿ����ڳ���ʱ���ڣ�����ڶ��е����˽��в����ɾ�������ˡ�
function List.pushleft (list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end
 
function List.pushright (list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end
 
function List.popleft (list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil    -- to allow garbage collection
    list.first = first + 1
    return value
end
 
function List.popright (list)
    local last = list.last
    if list.first > last then error("list is empty") end
    local value = list[last]
    list[last] = nil     -- to allow garbage collection
    list.last = last - 1
    return value
end

--[[
���ϸ������ϵĶ�������������ֻ�ܵ���pushright��popleft������������first��last������ֵ����֮���ӣ����˵�������ʹ�õ���Lua��tableʵ�ֵģ�
����Է��������Ԫ�أ�ͨ��ʹ���±��1��20��Ҳ����16,777,216 �� 16,777,236�����⣬Luaʹ��˫���ȱ�ʾ���֣��ٶ���ÿ����ִ��100��β������������ֵ�����ǰ��ĳ����������200�ꡣ
--]]

l = List.new()
List.pushright(l, 1)
List.pushright(l, 12)
List.pushright(l, 123)

print(List.popleft(l))
print(List.popleft(l))
print(List.popleft(l))
print(List.popleft(l))