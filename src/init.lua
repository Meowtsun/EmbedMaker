
--[[
	
	EmbedMaker:
		- This is a builder class which can be use to make valid discord embeds requests
		   This took direct idea from DiscordEmbedbuilder.js
		   Note that a few things might not be the same
		   
		   
	API:
		EmbedMaker.Data -> Embed
			- returns raw table of current embeds
			
		EmbedMaker:ToJSON (excludeHeader) -> string
			- Convert entire table to JSON, You can specify whether to excludeHeader or not with boolean (default = false)
			- Converted JSON will have embed header 
					[
						embeds: {
							...
						}
					]
				
		EmbedMaker:AddFields(value: field) -> EmbedMaker
			- Appends fields to the embed
			
		EmbedMaker:SetAuthor(value: author) -> EmbedMaker
			- Sets author of this embed
			
		EmbedMaker:SetColor(value: Color3) -> EmbedMaker
			- Sets color of this embed
			
		EmbedMaker:SetDescription(value: string) -> EmbedMaker
			- Sets description of this embed
			
		EmbedMaker:SetFields(value: {field}) - EmbedMaker
			- Sets the fields for this embed.
		
		EmbedMaker:SetFooter(value: footer) -> EmbedMaker
			- Sets the footer for this embed.
		
		EmbedMaker:SetImage(url: string, proxy_url: string?, height: number?, width: number?) -> EmbedMaker
			- Sets the image for this embed.
		
		EmbedMaker:SetThumbnail(url: string, proxy_url: string?, height: number?, width: number?) -> EmbedMaker
				- Sets the thumbnail for this embed.
				
		EmbedMaker:SetTimestamp(value: number | DateTime?) -> EmbedMaker
			- Sets the timestamp for this embed.
		
		EmbedMaker:SetTitle(value: string) -> EmbedMaker
			- Sets the title for this embed.
			
		EmbedMaker:SetURL(value: string) -> EmbedMaker
			- Sets the url for this embed.
			
		EmbedMaker:SpliceFields(index: number, deleteCount: number, ...: fields) -> EmbedMaker
			- Removes, replaces, or inserts fields for this embed.
		
		
	Licence: MIT licence

	Authors:
		Huonzales - Aug 14th, 2024
]]

local ImagePackingOrder = {'proxy_url', 'height', 'width'}
local HexMapping = string.split("0123456789abcdef", '')
local HttpService = game:GetService('HttpService')
local EmbedMaker = {}

local Module = {}


local function composeMethod(index, map)
	return function(self, value, ...)
		rawset(self, index, map 
			and map(value, ...)
			or value
		)
		return self
	end
end


local function composeAddonMethod(index, map)
	-- #Likely expected to be table, no need to check
	return function(self, value)
		if self[index] == nil then
			rawset(self, index, {})
		end
		
		table.insert(self[index], map
			and map(value)
			or value
		)
		return self
	end
end


local function packColor3(color: Color3)
	-- #Doing this is probably more accurate then multiplying directly
	local characters = string.split(color:ToHex(), '')
	local length = #characters - 1
	local value = 0
	
	for _, v in characters do
		local base = table.find(HexMapping, v) :: number - 1
		value += base * math.pow(16, length)
		length -= 1
	end
	
	return value
end


local function packISO(value)
	
	if typeof(value) == 'DateTime' then
		return value:ToIsoDate()
	end
	
	return (value 
		and DateTime.fromUnixTimestamp(value)
		or DateTime.now()
	):ToIsoDate()
	
end


local function packImageUrl(value, ...)
	
	local packedUrl = {url = value}
	local optional = {...}
	
	for i, v in ImagePackingOrder do
		if optional[i] then
			packedUrl[v] = optional[i]
		end
	end
	
	return packedUrl
end


function Module.new()
	return setmetatable({
	}, EmbedMaker)
end


function EmbedMaker.__newindex(self, index)
	return -- #No, I'm not allowing these
end


function EmbedMaker.__index(self, index)
	if index ~= 'Data' 
		then return EmbedMaker[index]
		else return self
	end
end


function EmbedMaker.SpliceFields(self, index, deleteCount, ...)
	
	if deleteCount > 0 then
		for i = index + deleteCount, index, -1 do
			table.remove(self.fields, i)
		end
	end

	if ... then
		local fields = {...}
		for rindex = #fields, 1, -1 do
			table.insert(self.fields, index, 
				fields[rindex]
			)
		end
	end
	
	return self
end


function EmbedMaker.ToJSON(self, excludeHeader)
	return HttpService:JSONEncode(
		excludeHeader 
			and self
			or {embeds = self}
	)
end


EmbedMaker.AddFields = composeAddonMethod('fields')
EmbedMaker.SetAuthor = composeMethod('author')
EmbedMaker.SetColor = composeMethod('color', packColor3)
EmbedMaker.SetDescription = composeMethod('description')
EmbedMaker.SetFields = composeMethod('fields')
EmbedMaker.SetFooter = composeMethod('footer')
EmbedMaker.SetImage = composeMethod('image', packImageUrl)
EmbedMaker.SetThumbnail = composeMethod('thumbnail', packImageUrl)
EmbedMaker.SetTimestamp = composeMethod('timestamp', packISO)
EmbedMaker.SetTitle = composeMethod('title')
EmbedMaker.SetUrl = composeMethod('url')


export type composedImageMethod<base, a, b, c, d> = (self: base, url: a, proxy_url: b, height: c, width: d) -> (base)
export type composedMethod<base, a> = (self: base, value: a) -> (base)

export type field = {
	name: string,
	value: string,
	inline: boolean?,
}

export type author = {
	name: string,
	url: string?,
	icon_url: string?,
	proxy_icon_url: string?,
}

export type footer = {
	text: string?,
	icon_url: string?,
	proxy_icon_url: string?,
}

export type EmbedMaker = {
	Data: EmbedMaker,
	
	AddFields: composedMethod<EmbedMaker, field>,
	SetAuthor: composedMethod<EmbedMaker, author>,
	SetColor: composedMethod<EmbedMaker, Color3>,
	SetDescription: composedMethod<EmbedMaker, string>,
	SetFields: composedMethod<EmbedMaker, {field}>,
	SetFooter: composedMethod<EmbedMaker, footer>,
	SetImage: composedImageMethod<EmbedMaker, string, string?, number?, number?>,
	SetThumbnail: composedImageMethod<EmbedMaker, string, string?, number?, number?>,
	SetTimestamp: composedMethod<EmbedMaker, number | DateTime?>,
	SetTitle: composedMethod<EmbedMaker, string>,
	SetUrl: composedMethod<EmbedMaker, string>,
	
	SpliceFields: (self: EmbedMaker, index: number, deleteCount: number?, field: field) -> (),
	ToJSON: (self: EmbedMaker, excludeHeader: boolean?) -> (string),
	
}


return Module
