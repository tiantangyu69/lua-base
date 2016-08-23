function dofile (filename)
	local f = assert(loadfile(filename))
	return f()
end

dofile("testCompile.lua")
testCompile()

f = loadstring("i = i + 1")
i = 0
f()
print(i)
f()
print(i)

f = loadstring("local a = 10; return a + 20")
print(f())

f = loadfile("foo.lua")
f()
foo("ok")

-- loadfile �� loadstring �������׳�������������������ǽ����� nil ���ϴ�����Ϣ
print(loadstring("i i"))