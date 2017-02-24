--[[
假定你想列出在一段源代码中出现的所有标示符，某种程度上，你需要过滤掉那些语言本身的保留字。一些C程序员喜欢用一个字符串数组来表示，
将所有的保留字放在数组中，对每一个标示符到这个数组中查找看是否为保留字，有时候为了提高查询效率，对数组存储的时候使用二分查找或者hash算法。
Lua中表示这个集合有一个简单有效的方法，将所有集合中的元素作为下标存放在一个table里，下面不需要查找table，只需要测试看对于给定的元素，表的对应下标的元素值是否为nil。比如：
--]]
reserved = {
    ["while"] = true,    ["end"] = true,
    ["function"] = true, ["local"] = true,
}
--[[
for w in allwords() do
    if reserved[w] then
    -- `w' is a reserved word
    ...
--]]

-- 还可以使用辅助函数更加清晰的构造集合：
function Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end
 
reserved = Set{"while", "end", "function", "local", }