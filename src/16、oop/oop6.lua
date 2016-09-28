function newAccount(initialBalance)
	local self = {
		balance = initialBalance,
		LIM = 10000,
	}
	
	local extra = function()
		if self.balance > self.LIM then
			return self.balance * 0.10
		else
			return 0
		end
	end
	
	local withdraw = function(v)
		self.balance = self.balance - v
	end
	
	local deposit = function(v)
		self.balance = self.balance + v
	end
	
	local getBalance = function()
		return self.balance + extra()
	end
	
	return {
		withdraw = withdraw,
		deposit = deposit,
		getBalance = getBalance
	}
end

accl = newAccount(100000)
accl.withdraw(40)
print(accl.getBalance())