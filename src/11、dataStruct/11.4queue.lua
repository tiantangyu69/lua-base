-- 虽然可以使用Lua的table库提供的insert和remove操作来实现队列，但这种方式实现的队列针对大数据量时效率太低，有效的方式是使用两个索引下标，一个表示第一个元素，另一个表示最后一个元素。
function ListNew ()
    return {first = 0, last = -1}
end

-- 为了避免污染全局命名空间，我们重写上面的代码，将其放在一个名为list的table中：
List = {}
function List.new ()
    return {first = 0, last = -1}
end

-- 下面，我们可以在常量时间内，完成在队列的两端进行插入和删除操作了。
function List.pushleft (list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end
 
function List.pushright (list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end
 
function List.popleft (list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil    -- to allow garbage collection
    list.first = first + 1
    return value
end
 
function List.popright (list)
    local last = list.last
    if list.first > last then error("list is empty") end
    local value = list[last]
    list[last] = nil     -- to allow garbage collection
    list.last = last - 1
    return value
end

--[[
对严格意义上的队列来讲，我们只能调用pushright和popleft，这样以来，first和last的索引值都随之增加，幸运的是我们使用的是Lua的table实现的，
你可以访问数组的元素，通过使用下标从1到20，也可以16,777,216 到 16,777,236。另外，Lua使用双精度表示数字，假定你每秒钟执行100万次插入操作，在数值溢出以前你的程序可以运行200年。
--]]

l = List.new()
List.pushright(l, 1)
List.pushright(l, 12)
List.pushright(l, 123)

print(List.popleft(l))
print(List.popleft(l))
print(List.popleft(l))
print(List.popleft(l))