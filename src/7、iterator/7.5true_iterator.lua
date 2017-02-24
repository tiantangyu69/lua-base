--[[
迭代器的名字有一些误导，因为它并没有迭代，完成迭代功能的是for语句，也许更好的叫法应该是生成器（generator）；但是在其他语言比如java、C++迭代器的说法已经很普遍了，我们也就沿用这个术语。
有一种方式创建一个在内部完成迭代的迭代器。这样当我们使用迭代器的时候就不需要使用循环了；我们仅仅使用每一次迭代需要处理的任务作为参数调用迭代器即可，具体地说，迭代器接受一个函数作为参数，并且这个函数在迭代器内部被调用。
作为一个具体的例子，我们使用上述方式重写allwords迭代器：
--]]

function allwords (f)
    -- repeat for each line in the file
    for l in io.lines() do
       -- repeat for each word in the line
       for w in string.gfind(l, "%w+") do
           -- call the function
           f(w)
       end
    end
end

-- 如果我们想要打印出单词，只需要
allwords(print)

-- 更一般的做法是我们使用匿名函数作为作为参数，下面的例子打印出单词'hello'出现的次数：
local count = 0
allwords(function (w)
    if w == "hello" then count = count + 1 end
end)
print(count)

-- 用for结构完成同样的任务：
local count = 0
for w in allwords() do
    if w == "hello" then count = count + 1 end
end
print(count)

--[[
真正的迭代器风格的写法在Lua老版本中很流行，那时还没有for循环。
两种风格的写法相差不大，但也有区别：
	一方面，第二种风格更容易书写和理解；
	另一方面，for结构更灵活，可以使用break和continue语句；在真正的迭代器风格写法中return语句只是从匿名函数中返回而不是退出循环。
--]]