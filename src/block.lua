x = 10
local i = 1  -- local to the chunk

while i <= x do
	local x = i * 2 -- local to the while body
	print(x) --> 2, 4, 6, 8, ...
	i = i + 1
end

if i > 20 then
	local x  -- local to the then body
	x = 20
	print(x + 2)
else
	print(x)  --> 10 (the global one)
end

print(x)  --> 10 (the global one)


print("\n-------------------------------------------------------------------\n")

do
	local a2 = 2;
	local d = 16
	x1 = 111
	x2 = 2323
end  -- scope of a2 and d ends here

print(a2, d)
print(x1, x2)

