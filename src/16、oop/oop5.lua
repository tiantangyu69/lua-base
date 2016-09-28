function newAccount(initialBalance)
	local self = {balance = initialBalance}
	local withdraw = function(v)
		self.balance = self.balance - v
	end
	
	local deposit = function(v)
		self.balance = self.balance + v
	end
	
	local getBalance = function()
		return self.balance
	end
	
	return {
		withdraw = withdraw,
		deposit = deposit,
		getBalance = getBalance
	}
end

accl = newAccount(100)
accl.withdraw(40)
print(accl.getBalance())