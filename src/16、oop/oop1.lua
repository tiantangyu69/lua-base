Account = {balance = 0}

function Account.withdraw(self, v)
	self.balance = self.balance - v
end

a1 = Account
--Account = nil
a1.withdraw(a1, 100)
print(a1.balance)


a2 = {balance = 0, withdraw = Account.withdraw}

a2.withdraw(a2, 260)
print(a2.balance)


function Account:withdraw(v)
	self.balance = self.balance - v
end

a = Account
a:withdraw(1000)
print(a.balance)




Account = {
	balance = 0,
	withdraw = function(self, v)
		self.balance = self.balance - v
	end
}

function Account:deposit(v)
	self.balance = self.balance + v
end

Account.deposit(Account, 200)
print(Account.balance)
Account:withdraw(100)
print(Account.balance)

function Account:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

a = Account:new{balance = 0}
a:deposit(3000)
print(a.balance)

a1 = Account:new{balance = 20}
a1:deposit(555)
print(a1.balance)