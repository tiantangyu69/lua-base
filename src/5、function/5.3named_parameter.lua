-- Lua�ĺ��������Ǻ�λ����صģ�����ʱʵ�λᰴ˳�����δ����βΡ���ʱ��������ָ�������Ǻ����õģ�����rename����������һ���ļ�����������ʱ���������Ǽǲ�������ǰ������������˳���ˣ�
-- invalid code
-- rename(old="temp.lua", new="temp1.lua")

-- ������δ�������Ч�ģ�Lua����ͨ�������еĲ�������һ�����У��ѱ���Ϊ������Ψһ������ʵ���������α����Ĺ��ܡ���ΪLua�﷨֧�ֺ�������ʱʵ�ο����Ǳ�Ĺ��졣
rename{old="temp.lua", new="temp1.lua"}

-- ��������뷨�����ض�����rename��
function rename (arg)
    return os.rename(arg.old, arg.new)
end

-- �������Ĳ����ܶ��ʱ�����ֺ��������Ĵ��ݷ�ʽ�ܷ���ġ�����GUI���д�������ĺ����кܶ�������Ҵ󲿷ֲ����ǿ�ѡ�ģ��������������ַ�ʽ��
w = Window {
    x=0, y=0, width=300, height=200,
    title = "Lua", background="blue",
    border = true
}
 
function Window (options)
    -- check mandatory options
    if type(options.title) ~= "string" then
       error("no title")
    elseif type(options.width) ~= "number" then
       error("no width")
    elseif type(options.height) ~= "number" then
       error("no height")
    end
 
    -- everything else is optional
    _Window(options.title,
       options.x or 0,          -- default value
       options.y or 0,          -- default value
       options.width, options.height,
       options.background or "white",  -- default
       options.border           -- default is false (nil)
    )
end