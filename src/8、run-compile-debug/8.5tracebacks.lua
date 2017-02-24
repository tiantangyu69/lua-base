--[[
虽然你可以使用任何类型的值作为错误信息，通常情况下，我们使用字符串来描述遇到的错误。
如果遇到内部错误（比如对一个非table的值使用索引下标访问）Lua将自己产生错误信息，
否则Lua使用传递给error函数的参数作为错误信息。不管在什么情况下，Lua都尽可能清楚的描述问题发生的缘由。
--]]
local status, err = pcall(function () a = 'a'+ 1 end)
print(err)
--> stdin:1: attempt to perform arithmetic on a string value
 
local status, err = pcall(function () error("my error") end)
print(err)
--> stdin:1: my error

--[[
例子中错误信息给出了文件名（stdin）与行号。
函数error还可以有第二个参数，表示错误发生的层级。比如，你写了一个函数用来检查“error是否被正确调用”：
--]]
function foo (str)
    if type(str) ~= "string" then
       error("string expected")
    end
end

-- 可有人这样调用此函数：
-- foo({x=1})

-- Lua会指出发生错误的是foo而不是error，实际上，错误是调用error时产生的。为了纠正这个问题，修改前面的代码让error报告错误发生在第二级（你自己的函数是第一级）如下：
function foo (str)
    if type(str) ~= "string" then
       error("string expected", 2)
    end
end
-- foo({x=1})

--[[
当错误发生的时候，我们常常希望了解详细的信息，而不仅是错误发生的位置。
若能了解到“错误发生时的栈信息”就好了，但pcall返回错误信息时，已经释放了保存错误发生情况的栈信息。
因此，若想得到tracebacks，我们必须在pcall返回以前获取。Lua提供了xpcall来实现这个功能，xpcall接受两个参数：调用函数、错误处理函数。
当错误发生时，Lua会在栈释放以前调用错误处理函数，因此可以使用debug库收集错误相关信息。
有两个常用的debug处理函数：debug.debug和debug.traceback，前者给出Lua的提示符，你可以自己动手察看错误发生时的情况；后者通过traceback创建更多的错误信息，
也是控制台解释器用来构建错误信息的函数。你可以在任何时候调用debug.traceback获取当前运行的traceback信息：
--]]
print(debug.traceback())
