--[[
Lua中的函数是带有词法定界（lexical scoping）的第一类值（first-class values）。
第一类值指：在Lua中函数和其他值（数值、字符串）一样，函数可以被存放在变量中，也可以存放在表中，可以作为函数的参数，还可以作为函数的返回值。
词法定界指：嵌套的函数可以访问他外部函数中的变量。这一特性给Lua提供了强大的编程能力。
Lua中关于函数稍微难以理解的是函数也可以没有名字，匿名的。当我们提到函数名（比如print），实际上是说一个指向函数的变量，像持有其他类型值的变量一样：
--]]

local now = os.date("%Y-%m-%d %H:%M:%S")
print(now)

a = {p = print}
a.p("Hello World")   --> Hello World
print = math.sin  -- `print' now refers to the sine function
a.p(print(1))     --> 0.841470
sin = a.p         -- `sin' now refers to the print function
sin(10, 20)       --> 10   20

-- 既然函数是值，那么表达式也可以创建函数了，Lua中我们经常这样写：
function foo (x) return 2*x end

-- 这实际上是Lua语法的特例，下面是原本的函数：
foo = function (x) return 2*x end

--[[
函数定义实际上是一个赋值语句，将类型为function的变量赋给一个变量。我们使用function (x) ... end来定义一个函数和使用{}创建一个表一样。
table标准库提供一个排序函数，接受一个表作为输入参数并且排序表中的元素。
这个函数必须能够对不同类型的值（字符串或者数值）按升序或者降序进行排序。
Lua不是尽可能多地提供参数来满足这些情况的需要，而是接受一个排序函数作为参数（类似C++的函数对象），排序函数接受两个排序元素作为输入参数，并且返回两者的大小关系，
例如：
--]]

network = {
    {name = "grauna",    IP = "210.26.30.34"},
    {name = "arraial",   IP = "210.26.30.23"},
    {name = "lua",       IP = "210.26.23.12"},
    {name = "derain",    IP = "210.26.23.20"},
}

-- 如果我们想通过表的name域排序：
table.sort(network, function (a,b)
    return (a.name > b.name)
end)

-- 以其他函数作为参数的函数在Lua中被称作高级函数（higher-order function），如上面的sort。在Lua中，高级函数与普通函数没有区别，它们只是把“作为参数的函数”当作第一类值（first-class value）处理而已。
-- 下面给出一个绘图函数的例子：
function eraseTerminal()
    io.write("\27[2J")
end
 
-- writes an '*' at column 'x' , 'row y'
function mark (x,y)
    io.write(string.format("\27[%d;%dH*", y, x))
end
 
-- Terminal size
TermSize = {w = 80, h = 24}
 
-- plot a function
-- (assume that domain and image are in the range [-1,1])
function plot (f)
    eraseTerminal()
    for i=1,TermSize.w do
       local x = (i/TermSize.w)*2 - 1
       local y = (f(x) + 1)/2 * TermSize.h
       mark(i, y)
    end
    io.read()  -- wait before spoiling the screen
end

plot(function (x) return math.sin(x*2*math.pi) end)

