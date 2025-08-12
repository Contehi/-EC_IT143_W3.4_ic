
USE EC_IT143_DA;
GO

-- 1. Add last_modified_date column if it doesn't exist
IF COL_LENGTH('dbo.t_hello_world', 'last_modified_date') IS NULL
BEGIN
    ALTER TABLE dbo.t_hello_world
    ADD last_modified_date datetime2 NULL;
    PRINT 'Column last_modified_date added.';
END
ELSE
    PRINT 'Column last_modified_date already exists.';
GO

-- 2. Drop trigger if it exists
IF OBJECT_ID('dbo.trg_hello_world_last_mod','TR') IS NOT NULL
    DROP TRIGGER dbo.trg_hello_world_last_mod;
GO

-- 3. Create trigger
CREATE TRIGGER dbo.trg_hello_world_last_mod
ON dbo.t_hello_world
AFTER UPDATE
AS

/*****************************************************************************************************************
NAME:    dbo.trg_hello_world_last_mod
PURPOSE: Hello World - Last Modified By Trigger

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     08/09/2025   IJCONTEH      1. Built this script for EC IT143

RUNTIME: 
1s

NOTES: 
Keep track of the last modified dates for each row in the table
******************************************************************************************************************/

BEGIN
    SET NOCOUNT ON;

    UPDATE t
    SET last_modified_date = SYSUTCDATETIME()
    FROM dbo.t_hello_world AS t
    INNER JOIN inserted AS i
        ON t.MyMessage = i.MyMessage;  -- Change this join to PK if available
END;
GO


