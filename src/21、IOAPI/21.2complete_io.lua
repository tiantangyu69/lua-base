--[[
为了对输入输出的更全面的控制，可以使用完全模式。完全模式的核心在于文件句柄（file handle）。该结构类似于C语言中的文件流（FILE*），
其呈现了一个打开的文件以及当前存取位置。打开一个文件的函数是io.open。它模仿C语言中的fopen函数，同样需要打开文件的文件名参数，
打开模式的字符串参数。模式字符串可以是 "r"（读模式），"w"（写模式，对数据进行覆盖），或者是 "a"（附加模式）。并且字符 "b" 可附
加在后面表示以二进制形式打开文件。正常情况下open函数返回一个文件的句柄。如果发生错误，则返回nil，以及一个错误信息和错误代码。
--]]
print(io.open("non-existent file", "r"))        --> nil    No such file or directory       2
print(io.open("/etc/passwd", "w"))              --> nil    Permission denied               13

--[[
错误代码的定义由系统决定。
以下是一段典型的检查错误的代码：
local f = assert(io.open(filename, mode))

如果open函数失败，错误信息作为assert的参数，由assert显示出信息。文件打开后就可以用read和write方法对他们进行读写操作。它们和io表
的read/write函数类似，但是调用方法上不同，必须使用冒号字符，作为文件句柄的方法来调用。例如打开一个文件并全部读取。可以使用如下代码。

local f = assert(io.open(filename, "r"))
local t = f:read("*all")
f:close()
--]]

-- 同C语言中的流（stream）设定类似，I/O库提供三种预定义的句柄：io.stdin、io.stdout和io.stderr。因此可以用如下代码直接发送信息到错误流（error stream）。
io.stderr:write("this is a error")
io.stdout:write("\nthis is std output str")

--[[
我们还可以将完全模式和简单模式混合使用。使用没有任何参数的io.input()函数得到当前的输入文件句柄；使用带有参数的io.input(handle)函数设置当前的输入文件为handle
句柄代表的输入文件。（同样的用法对于io.output函数也适用）例如要实现暂时的改变当前输入文件，可以使用如下代码：

local temp = io.input()     -- save current file
io.input("newinput")        -- open a new current file
...                         -- do something with new input
io.input():close()          -- close current file
io.input(temp)              -- restore previous current file
--]]


