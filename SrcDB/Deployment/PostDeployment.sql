/*	Code to be run post-deployment 
	See https://web.archive.org/web/20210807063236/https://medium.com/@desmond80in/multiple-post-deployment-scripts-with-sql-server-project-5d3c9e2f52b4
*/ 

RAISERROR('Inserting row into [dbo].[StaticTableExample]', 0, 1) WITH NOWAIT;
EXEC [dbo].[PopulateStaticTableExample]