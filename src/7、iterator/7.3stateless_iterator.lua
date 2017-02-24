--[[
无状态的迭代器是指不保留任何状态的迭代器，因此在循环中我们可以利用无状态迭代器避免创建闭包花费额外的代价。
每一次迭代，迭代函数都是用两个变量（状态常量和控制变量）的值作为参数被调用，一个无状态的迭代器只利用这两个值可以获取下一个元素。这种无状态迭代器的典型的简单的例子是ipairs，他遍历数组的每一个元素。
--]]

a = {"one", "two", "three"}
for i, v in ipairs(a) do
    print(i, v)
end

-- 迭代的状态包括被遍历的表（循环过程中不会改变的状态常量）和当前的索引下标（控制变量），ipairs和迭代函数都很简单，我们在Lua中可以这样实现：
function iter (a, i)
    i = i + 1
    local v = a[i]
    if v then
       return i, v
    end
end
 
function ipairs (a)
    return iter, a, 0
end

--[[
当Lua调用ipairs(a)开始循环时，他获取三个值：迭代函数iter、状态常量a、控制变量初始值0；然后Lua调用iter(a,0)返回1,a[1]（除非a[1]=nil）；第二次迭代调用iter(a,1)返回2,a[2]……直到第一个非nil元素。
Lua库中实现的pairs是一个用next实现的原始方法：
--]]
function pairs (t)
    return next, t, nil
end

-- 还可以不使用ipairs直接使用next
--[[
for k, v in next, t do
    ...
end
--]]

-- 记住：exp-list返回结果会被调整为三个，所以Lua获取next、t、nil；确切地说当他调用pairs时获取。