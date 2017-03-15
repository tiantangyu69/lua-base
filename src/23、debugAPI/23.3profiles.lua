--[[
尽管debug库名字上看来是一个调式库，除了用于调式以外，还可以用于完成其他任务。这种常见的任务就是profiling。对于一个实时的profile来说
（For a profile with timing），最好使用C接口来完成：对于每一个hook过多的Lua调用代价太大并且通常会导致测量的结果不准确。然而，
对于计数的profiles而言，Lua代码可以很好的胜任。下面这部分我们将实现一个简单的profiler：列出在程序运行过程中，每一个函数被调用的次数。
我们程序的主要数据结构是两张表，一张关联函数和他们调用次数的表，一张关联函数和函数名的表。这两个表的索引下标是函数本身。
--]]
local Counters = {}
local Names = {}

--[[
在profiling之后，我们可以访问函数名数据，但是记住：在函数在活动状态的情况下，可以得到比较好的结果，因为那时候Lua会察看正在运行的函数的代码来查找指定的函数名。
现在我们定义hook函数，他的任务就是获取正在执行的函数并将对应的计数器加1；同时这个hook函数也收集函数名信息：
--]]
local function hook()
	local f = debug.getinfo(2, "f").func
	if Counters[f] == nil then           -- first time 'f' is called?
		Counters[f] = 1
		Names[f] = debug.getinfo(2, "Sn")
	else
		Counters[f] = Counters[f] + 1
	end
end

-- 下一步就是使用这个hook运行程序，我们假设程序的主chunk在一个文件内，并且用户将这个文件名作为profiler的参数：
-- prompt> lua profiler main-prog
-- 这种情况下，我们的文件名保存在arg[1]，打开hook并运行文件：

local f = assert(loadfile(arg[1]))
debug.sethook(hook, "c")    -- turn on the hook
f()    -- run the main program
debug.sethook()   -- turn off the hook

-- 最后一步是显示结果，下一个函数为一个函数产生名称，因为在Lua中的函数名不确定，所以我们对每一个函数加上他的位置信息，型如file:line 。如果一个函数没有名字，那么我们只用它的位置表示。如果一个函数是C函数，我们只是用它的名字表示（他没有位置信息）。
function getname (func)
    local n = Names[func]
    if n.what == "C" then
       return n.name
    end
    local loc = string.format("[%s]:%s",
           n.short_src, n.linedefined)
    if n.namewhat ~= "" then
       return string.format("%s (%s)", loc, n.name)
    else
       return string.format("%s", loc)
    end
end
-- 最后，我们打印每一个函数和他的计数器：
for func, count in pairs(Counters) do
    print(getname(func), count)
end

--[[
如果我们将我们的profiler应用到Section 10.2的马尔科夫链的例子上，我们得到如下结果：
[markov.lua]:4 884723
write  10000
[markov.lua]:0 (f)       1
read   31103
sub    884722
[markov.lua]:1 (allwords)       1
[markov.lua]:20 (prefix)        894723
find   915824
[markov.lua]:26 (insert)        884723
random  10000
sethook 1
insert  884723
那意味着第四行的匿名函数（在allwords内定义的迭代函数）被调用884,723次，write(io.write)被调用10,000次。
你可以对这个profiler进行一些改进，比如对输出排序、打印出比较好的函数名、改善输出格式。不过，这个基本的profiler已经很有用，并且可以作为很多高级工具的基础。
--]]