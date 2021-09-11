CREATE TABLE [DWH].[ObjectDescriptions]
(
	[ObjectType]			NVARCHAR(128)	NOT NULL,
	[SchemaName]			NVARCHAR(128)	NOT NULL,
	[PrimaryObjectName]		NVARCHAR(128)	NOT NULL,
	[SecondaryObjectName]	NVARCHAR(128)	NOT NULL,
	[Classification]		NVARCHAR(128)	NOT NULL,
	[Comment]				NVARCHAR(MAX)	NOT NULL,
	[Active]				BIT				NOT NULL
	CONSTRAINT [PK_DWH_ObjectDescriptions] PRIMARY KEY CLUSTERED ([ObjectType], [SchemaName], [PrimaryObjectName],[SecondaryObjectName],[Classification])
)
GO