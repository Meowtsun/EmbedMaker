
local HexMapping = string.split("0123456789abcdef", '')

return 	function (color: Color3)
	
	local characters = string.split(color:ToHex(), '')
	local length = #characters - 1
	local value = 0

	for _, letter in characters do
		local base = table.find(HexMapping, letter) :: number - 1
		value += base * math.pow(16, length)
		length -= 1
	end

	return value
end