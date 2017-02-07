--[[
 <      >      <=     >=     ==     ~=
这些操作符返回结果为false或者true；
==和~=比较两个值，如果两个值类型不同，Lua认为两者不同；
nil只和自己相等。
Lua通过引用比较tables、userdata、functions。也就是说当且仅当两者表示同一个对象时相等。
--]]

a = {}; a.x = 1; a.y = 0
b = {}; b.x = 1; b.y = 0
c = a
print(a==c)
print(a~=b)


--[[
Lua比较数字按传统的数字大小进行，比较字符串按字母的顺序进行，但是字母顺序依赖于本地环境。
当比较不同类型的值的时候要特别注意：
--]]

print("0" == 0)       -- false
print(2 < 15)         -- true
print("2" < "15")     -- false (alphabetical order!)

-- 为了避免不一致的结果，混合比较数字和字符串，Lua会报错，比如：2 < "15"
