
return function (index: string)
	return function (self)
		self[index] = nil
		return self
	end
end