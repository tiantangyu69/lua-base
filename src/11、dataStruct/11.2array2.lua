-- Lua中有两种表示矩阵的方法，一是“数组的数组”。也就是说，table的每个元素是另一个table。例如，可以使用下面代码创建一个n行m列的矩阵：
mt = {}           -- create the matrix
for i = 1, N do
    mt[i] = {}    -- create a new row
    for j = 1, M do
       mt[i][j] = 0
    end
end

-- 由于Lua中table是对象，所以每一行我们必须显式地创建一个table，比起c或pascal，这显得冗余，但另一方面也提供了更多的灵活性，例如可修改前面的例子创建一个三角矩阵：
--[[
for j=1,M do
改成
for j=1,i do
--]]
-- 这样实现的三角矩阵比起整个矩阵，仅使用一半的内存空间。

--表示矩阵的另一方法，是将行和列组合起来。如果索引下标都是整数，通过第一个索引乘于一个常量（列）再加上第二个索引，看下面的例子实现创建n行m列的矩阵：
mt = {}           -- create the matrix
for i = 1,N do
    for j = 1,M do
       mt[i * M + j] = 0
    end
end