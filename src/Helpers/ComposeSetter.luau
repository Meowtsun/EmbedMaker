
return function (index: string, map: (...any) -> (...any)? )
	return function (self, value, ...)
		self[index] = if map 
			then map(value)
			else value
		return self
	end
end