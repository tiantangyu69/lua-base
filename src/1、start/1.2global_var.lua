-- 全局变量不需要申明，给一个变量赋值后即可创建这个全局变量，访问一个没有初始化的全局变量也不会出错，只不过得到的结果是 nil
print(b) -- nil
b = 10
print(b) -- 10

-- 如果想删除一个全局变量，只需要将变量赋值为 nil
b = nil
print(b) -- nil