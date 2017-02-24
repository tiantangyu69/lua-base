--[[
Lua中函数的另一个有趣的特征是可以正确的处理尾调用（proper tail recursion，一些书使用术语“尾递归”，虽然并未涉及到递归的概念）。
尾调用是一种类似在函数结尾的goto调用，当函数最后一个动作是调用另外一个函数时，我们称这种调用尾调用。例如：
--]]
function f(x)
    return g(x)
end

--[[
g的调用是尾调用。
例子中f调用g后不会再做任何事情，这种情况下当被调用函数g结束时程序不需要返回到调用者f；所以尾调用之后程序不需要在栈中保留关于调用者的任何信息。一些编译器比如Lua解释器利用这种特性在处理尾调用时不使用额外的栈，我们称这种语言支持正确的尾调用。
由于尾调用不需要使用栈空间，那么尾调用递归的层次可以无限制的。例如下面调用不论n为何值不会导致栈溢出。
--]]
function foo (n)
    if n > 0 then return foo(n - 1) end
end

--[[
需要注意的是：必须明确什么是尾调用。
一些调用者函数调用其他函数后也没有做其他的事情但不属于尾调用。比如：
--]]
function f (x)
    g(x)
    return
end
--[[ 上面这个例子中f在调用g后，不得不丢弃g地返回值，所以不是尾调用，同样的下面几个例子也不是尾调用：
return g(x) + 1      must do the addition
return x or g(x)     must adjust to 1 result
return (g(x))        must adjust to 1 result
--]]

-- Lua中类似return g(...)这种格式的调用是尾调用。但是g和g的参数都可以是复杂表达式，因为Lua会在调用之前计算表达式的值。例如下面的调用是尾调用：
-- return x[i].foo(x[j] + a*b, i + j)

--[[
可以将尾调用理解成一种goto，在状态机的编程领域尾调用是非常有用的。状态机的应用要求函数记住每一个状态，改变状态只需要goto(or call)一个特定的函数。
我们考虑一个迷宫游戏作为例子：迷宫有很多个房间，每个房间有东西南北四个门，每一步输入一个移动的方向，如果该方向存在即到达该方向对应的房间，否则程序打印警告信息。目标是：从开始的房间到达目的房间。
这个迷宫游戏是典型的状态机，每个当前的房间是一个状态。我们可以对每个房间写一个函数实现这个迷宫游戏，我们使用尾调用从一个房间移动到另外一个房间。一个四个房间的迷宫代码如下：
--]]
function room1 ()
    local move = io.read()
    if move == "south" then
       return room3()
    elseif move == "east" then
       return room2()
    else
       print("invalid move")
       return room1()   -- stay in the same room
    end
end
 
function room2 ()
    local move = io.read()
    if move == "south" then
       return room4()
    elseif move == "west" then
       return room1()
    else
       print("invalid move")
       return room2()
    end
end
 
function room3 ()
    local move = io.read()
    if move == "north" then
       return room1()
    elseif move == "east" then
       return room4()
    else
       print("invalid move")
       return room3()
    end
end
 
function room4 ()
    print("congratilations!")
end

--[[
我们可以调用room1()开始这个游戏。
如果没有正确的尾调用，每次移动都要创建一个栈，多次移动后可能导致栈溢出。
但正确的尾调用可以无限制的尾调用，因为每次尾调用只是一个goto到另外一个函数并不是传统的函数调用。
--]]
room1()
