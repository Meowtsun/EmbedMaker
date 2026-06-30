
return function ()
	
	local HttpService = game:GetService("HttpService")
	local EmbedMaker = require(script.Parent)
	local FieldBuilder = EmbedMaker.FieldBuilder
	local FooterBuilder = EmbedMaker.FooterBuilder
	local AuthorBuilder = EmbedMaker.AuthorBuilder
	
	describe("EmbedMaker library", function()
		it("should construct a valid EmbedBuilder", function()
			local embed = EmbedMaker.new()
			expect(embed).to.be.ok()
			expect(typeof(embed)).to.equal("table")
			expect(embed.SetTitle).to.be.a("function")
		end)


		describe("FieldBuilder", function()
			it("should validate and encode field", function()
				local field = EmbedMaker.FieldBuilder.new()
					:SetName("Power Level")
					:SetValue("Over 9000")
					:SetInline(true)

				expect(field:Validate()).to.equal(true)

				local json = field:ToJSON()
				local decoded = HttpService:JSONDecode(json)
				expect(decoded.name).to.equal("Power Level")
				expect(decoded.value).to.equal("Over 9000")
				expect(decoded.inline).to.equal(true)
			end)
		end)


		describe("AuthorBuilder", function()
			it("should validate and encode author", function()
				local author = EmbedMaker.AuthorBuilder.new()
					:SetName("Test Author")
					:SetURL("https://example.com")
					:SetIconURL("https://picsum.photos/64")

				expect(author:Validate()).to.equal(true)

				local json = author:ToJSON()
				local decoded = HttpService:JSONDecode(json)
				expect(decoded.name).to.equal("Test Author")
				expect(decoded.url).to.equal("https://example.com")
				expect(decoded.icon_url).to.be.ok()
			end)
		end)


		describe("FooterBuilder", function()
			it("should validate and encode footer", function()
				local footer = EmbedMaker.FooterBuilder.new()
					:SetText("Example Footer")
					:SetIconURL("https://picsum.photos/16")

				expect(footer:Validate()).to.equal(true)

				local json = footer:ToJSON()
				local decoded = HttpService:JSONDecode(json)
				expect(decoded.text).to.equal("Example Footer")
			end)
		end)


		describe("EmbedBuilder", function()
			it("should compose all parts correctly", function()
				local author = EmbedMaker.AuthorBuilder.new()
					:SetName("Author")
					:SetURL("https://example.com")
					:SetIconURL("https://picsum.photos/32")

				local footer = EmbedMaker.FooterBuilder.new()
					:SetText("Footer Text")
					:SetIconURL("https://picsum.photos/16")

				local field = EmbedMaker.FieldBuilder.new()
					:SetName("Stat")
					:SetValue("42")
					:SetInline(true)

				local embed = EmbedMaker.new()
					:SetTitle("Test Embed")
					:SetDescription("This is a description")
					:SetColor(Color3.fromRGB(100, 200, 255))
					:SetURL("https://example.com")
					:SetAuthor(author)
					:SetFooter(footer)
					:AddFields(field)
					:SetThumbnail("https://picsum.photos/128")
					:SetImage("https://picsum.photos/256")
					:SetTimestamp(DateTime.now())

				expect(embed:Validate()).to.equal(true)

				local json = embed:ToJSON()
				local data = HttpService:JSONDecode(json)

				expect(data.embeds).to.be.ok()
				local e = data.embeds[1]
				expect(e.title).to.equal("Test Embed")
				expect(e.description).to.equal("This is a description")
				expect(e.color).to.be.a("number")
				expect(e.footer.text).to.equal("Footer Text")
				expect(#e.fields).to.equal(1)
			end)

			it("should support Clear methods", function()
				local embed = EmbedMaker.new()
					:SetTitle("To Clear")
					:SetDescription("Gone soon")
					:ClearTitle()
					:ClearDescription()

				expect(embed.title).to.never.be.ok()
				expect(embed.description).to.never.be.ok()
			end)
		end)
	end)
	
	describe("Validation failures", function()

		it("should fail when Field name or value are missing", function()
			local f = FieldBuilder.new()
				:SetName("Valid Name")

			expect(function()
				f:Validate()
			end).to.throw()

			f = FieldBuilder.new()
				:SetValue("Valid Value")

			expect(function()
				f:Validate()
			end).to.throw()
		end)

		it("should fail when Field exceeds character limits", function()
			local longName = string.rep("a", 300)
			local longValue = string.rep("b", 2000)

			local f = FieldBuilder.new()
				:SetName(longName)
				:SetValue("ok")

			expect(function()
				f:Validate()
			end).to.throw()

			f = FieldBuilder.new()
				:SetName("ok")
				:SetValue(longValue)

			expect(function()
				f:Validate()
			end).to.throw()
		end)

		it("should fail when Author has no name", function()
			local a = AuthorBuilder.new()
				:SetURL("https://example.com")

			expect(function()
				a:Validate()
			end).to.throw()
		end)

		it("should fail when Footer has no text", function()
			local f = FooterBuilder.new()
				:SetIconURL("https://example.com/icon.png")

			expect(function()
				f:Validate()
			end).to.throw()
		end)

		it("should fail when Embed has too many fields", function()
			local embed = EmbedMaker.new()
			for i = 1, 30 do
				embed:AddFields(
					FieldBuilder.new()
						:SetName("N"..i)
						:SetValue("V"..i)
				)
			end

			expect(function()
				embed:Validate()
			end).to.throw()
		end)
	end)
	
	describe("Full embed serialization comparison", function()
		it("should produce correct JSON with all fields filled", function()
			local embed = EmbedMaker.new()
				:SetTitle("Example Embed Title")
				:SetDescription("This is a description for the example embed")
				:SetColor(Color3.fromRGB(27, 135, 255))
				:SetURL("https://example.com")
				:SetTimestamp(DateTime.fromUniversalTime(2025, 11, 2, 8, 38, 53))
				:SetAuthor(
					AuthorBuilder.new()
					:SetName("Example Author")
					:SetURL("https://example.com")
					:SetIconURL("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
				)
				:SetFooter(
					FooterBuilder.new()
					:SetText("Example Footer")
					:SetIconURL("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
				)
				:SetThumbnail("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
				:SetImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
				:AddFields(
					FieldBuilder.new()
					:SetName("Example Field")
					:SetValue("This is a field value")
					:SetInline(true)
				)

			expect(embed:Validate()).to.equal(true)

			local json = embed:ToJSON()
			local parsed = HttpService:JSONDecode(json)
			local expected = HttpService:JSONDecode([[
				{
					"embeds": [{
						"title": "Example Embed Title",
						"description": "This is a description for the example embed",
						"color": 1794047,
						"url": "https://example.com",
						"timestamp": "2025-11-02T08:38:53Z",
						"author": {
							"name": "Example Author",
							"url": "https://example.com",
							"icon_url": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
						},
						"footer": {
							"text": "Example Footer",
							"icon_url": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
						},
						"thumbnail": {
							"url": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
						},
						"image": {
							"url": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
						},
						"fields": [{
							"name": "Example Field",
							"value": "This is a field value",
							"inline": true
						}]
					}]
				}
			]])
			
			local function recursiveCheck(source, template, path)
				for index, value in source do
					local path = path and `{path}.{index}` or index
					if type(value) == 'table' then
						recursiveCheck(value, template[index], path)
					else
						it(`{path} should be equal in direct comparison`, function()
							expect(value).to.equal(template[index])
						end)
					end
				end
			end
			
			recursiveCheck(parsed, expected)
			
		end)
	end)
end