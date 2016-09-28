Account = {
	balance = 0,
	withdraw = function(self, v)
		self.balance = self.balance - v
	end,
	deposit = function(self, v)
		self.balance = self.balance + v
	end,
	new = function(self, o)
		o = o or {}
		setmetatable(o, self)
		self.__index = self
		return o
	end
}

a = Account:new{balance = 0}
a:deposit(3000)
print(a.balance)

a1 = Account:new{balance = 20}
a1:deposit(555)
print(a1.balance)

a2 = Account:new{balance = -100}
a2:withdraw(100)
print(a2.balance)

b = Account:new()
print(b.balance)