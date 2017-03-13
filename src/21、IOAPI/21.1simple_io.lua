--[[
简单模式的所有操作都是在两个当前文件之上。I/O库将当前输入文件作为标准输入（stdin），将当前输出文件作为标准输出（stdout）。
这样当我们执行io.read，就是在标准输入中读取一行。我们可以使用io.input和io.output函数来改变当前文件。
例如io.input(filename)就是打开给定文件（以读模式），并将其设置为当前输入文件。接下来所有的输入都来自于该文，直到再次使用
io.input。io.output函数。类似于io.input。一旦产生错误两个函数都会产生错误。如果你想直接控制错误必须使用完全模式中io.read函数。
写操作较读操作简单，我们先从写操作入手。下面这个例子里函数io.write获取任意数目的字符串参数，接着将它们写到当前的输出文件。通常
数字转换为字符串是按照通常的规则，如果要控制这一转换，可以使用string库中的format函数：
--]]
io.write("sin(3) = ", math.sin(3), "\n")
io.write(string.format("sin(3) = %.4f\n", math.sin(3)))

--[[
在编写代码时应当避免像io.write(a..b..c)；这样的书写，这同io.write(a,b,c)的效果是一样的。但是后者因为避免了串联操作，而消耗较少的资源。
原则上当你进行粗略（quick and dirty）编程，或者进行排错时常使用print函数。当需要完全控制输出时使用write。
--]]
print("hello",  "Lua"); print("Hi")
--> hello	Lus
--> Hi

io.write("hello", "Lua"); io.write("Hi")
-->helloLusHi
--[[
Write函数与print函数不同在于，write不附加任何额外的字符到输出中去，例如制表符，换行符等等。还有write函数是使用当前输出文件，
而print始终使用标准输出。另外print函数会自动调用参数的tostring方法，所以可以显示出表（tables）函数（functions）和nil。
--]]

--[[
read函数从当前输入文件读取串，由它的参数控制读取的内容：

"*all"				读取整个文件
"*line"				读取下一行
"*number"			从串中转换出一个数值
num					读取num个字符到串
--]]
t = io.read("*line")                 --> read the whole file
t = string.gsub(t, "a", "b")
io.write(t)

--[[
以下代码是一个完整的处理字符串的例子。文件的内容要使用MIME（多用途的网际邮件扩充协议）中的quoted-printable码进行编码。以这种形式编码，
非ASCII字符将被编码为“=XX”，其中XX是该字符值的十六进制表示，为表示一致性“=”字符同样要求被改写。在gsub函数中的“模式”参数的作用就是得到
所有值在128到255之间的字符，给它们加上等号标志。
--]]
t = io.read("*line")
t = string.gsub(t, "([\128-\255=])", function (c)
    return string.format("=%02X", string.byte(c))
end)
io.write(t)

--[[
该程序在奔腾333MHz环境下转换200k字符需要0.2秒。
io.read("*line")函数返回当前输入文件的下一行（不包含最后的换行符）。当到达文件末尾，返回值为nil（表示没有下一行可返回）。该读取方式是read函数的默认方式，
所以可以简写为io.read()。通常使用这种方式读取文件是由于对文件的操作是自然逐行进行的，否则更倾向于使用*all一次读取整个文件，或者稍后见到的逐块的读取文件。
下面的程序演示了应如何使用该模式读取文件。此程序复制当前输入文件到输出文件，并记录行数。
--]]
local count = 1
while true do
    local line = io.read()
    if line == nil or line =="nil" then break end
    io.write(string.format("%6d  ", count), line, "\n")
    count = count + 1
end

-- 然而为了在整个文件中逐行迭代。我们最好使用io.lines迭代器。例如对文件的行进行排序的程序如下：
local lines = {}
for line in io.lines() do
	if line == "nil" then
		break
	end
		
	table.insert(lines, line)
end

table.sort(lines)

for i, l in ipairs(lines) do
	io.write(l, "\n")
end

--[[
在奔腾333MHz上该程序处理处理4.5MB大小，32K行的文件耗时1.8秒，比使用高度优化的C语言系统排序程序快0.6秒。io.read("*number")函数从当前输入文件中读取出一个数值。
只有在该参数下read函数才返回数值，而不是字符串。当需要从一个文件中读取大量数字时，数字间的字符串为空白可以显著的提高执行性能。*number选项会跳过两个可被识别
数字之间的任意空格。这些可识别的字符串可以是-3、+5.2、1000，和 -3.4e-23。如果在当前位置找不到一个数字（由于格式不对，或者是到了文件的结尾），则返回nil 可以
对每个参数设置选项，函数将返回各自的结果。假如有一个文件每行包含三个数字：
6.0        -3.23         15e12
4.3        234           1000001
...

现在要打印出每行最大的一个数，就可以使用一次read函数调用来读取出每行的全部三个数字：

while true do
    local n1, n2, n3 = io.read("*number", "*number", "*number")
    if not n1 then break end
    print(math.max(n1, n2, n3))
end
--]]

--[[
在任何情况下，都应该考虑选择使用io.read函数的 " *.all " 选项读取整个文件，然后使用gfind函数来分解：
local pat = "(%S+)%s+(%S+)%s+(%S+)%s+"
for n1, n2, n3 in string.gfind(io.read("*all"), pat) do
    print(math.max(n1, n2, n3))
end
--]]

--[[
除了基本读取方式外，还可以将数值n作为read函数的参数。在这样的情况下read函数将尝试从输入文件中读取n个字符。如果无法读取到任何字符（已经到了文件末尾），
函数返回nil。否则返回一个最多包含n个字符的串。以下是关于该read函数参数的一个进行高效文件复制的例子程序（当然是指在Lua中）
--]]
local size = 2^13        -- good buffer size (8K)
while true do
    local block = io.read(size)
    if not block then break end
    io.write(block)
end
-- 特别的，io.read(0)函数的可以用来测试是否到达了文件末尾。如果不是返回一个空串，如果已是文件末尾返回nil。






















