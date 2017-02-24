-- 写一个最简单的程序，Hello World
print("Hello World")

-- 计算输入参数n的阶乘；本例要求用户输入一个数字n，然后打印n的阶乘
-- defines a factorial function
function fact(n)
	if n == 0 then
		return 1
	else
		return n * fact(n - 1)
	end
end

print("enter a number: ")
a = io.read("*number")
print(fact(a))

-- 读取输入
line = io.read()
n = tonumber(line)
if n == nil then
	error(line .. " is not a valid number")
else
	print(n * 2)
end