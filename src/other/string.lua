--[[
local buff = ""
for line in io.lines() do
	buff = buff .. line .. "\n"
	print(buff)
end
]]--

function newStack ()
	return {""}
end

function addString (stack, s)
	table.insert(stack, s)
	for i = table.getn(stack) - 1, 1, -1 do
		if string.len(stack[i]) > string.len(stack[i + 1]) then
			break
		end
		
		stack[i] = stack[i] .. table.remove(stack)
	end
end


local s = newStack()
for line in io.lines() do
	addString(s, line .. "\n")
end

s = toString(s)

--[[
local s = newStack()
for line in io.lines() do
	table.insert(t, line)
end

s = table.concat(t, "\n") .. "\n"
]]--		