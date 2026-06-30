
local EmbedBuilder = require(script.Builders.EmbedBuilder)
local FieldBuilder = require(script.Builders.FieldBuilder)
local FooterBuilder = require(script.Builders.FooterBuilder)
local AuthorBuilder = require(script.Builders.AuthorBuilder)

local Annotation = require(script.Annotation)
local Index = {}



function Index.new()
	return EmbedBuilder.new()
end



Index.EmbedBuilder = EmbedBuilder
Index.FieldBuilder = FieldBuilder
Index.FooterBuilder = FooterBuilder
Index.AuthorBuilder = AuthorBuilder
Index.Annotation = Annotation

return Index :: Annotation.EmbedMaker