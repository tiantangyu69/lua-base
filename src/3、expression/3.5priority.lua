-- 从高到低的顺序
--[[

^
not    - (unary)
*      /
+      -
..
<      >      <=     >=     ~=     ==
and
or

除了^和..外所有的二元运算符都是左连接的。

a+i < b/2+1          <-->       (a+i) < ((b/2)+1)
5+x^2*8              <-->       5+((x^2)*8)
a < y and y <= z     <-->       (a < y) and (y <= z)
-x^2                 <-->       -(x^2)
x^y^z                <-->       x^(y^z)
--]]