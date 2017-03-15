-- 函数os.exit终止一个程序的执行。函数os.getenv得到“环境变量”的值。以“变量名”作为参数，返回该变量值的字符串：
print(os.getenv("HOME"))    --> C:\Users\bjlizhitao

-- 如果没有该环境变量则返回nil。函数os.execute执行一个系统命令（和C中的system函数等价）。该函数获取一个命令字符串，返回一个错误代码。例如在Unix和DOS-Windows系统里都可以执行如下代码创建一个新目录：
function createDir (dirname)
    os.execute("mkdir " .. dirname)
end

--[[
os.execute函数较为强大，同时也更加依赖于计算机系统。函数os.setlocale设定Lua程序所使用的区域（locale）。区域定义的变化对于文化和语言是相当敏感的。
setlocale有两个字符串参数：区域名和特性（category，用来表示区域的各项特性）。在区域中包含六项特性：“collate”（排序）控制字符的排列顺序；"ctype" 
controls the types of individual characters (e.g., what is a letter) and the conversion between lower and upper cases; "monetary"（货币）
对Lua程序没有影响；"numeric"（数字）控制数字的格式；"time"控制时间的格式（也就是os.date函数）；和“all”包含以上所以特性。函数默认的特性就是“all”，
所以如果你只包含地域名就调用函数setlocale那么所有的特性都会被改变为新的区域特性。如果运行成功函数返回地域名，否则返回nil（通常因为系统不支持给定的区域）。
--]]
print(os.setlocale("ISO-8859-1", "collate"))  --> ISO-8859-1

--[[
关于“numeric”特性有一点难处理的地方。尽管葡萄牙语和其它的一些拉丁文语言使用逗号代替点号来表示十进制数，但是区域设置并不会改变Lua划分数字的方式。
（除了其它一些原因之外，由于print（3,4）还有其它的函数意义。）因此设置之后得到的系统也许既不能识别带逗号的数值，又不能理解带点号的数值：

-- 设置区域为葡萄牙语系巴西
print(os.setlocale('pt_BR'))    --> pt_BR
print(3,4)        --> 3    4
print(3.4)        --> stdin:1: malformed number near `3.4'

The category "numeric" is a little tricky. Although Portuguese and other Latin languages use a comma instead of a point to represent decimal numbers, 
the locale does not change the way that Lua parses numbers (among other reasons because expressions like print(3,4) already have a meaning in Lua). 
Therefore, you may end with a system that cannot recognize numbers with commas, but cannot understand numbers with points either:
--]]
-- set locale for Portuguese-Brazil
print(os.setlocale('pt_BR'))    --> pt_BR
print(3,4)        --> 3    4
print(3.4)        --> stdin:1: malformed number near '3.4'