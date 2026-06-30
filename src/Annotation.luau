--!strict
export type Field = FieldBuilder | FieldBuilderAPI
export type FieldBuilderAPI = {
	name: string,
	value: string,
	inline: boolean?,
}

export type FieldBuilder = {
	SetInline: (self: FieldBuilder, inline: boolean) -> (FieldBuilder),
	SetName: (self: FieldBuilder, name: string) -> (FieldBuilder),
	SetValue: (self: FieldBuilder, value: string) -> (FieldBuilder),
	ToJSON: (self: FieldBuilder) -> (string),
	Validate: (self: FieldBuilder) -> (boolean),
	
	name: string,
	value: string,
	inline: boolean?,
}

export type Author = AuthorBuilder | AuthorBuilderAPI
export type AuthorBuilderAPI = {
	icon_url: string?,
	url: string?,
	name: string,
}

export type AuthorBuilder = {
	ClearIconURL: ComposedClear<AuthorBuilder>,
	ClearURL: ComposedClear<AuthorBuilder>,
	
	SetIconURL: (self: AuthorBuilder, icon_url: string) -> (AuthorBuilder),
	SetName: (self: AuthorBuilder, name: string) -> (AuthorBuilder),
	SetURL: (self: AuthorBuilder, url: string) -> (AuthorBuilder),
	ToJSON: (self: AuthorBuilder) -> (string),
	Validate: (self: AuthorBuilder) -> (boolean),
	
	icon_url: string?,
	url: string?,
	name: string,
}

export type Footer = FooterBuilder | FooterBuilderAPI
export type FooterBuilderAPI = {
	icon_url: string?,
	text: string,
}

export type FooterBuilder = {
	ClearText: ComposedClear<FooterBuilder>,
	ClearIconURL: ComposedClear<FooterBuilder>,

	SetIconURL: (self: FooterBuilder, icon_url: string) -> (FooterBuilder),
	SetText: (self: FooterBuilder, text: string) -> (FooterBuilder),
	ToJSON: (self: FooterBuilder) -> (string),
	Validate: (self: FooterBuilder) -> (boolean),

	icon_url: string?,
	text: string,
}


export type EmbedBuilder = {
	AddFields: (self: EmbedBuilder, ... Field) -> (EmbedBuilder),
	
	ClearAuthor: ComposedClear<EmbedBuilder>,
	ClearColor:ComposedClear<EmbedBuilder>,
	ClearDescription: ComposedClear<EmbedBuilder>,
	ClearFooter: ComposedClear<EmbedBuilder>,
	ClearImage: ComposedClear<EmbedBuilder>,
	ClearThumbnail: ComposedClear<EmbedBuilder>,
	ClearTimestamp:ComposedClear<EmbedBuilder>,
	ClearTitle: ComposedClear<EmbedBuilder>,
	ClearUrl: ComposedClear<EmbedBuilder>,
	
	SetAuthor: (self: EmbedBuilder, author: Author) -> (EmbedBuilder),
	SetColor: (self: EmbedBuilder, color: Color3) -> (EmbedBuilder),
	SetDescription: (self: EmbedBuilder, description: string) -> (EmbedBuilder),
	SetFields: (self: EmbedBuilder, fields: {Field}) -> (EmbedBuilder),
	SetFooter: (self: EmbedBuilder, footer: Footer) -> (EmbedBuilder),
	SetImage: (self: EmbedBuilder, image: string) -> (EmbedBuilder),
	SetThumbnail: (self: EmbedBuilder, thumbnail: string) -> (EmbedBuilder),
	SetTimestamp: (self: EmbedBuilder, timestamp: DateTime | number?) -> (EmbedBuilder),
	SetTitle: (self: EmbedBuilder, title: string) -> (EmbedBuilder),
	SetURL: (self: EmbedBuilder, url: string) -> (EmbedBuilder),
	
	ToJSON: (self: EmbedBuilder, noValidation: boolean?, excludeHeader: boolean?) -> (string),
	Validate: (self: EmbedBuilder) -> (boolean),
	
	UpdateAuthor: (self: EmbedBuilder, author: Author) -> (EmbedBuilder),
	UpdateFooter: (self: EmbedBuilder, footer: Footer) -> (EmbedBuilder),
}

export type ComposedClear<A> = (self: A) -> A
export type BuilderModule<A> = {
	new: () -> A
}

export type EmbedMaker = {
	new: () -> EmbedBuilder,
	
	EmbedBuilder: BuilderModule<EmbedBuilder>,
	FieldBuilder: BuilderModule<FieldBuilder>,
	AuthorBuilder: BuilderModule<AuthorBuilder>,
	FooterBuilder: BuilderModule<FooterBuilder>,
	
}



return nil