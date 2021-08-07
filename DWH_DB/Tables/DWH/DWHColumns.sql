CREATE TABLE [DWH].[DWHColumns]
(
	[Id] BIGINT NOT NULL IDENTITY (1,1),
	[SchemaName] NVARCHAR(128) NOT NULL, /* http://web.archive.org/web/20210807074712/https://docs.microsoft.com/en-us/sql/sql-server/maximum-capacity-specifications-for-sql-server?view=sql-server-ver15 */ 
	[TableName] NVARCHAR(128) NULL,
	[ColumnName] NVARCHAR(128) NOT NULL,
	[DataType] NVARCHAR(30) NOT NULL,
	[IsNullable] NVARCHAR(8) NOT NULL,
	[ColProperty] NVARCHAR(30) NULL, /* e.g. identity etc */ 
	CONSTRAINT [PK_dbo_DWHColumns] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO