--[[
break��������˳���ǰѭ����for��repeat��while������ѭ���ⲿ������ʹ�á�
return�����Ӻ������ؽ������һ��������Ȼ����ʱ����β����һ��Ĭ�ϵ�return�������ֺ�������pascal�Ĺ��̣�procedure����
Lua�﷨Ҫ��break��returnֻ�ܳ�����block�Ľ�βһ�䣨Ҳ����˵����Ϊchunk�����һ�䣬������end֮ǰ������elseǰ������untilǰ�������磺
--]]
a = {1, 2, 3, 4, 5}
local i = 1
v = 3

while a[i] do
    if a[i] == v then
		print(v)
		break
	end
    i = i + 1
end

-- ��ʱ��Ϊ�˵��Ի�������Ŀ����Ҫ��block���м�ʹ��return����break��������ʽ��ʹ��do..end��ʵ�֣�
--[[
function foo ()
    return            --<< SYNTAX ERROR
    -- 'return' is the last statement in the next block
    do return end        -- OK
    ...               -- statements not reached
end
--]]