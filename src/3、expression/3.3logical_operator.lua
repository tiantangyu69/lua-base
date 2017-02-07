-- and or not
-- 逻辑运算符认为false和nil是假（false），其他为真，0也是true. and和or的运算结果不是true和false，而是和它的两个操作数相关。

-- a and b, 如果a为false，则返回a，否则返回b
-- a or  b, 如果a为true，则返回a，否则返回b

print(4 and 5)           --> 5
print(nil and 13)        --> nil
print(false and 13)      --> false
print(4 or 5)            --> 4
print(false or 5)        --> 5


-- 一个很实用的技巧：如果x为false或者nil则给x赋初始值v, x = x or v, and的优先级比or高

print(not nil)           --> true
print(not false)         --> true
print(not 0)             --> false
print(not not nil)       --> false
