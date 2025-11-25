

return 	function (value: DateTime | number)
	
	if typeof(value) == 'DateTime' then
		return value:ToIsoDate()
	end
	
	return (value and DateTime.fromUnixTimestamp(value) or DateTime.now()):ToIsoDate()
end