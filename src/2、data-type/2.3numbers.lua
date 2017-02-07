--[[
表示实数，Lua中没有整数。一般有个错误的看法CPU运算浮点数比整数慢。事实不是如此，用实数代替整数不会有什么误差（除非数字大于100,000,000,000,000）。
Lua的numbers可以处理任何长整数不用担心误差。你也可以在编译Lua的时候使用长整型或者单精度浮点型代替numbers，
在一些平台硬件不支持浮点数的情况下这个特性是非常有用的，具体的情况请参考Lua发布版所附的详细说明。
和其他语言类似，数字常量的小数部分和指数部分都是可选的，数字常量的例子：
4      0.4    4.57e-3       0.3e12     5e+20
--]]