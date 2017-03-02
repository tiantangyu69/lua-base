--[[
Lua中我们经常假定array在最后一个非nil元素处结束。这个传统的约定有一个弊端：我们的array中不能拥有nil元素。
对大部分应用来说这个限制不是什么问题，比如当所有的array有固定的类型的时候。但有些时候我们的array需要拥有nil元素，
这种情况下，我们需要一种方法来明确的表明array的大小。
Table库定义了两个函数操纵array的大小：getn，返回array的大小；setn，设置array的大小。如前面我们所见到的，
这两个方法和table的一个属性相关：要么我们在table的一个域中保存这个属性，要么我们使用一个独立的（weak）table来关联table和这个属性。
两种方法各有利弊，所以table库使用了这两个方法。
通常，调用table.setn(t, n)使得t和n在内部（weak）table关联，调用table.getn(t)将得到内部table中和t关联的那个值。
然而，如果表t有一个带有数字值n的域，setn将修改这个值，而getn返回这个值。Getn函数还有一个选择：如果他不能使用
上述方法返回array的大小，就会使用原始的方法：遍历array直到找到第一个nil元素。因此，你可以在array中一直使用table.getn(t)获得正确的结果。看例子：
--]]
print(table.getn{10,2,4})          --> 3
print(table.getn{10,2,nil})        --> 2
print(table.getn{10,2,nil; n=3})   --> 3
print(table.getn{n=1000})          --> 1000
 
a = {}
print(table.getn(a))               --> 0
table.setn(a, 10000)
print(table.getn(a))               --> 10000
 
a = {n=10}
print(table.getn(a))               --> 10
table.setn(a, 10000)
print(table.getn(a))               --> 10000

--[[
默认的，setn和getn使用内部表存储表的大小。这是最干净的选择，因为它不会使用额外的元素污染array。然而，使用n域的方法也有一些优点。
在带有可变参数的函数种，Lua内核使用这种方法设置arg数组的大小，因为内核不依赖于库，他不能使用setn。另外一个好处在于：我们可以在array
创建的时候直接初始化他的大小，如我们在上面例子中看到的。
使用setn和getn操纵array的大小是个好的习惯，即使你知道大小在域n中。table库中的所有函数（sort、concat、insert等等）
都遵循这个习惯。实际上，提供setn用来改变域n的值可能只是为了与旧的lua版本兼容，这个特性可能在将来的版本中改变，为了安全起见，
不要假定依赖于这个特性。请一直使用getn获取数组大小，使用setn设置数组大小。
--]]