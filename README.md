# EmbedMaker
Discord Embedbuilder.js in luau, made to be usable within Roblox Studio<br/>
you can find .rbxm file [Here]()<br/>

Note that few things have been changed:<br/>
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

### Results
![image](https://github.com/user-attachments/assets/d600a41b-ac11-44b1-b0fd-210763b3df6a)


