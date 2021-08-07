CREATE PROCEDURE [dbo].[PopulateStaticTableExample]

AS
SET NOCOUNT ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[StaticTableExample])
BEGIN
	INSERT INTO [dbo].[StaticTableExample] VALUES (1,NULL,42)
END
GO