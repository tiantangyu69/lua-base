--[[
time和date两个函数在Lua中实现所有的时钟查询功能。函数time在没有参数时返回当前时钟的数值。（在许多系统中该数值是当前距离某个特定时间的秒数。）
当为函数调用附加一个特殊的时间表时，该函数就是返回距该表描述的时间的数值。这样的时间表有如下的区间：

year		a full year
month		01-12
day			01-31
hour		00-23
min			00-59
sec			00-59
isdst		a boolean, true if daylight saving

前三项是必需的，如果未定义后几项，默认时间为正午（12:00:00）。如果是在里约热内卢（格林威治向西三个时区）的一台Unix计算机上（相对时间为1970年1月1日，00:00:00）
执行如下代码，其结果将如下。
--]]
print(os.time{year=1970, month=1, day=1, hour=0})
print(os.time{year=1970, month=1, day=1, hour=0, sec=1})
print(os.time{year=1970, month=1, day=1})