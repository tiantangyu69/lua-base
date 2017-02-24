--[[
Metatables也允许我们使用metamethods：__eq（等于），__lt（小于），和__le（小于等于）给关系运算符赋予特殊的含义。对剩下的三个关系运算符没有专门的metamethod，
因为Lua将a ~= b转换为not (a == b)；a > b转换为b < a；a >= b转换为 b <= a。
（直到Lua 4.0为止，所有的比较运算符被转换成一个，a <= b转为not (b < a)。然而这种转换并不一致正确。当我们遇到偏序（partial order）情况，也就是说，
并不是所有的元素都可以正确的被排序情况。例如，在大多数机器上浮点数不能被排序，因为他的值不是一个数字（Not a Number即NaN）。根据IEEE 754的标准，NaN表示一个未定义的值，
比如0/0的结果。该标准指出任何涉及到NaN比较的结果都应为false。也就是说，NaN <= x总是false，x < NaN也总是false。这样一来，在这种情况下a <= b 转换为 not (b < a)就不再正确了。）
在我们关于基和操作的例子中，有类似的问题存在。<=代表集合的包含：a <= b表示集合a是集合b的子集。这种意义下，可能a <= b和b < a都是false；因此，我们需要将__le和__lt的实现分开：
--]]

Set.mt.__le = function (a,b)    -- set containment
    for k in pairs(a) do
       if not b[k] then return false end
    end
    return true
end
 
Set.mt.__lt = function (a,b)
    return a <= b and not (b <= a)
end

-- 最后，我们通过集合的包含来定义集合相等：
Set.mt.__eq = function (a,b)
    return a <= b and b <= a
end

-- 有了上面的定义之后，现在我们就可以来比较集合了：
s1 = Set.new{2, 4}
s2 = Set.new{4, 10, 2}
print(s1 <= s2)          --> true
print(s1 < s2)           --> true
print(s1 >= s1)          --> true
print(s1 > s1)           --> false
print(s1 == s2 * s1)     --> true

--[[
与算术运算的metamethods不同，关系元算的metamethods不支持混合类型运算。对于混合类型比较运算的处理方法和Lua的公共行为类似。
如果你试图比较一个字符串和一个数字，Lua将抛出错误。相似的，如果你试图比较两个带有不同metamethods的对象，Lua也将抛出错误。
但相等比较从来不会抛出错误，如果两个对象有不同的metamethod，比较的结果为false，甚至可能不会调用metamethod。这也是模仿了Lua的公共的行为，
因为Lua总是认为字符串和数字是不等的，而不去判断它们的值。仅当两个有共同的metamethod的对象进行相等比较的时候，Lua才会调用对应的metamethod。
--]]