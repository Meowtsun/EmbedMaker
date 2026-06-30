
local HttpService = game:GetService('HttpService')
local Helpers = script.Parent.Parent.Helpers

local ComposeUpdater = require(Helpers.ComposeUpdater)
local ComposeSetter = require(Helpers.ComposeSetter)
local ComposeClear = require(Helpers.ComposeClear)

local PackImageUrl = require(Helpers.PackImageUrl)
local AuthorBuilder = {}
AuthorBuilder.__index = AuthorBuilder



function AuthorBuilder.new()
	return setmetatable({}, AuthorBuilder)
end



function AuthorBuilder:ToJSON()
	return HttpService:JSONEncode(self)
end



function AuthorBuilder:Validate()
	
	assert(self.name ~= nil and type(self.name) == "string", "Author must have a 'name' string")
	assert(#self.name <= 256, "Author 'name' must be <= 256 characters")
	assert(#(self.name:match("^%s*(.-)%s*$") :: string) > 0, "Author 'name' cannot be empty or whitespace")
	
	if self.url ~= nil then
		assert(type(self.url) == "string", "Author 'url' must be a string")
	end

	if self.icon_url ~= nil then
		assert(type(self.icon_url) == "string", "Author 'icon_url' must be a string")
	end

	return true
end



AuthorBuilder.ClearIconURL = ComposeClear("icon_url")
AuthorBuilder.ClearURL = ComposeClear("url")

AuthorBuilder.SetIconURL = ComposeSetter("icon_url")
AuthorBuilder.SetName = ComposeSetter("name")
AuthorBuilder.SetURL = ComposeSetter("url")


return AuthorBuilder