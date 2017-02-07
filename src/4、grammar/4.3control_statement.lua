-- 控制结构的条件表达式结果可以是任何值，Lua认为false和nil为假，其他值为真。

--[[
if语句，有三种形式：
if conditions then
    then-part
end;
 
if conditions then
    then-part
else
    else-part
end;
 
if conditions then
    then-part
elseif conditions then
    elseif-part
..            --->多个elseif
else
    else-part
end;
--]]
a  = 10
if a == 10 then
	print(a .. "==" .. 10)
end

if a < 10 then
	print("a < 10")
else
	print("a >= 10")
end

if a < 10 then
	print("a < 10")
elseif a == 10 then
	print("a == 10")
else
	print("a > 10")
end



--[[
while语句：
while condition do
    statements;
end;
--]]
x = 10
while x > 0 do
	print("x:" .. x)
	x = x - 1
end


--[[
repeat-until语句：
repeat
    statements;
until conditions;
--]]
y = 5
repeat
	print("y:" .. y)
	y = y + 1
until y > 10



--[[
for语句有两大类：
第一，数值for循环：
for var=exp1,exp2,exp3 do
    loop-part
end

for将用exp3作为step从exp1（初始值）到exp2（终止值），执行loop-part。其中exp3可以省略，默认step=1
有几点需要注意：

1. 三个表达式只会被计算一次，并且是在循环开始前。
for i=1,f(x) do
    print(i)
end
--]]
 
for i=10,1,-1 do
    print(i)
end
-- 第一个例子f(x)只会在循环前被调用一次。



--[[
2. 控制变量var是局部变量自动被声明,并且只在循环内有效.
for i=1,10 do
    print(i)
end
max = i       -- probably wrong! 'i' here is global

如果需要保留控制变量的值，需要在循环中将其保存
-- find a value in a list
local found = nil
for i=1,a.n do
    if a[i] == value then
       found = i         -- save value of 'i'
       break
    end
end
print(found)
--]]

-- 3. 循环过程中不要改变控制变量的值，那样做的结果是不可预知的。如果要退出循环，使用break语句。
--[[
第二，范型for循环：
前面已经见过一个例子：
--]]
-- print all values of array 'a'
a = {1,2,3,4,5,6}
for i,v in ipairs(a) do print("v:" .. v) end

--[[
范型for遍历迭代子函数返回的每一个值。
再看一个遍历表key的例子：
--]]
-- print all keys of table 't'
t = {["a"] = 1, ["b"] = 2, c = 3}
for k in pairs(t) do print(k) end


--[[
范型for和数值for有两点相同：
1. 控制变量是局部变量
2. 不要修改控制变量的值
再看一个例子，假定有一个表:
--]]
days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
			  
-- 现在想把对应的名字转换成星期几，一个有效地解决问题的方式是构造一个反向表：
revDays = {["Sunday"] = 1, ["Monday"] = 2,
                     ["Tuesday"] = 3, ["Wednesday"] = 4,
                     ["Thursday"] = 5, ["Friday"] = 6, 
                     ["Saturday"] = 7}
					 
-- 下面就可以很容易获取问题的答案了:
x = "Tuesday"
print(revDays[x])        --> 3

-- 我们不需要手工，可以自动构造反向表
revDays = {}
for i,v in ipairs(days) do
    revDays[v] = i
end