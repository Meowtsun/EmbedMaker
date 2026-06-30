
local HttpService = game:GetService('HttpService')
local Helpers = script.Parent.Parent.Helpers

local ComposeSetter = require(Helpers.ComposeSetter)
local FieldBuilder = {}
FieldBuilder.__index = FieldBuilder


function FieldBuilder.new()
	return setmetatable({}, FieldBuilder)
end



function FieldBuilder:Validate()
	
	assert(self.name ~= nil and type(self.name) == "string", "Field must have a 'name' string")
	assert(#self.name <= 256, "Field 'name' must be <= 256 characters")
	assert(#(self.name:match("^%s*(.-)%s*$") :: string) > 0, "Field 'name' cannot be empty or whitespace")
	
	
	assert(self.value ~= nil and type(self.value) == "string", "Field must have a 'value' string")
	assert(#self.value <= 1024, "Field 'value' must be <= 1024 characters")
	assert(#(self.value:match("^%s*(.-)%s*$") :: string) > 0, "Field 'value' cannot be empty or whitespace")
	
	if self.inline ~= nil then
		assert(type(self.inline) == "boolean", "Field 'inline' must be a boolean")
	end
	
	return true
end



function FieldBuilder:ToJSON()
	return HttpService:JSONEncode(self)
end



FieldBuilder.SetInline = ComposeSetter('inline')
FieldBuilder.SetName = ComposeSetter('name')
FieldBuilder.SetValue = ComposeSetter('value')


return FieldBuilder