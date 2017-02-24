--[[
Errare humanum est����������������˵ı��ԣ�����������Ҫ�����ܵķ�ֹ����ķ�����Lua������Ϊ��չ����Ƕ���ڱ��Ӧ���У����Բ��ܵ�������ʱ�򵥵ı��������˳���
�෴����������ʱLua������ǰ��chunk�����ص�Ӧ���С�
��Lua���������������ʱ�ͻ��׳����󣬱��磺���������ֽ�����ӣ�����һ���Ǻ����ı��������ʱ��в����ڵ�ֵ�ȡ�
��Ҳ����ͨ������error������ʽ���׳�����error�Ĳ�����Ҫ�׳��Ĵ�����Ϣ��
--]]
print "enter a number:"
n = io.read("*number")
if not n then 
	error("invalid input")
else
	print(n)
end

-- Lua�ṩ��ר�ŵ����ú���assert������������ƵĹ��ܣ�
print "enter a number:"
n = assert(io.read("*number"), "invalid input")
-- assert���ȼ���һ����������û���⣬assert�����κ����飻����assert�Եڶ���������Ϊ������Ϣ�׳����ڶ��������ǿ�ѡ�ġ�
-- ע�⣬assert�����ȴ�������������Ȼ��ŵ��ú���������������룬����n�Ƿ�Ϊ���֣��ַ������Ӳ����ܻ�ִ�У�
n = io.read()
assert(tonumber(n), "invalid input: " .. n .. " is not a number")

-- �����������쳣�����������Ķ��������ش����������׳�����ѡ����һ�ַ�ʽ��û�й̶��Ĺ��򣬲���������ԭ���ǣ����ڳ����߼����ܹ�������쳣�����׳�����ķ�ʽ����֮�����򷵻ش�����롣
-- ����sin�������ٶ�������sin��������ʱ���ش�����룬��ʹ��sin�Ĵ�����ܱ�Ϊ��
local res = math.sin(x)
-- if not res then      -- error

-- ��Ȼ������Ҳ�����ڵ���sinǰ���x�Ƿ�Ϊ���֣�
-- if not tonumber(x) then     error: x is not a number

--[[
����ʵ�ϣ����ǼȲ��Ǽ�����Ҳ���Ǽ�鷵�ؽ������Ϊ�������������ζ�����ǵĳ���ĳ���ط��������⣬��������£������쳣�����ʵ�ʵķ�ʽ���׳���������ֹ��������С�
������һ�����ӡ�io.open�������ڴ��ļ�������ļ������ڣ��������Σ��ܶ�ϵͳ�У�����ͨ��������ȥ���ļ������ж��ļ��Ƿ���ڡ�
�������io.open���ܴ��ļ��������ļ������ڻ���û��Ȩ�ޣ�����������nil�ʹ�����Ϣ���������ַ�ʽ�����ǿ���ͨ�����û����������磺�Ƿ�Ҫ����һ���ļ�������ش������⣺
--]]
local file, msg
repeat
    print "enter a file name:"
    local name = io.read()
    if not name then return end     -- no input
    file, msg = io.open(name, "r")
    if not file then print(msg) end
until file

-- �������͵�����봦����Щ�����������밲ȫ�����У�����ʹ��assert��
file = assert(io.open(name, "r"))

-- Lua����һ��ϰ�ߣ����io.openʧ�ܣ�assert���׳�����
file = assert(io.open("no-file", "r"))
       --> stdin:1: no-file: No such file or directory
	   
-- ע�⣺io.open���صĵڶ��������������Ϣ������Ϊassert�ĵڶ���������