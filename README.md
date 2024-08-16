# EmbedMaker
Discord Embedbuilder.js copy, made to be usable within Roblox Studio
note that few things have been changed:

- SetTimestamp
- SetThumbnail
- SetImage
- SetColor
- ToJSON

# API overview
```lua
local embed = EmbedMaker.new()
  :SetTitle(`@{username} updated {listed.Source.Name}.lua` )
		:SetColor(SETTINGS.Embeds[listed.Source.ClassName].Color)
		:SetThumbnail(SETTINGS.Embeds[listed.Source.ClassName].Image)
		:SetTimestamp()

		:AddFields({
				name = '', 
				value = `**{listed.Commit == ''and '- No message' or listed.Commit}**`, 
    })

    :AddFields({
					name = '', 
					value = `\`{listed.Source:GetFullName()}\``, 
				})
			
		:SetFooter({
			text = `Lines: {lines} • Place: {name} • Version: {game.PlaceVersion}`,
		})

print(embed.Data)
HttpService:PostAsync(http, embed:ToJSON())
```
