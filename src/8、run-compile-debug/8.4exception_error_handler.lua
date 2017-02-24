--[[
很多应用中，不需要在Lua进行错误处理，一般由应用来完成。通常应用要求Lua运行一段chunk，如果发生异常，应用根据Lua返回的错误代码进行处理。
在控制台模式下的Lua解释器如果遇到异常，打印出错误然后继续显示提示符等待下一个命令。
如果在Lua中需要处理错误，需要使用pcall函数封装你的代码。
假定你想运行一段Lua代码，这段代码运行过程中可以捕捉所有的异常和错误。
第一步：将这段代码封装在一个函数内
function foo ()
    ...
    if unexpected_condition then error() end
    ...
    print(a[i])   -- potential error: `a' may not be a table
    ...
end


第二步：使用pcall调用这个函数
if pcall(foo) then
    -- no errors while running `foo'
    ...
else
    -- `foo' raised an error: take appropriate actions
    ...
end


当然也可以用匿名函数的方式调用pcall：
if pcall(function () ... end) then ...
else ...

pcall在保护模式（protected mode）下执行函数内容，同时捕获所有的异常和错误。若一切正常，pcall返回true以及“被执行函数”的返回值；否则返回nil和错误信息。
错误信息不一定仅为字符串（下面的例子是一个table），传递给error的任何信息都会被pcall返回：
--]]
local status, err = pcall(function () error({code=121}) end)
print(err.code)  -->  121

-- 种机制提供了强大的能力，足以应付Lua中的各种异常和错误情况。我们通过error抛出异常，然后通过pcall捕获之。
