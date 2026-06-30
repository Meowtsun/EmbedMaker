
local ImagePackingOrder = {'proxy_url', 'height', 'width'}

return function (value, ...)
	local packedUrl = {url = value}
	local optional = {...}

	for i, v in ImagePackingOrder do
		if optional[i] then
			packedUrl[v] = optional[i]
		end
	end

	return packedUrl
end
