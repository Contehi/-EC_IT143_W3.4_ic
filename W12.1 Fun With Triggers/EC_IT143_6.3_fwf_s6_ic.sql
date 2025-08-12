--Q1: How to keep track of when a record was last modified.
--A1: Add columns to the table: LastModifiedDate datetime2
     --Create an AFTER UPDATE trigger that sets those columns when a row is updated.

--Q2: How to keep track of who last modified a record.
--A2: LastModifiedBy sysname (or nvarchar(200)).

--Use inserted pseudo-table to update only modified rows.


--To test if the after-update trigger worked as expected.


IF OBJECT_ID('dbo.[t-hello-world]', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.[t-hello-world] (
        id INT IDENTITY(1,1) PRIMARY KEY,
        my_message NVARCHAR(255) NOT NULL,
        [current_date] DATETIME DEFAULT GETDATE(),
        last_modified_by NVARCHAR(255) NULL,
        last_modified_date DATETIME NULL
    );
END
ELSE
BEGIN
    -- Add missing columns if table already exists
    IF COL_LENGTH('dbo.[t-hello-world]', 'current_date') IS NULL
        ALTER TABLE dbo.[t-hello-world] ADD [current_date] DATETIME DEFAULT GETDATE();
    IF COL_LENGTH('dbo.[t-hello-world]', 'last_modified_by') IS NULL
        ALTER TABLE dbo.[t-hello-world] ADD last_modified_by NVARCHAR(255) NULL;
    IF COL_LENGTH('dbo.[t-hello-world]', 'last_modified_date') IS NULL
        ALTER TABLE dbo.[t-hello-world] ADD last_modified_date DATETIME NULL;
END
GO

-- STEP 2: Drop trigger if it already exists
IF OBJECT_ID('dbo.trg_t_hello_world_last_mod', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_t_hello_world_last_mod;
GO

--  Create trigger to update last_modified_date & last_modified_by
CREATE TRIGGER dbo.trg_t_hello_world_last_mod
ON dbo.[t-hello-world]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE t
    SET 
        t.last_modified_date = GETDATE(),
        t.last_modified_by = SUSER_SNAME()
    FROM dbo.[t-hello-world] AS t
    INNER JOIN inserted AS i
        ON t.id = i.id;
END;
GO

--Test the trigger

INSERT INTO dbo.[t-hello-world] (my_message)
VALUES ('Hello World Test 1'), ('Hello World Test 2');

-- Update a row to trigger changes
UPDATE dbo.[t-hello-world]
SET my_message = 'Hello World Updated'
WHERE id = 1;

SELECT * FROM dbo.[t-hello-world];
GO

--Q4: How do you set the “last modified by” to “server user”?
--A4: This works for server user and the intial Insert

ALTER TABLE dbo.[t-hello-world]
ADD last_modified_by VARCHAR(50) DEFAULT SUSER_NAME();

