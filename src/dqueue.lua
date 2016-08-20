List = {}
function List.new ()
	return {first = 0, last = -1}
end

function List.pushLeft (list, value)
	local first = list.first - 1
	list.first = first
	list[first] = value
end

function List.pushRight (list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
end

function List.popLeft (list)
	local first = list.first
	if first > list.last then error("list is empty") end
	local value = list[first]
	list[first] = nil  -- to allow garbage collection
	list.first = first + 1
	return value
end

function List.popRight (list)
	local last = list.last
	if list.first > last then error("list is empty") end
	local value = list[last]
	list[last] = nil  -- to allow garbage collection
	list.last = last - 1
	return value
end


listTest = List.new()

List.pushLeft(listTest, "111111")
List.pushLeft(listTest, "222222")
List.pushLeft(listTest, "333333")
List.pushLeft(listTest, "444444")
List.pushLeft(listTest, "555555")

print(List.popRight(listTest))
print(List.popRight(listTest))
print(List.popRight(listTest))
print(List.popRight(listTest))
print(List.popRight(listTest))