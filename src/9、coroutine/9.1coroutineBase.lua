-- Lua的所有协同函数存放于coroutine table中。create函数用于创建新的协同程序，其只有一个参数：一个函数，即协同程序将要运行的代码。若一切顺利，返回值为thread类型，表示创建成功。通常情况下，create的参数是匿名函数：
co = coroutine.create(function()
	print("hi coroutine")
end
)
print(co) --> thread: 0x0079B650


-- 协同有三个状态：挂起态（suspended）、运行态（running）、停止态（dead）。当我们创建协同程序成功时，其为挂起态，即此时协同程序并未运行。我们可用status函数检查协同的状态：
print(coroutine.status(co))  --> suspended


-- 函数coroutine.resume使协同程序由挂起状态变为运行态：
coroutine.resume(co)  --> hi coroutine


-- 运行完之后进入终止态
print(coroutine.status(co))  --> dead


-- 到目前为止，协同看起来只是一种复杂的调用函数的方式，真正的强大之处体现在yield函数，它可以将正在运行的代码挂起，看一个例子：
co = coroutine.create(function()
	for i = 1, 2 do
		print("co", i)
		coroutine.yield()
	end
end)
-- 执行这个协同程序，程序将在第一个yield处被挂起：
coroutine.resume(co)               --> co   1
print(coroutine.status(co))        --> suspended
-- 从协同的观点看：使用函数yield可以使程序挂起，当我们激活被挂起的程序时，将从函数yield的位置继续执行程序，直到再次遇到yield或程序结束。
coroutine.resume(co)               --> co   2
print(coroutine.status(co))        --> suspended 

coroutine.resume(co)               --> prints nothing   
print(coroutine.status(co))        --> dead

-- 上面最后一次调用时，协同体已结束，因此协同程序处于终止态。如果我们仍然希望激活它，resume将返回false和错误信息。
print(coroutine.resume(co))        --> false  cannot resume dead coroutine
--[[
注意：resume运行在保护模式下，因此，如果协同程序内部存在错误，Lua并不会抛出错误，而是将错误返回给resume函数。
Lua中协同的强大能力，还在于通过resume-yield来交换数据。
第一个例子中只有resume，没有yield，resume把参数传递给协同的主程序。
--]]
co = coroutine.create(function(a, b, c)
	print("co", a, b, c)
end)
coroutine.resume(co, 1, 2, 3)        --> co      1       2       3

-- 第二个例子，数据由yield传给resume。true表明调用成功，true之后的部分，即是yield的参数。
co = coroutine.create(function(a, b)
	coroutine.yield(a + b, a - b)
end)
print(coroutine.resume(co, 20, 10))  --> true  30  10

-- 相应地，resume的参数，会被传递给yield。
co = coroutine.create(function()
	print("co", coroutine.yield())
end)
coroutine.resume(co)
coroutine.resume(co, 4, 5)         --> co  4  5

-- 最后一个例子，协同代码结束时的返回值，也会传给resume：
co = coroutine.create(function()
	return 6, 7
end)
print(coroutine.resume(co))

--[[
我们很少在一个协同程序中同时使用多个特性，但每一种都有用处。
现在已大体了解了协同的基础内容，在我们继续学习之前，先澄清两个概念：Lua的协同称为不对称协同（asymmetric coroutines），
指“挂起一个正在执行的协同函数”与“使一个被挂起的协同再次执行的函数”是不同的，有些语言提供对称协同（symmetric coroutines），即使用同一个函数负责“执行与挂起间的状态切换”。
有人称不对称的协同为半协同，另一些人使用同样的术语表示真正的协同，严格意义上的协同不论在什么地方只要它不是在其他的辅助代码内部的时候都可以并且只能使执行挂起，
不论什么时候在其控制栈内都不会有不可决定的调用。（However, other people use the same term semi-coroutine to denote a restricted implementation of coroutines, 
where a coroutine can only suspend its execution when it is not inside any auxiliary function, that is, when it has no pending calls in its control stack.）。
只有半协同程序内部可以使用yield，python中的产生器（generator）就是这种类型的半协同。
与对称的协同和不对称协同的区别不同的是，协同与产生器的区别更大。产生器相对比较简单，他不能完成真正的协同所能完成的一些任务。
我们熟练使用不对称的协同之后，可以利用不对称的协同实现比较优越的对称协同。
--]]