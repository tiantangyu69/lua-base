print("-------------------if elseif else end------------------------------\n")

a = 10
b = 20

if a < b then
	print("a < b")
end

if	a == b then
	print("a == b")
else
	print("a != b")
end

if a == b then
	print("a == b")
elseif a > b then
	print("a > b")
else
	print("a < b")
end

print("\n--------------------while repeat-until for ----------------------\n")

while a > 0 do
	print(a)
	a = a - 1;
end

print("\n---------------\n")

repeat
	print(b)
	b = b - 5
until b < 0

print("\n---------------\n")

for var=0,10 do
	print(var)
end

print("\n---------------\n")

for var=0,10,2 do
	print(var)
end



