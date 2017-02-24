--[[
Lua和C是很容易结合的，使用C为Lua写包。与Lua中写包不同，C包在使用以前必须首先加载并连接，在大多数系统中最容易的实现方式是通过动态连接库机制，
然而动态连接库不是ANSI C的一部分，也就是说在标准C中实现动态连接是很困难的。
通常Lua不包含任何不能用标准C实现的机制，动态连接库是一个特例。我们可以将动态连接库机制视为其他机制之母：
一旦我们拥有了动态连接机制，我们就可以动态的加载Lua中不存在的机制。所以，在这种特殊情况下，Lua打破了他平台兼容的原则而通过条件编译的方式为一些平台实现了动态连接机制。
标准的Lua为windows、Linux、FreeBSD、Solaris和其他一些Unix平台实现了这种机制，扩展其它平台支持这种机制也是不难的。在Lua提示符下运行print(loadlib())
看返回的结果，如果显示bad arguments则说明你的发布版支持动态连接机制，否则说明动态连接机制不支持或者没有安装。
Lua在一个叫loadlib的函数内提供了所有的动态连接的功能。这个函数有两个参数:库的绝对路径和初始化函数。所以典型的调用的例子如下：
--]]
-- print(loadlib())

local path = "/usr/local/lua/lib/libluasocket.so"
local f = loadlib(path, "luaopen_socket")

--[[
loadlib函数加载指定的库并且连接到Lua，然而它并不打开库（也就是说没有调用初始化函数），反之他返回初始化函数作为Lua的一个函数，
这样我们就可以直接在Lua中调用他。如果加载动态库或者查找初始化函数时出错，loadlib将返回nil和错误信息。我们可以修改前面一段代码，使其检测错误然后调用初始化函数：
--]]
local path = "/usr/local/lua/lib/libluasocket.so"
-- or path = "C:\\windows\\luasocket.dll"
local f = assert(loadlib(path, "luaopen_socket"))
f()  -- actually open the library
-- 一般情况下我们期望二进制的发布库包含一个与前面代码段相似的stub文件，
-- 安装二进制库的时候可以随便放在某个目录，只需要修改stub文件对应二进制库的实际路径即可。
-- 将stub文件所在的目录加入到LUA_PATH，这样设定后就可以使用require函数加载C库了