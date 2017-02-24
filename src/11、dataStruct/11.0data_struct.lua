--[[
table是Lua中唯一的数据结构，其他语言所提供的数据结构，如：arrays、records、lists、queues、sets等，Lua都是通过table来实现，并且在lua中table很好的实现了这些数据结构。
在传统的C语言或者Pascal语言中我们经常使用arrays和lists（record+pointer）来实现大部分的数据结构，在Lua中不仅可以用table完成同样的功能，而且table的功能更加强大。
通过使用table很多算法的实现都简化了，比如你在lua中很少需要自己去实现一个搜索算法，因为table本身就提供了这样的功能。
我们需要花一些时间去学习如何有效的使用table，下面通过一些例子，我们来看看如果通过table来实现一些常用的数据结构。
首先，我们从arrays和lists开始，因为两者是其他数据结构的基础，大家也比较熟悉。前面章节，我们已接触了table的一些内容，本章，我们将彻底了解它。
--]]