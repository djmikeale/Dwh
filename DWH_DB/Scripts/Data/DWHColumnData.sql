CREATE PROCEDURE [DWH].[DWHColumnData]

AS
BEGIN
	TRUNCATE TABLE [DWH].[DWHColumns]

	INSERT INTO [DWH].[DWHColumns](SchemaName, TableName, ColumnName, DataType, IsNullable, ColProperty) VALUES
	('Extract','','DWH_ID','BIGINT','NOT NULL','IDENTITY (1, 1)'),
	('Extract','','DWH_CreateJobID','BIGINT','NOT NULL','')
END