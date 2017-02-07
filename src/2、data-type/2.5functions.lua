--[[
函数是第一类值（和其他变量相同），意味着函数可以存储在变量中，可以作为函数的参数，也可以作为函数的返回值。这个特性给了语言很大的灵活性：一个程序可以重新定义函数增加新的功能或者为了避免运行不可靠代码创建安全运行环境而隐藏函数，
此外这特性在Lua实现面向对象中也起了重要作用。Lua可以调用lua或者C实现的函数，Lua所有标准库都是用C实现的。标准库包括string库、table库、I/O库、OS库、算术库、debug库。
--]]