CREATE PROCEDURE [DWH].[AddOrModifyObjectDescriptions]

AS
BEGIN
	/*---------------------------------------------------------------------
	-- Write or update extended properties to objects. Modified from https://www.sqlservercentral.com/articles/industrial-strength-database-documentation-using-extended-properties
	---------------------------------------------------------------------*/

	/*---------------------------------------------------------------------
	-- Create the temporary table to hold the scripts
	---------------------------------------------------------------------*/
	DROP TABLE IF EXISTS #ModifyCreate
	CREATE TABLE #ModifyCreate (SQLText NVARCHAR(2500))

	/*---------------------------------------------------------------------
	-- Handle Table columns
	---------------------------------------------------------------------*/
	INSERT INTO #ModifyCreate
	SELECT CASE WHEN ep.class IS NULL 
		THEN 'sp_addextendedproperty' 
		ELSE 'sp_updateextendedproperty' END + 
			' @level0type = N''Schema'', @level0name = [' + o.SchemaName + '], 
			@level1type = N''Table'', @level1name = [' + o.PrimaryObjectName + '], 
			@level2type = N''Column'', @level2name = [' + o.SecondaryObjectName + '], 
			@name = ' + o.Classification + ', @value = ''' + REPLACE(o.Comment, '''', '''''') + ''';' AS sqlText
	  FROM [DWH].[ObjectDescriptions] AS o
	  LEFT JOIN sys.extended_properties ep 
	  ON OBJECT_NAME(ep.Major_Id) = o.PrimaryObjectName
	  AND COL_NAME(ep.Major_id,ep.Minor_id) = o.SecondaryObjectName
	  AND ep.name = o.Classification
	  WHERE o.ObjectType = 'TableColumn' AND o.Active = 1


	/*---------------------------------------------------------------------
	-- Handle Tables
	---------------------------------------------------------------------*/
	INSERT INTO #ModifyCreate
	SELECT CASE WHEN ep.class IS NULL 
		THEN 'sp_addextendedproperty' 
		ELSE 'sp_updateextendedproperty' END + 
			' @level0type = N''Schema'', @level0name = [' + o.SchemaName + '], 
			@level1type = N''Table'', @level1name = [' + o.PrimaryObjectName + '], 
			@name = ' + o.Classification + ', @value = ''' + REPLACE(o.Comment, '''', '''''') + ''';' AS sqlText
	  FROM [DWH].[ObjectDescriptions] AS o
	  LEFT JOIN sys.extended_properties ep 
	  ON OBJECT_NAME(ep.Major_Id) = o.PrimaryObjectName
	  AND ep.minor_id = 0
	  AND ep.name = o.Classification
	  WHERE o.ObjectType = 'Table' AND o.Active = 1
	-- Determine loop boundaries
	DECLARE @sql nvarchar(max) = ''
	DECLARE @counter int = 0
	DECLARE @total int = ISNULL((SELECT COUNT(1) FROM #ModifyCreate), 0)
    
	/*---------------------------------------------------------------------
	-- Execute rows in temp table
	---------------------------------------------------------------------*/
	WHILE (@counter < (@total))
	BEGIN
		SET @sql = (select sqlText from #ModifyCreate order by sqlText offset @counter rows fetch next 1 rows only)
		EXEC (@sql)
		SET @counter = @counter + 1
	END

	DROP TABLE IF EXISTS #ModifyCreate
END