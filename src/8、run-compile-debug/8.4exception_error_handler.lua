--[[
�ܶ�Ӧ���У�����Ҫ��Lua���д�����һ����Ӧ������ɡ�ͨ��Ӧ��Ҫ��Lua����һ��chunk����������쳣��Ӧ�ø���Lua���صĴ��������д���
�ڿ���̨ģʽ�µ�Lua��������������쳣����ӡ������Ȼ�������ʾ��ʾ���ȴ���һ�����
�����Lua����Ҫ���������Ҫʹ��pcall������װ��Ĵ��롣
�ٶ���������һ��Lua���룬��δ������й����п��Բ�׽���е��쳣�ʹ���
��һ��������δ����װ��һ��������
function foo ()
    ...
    if unexpected_condition then error() end
    ...
    print(a[i])   -- potential error: `a' may not be a table
    ...
end


�ڶ�����ʹ��pcall�����������
if pcall(foo) then
    -- no errors while running `foo'
    ...
else
    -- `foo' raised an error: take appropriate actions
    ...
end


��ȻҲ���������������ķ�ʽ����pcall��
if pcall(function () ... end) then ...
else ...

pcall�ڱ���ģʽ��protected mode����ִ�к������ݣ�ͬʱ�������е��쳣�ʹ�����һ��������pcall����true�Լ�����ִ�к������ķ���ֵ�����򷵻�nil�ʹ�����Ϣ��
������Ϣ��һ����Ϊ�ַ����������������һ��table�������ݸ�error���κ���Ϣ���ᱻpcall���أ�
--]]
local status, err = pcall(function () error({code=121}) end)
print(err.code)  -->  121

-- �ֻ����ṩ��ǿ�������������Ӧ��Lua�еĸ����쳣�ʹ������������ͨ��error�׳��쳣��Ȼ��ͨ��pcall����֮��
