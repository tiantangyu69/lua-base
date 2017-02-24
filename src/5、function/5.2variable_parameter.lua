-- Lua函数可以接受可变数目的参数，和C语言类似在函数参数列表中使用三点（...）表示函数有可变的参数。Lua将函数的参数放在一个叫arg的表中，除了参数以外，arg表中还有一个域n表示参数的个数。
-- 例如，我们可以重写print函数：
printResult = ""
 
function print2(...)
    for i,v in ipairs(arg) do
       printResult = printResult .. tostring(v) .. "\t"
    end
    printResult = printResult .. "\n"
end

-- 有时候我们可能需要几个固定参数加上可变参数
function g(a, b, ...)
end
 
-- CALL              PARAMETERS
 
g(3)              --> a=3, b=nil, arg={n=0}
g(3, 4)           --> a=3, b=4, arg={n=0}
g(3, 4, 5, 8)     --> a=3, b=4, arg={5, 8; n=2}


--[[
如上面所示，Lua会将前面的实参传给函数的固定参数，后面的实参放在arg表中。
举个具体的例子，如果我们只想要string.find返回的第二个值。一个典型的方法是使用哑元（dummy variable，下划线）：
--]]

local _, x = string.find("hello Lua", "Lua")
-- now use `x'
print(x)


-- 还可以利用可变参数声明一个select函数：
function select (n, ...)
    return arg[n]
end
print(string.find("hello hello", " hel")) --> 6  9
print(select(1, string.find("hello hello", " hel"))) --> 6
print(select(2, string.find("hello hello", " hel"))) --> 9

-- 有时候需要将函数的可变参数传递给另外的函数调用，可以使用前面我们说过的unpack(arg)返回arg表所有的可变参数，Lua提供了一个文本格式化的函数string.format（类似C语言的sprintf函数）：
function fwrite(fmt, ...)
    return io.write(string.format(fmt, unpack(arg)))
end
-- 这个例子将文本格式化操作和写操作组合为一个函数。