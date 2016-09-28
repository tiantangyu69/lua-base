-- 非全局的环境
--[[
a = 1
setfenv(1, {_G = _G})
_G.print(a)
_G.print(_G.a)
]]

a = 1
local newgt = {}
setmetatable(newgt, {__index = _G})
setfenv(1, newgt)
print(a)

a = 10
print(a)
print(_G.a)
_G.a = 20
print(_G.a)
print(a)