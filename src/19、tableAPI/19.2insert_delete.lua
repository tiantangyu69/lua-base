--[[
table库提供了从一个list的任意位置插入和删除元素的函数。table.insert函数在array指定位置插入一个元素，并将后面所有其他的元素后移。
另外，insert改变array的大小（using setn）。例如，如果a是一个数组{10,20,30}，调用table.insert(a,1,15)后，a变为{15,10,20,30}。
经常使用的一个特殊情况是，我们不带位置参数调用insert，将会在array最后位置插入元素（所以不需要元素移动）。下面的代码逐行独入程序，并将所有行保存在一个array内：
--]]

a = {}
for line in io.lines() do
    table.insert(a, line)
end
print(table.getn(a))        --> (number of lines read)

--[[
table.remove函数删除数组中指定位置的元素，并返回这个元素，所有后面的元素前移，并且数组的大小改变。不带位置参数调用的时候，他删除array的最后一个元素。
使用这两个函数，很容易实现栈、队列和双端队列。我们可以初始化结构为a={}。一个push操作等价于table.insert(a,x)；一个pop操作等价于table.remove(a)。
要在结构的另一端结尾插入元素我们使用table.insert(a,1,x)；删除元素用table.remove(a,1)。最后两个操作不是特别有效的，因为他们必须来回移动元素。
然而，因为table库这些函数使用C实现，对于小的数组(几百个元素)来说效率都不会有什么问题。
--]]