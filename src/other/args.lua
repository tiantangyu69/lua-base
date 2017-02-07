printResult = ""

function printArgs(...)
	for i, v in ipairs(arg) do
		printResult = printResult .. tostring(v) .. "\t"
	end
	printResult = printResult .. "\n"
	print(printResult)
end

printArgs("a", "b", "c", "d")

-- 有时候我们可能需要几个固定参数加上可变参数
function g (a, b, ...) 
	print(a, b, arg)
end
g(3)              --> a=3, b=nil, arg={n=0}
g(3, 4)           --> a=3, b=4, arg={n=0}
g(3, 4, 5, 8)     --> a=3, b=4, arg={5, 8; n=2}


--举个具体的例子，如果我们只想要string.find返回的第二个值。一个典型的方法是使用哑元（dummy variable，下划线）：
s = "hello"
p = "ll"
local _, x = string.find(s, p)

print(x)
-- now use `x'



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

--[[
w = Window {
    x=0, y=0, width=300, height=200,
    title = "Lua", background="blue",
    border = true
}

function Window (options)
    -- check mandatory options
    if type(options.title) ~= "string" then
       error("no title")
    elseif type(options.width) ~= "number" then
       error("no width")
    elseif type(options.height) ~= "number" then
       error("no height")
    end

    -- everything else is optional
    _Window(options.title,
       options.x or 0,          -- default value
       options.y or 0,          -- default value
       options.width, options.height,
       options.background or "white",  -- default
       options.border           -- default is false (nil)
    )
end
]]--

