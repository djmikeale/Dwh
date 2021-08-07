 /* Use as src to input columns into excel */ 
 
 WITH CTE AS 
(
SELECT 
      'Extract' AS DstSchema
	  ,[TableName]
      , (SELECT '[' + ColumnName + '] ' + UPPER(DataType) + ' ' + IsNullable + CASE WHEN ColProperty = '' THEN ', ' ELSE ' ' + ColProperty + ', ' END
        FROM [DWH].[DWHColumns] AS innerTbl
        WHERE innerTbl.[TableName] = tbl.[TableName] OR TableName = ''
        FOR XML PATH(''))
    AS cols
  FROM [DWH].[DWHColumns] AS Tbl
  WHERE TableName <> ''
  GROUP BY TableName


)

SELECT CAST('CREATE TABLE [Extract].[' + TableName + + '] (' + cols + 'CONSTRAINT [PK_' + DstSchema + '_' + TableName + '] PRIMARY KEY CLUSTERED ([DWH_ID] ASC))' AS nvarchar(max)) AS QueryContent, [TableName] AS [Filename] FROM CTE