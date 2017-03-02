--[[
我们经常写一个package然后将所有的代码放到一个单独的文件中。然后我们只需要执行这个文件即加载package。
例如，如果我们将上面我们的复数的package代码放到一个文件complex.lua中，命令“require complex”将打开这个package。
记住require命令不会将相同的package加载多次。
需要注意的问题是，搞清楚保存package的文件名和package名的关系。当然，将他们联系起来是一个好的想法，因为require命令使用文件而不是packages。
一种解决方法是在package的后面加上后缀（比如.lua）来命名文件。Lua并不需要固定的扩展名，而是由你的路径设置决定。例如，如果你的路径包含："/usr/local/lualibs/?.lua"，
那么复数package可能保存在一个complex.lua文件中。
有些人喜欢先命名文件后命名package。也就是说，如果你重命名文件，package也会被重命名。这个解决方法提供了很大的灵活性。
例如，如果你有两个有相同名称的package，你不需要修改任何一个，只需要重命名一下文件。在Lua中我们使用_REQUIREDNAME变量来重命名。
记住，当require加载一个文件的时候，它定义了一个变量来表示虚拟的文件名。因此，在你的package中可以这样写：
--]]

local P = {}
if _REQUIREDNAME == nil then
	complex = P
else
	_G[_REQUIREDNAME] = P
end

local P = {}
complex = P
setfenv(1, P)

function add(c1, c2)
	return new(c1.r + c2.r, c1.i + c2.i)
end



local P = {}
if _REQUIREDNAME == nil then
	complex = P
else
	_G[_REQUIREDNAME] = P
end
setfenv(1, P)


local P = {}
setmetatable(P, {__index = _G})
setfenv(1, P)


local P = {}
pack = P
local _G = _G
setfenv(1, P)