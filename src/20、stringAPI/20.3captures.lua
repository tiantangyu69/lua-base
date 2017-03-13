--[[
Capture 是这样一种机制：可以使用模式串的一部分匹配目标串的一部分。将你想捕获的模式用圆括号括起来，就指定了一个capture。
在string.find使用captures的时候，函数会返回捕获的值作为额外的结果。这常被用来将一个目标串拆分成多个：
--]]
pair = "name = Anna"
_, _, key, value = string.find(pair, "(%a+)%s*=%s*(%a+)")
print(key, value)    --> name   Anna

--[[
'%a+' 表示非空的字母序列；'%s*' 表示0个或多个空白。在上面的例子中，整个模式代表：一个字母序列，后面是任意多个空白，然后是 '=' 再后面是任意多个空白，然后是一个字母序列。
两个字母序列都是使用圆括号括起来的子模式，当他们被匹配的时候，他们就会被捕获。当匹配发生的时候，find函数总是先返回匹配串的索引下标（上面例子中我们存储哑元变量 _ 中），
然后返回子模式匹配的捕获部分。下面的例子情况类似：
--]]
date = "17/7/1990"
_, _, d, m, y = string.find(date, "(%d+)/(%d+)/(%d+)")
print(d, m, y)       --> 17  7  1990

--[[
我们可以在模式中使用向前引用，'%d'（d代表1-9的数字）表示第d个捕获的拷贝。看个例子，假定你想查找一个字符串中单引号或者双引号引起来的子串，
你可能使用模式 '["'].-["']'，但是这个模式对处理类似字符串 "it's all right" 会出问题。为了解决这个问题，可以使用向前引用，使用捕获的第一个引号来表示第二个引号：
--]]
s = [[then he said: "it's all right"!]]
a, b, c, quotedPart = string.find(s, "([\"'])(.-)%1")
print(quotedPart)    --> it's all right
print(c)             --> "

--[[
第一个捕获是引号字符本身，第二个捕获是引号中间的内容（'.-' 匹配引号中间的子串）。
捕获值的第三个应用是用在函数gsub中。与其他模式一样，gsub的替换串可以包含 '%d'，当替换发生时他被转换为对应的捕获值。（顺便说一下，由于存在这些情况，
替换串中的字符 '%' 必须用 "%%" 表示）。下面例子中，对一个字符串中的每一个字母进行复制，并用连字符将复制的字母和原字母连接起来：
--]]
print(string.gsub("hello Lua!", "(%a)", "%1-%1")) --> h-he-el-ll-lo-o L-Lu-ua-a!

-- 下面代码互换相邻的字符:
print(string.gsub("hello Lua", "(.)(.)", "%2%1")) -->  ehll ouLa

-- 让我们看一个更有用的例子，写一个格式转换器：从命令行获取LaTeX风格的字符串，形如：
s = "\command{some test}"
s = string.gsub(s, "\(%a+){(.-)}", "<%1>%2</%1>")
print(s)

-- 另一个有用的例子是去除字符串首尾的空格：
function trim (s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

s = "   sdf sdfsdf1  "
s = trim(s)
print(s)

--[[
注意模式串的用法，两个定位符（'^' 和 '$'）保证我们获取的是整个字符串。因为，两个 '%s*' 匹配首尾的所有空格，'.-' 匹配剩余部分。还有一点需要注意的是gsub返回两个值，
我们使用额外的圆括号丢弃多余的结果（替换发生的次数）。
最后一个捕获值应用之处可能是功能最强大的。我们可以使用一个函数作为string.gsub的第三个参数调用gsub。
在这种情况下，string.gsub每次发现一个匹配的时候就会调用给定的作为参数的函数，捕获值可以作为被调用的这个函数的参数，
而这个函数的返回值作为gsub的替换串。先看一个简单的例子，下面的代码将一个字符串中全局变量$varname出现的地方替换为变量varname的值：
--]]
function expand (s)
    s = string.gsub(s, "$(%w+)", function (n)
       return _G[n]
    end)
    return s
end
 
name = "Lua"; status = "great"
print(expand("$name is $status, isn't it?"))      --> Lua is great, isn't it?


-- 如果你不能确定给定的变量是否为string类型，可以使用tostring进行转换：
function expand (s)
    return (string.gsub(s, "$(%w+)", function (n)
       return tostring(_G[n])
    end))
end
 
print(expand("print = $print; gg = $gg"))            --> print = function: 0x8050ce0; a = nil

-- 下面是一个稍微复杂点的例子，使用loadstring来计算一段文本内$后面跟着一对方括号内表达式的值：
s = "sin(3) = $[math.sin(3)]; 2^5 = $[2^5]"
print((string.gsub(s, "$(%b[])", function (x)
    x = "return " .. string.sub(x, 2, -2)
    local f = loadstring(x)
    return f()
end)))
 
-->  sin(3) = 0.1411200080598672; 2^5 = 32
--[[
第一次匹配是 "$[math.sin(3)]"，对应的捕获为 "$[math.sin(3)]"，调用string.sub去掉首尾的方括号，所以被加载执行的字符串是 "return math.sin(3)"，"$[2^5]" 的匹配情况类似。
我们常常需要使用string.gsub遍历字符串，而对返回结果不感兴趣。比如，我们收集一个字符串中所有的单词，然后插入到一个表中：
--]]
words = {}
string.gsub(s, "(%a+)", function (w)
    table.insert(words, w)
end)
--[[
如果字符串s为 "hello hi, again!"，上面代码的结果将是：
{"hello", "hi", "again"}
--]]

-- 使用string.gfind函数可以简化上面的代码：
words = {}
for w in string.gfind(s, "(%a)") do
    table.insert(words, w)
end

--[[
gfind函数比较适合用于范性for循环。他可以遍历一个字符串内所有匹配模式的子串。我们可以进一步的简化上面的代码，
调用gfind函数的时候，如果不显示的指定捕获，函数将捕获整个匹配模式。所以，上面代码可以简化为：
--]]
words = {}
for w in string.gfind(s, "%a") do
    table.insert(words, w)
end

function escape (s)
    s = string.gsub(s, "([&=+%c])", function (c)
       return string.format("%%%02X", string.byte(c))
    end)
    s = string.gsub(s, " ", "+")
    return s
end

function encode (t)
    local s = ""
    for k,v in pairs(t) do
       s = s .. "&" .. escape(k) .. "=" .. escape(v)
    end
    return string.sub(s, 2)     -- remove first `&'
end
t = {name = "al",  query = "a+b = c", q="yes or no"}
 
print(encode(t)) --> q=yes+or+no&query=a%2Bb+%3D+c&name=al

























