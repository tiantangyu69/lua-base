--[[
当一个函数内部嵌套另一个函数定义时，内部的函数体可以访问外部的函数的局部变量，这种特征我们称作词法定界。虽然这看起来很清楚，事实并非如此，词法定界加上第一类函数在编程语言里是一个功能强大的概念，很少语言提供这种支持。
下面看一个简单的例子，假定有一个学生姓名的列表和一个学生名和成绩对应的表；现在想根据学生的成绩从高到低对学生进行排序，可以这样做：
--]]
names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}
table.sort(names, function (n1, n2)
    return grades[n1] > grades[n2]    -- compare the grades
end)

-- 假定创建一个函数实现此功能：
function sortbygrade (names, grades)
    table.sort(names, function (n1, n2)
       return grades[n1] > grades[n2]    -- compare the grades
    end)
end

-- 例子中包含在sortbygrade函数内部的sort中的匿名函数可以访问sortbygrade的参数grades，在匿名函数内部grades不是全局变量也不是局部变量，我们称作外部的局部变量（external local variable）或者upvalue。
--（upvalue意思有些误导，然而在Lua中他的存在有历史的根源，还有他比起external local variable简短）。
-- 看下面的代码：
function newCounter()
	local i = 0
	return function()   -- anonymous function
		i = i + 1
		return i
	end
end

c1 = newCounter()
print(c1())
print(c1())

-- 匿名函数使用upvalue i保存他的计数，当我们调用匿名函数的时候i已经超出了作用范围，因为创建i的函数newCounter已经返回了。
-- 然而Lua用闭包的思想正确处理了这种情况。简单的说，闭包是一个函数以及它的upvalues。如果我们再次调用newCounter，将创建一个新的局部变量i，因此我们得到了一个作用在新的变量i上的新闭包。
c2 = newCounter()
print(c2())  --> 1
print(c1())  --> 3
print(c2())  --> 2

--[[
c1、c2是建立在同一个函数上，但作用在同一个局部变量的不同实例上的两个不同的闭包。
技术上来讲，闭包指值而不是指函数，函数仅仅是闭包的一个原型声明；尽管如此，在不会导致混淆的情况下我们继续使用术语函数代指闭包。
闭包在上下文环境中提供很有用的功能，如前面我们见到的可以作为高级函数（sort）的参数；作为函数嵌套的函数（newCounter）。
这一机制使得我们可以在Lua的函数世界里组合出奇幻的编程技术。闭包也可用在回调函数中，比如在GUI环境中你需要创建一系列button，
但用户按下button时回调函数被调用，可能不同的按钮被按下时需要处理的任务有点区别。具体来讲，一个十进制计算器需要10个相似的按钮，每个按钮对应一个数字，可以使用下面的函数创建他们：
--]]
function digitButton (digit)
    return Button{  label = digit,
           action = function ()
              add_to_display(digit)
           end
    }
end

-- 这个例子中我们假定Button是一个用来创建新按钮的工具， label是按钮的标签，action是按钮被按下时调用的回调函数。
--（实际上是一个闭包，因为他访问upvalue digit）。digitButton完成任务返回后，局部变量digit超出范围，回调函数仍然可以被调用并且可以访问局部变量digit。



-- 闭包在完全不同的上下文中也是很有用途的。因为函数被存储在普通的变量内我们可以很方便的重定义或者预定义函数。
-- 通常当你需要原始函数有一个新的实现时可以重定义函数。例如你可以重定义sin使其接受一个度数而不是弧度作为参数：
oldSin = math.sin
math.sin = function (x)
    return oldSin(x*math.pi/180)
end
-- 更清楚的方式：
do
    local oldSin = math.sin
    local k = math.pi/180
    math.sin = function (x)
       return oldSin(x*k)
    end
end

-- 这样我们把原始版本放在一个局部变量内，访问sin的唯一方式是通过新版本的函数。
-- 利用同样的特征我们可以创建一个安全的环境（也称作沙箱，和java里的沙箱一样），当我们运行一段不信任的代码（比如我们运行网络服务器上获取的代码）时安全的环境是需要的，
-- 比如我们可以使用闭包重定义io库的open函数来限制程序打开的文件。
do
    local oldOpen = io.open
    io.open = function (filename, mode)
       if access_OK(filename, mode) then
           return oldOpen(filename, mode)
       else
           return nil, "access denied"
       end
    end
end
