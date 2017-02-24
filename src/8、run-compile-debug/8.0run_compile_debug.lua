--[[
虽然我们把Lua当作解释型语言，但是Lua会首先把代码预编译成中间码然后再执行（很多解释型语言都是这么做的）。
在解释型语言中存在编译阶段听起来不合适，然而，解释型语言的特征不在于他们是否被编译，而是编译器是语言运行时的一部分，所以，执行编译产生的中间码速度会更快。
我们可以说函数dofile的存在就是说明可以将Lua作为一种解释型语言被调用。
前面我们介绍过dofile，把它当作Lua运行代码的chunk的一种原始的操作。
dofile实际上是一个辅助的函数。真正完成功能的函数是loadfile；
与dofile不同的是loadfile编译代码成中间码并且返回编译后的chunk作为一个函数，而不执行代码；另外loadfile不会抛出错误信息而是返回错误码。我们可以这样定义dofile：
--]]

function dofile (filename)
	local f = assert(loadfile(filename))
	return f()
end

dofile("testCompile.lua")
testCompile()

--[[
如果loadfile失败assert会抛出错误。
完成简单的功能dofile比较方便，他读入文件编译并且执行。然而loadfile更加灵活。在发生错误的情况下，loadfile返回nil和错误信息，这样我们就可以自定义错误处理。
另外，如果我们运行一个文件多次的话，loadfile只需要编译一次，但可多次运行。dofile却每次都要编译。
loadstring与loadfile相似，只不过它不是从文件里读入chunk，而是从一个串中读入。例如：
--]]

f = loadstring("i = i + 1")
-- f将是一个函数，调用时执行i=i+1。
i = 0
f()
print(i) --> 1
f()
print(i) --> 2


--[[
loadstring函数功能强大，但使用时需多加小心。确认没有其它简单的解决问题的方法再使用。
Lua把每一个chunk都作为一个匿名函数处理。例如：chunk "a = 1"，loadstring返回与其等价的function () a = 1 end
与其他函数一样，chunks可以定义局部变量也可以返回值：
--]]
f = loadstring("local a = 10; return a + 20")
print(f()) --> 30

-- loadfile 和 loadstring 都不会抛出错误，如果发生错误他们将返回 nil 加上错误信息
print(loadstring("i i"))  --> nil    [string "i i"]:1: '=' expected near 'i'


-- 另外，loadfile和loadstring都不会有边界效应产生，他们仅仅编译chunk成为自己内部实现的一个匿名函数。
-- 通常对他们的误解是他们定义了函数。Lua中的函数定义是发生在运行时的赋值而不是发生在编译时。假如我们有一个文件foo.lua：
--[[
function foo (x)
    print(x)
end
--]]

-- 当我们执行命令f = loadfile("foo.lua")后，foo被编译了但还没有被定义，如果要定义他必须运行chunk：
f = loadfile("foo.lua")
f()
foo("ok")
-- 如果你想快捷的调用dostring（比如加载并运行），可以这样
loadstring("s")()

-- 通常使用loadstring加载一个字串没什么意义，例如：
f = loadstring("i = i + 1")
-- 大概与f = function () i = i + 1 end等价，但是第二段代码速度更快因为它只需要编译一次，第一段代码每次调用loadstring都会重新编译，还有一个重要区别：loadstring编译的时候不关心词法范围：
local i = 0
f = loadstring("i = i + 1")
g = function () i = i + 1 end
--[[
这个例子中，和想象的一样g使用局部变量i，然而f使用全局变量i；loadstring总是在全局环境中编译他的串。
loadstring通常用于运行程序外部的代码，比如运行用户自定义的代码。注意：loadstring期望一个chunk，即语句。如果想要加载表达式，需要在表达式前加return，那样将返回表达式的值。看例子：
--]]
print "enter your expression:"
local l = io.read()
local func = assert(loadstring("return " .. l))
print("the value of your expression is " .. func())

-- loadstring返回的函数和普通函数一样，可以多次被调用：
print "enter function to be plotted (with variable 'x'):"
local l = io.read()
local f = assert(loadstring("return " .. l))
for i=1,20 do
    x = i   -- global 'x' (to be visible from the chunk)
    print(string.rep("*", f()))
end


