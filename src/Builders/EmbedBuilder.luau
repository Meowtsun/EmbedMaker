
local HttpService = game:GetService('HttpService')
local Helpers = script.Parent.Parent.Helpers

local FieldBuilder = require(script.Parent.FieldBuilder)
local FooterBuilder = require(script.Parent.FooterBuilder)
local AuthorBuilder = require(script.Parent.AuthorBuilder)

local ComposeUpdater = require(Helpers.ComposeUpdater)
local ComposeSetter = require(Helpers.ComposeSetter)
local ComposeClear = require(Helpers.ComposeClear)

local PackColor3 = require(Helpers.PackColor3)
local PackISO = require(Helpers.PackISO)
local PackImageUrl = require(Helpers.PackImageUrl)
local EmbedBuilder = {}
EmbedBuilder.__index = EmbedBuilder


function EmbedBuilder.new()
	return setmetatable({}, EmbedBuilder)
end



function EmbedBuilder:SpliceFields(index, deleteCount, ...)
	
	if not self.fields then
		self.fields = {...}
		return self
	end
	
	for ind = 1, deleteCount do
		table.remove(self.fields, index)
	end
	
	for ind, field in {...} do
		table.insert(self.fields, index + (ind - 1), field)
	end
	
	return self
end



function EmbedBuilder:AddFields(...)
	
	if not self.fields then
		self.fields = {...}
		return self
	end
	
	for _,field in { ... } do
		table.insert(self.fields, field)
	end
	
	return self
end



function EmbedBuilder:Validate()
	
	if self.title then
		assert(type(self.title) == "string" and #self.title <= 256, "Title must be <= 256 chars")
		assert(#(self.title:match("^%s*(.-)%s*$") :: string) > 0, "Title cannot be empty or whitespace")
	end
	
	if self.description then
		assert(type(self.description) == "string" and #self.description <= 4096, "Description must be <= 4096 chars")
	end

	if self.color then
		assert(type(self.color) == "number", "Color must be a number")
	end

	if self.url then
		assert(type(self.url) == "string", "URL must be a string")
		assert(#(self.url:match("^%s*(.-)%s*$") :: string) > 0, "Url cannot be empty or whitespace")
	end

	if self.author then
		AuthorBuilder.Validate(self.author)
	end

	if self.footer then
		FooterBuilder.Validate(self.footer)
	end

	if self.fields then
		assert(#self.fields <= 25, "Embed cannot have more than 25 fields")
		for _, field in self.fields do
			FieldBuilder.Validate(field)
		end
	end

	return true
end



function EmbedBuilder:ToJSON(noValidation, excludeHeader)
	
	if not noValidation then
		self:Validate()
	end
	
	return HttpService:JSONEncode(
		excludeHeader 
			and self
			or { embeds = {self} }
	)
end


EmbedBuilder.ClearAuthor = ComposeClear('author')
EmbedBuilder.ClearColor = ComposeClear('color')
EmbedBuilder.ClearDescription = ComposeClear('description')
EmbedBuilder.ClearFooter = ComposeClear('footer')
EmbedBuilder.ClearImage = ComposeClear('image')
EmbedBuilder.ClearThumbnail = ComposeClear('thumbnail')
EmbedBuilder.ClearTimestamp = ComposeClear('timestamp')
EmbedBuilder.ClearTitle = ComposeClear('title')
EmbedBuilder.ClearUrl = ComposeClear('url')

EmbedBuilder.SetAuthor = ComposeSetter('author')
EmbedBuilder.SetColor = ComposeSetter('color', PackColor3)
EmbedBuilder.SetDescription = ComposeSetter('description')
EmbedBuilder.SetFields = ComposeSetter('fields')
EmbedBuilder.SetFooter = ComposeSetter('footer')
EmbedBuilder.SetImage = ComposeSetter('image', PackImageUrl)
EmbedBuilder.SetThumbnail = ComposeSetter('thumbnail', PackImageUrl)
EmbedBuilder.SetTimestamp = ComposeSetter('timestamp', PackISO)
EmbedBuilder.SetTitle = ComposeSetter('title')
EmbedBuilder.SetURL = ComposeSetter('url')

EmbedBuilder.UpdateAuthor = ComposeUpdater('author')
EmbedBuilder.UpdateFooter = ComposeUpdater('footer')


return EmbedBuilder