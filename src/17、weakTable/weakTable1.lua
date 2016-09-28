a = {}
b = {}
setmetatable(a, b)
b.__mode = "k" 
-- now 'a' has week keys
key = {}
a[key] = 1

key = {}
a[key] = 2

collectgarbage() -- forces a garbage collection cycle

for k, v in pairs(a) do
	print(v)
end