-- дһ����򵥵ĳ���Hello World
print("Hello World")

-- �����������n�Ľ׳ˣ�����Ҫ���û�����һ������n��Ȼ���ӡn�Ľ׳�
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

-- ��ȡ����
line = io.read()
n = tonumber(line)
if n == nil then
	error(line .. " is not a valid number")
else
	print(n * 2)
end