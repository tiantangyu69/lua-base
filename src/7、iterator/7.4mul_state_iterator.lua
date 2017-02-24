--[[
很多情况下，迭代器需要保存多个状态信息而不是简单的状态常量和控制变量，最简单的方法是使用闭包，
还有一种方法就是将所有的状态信息封装到table内，将table作为迭代器的状态常量，因为这种情况下可以将所有的信息存放在table内，所以迭代函数通常不需要第二个参数。
下面我们重写allwords迭代器，这一次我们不是使用闭包而是使用带有两个域（line, pos）的table。
开始迭代的函数是很简单的，他必须返回迭代函数和初始状态：
--]]
local iterator       -- to be defined later
 
function allwords()
    local state = {line = io.read(), pos = 1}
    return iterator, state
end

-- 真正的处理工作是在迭代函数内完成：
function iterator (state)
    while state.line do      -- repeat while there are lines
       -- search for next word
       local s, e = string.find(state.line, "%w+", state.pos)
       if s then     -- found a word?
           -- update next position (after this word)
           state.pos = e + 1
           return string.sub(state.line, s, e)
       else   -- word not found
           state.line = io.read()   -- try next line...
           state.pos = 1     -- ... from first position
       end
    end
    return nil        -- no more lines: end loop
end

-- 我们应该尽可能的写无状态的迭代器，因为这样循环的时候由for来保存状态，不需要创建对象花费的代价小；如果不能用无状态的迭代器实现，应尽可能使用闭包；
-- 尽可能不要使用table这种方式，因为创建闭包的代价要比创建table小，另外Lua处理闭包要比处理table速度快些。后面我们还将看到另一种使用协同来创建迭代器的方式，这种方式功能更强但更复杂。