# EmbedMaker `v1.2`

---

Builder utility for Roblox Lua to create rich embeds with modular fields, author, footer, images, and colors.
APIs are taken from EmbedBuilder in Discord.js

---

### Installation

#### Creator Store

you can get the model directly from [Creator Store](https://create.roblox.com/store/asset/70491445150377/EmbedMaker)

#### Releases

if you need specific versions you can look into [Releases](https://github.com/Meowtsun/EmbedMaker/releases)

---

### Usage

```lua
local EmbedMaker = require(...)
local FooterBuilder = EmbedMaker.FooterBuilder
local FieldBuilder = EmbedMaker.FieldBuilder

local embed = EmbedMaker.new()
    :SetTitle("Hello World")
    :SetDescription("This is a description")
    :SetColor(Color3.fromRGB(255, 0, 0))
    :AddFields(
        FieldBuilder.new()
            :SetName("Field1")
            :SetValue("Value1")
            :SetInline(true)
        ,
        FieldBuilder.new()
            :SetName("Field2")
            :SetValue("Value2")
        ,
        -- providing table also works ofc
        {name = "Field3", value = "Value3"}
    )
    :SetFooter(
       FooterBuilder.new()
        :SetText("This is a footer text")
    )

local json = embed:ToJSON()
print(json)
```

---

### APIs

- [EmbedMaker](#embedmakernew)
  - [`new()`](#embedmakernew)
- [EmbedBuilder](#embedbuilder)
  - [`AddFields()`](#embedbuilderaddfields)
  - [`Clear()`](#embedbuilderclear)
  - [`Set()`](#embedbuilderset)
  - [`UpdateAuthor()`](#embedbuilderupdateauthor)
  - [`UpdateFooter()`](#embedbuilderupdatefooter)
  - [`ToJSON()`](#embedbuildertojson)
  - [`Validate()`](#embedbuildervalidate)
- [FieldBuilder](#fieldbuilder)
- [AuthorBuilder](#authorbuilder)
- [FooterBuilder](#footerbuilder)

---

<h4 id="embedmakernew">EmbedMaker.new(): EmbedBuilder</h4>

Returns a new [EmbedBuilder](#embedbuilder) instance.
<br><br>

---

<h4 id="embedbuilder">EmbedBuilder</h4>

Builder for full embeds, allowing setting of author, footer, fields, images, colors, timestamps, and more.

- `AddFields(...fields: Field): EmbedBuilder` – Adds one or more fields to the embed.
- `ClearAuthor(): EmbedBuilder` – Clears the author.
- `ClearColor(): EmbedBuilder` – Clears the color.
- `ClearDescription(): EmbedBuilder` – Clears the description.
- `ClearFooter(): EmbedBuilder` – Clears the footer.
- `ClearImage(): EmbedBuilder` – Clears the image.
- `ClearThumbnail(): EmbedBuilder` – Clears the thumbnail.
- `ClearTimestamp(): EmbedBuilder` – Clears the timestamp.
- `ClearTitle(): EmbedBuilder` – Clears the title.
- `ClearUrl(): EmbedBuilder` – Clears the URL.
- `SetAuthor(author: Author): EmbedBuilder` – Sets the embed author.
- `SetColor(color: Color3): EmbedBuilder` – Sets the embed color.
- `SetDescription(description: string): EmbedBuilder` – Sets the description.
- `SetFields(fields: {Field}): EmbedBuilder` – Replaces all fields with the provided list.
- `SetFooter(footer: Footer): EmbedBuilder` – Sets the embed footer.
- `SetImage(image: string): EmbedBuilder` – Sets the image URL.
- `SetThumbnail(thumbnail: string): EmbedBuilder` – Sets the thumbnail URL.
- `SetTimestamp(timestamp: DateTime | number?): EmbedBuilder` – Sets the timestamp.
- `SetTitle(title: string): EmbedBuilder` – Sets the title.
- `SetURL(url: string): EmbedBuilder` – Sets the URL.
- `ToJSON(noValidation?: boolean, excludeHeader?: boolean): string` – Converts embed to JSON string.
- `Validate(): boolean` – Checks if the embed is valid.
- `UpdateAuthor(author: Author): EmbedBuilder` – Updates the author without clearing other fields.
- `UpdateFooter(footer: Footer): EmbedBuilder` – Updates the footer without clearing other fields.

**Properties:**  

- `author: Author?`  
- `color: Color3?`  
- `description: string?`  
- `fields: {Field}`  
- `footer: Footer?`  
- `image: string?`  
- `thumbnail: string?`  
- `timestamp: number?`  
- `title: string?`  
- `url: string?`

<h4 id="fieldbuilder">FieldBuilder</h4>

Builder for embed fields.

- `SetName(name: string)`
- `SetValue(value: string)`
- `SetInline(inline: boolean)`
- `ToJSON(): string`
- `Validate(): boolean`
- Properties: `name`, `value`, `inline`

<h4 id="authorbuilder">AuthorBuilder</h4>

Builder for embed author.

- `SetName(name: string)`
- `SetURL(url: string)`
- `SetIconURL(icon_url: string)`
- `ClearURL()`, `ClearIconURL()`
- `ToJSON()`
- `Validate(): boolean`
- Properties: `name`, `url`, `icon_url`

<h4 id="footerbuilder">FooterBuilder</h4>

Builder for embed footer.

- `SetText(text: string)`
- `SetIconURL(icon_url: string)`
- `ClearText()`, `ClearIconURL()`
- `ToJSON(): string`
- `Validate(): boolean`
- Properties: `text`, `icon_url`
