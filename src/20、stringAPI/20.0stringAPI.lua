--[[
Lua解释器对字符串的支持很有限。一个程序可以创建字符串并连接字符串，但不能截取子串，检查字符串的大小，检测字符串的内容。在Lua中操纵字符串的功能基本来自于string库。
String库中的一些函数是非常简单的：string.len(s)返回字符串s的长度；string.rep(s, n)返回重复n次字符串s的串；
你使用string.rep("a", 2^20)可以创建一个1M bytes的字符串（比如，为了测试需要）；string.lower(s)将s中的大写字母转换成小写
（string.upper将小写转换成大写）。如果你想不关心大小写对一个数组进行排序的话，你可以这样：

table.sort(a, function(a, b)
	return string.lower(a) < string.lower(b)
)
--]]

-- string.upper和string.lower都依赖于本地环境变量。所以，如果你在 European Latin-1环境下，表达式：
print(string.upper("a??o"))

--[[
调用string.sub(s,i,j)函数截取字符串s的从第i个字符到第j个字符之间的串。Lua中，字符串的第一个字符索引从1开始。
你也可以使用负索引，负索引从字符串的结尾向前计数：-1指向最后一个字符，-2指向倒数第二个，以此类推。
所以， string.sub(s, 1, j)返回字符串s的长度为j的前缀；string.sub(s, j, -1)返回从第j个字符开始的后缀。
如果不提供第3个参数，默认为-1，因此我们将最后一个调用写为string.sub(s, j)；string.sub(s, 2, -2)返回去除第一个和最后一个字符后的子串。
--]]
s = "{in brackets}"
print(string.sub(s, 2, -2))
-- 记住：Lua中的字符串是恒定不变的。String.sub函数以及Lua中其他的字符串操作函数都不会改变字符串的值，而是返回一个新的字符串。一个常见的错误是：
string.sub(s, 2, -2)
-- 认为上面的这个函数会改变字符串s的值。如果你想修改一个字符串变量的值，你必须将变量赋给一个新的字符串：
print(s)
s = string.sub(s, 2, -2)
print(s)

--[[
string.char函数和string.byte函数用来将字符在字符和数字之间转换。string.char获取0个或多个整数，将每一个数字转换成字符，然后返回一个所有这些字符连
接起来的字符串。string.byte(s, i)将字符串s的第i个字符的转换成整数；第二个参数是可选的，缺省情况下i=1。下面的例子中，我们假定字符用ASCII表示：
--]]
print(string.char(97))
i = 99
print(string.char(i, i + 1, i + 2))
print(string.byte("abc"))
print(string.byte("abc", 2))
print(string.byte("abc", -1))

--[[
上面最后一行，我们使用负数索引访问字符串的最后一个字符。
函数string.format在用来对字符串进行格式化的时候，特别是字符串输出，是功能强大的工具。这个函数有两个参数，使用和C语言的printf函数几乎一模一样，
你完全可以照C语言的printf来使用这个函数。第一个参数为格式化串：由指示符和控制格式的字符组成。指示符后的控制格式的字符可以为：
十进制'd'；十六进制'x'；八进制'o'；浮点数'f'；字符串's'。在指示符'%'和控制格式字符之间还可以有其他的选项：用来控制更详细的格式，比如一个浮点数的小数的位数：
--]]
PI = 3.1415926
print(string.format("pi = %.4f", PI))                --> pi = 3.1416
d = 5; m = 11; y = 1990
print(string.format("%02d/%02d/%04d", d, m, y))      --> 05/11/1990
tag, title = "h1", "a title"
print(string.format("<%s>%s</%s>", tag, title, tag)) --> <h1>a title</h1>

--[[
第一个例子，%.4f代表小数点后面有4位小数的浮点数。第二个例子%02d代表以固定的两位显示十进制数，不足的前面补0。而%2d前面没有指定0，
不足两位时会以空白补足。对于格式串部分指示符得详细描述清参考lua手册，或者参考C手册，因为Lua调用标准C的printf函数来实现最终的功能。
--]]