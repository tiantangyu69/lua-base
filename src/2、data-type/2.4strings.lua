-- 指字符的序列。lua是8位字节，所以字符串可以包含任何数值字符，包括嵌入的0。这意味着你可以存储任意的二进制数据在一个字符串里。Lua中字符串是不可以修改的，你可以创建一个新的变量存放你要的字符串，如下：
a = "one string"
b = string.gsub(a, "one", "another")
print(a) -- one string
print(b) -- another string

-- 为了风格统一，最好使用一种，除非两种引号嵌套情况。对于字符串中含有引号的情况还可以使用转义符\来表示。Lua中的转义序列有：

--[[
\a bell
\b back space               -- 后退
\f form feed                -- 换页
\n newline                  -- 换行
\r carriage return          -- 回车
\t horizontal tab           -- 制表
\v vertical tab
\\ backslash                 -- "\"
\" double quote             -- 双引号
\' single quote             -- 单引号
\[ left square bracket      -- 左中括号
\] right square bracket     -- 右中括号
--]]

--[[
还可以在字符串中使用\ddd（ddd为三位十进制数字）方式表示字母。
"alo\n123\""和'\97lo\10\04923"'是相同的。
--]]

-- 还可以使用如下方式表示字符串。这种形式的字符串可以包含多行也，可以嵌套且不会解释转义序列，如果第一个字符是换行符会被自动忽略掉。这种形式的字符串用来包含一段代码是非常方便的。

page = [[
<HTML>
<HEAD>
<TITLE>An HTML Page</TITLE>
</HEAD>
<BODY>
Lua
a text between double brackets
</BODY>
</HTML>
]]
 
io.write(page)

-- 运行时，Lua会自动在string和numbers之间自动进行类型转换，当一个字符串使用算术操作符时，string就会被转成数字。
print("10" + 1)
print("10 + 1")
-- print("-5.3e - 10" * "2")   --> -1.06e-09
-- print("hello" + 1)          -- ERROR (cannot convert "hello")

-- 反过来，当Lua期望一个string而碰到数字时，会将数字转成string。
print(10 .. 20)      --> 1020


-- ..在Lua中是字符串连接符，当在一个数字后面写..时，必须加上空格以防止被解释错。
-- 尽管字符串和数字可以自动转换，但两者是不同的，像10 == "10"这样的比较永远都是错的。如果需要显式将string转成数字可以使用函数tonumber()，如果string不是正确的数字该函数将返回nil。
line = io.read()         -- read a line
n = tonumber(line)       -- try to convert it to a number
if n == nil then
    error(line .. " is not a valid number")
else
    print(n*2)
end

-- 反之,可以调用tostring()将数字转成字符串，这种转换一直有效：
print(tostring(10) == "10")     --> true
print(10 .. "" == "10")         --> true