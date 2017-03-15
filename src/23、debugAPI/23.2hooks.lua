--[[
debug库的hook是这样一种机制：注册一个函数，用来在程序运行中某一事件到达时被调用。有四种可以触发一个hook的事件：当Lua调用一个函数的时候call事件发生；
每次函数返回的时候，return事件发生；Lua开始执行代码的新行时候，line事件发生；运行指定数目的指令之后，count事件发生。Lua使用单个参数调用hooks，参数
为一个描述产生调用的事件："call"、"return"、"line" 或 "count"。另外，对于line事件，还可以传递第二个参数：新行号。我们在一个hook内总是可以使用debug.getinfo获取更多的信息。
使用带有两个或者三个参数的debug.sethook 函数来注册一个hook：第一个参数是hook函数；第二个参数是一个描述我们打算监控的事件的字符串；可选的第三个参数
是一个数字，描述我们打算获取count事件的频率。为了监控call、return和line事件，可以将他们的第一个字母（'c'、'r' 或 'l'）组合成一个mask字符串即可。要想关掉hooks，只需要不带参数地调用sethook即可。
下面的简单代码，是一个安装原始的跟踪器：打印解释器执行的每一个新行的行号：
--]]
debug.sethook(print, "l")

-- 上面这一行代码，简单的将print函数作为hook函数，并指示Lua当line事件发生时调用print函数。可以使用getinfo将当前正在执行的文件名信息加上去，使得跟踪器稍微精致点的：
function trace (event, line)
    local s = debug.getinfo(2).short_src
    print(s .. ":" .. line)
end
 
debug.sethook(trace, "l")