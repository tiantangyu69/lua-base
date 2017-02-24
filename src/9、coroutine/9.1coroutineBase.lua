-- Lua������Эͬ���������coroutine table�С�create�������ڴ����µ�Эͬ������ֻ��һ��������һ����������Эͬ����Ҫ���еĴ��롣��һ��˳��������ֵΪthread���ͣ���ʾ�����ɹ���ͨ������£�create�Ĳ���������������
co = coroutine.create(function()
	print("hi coroutine")
end
)
print(co) --> thread: 0x0079B650


-- Эͬ������״̬������̬��suspended��������̬��running����ֹ̬ͣ��dead���������Ǵ���Эͬ����ɹ�ʱ����Ϊ����̬������ʱЭͬ����δ���С����ǿ���status�������Эͬ��״̬��
print(coroutine.status(co))  --> suspended


-- ����coroutine.resumeʹЭͬ�����ɹ���״̬��Ϊ����̬��
coroutine.resume(co)  --> hi coroutine


-- ������֮�������ֹ̬
print(coroutine.status(co))  --> dead


-- ��ĿǰΪֹ��Эͬ������ֻ��һ�ָ��ӵĵ��ú����ķ�ʽ��������ǿ��֮��������yield�����������Խ��������еĴ�����𣬿�һ�����ӣ�
co = coroutine.create(function()
	for i = 1, 2 do
		print("co", i)
		coroutine.yield()
	end
end)
-- ִ�����Эͬ���򣬳����ڵ�һ��yield��������
coroutine.resume(co)               --> co   1
print(coroutine.status(co))        --> suspended
-- ��Эͬ�Ĺ۵㿴��ʹ�ú���yield����ʹ������𣬵����Ǽ������ĳ���ʱ�����Ӻ���yield��λ�ü���ִ�г���ֱ���ٴ�����yield����������
coroutine.resume(co)               --> co   2
print(coroutine.status(co))        --> suspended 

coroutine.resume(co)               --> prints nothing   
print(coroutine.status(co))        --> dead

-- �������һ�ε���ʱ��Эͬ���ѽ��������Эͬ��������ֹ̬�����������Ȼϣ����������resume������false�ʹ�����Ϣ��
print(coroutine.resume(co))        --> false  cannot resume dead coroutine
--[[
ע�⣺resume�����ڱ���ģʽ�£���ˣ����Эͬ�����ڲ����ڴ���Lua�������׳����󣬶��ǽ����󷵻ظ�resume������
Lua��Эͬ��ǿ��������������ͨ��resume-yield���������ݡ�
��һ��������ֻ��resume��û��yield��resume�Ѳ������ݸ�Эͬ��������
--]]
co = coroutine.create(function(a, b, c)
	print("co", a, b, c)
end)
coroutine.resume(co, 1, 2, 3)        --> co      1       2       3

-- �ڶ������ӣ�������yield����resume��true�������óɹ���true֮��Ĳ��֣�����yield�Ĳ�����
co = coroutine.create(function(a, b)
	coroutine.yield(a + b, a - b)
end)
print(coroutine.resume(co, 20, 10))  --> true  30  10

-- ��Ӧ�أ�resume�Ĳ������ᱻ���ݸ�yield��
co = coroutine.create(function()
	print("co", coroutine.yield())
end)
coroutine.resume(co)
coroutine.resume(co, 4, 5)         --> co  4  5

-- ���һ�����ӣ�Эͬ�������ʱ�ķ���ֵ��Ҳ�ᴫ��resume��
co = coroutine.create(function()
	return 6, 7
end)
print(coroutine.resume(co))

--[[
���Ǻ�����һ��Эͬ������ͬʱʹ�ö�����ԣ���ÿһ�ֶ����ô���
�����Ѵ����˽���Эͬ�Ļ������ݣ������Ǽ���ѧϰ֮ǰ���ȳ����������Lua��Эͬ��Ϊ���Գ�Эͬ��asymmetric coroutines����
ָ������һ������ִ�е�Эͬ�������롰ʹһ���������Эͬ�ٴ�ִ�еĺ������ǲ�ͬ�ģ���Щ�����ṩ�Գ�Эͬ��symmetric coroutines������ʹ��ͬһ����������ִ���������״̬�л�����
���˳Ʋ��ԳƵ�ЭͬΪ��Эͬ����һЩ��ʹ��ͬ���������ʾ������Эͬ���ϸ������ϵ�Эͬ������ʲô�ط�ֻҪ�������������ĸ��������ڲ���ʱ�򶼿��Բ���ֻ��ʹִ�й���
����ʲôʱ���������ջ�ڶ������в��ɾ����ĵ��á���However, other people use the same term semi-coroutine to denote a restricted implementation of coroutines, 
where a coroutine can only suspend its execution when it is not inside any auxiliary function, that is, when it has no pending calls in its control stack.����
ֻ�а�Эͬ�����ڲ�����ʹ��yield��python�еĲ�������generator�������������͵İ�Эͬ��
��ԳƵ�Эͬ�Ͳ��Գ�Эͬ������ͬ���ǣ�Эͬ���������������󡣲�������ԱȽϼ򵥣����������������Эͬ������ɵ�һЩ����
��������ʹ�ò��ԳƵ�Э֮ͬ�󣬿������ò��ԳƵ�Эͬʵ�ֱȽ���Խ�ĶԳ�Эͬ��
--]]