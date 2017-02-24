--[[
�ܶ�����£���������Ҫ������״̬��Ϣ�����Ǽ򵥵�״̬�����Ϳ��Ʊ�������򵥵ķ�����ʹ�ñհ���
����һ�ַ������ǽ����е�״̬��Ϣ��װ��table�ڣ���table��Ϊ��������״̬��������Ϊ��������¿��Խ����е���Ϣ�����table�ڣ����Ե�������ͨ������Ҫ�ڶ���������
����������дallwords����������һ�����ǲ���ʹ�ñհ�����ʹ�ô���������line, pos����table��
��ʼ�����ĺ����Ǻܼ򵥵ģ������뷵�ص��������ͳ�ʼ״̬��
--]]
local iterator       -- to be defined later
 
function allwords()
    local state = {line = io.read(), pos = 1}
    return iterator, state
end

-- �����Ĵ��������ڵ�����������ɣ�
function iterator (state)
    while state.line do      -- repeat while there are lines
       -- search for next word
       local s, e = string.find(state.line, "%w+", state.pos)
       if s then     -- found a word?
           -- update next position (after this word)
           state.pos = e + 1
           return string.sub(state.line, s, e)
       else   -- word not found
           state.line = io.read()   -- try next line...
           state.pos = 1     -- ... from first position
       end
    end
    return nil        -- no more lines: end loop
end

-- ����Ӧ�þ����ܵ�д��״̬�ĵ���������Ϊ����ѭ����ʱ����for������״̬������Ҫ�������󻨷ѵĴ���С�������������״̬�ĵ�����ʵ�֣�Ӧ������ʹ�ñհ���
-- �����ܲ�Ҫʹ��table���ַ�ʽ����Ϊ�����հ��Ĵ���Ҫ�ȴ���tableС������Lua����հ�Ҫ�ȴ���table�ٶȿ�Щ���������ǻ���������һ��ʹ��Эͬ�������������ķ�ʽ�����ַ�ʽ���ܸ�ǿ�������ӡ�