--[[
在这一章中（下面关于标准库的几章中同样）我的主要目的不是对每一个函数给出完整地说明，而是告诉你标准库能够提供什么功能。为了能够清楚地说明问题，
我可能会忽略一些小的选项或者行为。主要的思想是激发你的好奇心，这些好奇之处可能在参考手册中找到答案。
数学库由算术函数的标准集合组成，比如三角函数库（sin, cos, tan, asin, acos, etc.），幂指函数（exp, log, log10），舍入函数（floor, ceil）、max、min，加上一个变量pi。数学库也定义了一个幂操作符（^）。
所有的三角函数都在弧度单位下工作。（Lua4.0以前在度数下工作。）你可以使用deg和rad函数在度和弧度之间转换。如果你想在degree情况下使用三角函数，你可以重定义三角函数：

local sin, asin, ... = math.sin, math.asin, ...
local deg, rad = math.deg, math.rad
math.sin = function (x) return sin(rad(x)) end
math.asin = function (x) return deg(asin(x)) end
...

math.random用来产生伪随机数，有三种调用方式：
第一：不带参数，将产生 [0,1)范围内的随机数.
第二：带一个参数n，将产生1 <= x <= n范围内的随机数x.
第三：带两个参数a和b,将产生a <= x <= b范围内的随机数x.

你可以使用randomseed设置随机数发生器的种子，只能接受一个数字参数。通常在程序开始时，使用固定的种子初始化随机数发生器，意味着每次运行程序，将产生相同的随机数序列。为了调试方便，这很有好处，但是在游戏中就意味着每次运行都拥有相同的关卡。解决这个问题的一个通常的技巧是使用当前系统时间作为种子：
math.randomseed(os.time())
（os.time函数返回一个表示当前系统时间的数字，通常是自新纪元以来的一个整数。）
--]]

print(math.random())
print(math.random(5))
print(math.random(6, 10))
math.randomseed(os.time())
print(math.random())