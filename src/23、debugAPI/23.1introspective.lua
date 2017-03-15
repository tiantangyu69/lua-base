--[[
在debug库中主要的自省函数是debug.getinfo。他的第一个参数可以是一个函数或者栈级别。对于函数foo调用debug.getinfo(foo)，将返回关于这个函数信息的一个表。这个表有下列一些域：
ü  source，标明函数被定义的地方。如果函数在一个字符串内被定义（通过loadstring），source就是那个字符串。如果函数在一个文件中定义，source是@加上文件名。
ü  short_src，source的简短版本（最多60个字符），记录一些有用的错误信息。
ü  linedefined，source中函数被定义之处的行号。
ü  what，标明函数类型。如果foo是一个普通得Lua函数，结果为 "Lua"；如果是一个C函数，结果为 "C"；如果是一个Lua的主chunk，结果为 "main"。
ü  name，函数的合理名称。
ü  namewhat，上一个字段代表的含义。这个字段的取值可能为：W"global"、"local"、"method"、"field"，或者 ""（空字符串）。空字符串意味着Lua没有找到这个函数名。
ü  nups，函数的upvalues的个数。
ü  func，函数本身；详细情况看后面。
当foo是一个C函数的时候，Lua无法知道很多相关的信息，所以对这种函数，只有what、name、namewhat这几个域的值可用。
以数字 n调用debug.getinfo(n)时，返回在n级栈的活动函数的信息数据。比如，如果n=1，返回的是正在进行调用的那个函数的信息。
（n=0表示C函数getinfo本身）如果n比栈中活动函数的个数大的话，debug.getinfo返回nil。当你使用数字n调用debug.getinfo查询活动函数的信息的时候，
返回的结果table中有一个额外的域：currentline，即在那个时刻函数所在的行号。另外，func表示指定n级的活动函数。
字段名的写法有些技巧。记住：因为在Lua中函数是第一类值，所以一个函数可能有多个函数名。查找指定值的函数的时候，Lua会首先在全局变量中查找，
如果没找到才会到调用这个函数的代码中看它是如何被调用的。后面这种情况只有在我们使用数字调用getinfo的时候才会起作用，也就是这个时候我们能够获取调用相关的详细信息。
函数getinfo 的效率并不高。Lua以不消弱程序执行的方式保存debug信息（Lua keeps debug information in a form that does not impair program execution），效率被放在第二位。
为了获取比较好地执行性能，getinfo可选的第二个参数可以用来指定选取哪些信息。指定了这个参数之后，程序不会浪费时间去收集那些用户不关心的信息。这个参数的格式是一个字符串，
每一个字母代表一种类型的信息，可用的字母的含义如下：

'n'			selects fields name and namewhat
'f'			selects field func
'S'			selects fields source, short_src, what, and linedefined
'l'			selects field currentline
'u'			selects field nup
--]]

-- 下面的函数阐明了debug.getinfo的使用，函数打印一个活动栈的原始跟踪信息（traceback）：
function traceback ()
    local level = 1
    while true do
       local info = debug.getinfo(level, "Sl")
       if not info then break end
       if info.what == "C" then    -- is a C function?
           print(level, "C function")
       else   -- a Lua function
           print(string.format("[%s]:%d",
                  info.short_src, info.currentline))
       end
       level = level + 1
    end
end

-- 不难改进这个函数，使得getinfo获取更多的数据，实际上debug库提供了一个改善的版本debug.traceback，与我们上面的函数不同的是，debug.traceback并不打印结果，而是返回一个字符串。
print(debug.traceback(traceback))

traceback()