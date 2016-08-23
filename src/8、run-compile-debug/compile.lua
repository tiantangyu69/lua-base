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

-- loadfile 和 loadstring 都不会抛出错误，如果发生错误他们将返回 nil 加上错误信息
print(loadstring("i i"))