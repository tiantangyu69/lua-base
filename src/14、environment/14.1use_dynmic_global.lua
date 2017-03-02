--[[
通常，赋值操作对于访问和修改全局变量已经足够。然而，我们经常需要一些原编程（meta-programming）的方式，比如当我们需要操纵一个名字被存储在另一个变量中的全局变量，
或者需要在运行时才能知道的全局变量。为了获取这种全局变量的值，有的程序员可能写出下面类似的代码：

loadstring("value = " .. varname)()
or
value = loadstring("return " .. varname)()

如果varname是x，上面连接操作的结果为："return x"（第一种形式为 "value = x"），当运行时才会产生最终的结果。然而这段代码涉及到一个新的chunk的创建和编译以及其他很多额外的问题。
你可以换种方式更高效更简洁的完成同样的功能，代码如下：
value = _G[varname]

因为环境是一个普通的表，所以你可以使用你需要获取的变量（变量名）索引表即可。
也可以用相似的方式对一个全局变量赋值：_G[varname] = value。小心：一些程序员对这些函数很兴奋，并且可能写出这样的代码：_G["a"] = _G["var1"]，这只是a = var1的复杂的写法而已。
对前面的问题概括一下，表域可以是型如"io.read" or "a.b.c.d"的动态名字。我们用循环解决这个问题，从_G开始，一个域一个域的遍历：
--]]
function getfield (f)
    local v = _G      -- start with the table of globals
    for w in string.gfind(f, "[%w_]+") do
       v = v[w]
    end
    return v
end

-- 我们使用string库的gfind函数来迭代f中的所有单词（单词指一个或多个子母下划线的序列）。相对应的，设置一个域的函数稍微复杂些。赋值如：
-- a.b.c.d.e = v
-- 实际等价于：
-- local temp = a.b.c.d
-- temp.e = v

-- 也就是说，我们必须记住最后一个名字，必须独立的处理最后一个域。新的setfield函数当其中的域（译者注：中间的域肯定是表）不存在的时候还需要创建中间表。
function setfield (f, v)
    local t = _G         -- start with the table of globals
    for w, d in string.gfind(f, "([%w_]+)(.?)") do
       if d == "." then  -- not last field?
           t[w] = t[w] or {}    -- create table if absent
           t = t[w]          -- get the table
       else                 -- last field
           t[w] = v          -- do the assignment
       end
    end
end

-- 这个新的模式匹配以变量w加上一个可选的点（保存在变量d中）的域。如果一个域名后面不允许跟上点，表明它是最后一个名字。（我们将在第20章讨论模式匹配问题）。使用上面的函数
setfield("t.x.y", 10)

-- 创建一个全局变量表t，另一个表t.x，并且对t.x.y赋值为10：
print(t.x.y)                --> 10
print(getfield("t.x.y"))     --> 10