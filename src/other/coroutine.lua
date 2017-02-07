co = coroutine.create(
	function()
		print("hi")
	end
)

print(co)
print(coroutine.status(co))  --> suspended

coroutine.resume(co)

co = coroutine.create(
	function()
		for i = 1, 10 do
			print("co", i)
			coroutine.yield()
		end
	end
)

coroutine.resume(co)
print(coroutine.status(co))
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co) 
print(coroutine.resume(co))

co = coroutine.create(
	function(a, b, c)
		print("co", a, b, c)
	end
)
coroutine.resume(co, 3, 345, 3452)


co = coroutine.create(
	function(a, b)
		coroutine.yield(a + b, a - b)
	end
)

print(coroutine.resume(co, 22, 45))

co = coroutine.create(
	function()
		print("co", coroutine.yield())
	end
)
coroutine.resume(co)
coroutine.resume(co, 4, 5)

co = coroutine.create(
	function()
		return 6, 7
	end
)
print(coroutine.resume(co))


-- 生产者，消费者
function receive (prod)
    local status, value = coroutine.resume(prod)
    return value
end
 
function send (x)
    coroutine.yield(x)
end
 
function producer ()
    return coroutine.create(function ()
       while true do
           local x = io.read()      -- produce new value
           send(x)
       end
    end)
end
 
function filter (prod)
    return coroutine.create(function ()
       local line = 1
       while true do
           local x = receive(prod)  -- get new value
           x = string.format("%5d %s", line, x)
           send(x)       -- send it to consumer
           line = line + 1
       end
    end)
end
 
function consumer (prod)
    while true do
       local x = receive(prod)  -- get new value
       io.write(x, "\n")        -- consume new value
    end
end

consumer(filter(producer()))