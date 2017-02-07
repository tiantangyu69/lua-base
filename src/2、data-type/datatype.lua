print(type("hello world")) -- string
print(type(10.4 * 3)) -- number
print(type(print)) -- function
print(type(type)) -- function

--Lua 中所有的取值都可以作为条件，在控制结构的条件中除了 false 和 nil 为假，其他值都为真
print(type(true)) -- boolean
print(type(nil)) -- nil
print(type(type(type(x)))) -- string
print(type(type(a))) -- string
a = 10
print(type(type(a))) -- string
a = print
print(type(a)) -- function

print([[
aaaaaaaaaa
bbbbbbbbbb
cccccccccc
]])

print(type(dddd))

-- Lua 中的字符串是不可以修改的
a = "one string"
b = string.gsub(a, "one", "another")
print(a)
print(b)

-- Lua 中的转译字符
--[[
	\a bell
	\b back space               -- 后退
	\f form feed                -- 换页
	\n newline                  -- 换行
	\r carriage return          -- 回车
	\t horizontal tab           -- 制表
	\v vertical tab
	\\ backslash                 -- "\"
	\" double quote             -- 双引号
	\' single quote             -- 单引号
	\[ left square bracket      -- 左中括号
	\] right square bracket     -- 右中括号
]]--
print("\a")