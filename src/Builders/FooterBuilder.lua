
local HttpService = game:GetService('HttpService')
local Helpers = script.Parent.Parent.Helpers

local ComposeSetter = require(Helpers.ComposeSetter)
local ComposeClear = require(Helpers.ComposeClear)

local PackImageUrl = require(Helpers.PackImageUrl)
local FooterBuilder = {}
FooterBuilder.__index = FooterBuilder



function FooterBuilder.new()
	return setmetatable({}, FooterBuilder)
end



function FooterBuilder:Validate()
	
	assert(self.text ~= nil and type(self.text) == "string", "Footer must have a 'text' string")
	assert(#self.text <= 2048, "Footer 'text' must be <= 2048 characters")
	assert(#(self.text:match("^%s*(.-)%s*$") :: string) > 0, "Footer 'text' cannot be empty or whitespace")
	
	if self.icon_url ~= nil then
		assert(type(self.icon_url) == "string", "Footer 'icon_url' must be a string")
	end
	
	return true
end



function FooterBuilder:ToJSON()
	return HttpService:JSONEncode(self)
end



FooterBuilder.ClearText = ComposeClear("text")
FooterBuilder.ClearIconURL = ComposeClear("icon_url")

FooterBuilder.SetText = ComposeSetter("text")
FooterBuilder.SetIconURL = ComposeSetter("icon_url")



return FooterBuilder
