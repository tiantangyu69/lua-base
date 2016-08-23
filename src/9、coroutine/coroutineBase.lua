-- 协同有三个状态：挂起态、运行态、停止态

-- 创建时为挂起状态
co = coroutine.create(function()
	print("hi coroutine")
end
)

print(co)
print(coroutine.status(co))

-- 函数 coroutine.resume 可以使程序由挂起状态变为运行态
coroutine.resume(co)

-- 运行完之后进入终止态
print(coroutine.status(co))

-- 将正在运行的代码挂起
co = coroutine.create(function()
	for i = 1, 2 do
		print("co", i)
		coroutine.yield()
	end
end)

coroutine.resume(co)
print(coroutine.status(co))

coroutine.resume(co)
print(coroutine.status(co))

coroutine.resume(co)
print(coroutine.status(co))

print(coroutine.resume(co))

-- lua 中一对 resume-yield 可以相互交换数据
co = coroutine.create(function(a, b, c)
	print("co", a, b, c)
end)
coroutine.resume(co, 1, 2, 3)

co = coroutine.create(function(a, b)
	coroutine.yield(a + b, a - b)
end)
print(coroutine.resume(co, 20, 10))


co = coroutine.create(function()
	print("co", coroutine.yield())
end)
coroutine.resume(co)
coroutine.resume(co, 4, 5)

co = coroutine.create(function()
	return 6, 7
end)
print(coroutine.resume(co))