--[[
break语句用来退出当前循环（for、repeat、while）。在循环外部不可以使用。
return用来从函数返回结果，当一个函数自然结束时，结尾会有一个默认的return。（这种函数类似pascal的过程（procedure））
Lua语法要求break和return只能出现在block的结尾一句（也就是说：作为chunk的最后一句，或者在end之前，或者else前，或者until前），例如：
--]]
a = {1, 2, 3, 4, 5}
local i = 1
v = 3

while a[i] do
    if a[i] == v then
		print(v)
		break
	end
    i = i + 1
end

-- 有时候为了调试或者其他目的需要在block的中间使用return或者break，可以显式的使用do..end来实现：
--[[
function foo ()
    return            --<< SYNTAX ERROR
    -- 'return' is the last statement in the next block
    do return end        -- OK
    ...               -- statements not reached
end
--]]