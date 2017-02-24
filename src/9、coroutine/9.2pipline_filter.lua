-- 协同最具代表性的例子是用来解决生产者-消费者问题。假定有一个函数不断地生产数据（比如从文件中读取），另一个函数不断的处理这些数据（比如写到另一文件中），函数如下：
function producer ()
    while true do
       local x = io.read()      -- produce new value
       send(x)                  -- send to consumer
    end
end
 
function consumer ()
    while true do
       local x = receive()      -- receive from producer
       io.write(x, "\n")        -- consume new value
    end
end

--[[
（例子中生产者和消费者都在不停的循环，修改一下使得没有数据的时候他们停下来并不困难），问题在于如何使得receive和send协同工作。
只是一个典型的谁拥有主循环的情况，生产者和消费者都处在活动状态，都有自己的主循环，都认为另一方是可调用的服务。
对于这种特殊的情况，可以改变一个函数的结构解除循环，使其作为被动的接受。然而这种改变在某些特定的实际情况下可能并不简单。
协同为解决这种问题提供了理想的方法，因为调用者与被调用者之间的resume-yield关系会不断颠倒。
当一个协同调用yield时并不会进入一个新的函数，取而代之的是返回一个未决的resume的调用。
相似的，调用resume时也不会开始一个新的函数而是返回yield的调用。这种性质正是我们所需要的，
与使得send-receive协同工作的方式是一致的。receive唤醒生产者生产新值，send把产生的值送给消费者消费。
--]]
function receive ()
    local status, value = coroutine.resume(producer)
    return value
end
 
function send (x)
    coroutine.yield(x)
end

producer = coroutine.create( function ()
    while true do
       local x = io.read()      -- produce new value
       send(x)
    end
end)
--[[
这种设计下，开始时调用消费者，当消费者需要值时他唤起生产者生产值，生产者生产值后停止直到消费者再次请求。我们称这种设计为消费者驱动的设计。
我们可以使用过滤器扩展这个设计，过滤器指在生产者与消费者之间，可以对数据进行某些转换处理。过滤器在同一时间既是生产者又是消费者，
他请求生产者生产值并且转换格式后传给消费者，我们修改上面的代码加入过滤器（给每一行前面加上行号）。完整的代码如下：
--]]

function receive(prod)
	local status, value = coroutine.resume(prod)
	return value
end

function send(x)
	coroutine.yield(x)
end

function producer()
	return coroutine.create(function()
		while true do
			local x = io.read()
			send(x)
		end
	end)
end

function filter(prod)
	return coroutine.create(function()
		local line = 1
		while true do
			local x = receive(prod)
			x = string.format("%5d %s", line, x)
			send(x)
			line = line + 1
		end
	end)
end

function consumer(prod)
	while true do
		local x = receive(prod)
		io.write(x, "\n")
	end
end

-- 可以调用
p = producer()
f = filter(p)
consumer(f)

-- 或者：
consumer(filter(producer()))
--[[
看完上面这个例子你可能很自然的想到UNIX的管道，协同是一种非抢占式的多线程。
管道的方式下，每一个任务在独立的进程中运行，而协同方式下，每个任务运行在独立的协同代码中。
管道在读（consumer）与写（producer）之间提供了一个缓冲，因此两者相关的的速度没有什么限制，在上下文管道中这是非常重要的，
因为在进程间的切换代价是很高的。协同模式下，任务间的切换代价较小，与函数调用相当，因此读写可以很好的协同处理。
--]]