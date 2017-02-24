-- Lua的函数参数是和位置相关的，调用时实参会按顺序依次传给形参。有时候用名字指定参数是很有用的，比如rename函数用来给一个文件重命名，有时候我们我们记不清命名前后两个参数的顺序了：
-- invalid code
-- rename(old="temp.lua", new="temp1.lua")

-- 上面这段代码是无效的，Lua可以通过将所有的参数放在一个表中，把表作为函数的唯一参数来实现上面这段伪代码的功能。因为Lua语法支持函数调用时实参可以是表的构造。
rename{old="temp.lua", new="temp1.lua"}

-- 根据这个想法我们重定义了rename：
function rename (arg)
    return os.rename(arg.old, arg.new)
end

-- 当函数的参数很多的时候，这种函数参数的传递方式很方便的。例如GUI库中创建窗体的函数有很多参数并且大部分参数是可选的，可以用下面这种方式：
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