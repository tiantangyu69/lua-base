--[[
Lua�к�������һ����Ȥ�������ǿ�����ȷ�Ĵ���β���ã�proper tail recursion��һЩ��ʹ�����β�ݹ顱����Ȼ��δ�漰���ݹ�ĸ����
β������һ�������ں�����β��goto���ã����������һ�������ǵ�������һ������ʱ�����ǳ����ֵ���β���á����磺
--]]
function f(x)
    return g(x)
end

--[[
g�ĵ�����β���á�
������f����g�󲻻������κ����飬��������µ������ú���g����ʱ������Ҫ���ص�������f������β����֮�������Ҫ��ջ�б������ڵ����ߵ��κ���Ϣ��һЩ����������Lua�������������������ڴ���β����ʱ��ʹ�ö����ջ�����ǳ���������֧����ȷ��β���á�
����β���ò���Ҫʹ��ջ�ռ䣬��ôβ���õݹ�Ĳ�ο��������Ƶġ�����������ò���nΪ��ֵ���ᵼ��ջ�����
--]]
function foo (n)
    if n > 0 then return foo(n - 1) end
end

--[[
��Ҫע����ǣ�������ȷʲô��β���á�
һЩ�����ߺ�����������������Ҳû�������������鵫������β���á����磺
--]]
function f (x)
    g(x)
    return
end
--[[ �������������f�ڵ���g�󣬲��ò�����g�ط���ֵ�����Բ���β���ã�ͬ�������漸������Ҳ����β���ã�
return g(x) + 1      must do the addition
return x or g(x)     must adjust to 1 result
return (g(x))        must adjust to 1 result
--]]

-- Lua������return g(...)���ָ�ʽ�ĵ�����β���á�����g��g�Ĳ����������Ǹ��ӱ��ʽ����ΪLua���ڵ���֮ǰ������ʽ��ֵ����������ĵ�����β���ã�
-- return x[i].foo(x[j] + a*b, i + j)

--[[
���Խ�β��������һ��goto����״̬���ı������β�����Ƿǳ����õġ�״̬����Ӧ��Ҫ������סÿһ��״̬���ı�״ֻ̬��Ҫgoto(or call)һ���ض��ĺ�����
���ǿ���һ���Թ���Ϸ��Ϊ���ӣ��Թ��кܶ�����䣬ÿ�������ж����ϱ��ĸ��ţ�ÿһ������һ���ƶ��ķ�������÷�����ڼ�����÷����Ӧ�ķ��䣬��������ӡ������Ϣ��Ŀ���ǣ��ӿ�ʼ�ķ��䵽��Ŀ�ķ��䡣
����Թ���Ϸ�ǵ��͵�״̬����ÿ����ǰ�ķ�����һ��״̬�����ǿ��Զ�ÿ������дһ������ʵ������Թ���Ϸ������ʹ��β���ô�һ�������ƶ�������һ�����䡣һ���ĸ�������Թ��������£�
--]]
function room1 ()
    local move = io.read()
    if move == "south" then
       return room3()
    elseif move == "east" then
       return room2()
    else
       print("invalid move")
       return room1()   -- stay in the same room
    end
end
 
function room2 ()
    local move = io.read()
    if move == "south" then
       return room4()
    elseif move == "west" then
       return room1()
    else
       print("invalid move")
       return room2()
    end
end
 
function room3 ()
    local move = io.read()
    if move == "north" then
       return room1()
    elseif move == "east" then
       return room4()
    else
       print("invalid move")
       return room3()
    end
end
 
function room4 ()
    print("congratilations!")
end

--[[
���ǿ��Ե���room1()��ʼ�����Ϸ��
���û����ȷ��β���ã�ÿ���ƶ���Ҫ����һ��ջ������ƶ�����ܵ���ջ�����
����ȷ��β���ÿ��������Ƶ�β���ã���Ϊÿ��β����ֻ��һ��goto������һ�����������Ǵ�ͳ�ĺ������á�
--]]
room1()
