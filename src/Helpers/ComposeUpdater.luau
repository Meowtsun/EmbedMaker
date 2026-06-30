
local reconcile = require(script.Parent.Reconcile)

return function (index: string, map: (...any) -> (...any)? )
	return function (self, value, ...)
		local value = if map 
			then map(value) 
			else value
		self[index] = self[index] or {}
		reconcile(self[index], value)
		return self
	end
end