-- and or not
-- �߼��������Ϊfalse��nil�Ǽ٣�false��������Ϊ�棬0Ҳ��true. and��or������������true��false�����Ǻ�����������������ء�

-- a and b, ���aΪfalse���򷵻�a�����򷵻�b
-- a or  b, ���aΪtrue���򷵻�a�����򷵻�b

print(4 and 5)           --> 5
print(nil and 13)        --> nil
print(false and 13)      --> false
print(4 or 5)            --> 4
print(false or 5)        --> 5


-- һ����ʵ�õļ��ɣ����xΪfalse����nil���x����ʼֵv, x = x or v, and�����ȼ���or��

print(not nil)           --> true
print(not false)         --> true
print(not 0)             --> false
print(not not nil)       --> false
