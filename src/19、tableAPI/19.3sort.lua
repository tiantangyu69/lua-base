--[[
另一个有用的函数是table.sort。他有两个参数：存放元素的array和排序函数。排序函数有两个参数并且如果在array中排序后第一个参数在第二个参数前面，
排序函数必须返回true。如果未提供排序函数，sort使用默认的小于操作符进行比较。
一个常见的错误是企图对表的下标域进行排序。在一个表中，所有下标组成一个集合，但是无序的。如果你想对他们排序，
必须将他们复制到一个array然后对这个array排序。我们看个例子，假定上面的读取源文件并创建了一个表，这个表给出了源文件中每一个函数被定义的地方的行号：
--]]

lines = {
	luaH_set = 10,
	luaH_get = 33,
	luaH_present = 66,
}

--[[
现在你想以字母顺序打印出这些函数名，如果你使用pairs遍历这个表，函数名出现的顺序将是随机的。然而，你不能直接排序他们，
因为这些名字是表的key。当你将这些函数名放到一个数组内，就可以对这个数组进行排序。首先，必须创建一个数组来保存这些函数名，然后排序他们，最后打印出结果：
--]]

a = {}
for n in pairs(lines) do
	table.insert(a, n)
end

table.sort(a)

for i, n in ipairs(a) do
	print(n)
end

--[[
注意，对于Lua来说，数组也是无序的。但是我们知道怎样去计数，因此只要我们使用排序好的下标访问数组就可以得到排好序的函数名。
这就是为什么我们一直使用ipairs而不是pairs遍历数组的原因。前者使用key的顺序1、2、……，后者表的自然存储顺序。
有一个更好的解决方法，我们可以写一个迭代子来根据key值遍历这个表。一个可选的参数f可以指定排序的方式。首先，将排序的keys放到数组内，然后遍历这个数组，每一步从原始表中返回key和value：
--]]

function pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do
		table.insert(a, n)
	end
	
	table.sort(a, f)
	local i = 0
	local iter = function()
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	
	return iter
end

for name, line in pairsByKeys(lines) do
	print(name, line)
end