--!nocheck

local function Copy<a> (stack: a, deep: boolean?): a
	local clone = table.clone(stack)
	
	if deep then -- perform full copy
		for index, value in clone do
			if type(value) == 'table' then
				clone[index] = Copy(value, deep)
			end
		end
	end
	
	return clone
end

return Copy