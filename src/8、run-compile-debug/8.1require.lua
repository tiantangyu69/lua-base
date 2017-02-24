--[[
Lua提供高级的require函数来加载运行库。粗略的说require和dofile完成同样的功能但有两点不同：
	1.require会搜索目录加载文件
	2.require会判断是否文件已经加载避免重复加载同一文件。由于上述特征，require在Lua中是加载库的更好的函数。
	
require使用的路径和普通我们看到的路径还有些区别，我们一般见到的路径都是一个目录列表。
require的路径是一个模式列表，每一个模式指明一种由虚文件名（require的参数）转成实文件名的方法。
更明确地说，每一个模式是一个包含可选的问号的文件名。匹配的时候Lua会首先将问号用虚文件名替换，
然后看是否有这样的文件存在。如果不存在继续用同样的方法用第二个模式匹配。例如，路径如下：

?;?.lua;c:\windows\?;/usr/local/lua/?/?.lua

调用require "lili"时会试着打开这些文件：
lili
lili.lua
c:\windows\lili
/usr/local/lua/lili/lili.lua


require关注的问题只有分号（模式之间的分隔符）和问号，其他的信息（目录分隔符，文件扩展名）在路径中定义。
为了确定路径，Lua首先检查全局变量LUA_PATH是否为一个字符串，如果是则认为这个串就是路径；
否则require检查环境变量LUA_PATH的值，如果两个都失败require使用固定的路径（典型的"?;?.lua"）
require的另一个功能是避免重复加载同一个文件两次。Lua保留一张所有已经加载的文件的列表（使用table保存）。
如果一个加载的文件在表中存在require简单的返回；表中保留加载的文件的虚名，而不是实文件名。所以如果你使用不同的虚文件名require同一个文件两次，
将会加载两次该文件。比如require "foo"和require "foo.lua"，路径为"?;?.lua"将会加载foo.lua两次。我们也可以通过全局变量_LOADED访问文件名列表，
这样我们就可以判断文件是否被加载过；同样我们也可以使用一点小技巧让require加载一个文件两次。比如，require "foo"之后_LOADED["foo"]将不为nil，我们可以将其赋值为nil，require "foo.lua"将会再次加载该文件。
一个路径中的模式也可以不包含问号而只是一个固定的路径，比如：
?;?.lua;/usr/local/default.lua

这种情况下，require没有匹配的时候就会使用这个固定的文件（当然这个固定的路径必须放在模式列表的最后才有意义）。
在require运行一个chunk以前，它定义了一个全局变量_REQUIREDNAME用来保存被required的虚文件的文件名。
我们可以通过使用这个技巧扩展require的功能。举个极端的例子，我们可以把路径设为"/usr/local/lua/newrequire.lua"，
这样以后每次调用require都会运行newrequire.lua，这种情况下可以通过使用_REQUIREDNAME的值去实际加载required的文件。
--]]


require "foo"
foo("dddddddddddddddddd")