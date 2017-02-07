reserved = {
	["while"] = true, ["end"] = true, ["function"] = true, ["local"] = true
}


function allwords ()
	local line = io.read()
	local pos = 1
	return function ()
		while line do
			return line
		end
		
		return nil
	end
end


--[[
for w in allwords () do
	if reserved[w] then
		print(w .. " it is guanjianzi")
	else
		print(w .. " it not a  guanjianzi")
	end
end
]]--

function Set (list)
	local set = {}
	for _, l in ipairs(list) do set[l] = true end
	return set
end

reserved = Set{"while", "end", "function", "local", }

for k, v in ipairs(reserved) do 
	print(k, v)
end


array = {"one", "two", "three"}

for k,v in ipairs(array) do
	print(k, v)
end