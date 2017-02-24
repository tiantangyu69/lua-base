--[[
Errare humanum est（拉丁谚语：犯错是人的本性）。所以我们要尽可能的防止错误的发生，Lua经常作为扩展语言嵌入在别的应用中，所以不能当错误发生时简单的崩溃或者退出。
相反，当错误发生时Lua结束当前的chunk并返回到应用中。
当Lua遇到不期望的情况时就会抛出错误，比如：两个非数字进行相加；调用一个非函数的变量；访问表中不存在的值等。
你也可以通过调用error函数显式地抛出错误，error的参数是要抛出的错误信息。
--]]
print "enter a number:"
n = io.read("*number")
if not n then 
	error("invalid input")
else
	print(n)
end

-- Lua提供了专门的内置函数assert来完成上面类似的功能：
print "enter a number:"
n = assert(io.read("*number"), "invalid input")
-- assert首先检查第一个参数，若没问题，assert不做任何事情；否则，assert以第二个参数作为错误信息抛出。第二个参数是可选的。
-- 注意，assert会首先处理两个参数，然后才调用函数，所以下面代码，无论n是否为数字，字符串连接操作总会执行：
n = io.read()
assert(tonumber(n), "invalid input: " .. n .. " is not a number")

-- 当函数遇到异常有两个基本的动作：返回错误代码或者抛出错误。选择哪一种方式，没有固定的规则，不过基本的原则是：对于程序逻辑上能够避免的异常，以抛出错误的方式处理之，否则返回错误代码。
-- 例如sin函数，假定我们让sin碰到错误时返回错误代码，则使用sin的代码可能变为：
local res = math.sin(x)
-- if not res then      -- error

-- 当然，我们也可以在调用sin前检查x是否为数字：
-- if not tonumber(x) then     error: x is not a number

--[[
而事实上，我们既不是检查参数也不是检查返回结果，因为参数错误可能意味着我们的程序某个地方存在问题，这种情况下，处理异常最简单最实际的方式是抛出错误并且终止代码的运行。
再来看一个例子。io.open函数用于打开文件，如果文件不存在，结果会如何？很多系统中，我们通过“试着去打开文件”来判断文件是否存在。
所以如果io.open不能打开文件（由于文件不存在或者没有权限），函数返回nil和错误信息。依据这种方式，我们可以通过与用户交互（比如：是否要打开另一个文件）合理地处理问题：
--]]
local file, msg
repeat
    print "enter a file name:"
    local name = io.read()
    if not name then return end     -- no input
    file, msg = io.open(name, "r")
    if not file then print(msg) end
until file

-- 如果你想偷懒不想处理这些情况，又想代码安全的运行，可以使用assert：
file = assert(io.open(name, "r"))

-- Lua中有一个习惯：如果io.open失败，assert将抛出错误。
file = assert(io.open("no-file", "r"))
       --> stdin:1: no-file: No such file or directory
	   
-- 注意：io.open返回的第二个结果（错误信息）会作为assert的第二个参数。